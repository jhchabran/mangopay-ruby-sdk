require_relative '../../spec_helper'

describe Leetchi::Card do

    include Capybara::DSL

    let(:new_user) {
        Leetchi::User.create({
            'Tag' => 'test',
            'Email' => 'my@email.com',
            'FirstName' => 'John',
            'LastName' => 'Doe',
            'CanRegisterMeanOfPayment' => true
            })
    }

    let(:new_card) do
        card = Leetchi::Card.create({
            'Tag' => 'test-card',
            'OwnerID' => new_user['ID'],
            'ReturnURL' => 'http://leetchi.com'
            })
        visit(card['RedirectURL'])
        fill_in('number', :with => '4970100000000154')
        fill_in('cvv', :with => '123')
        click_button('paybutton')
        card
    end

    before do
        VCR.insert_cassette 'card', :record => :new_episodes
    end
    after do
        VCR.eject_cassette
    end

    describe "CREATE" do
        it "create a new card and return a redirect url" do
            new_card['RedirectURL'].wont_be_empty
        end
    end

    describe "GET" do
        it "get the users card" do
            card = Leetchi::Card.details(new_card["ID"])
            card["ID"].must_equal new_card["ID"]
        end
    end

    describe "DELETE" do
        it "delete the card" do
            deleted_card = Leetchi::Card.delete(new_card["ID"])
            deleted_card.must_equal "\"OK\""
        end
    end

end
