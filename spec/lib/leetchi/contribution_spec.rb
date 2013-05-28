require_relative '../../spec_helper'

describe Leetchi::Contribution, :type => :feature do

    let(:new_user) {
        Leetchi::User.create({
            'Tag' => 'test',
            'Email' => 'my@email.com',
            'FirstName' => 'John',
            'LastName' => 'Doe',
            'CanRegisterMeanOfPayment' => true
            })
    }

    let(:new_contribution) do
        contribution = Leetchi::Contribution.create({
            'Tag' => 'test_contribution',
            'UserID' => new_user['ID'],
            'WalletID' => 0,
            'Amount' => 10000,
            'ReturnURL' => 'https://leetchi.com'
            })
        visit(contribution['PaymentURL'])
        fill_in('number', :with => '4970100000000154')
        fill_in('cvv', :with => '123')
        click_button('paybutton')
        contribution = Leetchi::Contribution.details(contribution['ID'])
        while contribution["IsSucceeded"] == false do
            contribution = Leetchi::Contribution.details(contribution['ID'])
        end
        contribution
    end

    let(:new_contribution_refund) {
        Leetchi::Contribution.refund({
            'ContributionID' => new_contribution['ID'],
            'UserID' => new_user['ID'],
            'Tag' => 'test_contribution_refund'
            })
    }

    describe "CREATE" do
        it "creates a contribution" do
            expect(new_contribution['ID']).not_to be_nil
            expect(new_contribution['PaymentURL']).not_to be_nil
        end
    end

    describe "GET" do
        it "get the contribution" do
            contribution = Leetchi::Contribution.details(new_contribution['ID'])
            expect(contribution['ID']).to eq(new_contribution['ID'])
        end
    end

    describe "REFUND" do
        it "creates a refund request for the contribution" do
            expect(new_contribution_refund['ID']).not_to be_nil
        end
        it "gets the refund request" do
            contribution_refund = Leetchi::Contribution.get_refund(new_contribution_refund['ID'])
            expect(contribution_refund['ID']).to eq(new_contribution_refund['ID'])
        end
    end
end
