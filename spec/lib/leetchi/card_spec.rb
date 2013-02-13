require_relative '../../spec_helper'

describe Leetchi::Card do

    let(:new_user) {
        Leetchi::User.create({
            'Tag' => 'test',
            'Email' => 'my@email.com',
            'FirstName' => 'John',
            'LastName' => 'Doe',
            'CanRegisterMeanOfPayment' => true
            })
    }

    let(:new_card) {
        Leetchi::Card.create({
            'Tag' => 'test-card',
            'OwnerID' => new_user['ID'],
            'ReturnURL' => 'http://leetchi.com'
            })
    }

    before do
        VCR.insert_cassette 'card', :record => :new_episodes
    end
    after do
        VCR.eject_cassette
    end

    describe "CREATE" do
        it "create a new card and return a rdirect url" do
            new_card['RedirectURL'].wont_be_empty
        end
    end

    describe "GET" do
        it "get records the fixture" do
            card = Leetchi::Card.details(new_card["ID"])
            card["ID"].must_equal new_card["ID"]
        end
    end

    describe "DELETE" do
    end

end
