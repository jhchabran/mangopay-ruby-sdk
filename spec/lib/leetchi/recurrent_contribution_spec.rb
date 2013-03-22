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

    describe "CREATE" do
        it "create a new recurrent contribution and return a PaymentURL" do
            expect(new_recurrent_contribution['PaymentURL']).not_to be_empty
        end
    end

    describe "GET" do
        it "get a recurrent contribution" do
            recurrent_contribution = Leetchi::RecurrentContribution.get(new_recurrent_contribution["ID"])
            expect(recurrent_contribution["ID"]).to eq(new_recurrent_contribution["ID"])
        end
    end

end
