require_relative '../../spec_helper'

describe Leetchi::Contribution do

    before do
        VCR.insert_cassette 'contribution', :record => :new_episodes
    end
    after do
        VCR.eject_cassette
    end

    let(:new_user) {
        Leetchi::User.create({
            'Tag' => 'test',
            'Email' => 'my@email.com',
            'FirstName' => 'John',
            'LastName' => 'Doe',
            'CanRegisterMeanOfPayment' => true
            })
    }

    let(:new_contribution) {
        Leetchi::Contribution.create({
            'Tag' => 'test_contribution',
            'UserID' => new_user['ID'],
            'WalletID' => 0,
            'Amount' => 10000,
            'ReturnURL' => 'https://leetchi.com',
            'BankAccountBIC' => 'AGRIFRPP879'
            })
    }

    describe "CREATE" do
        it "creates a contribution" do
            new_contribution['ID'].wont_be_nil
            new_contribution['PaymentURL'].wont_be_nil
        end
    end

    describe "GET" do
        it "get the contribution" do
            contribution = Leetchi::Contribution.details(new_contribution['ID'])
            contribution['ID'].must_equal new_contribution['ID']
        end
    end
end
