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

    let(:new_strong_authentication) {
        Leetchi::Beneficiary.create_strong_authentication(new_beneficiary['ID'], {
            'Tag' => 'test_beneficiary_strong_authentication'
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

        it "fails and returns a 2004 error code" do
            fail_beneficiary = Leetchi::Beneficiary.create({
                'Tag' => 'test',
                'UserID' => new_user['ID'],
                'BankAccountOwnerAddress' => '1 bis cite paradis',
                'BankAccountIBAN' => 'FR76 1790 6000 3200 0833 5232 973',
                'BankAccountBIC' => 'AGRIFRPP879'
                })
            fail_beneficiary["ErrorCode"].must_equal 2004
        end

        it "fails and returns a 2005 error code" do
            fail_beneficiary = Leetchi::Beneficiary.create({
                'Tag' => 'test',
                'UserID' => new_user['ID'],
                'BankAccountOwnerName' => new_user['FirstName'],
                'BankAccountIBAN' => 'FR76 1790 6000 3200 0833 5232 973',
                'BankAccountBIC' => 'AGRIFRPP879'
                })
            fail_beneficiary["ErrorCode"].must_equal 2005
        end

        it "fail and returns a 2006 error code" do
            fail_beneficiary = Leetchi::Beneficiary.create({
                'Tag' => 'test',
                'UserID' => new_user['ID'],
                'BankAccountOwnerName' => new_user['FirstName'],
                'BankAccountOwnerAddress' => '1 bis cite paradis',
                'BankAccountIBAN' => 'FR76 1790 6000 3200 0833 5232 973',
                'BankAccountBIC' => 'RPPdsakdnsajkdna79'
                })
            fail_beneficiary["ErrorCode"].must_equal 2006
        end

        it "fail and returns a 2007 error code" do
            fail_beneficiary = Leetchi::Beneficiary.create({
                'Tag' => 'test',
                'UserID' => new_user['ID'],
                'BankAccountOwnerName' => new_user['FirstName'],
                'BankAccountOwnerAddress' => '1 bis cite paradis',
                'BankAccountIBAN' => 'OIJDSAOIJDSAOIDJSAOIJDSA',
                'BankAccountBIC' => 'AGRIFRPP879'
                })
            fail_beneficiary["ErrorCode"].must_equal 2007
        end

        it "fail and returns a 2008 error code" do
            fail_beneficiary = Leetchi::Beneficiary.create({
                'Tag' => 'test',
                'UserID' => new_user['ID'],
                'BankAccountOwnerName' => new_user['FirstName'],
                'BankAccountOwnerAddress' => '1 bis cite paradis',
                'BankAccountIBAN' => 'GB87 BARC 2065 8244 9716 55',
                'BankAccountBIC' => 'CRLYFRPP'
                })
            fail_beneficiary["ErrorCode"].must_equal 2008
        end
    end

    describe "GET" do
        it "it gets a beneficiary" do
            beneficiary = Leetchi::Beneficiary.details(new_beneficiary["ID"])
            beneficiary["ID"].must_equal new_beneficiary['ID']
        end
    end

    describe "StrongAuthentication" do
      it "creates the beneficiary strong authentication request" do
        new_strong_authentication.wont_be_nil
    end
    it "gets the beneficiary strong authentication request" do
        strong_authentication = Leetchi::Beneficiary.get_strong_authentication(new_strong_authentication['ID'])
        strong_authentication['ID'].must_equal new_strong_authentication['ID']
    end
    it "updated the beneficiary strong authentication request" do
        strong_authentication = Leetchi::Beneficiary.update_strong_authentication(new_beneficiary['ID'], {
            'Tag' => 'test_beneficiary_strong_authentication2',
            'IsDocumentsTransmitted' => true
            })
        strong_authentication['ID'].must_equal new_strong_authentication['ID']
        strong_authentication['Tag'].must_equal 'test_beneficiary_strong_authentication2'
        strong_authentication['IsDocumentsTransmitted'].must_equal true
    end
end
end
