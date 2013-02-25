require_relative '../../spec_helper'

describe Leetchi::User do

    let(:new_user) {
        Leetchi::User.create({
            'Tag' => 'test',
            'Email' => 'my@email.com',
            'FirstName' => 'John',
            'LastName' => 'Doe',
            'CanRegisterMeanOfPayment' => true
            })
    }

    let(:new_wallet) {
        Leetchi::Wallet.create({
            'Name' => 'test',
            'Owners' => [ new_user['ID'] ],
            'RaisingGoalAmount' => 12000
            })
    }

    let(:new_strong_authentication) {
        Leetchi::User.create_strong_authentication(new_user['ID'], {
            'Tag' => 'test_strong_auth'
            })
    }

    before do
        VCR.insert_cassette 'user', :record => :new_episodes
    end
    after do
        VCR.eject_cassette
    end

    describe "CREATE" do
        it "create a user" do
            new_user["FirstName"].must_equal 'John'
            new_user["LastName"].must_equal 'Doe'
            new_user["Email"].must_equal 'my@email.com'
            new_user["CanRegisterMeanOfPayment"].must_equal true
            new_user["ID"].wont_be_nil
        end
    end

    describe "GET" do
        it "gets the user infos" do
            user = Leetchi::User.details(new_user["ID"])

            user["FirstName"].must_equal new_user["FirstName"]
            user["LastName"].must_equal new_user["LastName"]
            user["Email"].must_equal new_user["Email"]
            user["ID"].must_equal new_user["ID"]
        end
    end

    describe "UPDATE" do
        it "update the user infos" do
            user = Leetchi::User.update(new_user["ID"], {
                'Tag' => 'test-update',
                'Email' => 'mynew@email.com',
                'FirstName' => 'Jack',
                'LastName' => 'Black',
                'CanRegisterMeanOfPayment' => false
                })
            user["FirstName"].must_equal 'Jack'
            user["LastName"].must_equal 'Black'
            user["Email"].must_equal 'mynew@email.com'
            user["CanRegisterMeanOfPayment"].must_equal false
            user["ID"].must_equal new_user["ID"]
        end
    end

    describe "GET_WALLETS" do
        it "get an empty list of wallets" do
            wallets = Leetchi::User.get_wallets(new_user["ID"])
            wallets.must_be_empty
        end
        it "gets a new wallet for the user" do
            new_wallet
            wallets = Leetchi::User.get_wallets(new_user['ID'])
            wallets.wont_be_empty
            wallets[0]["Owners"][0].must_equal new_user['ID']
        end
    end

    describe "CARDS" do
        it "gets the user cards" do
            cards = Leetchi::User.cards(new_user["ID"])
            cards.must_be_empty
        end
    end

    describe "OPERATIONS" do
        it "gets all the users operations" do
            operations = Leetchi::User.operations(new_user['ID'])
            operations.must_be_empty
        end
        it "gets all the users personal operation" do
            personal_operations = Leetchi::User.personal_operations(new_user['ID'])
            personal_operations.must_be_empty
        end
    end

    describe "STRONG_AUTHENTICATION" do
        it "creates a new strong authentication request" do
            new_strong_authentication['ID'].wont_be_nil
        end
        it "gets the user strong authentication request" do
            strong_authentication = Leetchi::User.get_strong_authentication(new_strong_authentication['UserID'])
            strong_authentication['ID'].must_equal new_strong_authentication['ID']
        end
        it "updates the user strong authentication request" do
            strong_authentication = Leetchi::User.update_strong_authentication(new_strong_authentication['UserID'], {
                    'Tag' => 'test_strong_authentication2',
                    'IsDocumentsTransmitted' => true
                })
            strong_authentication['ID'].must_equal new_strong_authentication['ID']
            strong_authentication['UserID'].must_equal new_strong_authentication['UserID']
            strong_authentication['Tag'].must_equal 'test_strong_authentication2'
            strong_authentication['IsDocumentsTransmitted'].must_equal true
        end
    end

    describe "EXPENSE_SITES" do
      it "get the expense sites for the given user" do
        expense_sites = Leetchi::User.expense_sites(new_user['ID'], new_wallet['ID'])
        expense_sites.must_be_kind_of Array
      end
    end
end
