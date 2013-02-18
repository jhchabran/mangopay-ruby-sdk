require_relative '../../spec_helper'

describe Leetchi::RecurrentContribution do

    let(:new_user) {
        Leetchi::User.create({
            'Tag' => 'test',
            'Email' => 'my@email.com',
            'FirstName' => 'John',
            'LastName' => 'Doe',
            'CanRegisterMeanOfPayment' => true
            })
    }

    let(:new_recurrent_contribution) {
        Leetchi::RecurrentContribution.create({
            'Tag' => 'test-recurrent-contribution',
            'UserID' => new_user['ID'],
            'WalletID' => 0,
            'Amount' => 4200,
            'StartDate' => '1388534400',
            'FrequencyCode' => 'TwiceMonthly',
            'NumberOfExecutions' => 10,
            'ReturnURL' => 'http://leetchi.com'
            })
    }

    before do
        VCR.insert_cassette 'recurrent_contribution', :record => :new_episodes
    end
    after do
        VCR.eject_cassette
    end

    describe "CREATE" do
        it "create a new recurrent contribution and return a PaymentURL" do
            new_recurrent_contribution['PaymentURL'].wont_be_empty
        end
    end

    describe "GET" do
        it "get a recurrent contribution" do
            recurrent_contribution = Leetchi::RecurrentContribution.get(new_recurrent_contribution["ID"])
            recurrent_contribution["ID"].must_equal new_recurrent_contribution["ID"]
        end
    end

end
