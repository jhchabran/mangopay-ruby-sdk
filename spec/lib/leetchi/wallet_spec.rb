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
    before do
        VCR.insert_cassette 'wallet', :record => :new_episodes
    end
    after do
        VCR.eject_cassette
    end

    describe "CREATE" do
        it "should create a new wallet" do
            new_wallet["ID"].wont_be_nil
            new_wallet["Name"].must_equal 'test'
            new_wallet["RaisingGoalAmount"].must_equal 12000
            new_wallet["CollectedAmount"].must_equal 0
            new_wallet["SpentAmount"].must_equal 0
        end
    end

    describe "GET" do
        it "get the wallet" do
            wallet = Leetchi::Wallet.details(new_wallet["ID"])
            wallet['ID'].must_equal new_wallet['ID']
            wallet['Name'].must_equal new_wallet['Name']
            wallet['Owners'].must_equal new_wallet['Owners']
            wallet['RaisingGoalAmount'].must_equal new_wallet['RaisingGoalAmount']
        end
    end

    describe "UPDATE" do
        it "update the wallet" do
            wallet = Leetchi::Wallet.update(new_wallet["ID"], {
                'Name' => 'test_update',
                'RaisingGoalAmount' => 5000
                })
            wallet['ID'].must_equal wallet['ID']
            wallet['Name'].must_equal 'test_update'
            wallet['RaisingGoalAmount'].must_equal 5000
        end
    end

    describe "GET_OWNERS" do
        it "get the wallet's owners" do
            wallet = Leetchi::Wallet.get_owners(new_wallet["ID"])
            wallet[0]['ID'].must_equal new_user['ID']
        end
    end

    describe "GET_CONTRIBUTORS" do
        it "get the wallet's contributors" do
            wallet = Leetchi::Wallet.get_contributors(new_wallet["ID"])
            wallet[0]['ID'].must_equal new_user['ID']
        end
    end

    describe "GET_REFUNDED" do
        it "get the wallet's refunded" do
            wallet = Leetchi::Wallet.get_refunded(new_wallet["ID"])
            wallet[0]['ID'].must_equal new_user['ID']
        end
    end
end
