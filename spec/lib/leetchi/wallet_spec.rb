require_relative '../../spec_helper'

describe Leetchi::Wallet do

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

    describe "CREATE" do
        it "should create a new wallet" do
            expect(new_wallet["ID"]).not_to be_nil
            expect(new_wallet["Name"]).to eq('test')
            expect(new_wallet["RaisingGoalAmount"]).to eq(12000)
            expect(new_wallet["CollectedAmount"]).to eq(0)
            expect(new_wallet["SpentAmount"]).to eq(0)
        end
    end

    describe "GET" do
        it "get the wallet" do
            wallet = Leetchi::Wallet.details(new_wallet["ID"])
            expect(wallet['ID']).to eq(new_wallet['ID'])
            expect(wallet['Name']).to eq(new_wallet['Name'])
            expect(wallet['Owners']).to eq(new_wallet['Owners'])
            expect(wallet['RaisingGoalAmount']).to eq(new_wallet['RaisingGoalAmount'])
        end
    end

    describe "UPDATE" do
        it "update the wallet" do
            wallet = Leetchi::Wallet.update(new_wallet["ID"], {
                'Name' => 'test_update',
                'RaisingGoalAmount' => 5000
                })
            expect(wallet['ID']).to eq(wallet['ID'])
            expect(wallet['Name']).to eq('test_update')
            expect(wallet['RaisingGoalAmount']).to eq(5000)
        end
    end

    describe "GET_OWNERS" do
        it "get the wallet's owners" do
            wallet = Leetchi::Wallet.get_owners(new_wallet["ID"])
            expect(wallet[0]['ID']).to eq(new_user['ID'])
        end
    end

    describe "GET_CONTRIBUTORS" do
        it "get the wallet's contributors" do
            wallet = Leetchi::Wallet.get_contributors(new_wallet["ID"])
            expect(wallet[0]['ID']).to eq(new_user['ID'])
        end
    end

    describe "GET_REFUNDED" do
        it "get the wallet's refunded" do
            wallet = Leetchi::Wallet.get_refunded(new_wallet["ID"])
            expect(wallet[0]['ID']).to eq(new_user['ID'])
        end
    end

    describe "OPERATIONS" do
        it "gets the wallet operations" do
            operations = Leetchi::Wallet.operations(new_wallet['ID'])
            expect(operations).to be_kind_of(Array)
        end
    end
end
