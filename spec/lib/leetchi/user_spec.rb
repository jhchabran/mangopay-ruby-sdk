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

    describe "CREATE" do
        it "create a user" do
            expect(new_user["FirstName"]).to eq('John')
            expect(new_user["LastName"]).to eq('Doe')
            expect(new_user["Email"]).to eq('my@email.com')
            expect(new_user["CanRegisterMeanOfPayment"]).to be_true
            expect(new_user["ID"]).not_to be_nil
        end
    end

    describe "GET" do
        it "gets the user infos" do
            user = Leetchi::User.details(new_user["ID"])

            expect(user["FirstName"]).to eq(new_user["FirstName"])
            expect(user["LastName"]).to eq(new_user["LastName"])
            expect(user["Email"]).to eq(new_user["Email"])
            expect(user["ID"]).to eq(new_user["ID"])
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
            expect(user["FirstName"]).to eq('Jack')
            expect(user["LastName"]).to eq('Black')
            expect(user["Email"]).to eq('mynew@email.com')
            expect(user["CanRegisterMeanOfPayment"]).to be_false
            expect(user["ID"]).to eq(new_user["ID"])
        end
    end

    describe "GET_WALLETS" do
        it "get an empty list of wallets" do
            wallets = Leetchi::User.get_wallets(new_user["ID"])
            expect(wallets).to be_empty
        end
        it "gets a new wallet for the user" do
            new_wallet
            wallets = Leetchi::User.get_wallets(new_user['ID'])
            expect(wallets).not_to be_empty
            expect(wallets[0]["Owners"][0]).to eq(new_user['ID'])
        end
    end

    describe "CARDS" do
        it "gets the user cards" do
            cards = Leetchi::User.cards(new_user["ID"])
            expect(cards).to be_empty
        end
    end

    describe "OPERATIONS" do
        it "gets all the users operations" do
            operations = Leetchi::User.operations(new_user['ID'])
            expect(operations).to be_empty
        end
        it "gets all the users personal operation" do
            personal_operations = Leetchi::User.personal_operations(new_user['ID'])
            expect(personal_operations).to be_empty
        end
    end

    describe "STRONG_AUTHENTICATION" do
        it "creates a new strong authentication request" do
            expect(new_strong_authentication['ID']).not_to be_nil
        end
        it "gets the user strong authentication request" do
            strong_authentication = Leetchi::User.get_strong_authentication(new_strong_authentication['UserID'])
            expect(strong_authentication['ID']).to eq(new_strong_authentication['ID'])
        end
        it "updates the user strong authentication request" do
            strong_authentication = Leetchi::User.update_strong_authentication(new_strong_authentication['UserID'], {
                    'Tag' => 'test_strong_authentication2',
                    'IsDocumentsTransmitted' => true
                })
            expect(strong_authentication['ID']).to eq(new_strong_authentication['ID'])
            expect(strong_authentication['UserID']).to eq(new_strong_authentication['UserID'])
            expect(strong_authentication['Tag']).to eq('test_strong_authentication2')
            expect(strong_authentication['IsDocumentsTransmitted']).to be_true
        end
    end

    describe "EXPENSE_SITES" do
      it "get the expense sites for the given user" do
        expense_sites = Leetchi::User.expense_sites(new_user['ID'], new_wallet['ID'])
        expect(expense_sites).to be_kind_of(Array)
      end
    end
end
