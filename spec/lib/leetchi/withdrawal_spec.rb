require_relative '../../spec_helper'

describe Leetchi::Withdrawal, :type => :feature do

    let(:new_user) {
        user = Leetchi::User.create({
            'Tag' => 'test',
            'Email' => 'my@email.com',
            'FirstName' => 'John',
            'LastName' => 'Doe',
            'CanRegisterMeanOfPayment' => true
            })
        contribution = Leetchi::Contribution.create({
            'Tag' => 'test_contribution',
            'UserID' => user['ID'],
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
        user
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

    let(:new_withdrawal) {
        Leetchi::Withdrawal.create({
            'Tag' => 'test_withdrawal',
            'UserID' => new_user['ID'],
            'WalletID' => 0,
            'Amount' => 2500,
            'BeneficiaryID' => new_beneficiary['ID']
            })
    }

    describe "CREATE" do
        it "create a withdrawal" do
            expect(new_withdrawal['ID']).not_to be_nil
            expect(new_withdrawal['UserID']).to eq(new_user['ID'])
            expect(new_withdrawal['BeneficiaryID']).to eq(new_beneficiary['ID'])
        end
        it "fails and return a 2001 error code: Invalid withdrawal amount" do
            fail_withdrawal = Leetchi::Withdrawal.create({
                'Tag' => 'test_withdrawal',
                'UserID' => new_user['ID'],
                'WalletID' => 0,
                'Amount' => -123,
                'BeneficiaryID' => new_beneficiary['ID']
                })
            expect(fail_withdrawal['ErrorCode']).to eq(2001)
        end
        it "fails and return a 2002 error code: Both parameters are specified: Amount and AmountWithoutFees" do
            fail_withdrawal = Leetchi::Withdrawal.create({
                'Tag' => 'test_withdrawal',
                'UserID' => new_user['ID'],
                'WalletID' => 0,
                'Amount' => 2500,
                'AmountWithoutFees' => 2500,
                'BeneficiaryID' => new_beneficiary['ID']
                })
            expect(fail_withdrawal['ErrorCode']).to eq(2002)
        end
        it "fails and return a 2003 error code: Invalid withdrawal ClientFeeAmount" do
            fail_withdrawal = Leetchi::Withdrawal.create({
                'Tag' => 'test_withdrawal',
                'UserID' => new_user['ID'],
                'WalletID' => 0,
                'Amount' => 2500,
                'BeneficiaryID' => new_beneficiary['ID'],
                'ClientFeeAmount' => -3000
                })
            expect(fail_withdrawal['ErrorCode']).to eq(2003)
        end
    end

    describe "GET" do
        it "get the withdrawal" do
            withdrawal = Leetchi::Withdrawal.details(new_withdrawal['ID'])
            expect(withdrawal['ID']).to eq(new_withdrawal['ID'])
        end
    end
end
