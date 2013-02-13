require_relative '../../spec_helper'

describe Leetchi::Beneficiary do

    let(:new_user) {
        Leetchi::User.create({
            'Tag' => 'test',
            'Email' => 'my@email.com',
            'FirstName' => 'John',
            'LastName' => 'Doe',
            'CanRegisterMeanOfPayment' => true
            })
    }

    let(:new_beneficiary) {
        Leetchi::Beneficiary.create({
            'Tag' => 'test',
            'UserID' => new_user['ID'],
            'BankAccountOwnerName' => new_user['FirstName'],
            'BankAccountOwnerAddress' => '1 bis cite paradis',
            'BankAccountIBAN' => 'FR76 1790 6000 3200 0833 5232 973',
            'BankAccountBIC' => 'AGRIFRPP879'
            })
    }

    before do
        VCR.insert_cassette 'beneficiary', :record => :new_episodes
    end
    after do
        VCR.eject_cassette
    end

    describe "CREATE" do
        it "create a beneficiary" do
            new_beneficiary['ID'].wont_be_nil
            new_beneficiary['UserID'].must_equal new_user['ID']
        end
    end

    describe "GET" do
        it "it gets a beneficiary" do
            beneficiary = Leetchi::Beneficiary.details(new_beneficiary["ID"])
            beneficiary["ID"].must_equal new_beneficiary['ID']
        end
    end
end
