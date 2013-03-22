require_relative '../../spec_helper'

describe Leetchi::Card, :type => :feature do

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
        card = Leetchi::Card.details(card['ID'])
        while card["IsSucceeded"] == false do
            card = Leetchi::Card.details(card['ID'])
        end
        card
    end

    describe "CREATE" do
        it "create a new card and return a redirect url" do
            expect(new_card['RedirectURL']).not_to be_empty
        end
    end

    describe "GET" do
        it "get the users card" do
            card = Leetchi::Card.details(new_card["ID"])
            expect(card["ID"]).to eq(new_card["ID"])
        end
    end

    describe "DELETE" do
        it "delete the card" do
            deleted_card = Leetchi::Card.delete(new_card["ID"])
            expect(deleted_card).to eq("\"OK\"")
        end
    end

end
