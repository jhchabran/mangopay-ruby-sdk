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
    end
end
