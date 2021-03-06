require_relative '../../spec_helper'

describe MangoPay::RecurrentContribution do

    let(:new_user) {
        MangoPay::User.create({
            'Tag' => 'test',
            'Email' => 'my@email.com',
            'FirstName' => 'John',
            'LastName' => 'Doe',
            'CanRegisterMeanOfPayment' => true
            })
    }

    let(:new_recurrent_contribution) {
        MangoPay::RecurrentContribution.create({
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
            recurrent_contribution = MangoPay::RecurrentContribution.get(new_recurrent_contribution["ID"])
            expect(recurrent_contribution["ID"]).to eq(new_recurrent_contribution["ID"])
        end
    end

    describe "UPDATE" do
        it "updates a recurrent contribution" do
            recurrent_contribution = MangoPay::RecurrentContribution.update(new_recurrent_contribution["ID"], { :IsEnabled => false })
            expect(recurrent_contribution["IsEnabled"]).to be_false
        end
    end

    describe "GET_EXECUTIONS" do
        it "get a list of the recurrent contribution executions" do
            recurrent_contribution_executions = MangoPay::RecurrentContribution.get_executions(new_recurrent_contribution["ID"])
            expect(recurrent_contribution_executions).to be_a_kind_of(Array)
            expect(recurrent_contribution_executions).to be_empty
        end
    end
end
