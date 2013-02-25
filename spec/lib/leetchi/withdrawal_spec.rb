require_relative '../../spec_helper'

describe Leetchi::Withdrawal do

    include Capybara::DSL

    before do
        VCR.insert_cassette 'withdrawal', :record => :new_episodes
    end
    after do
        VCR.eject_cassette
    end

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
            'ReturnURL' => 'https://leetchi.com',
            'BankAccountBIC' => 'AGRIFRPP879'
            })
        visit(contribution['PaymentURL'])
        fill_in('number', :with => '4970100000000154')
        fill_in('cvv', :with => '123')
        click_button('paybutton')
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
            new_withdrawal['ID'].wont_be_nil
            new_withdrawal['UserID'].must_equal new_user['ID']
            new_withdrawal['BeneficiaryID'].must_equal new_beneficiary['ID']
        end
        it "fails and return a 2001 error code: Invalid withdrawal amount" do
            fail_withdrawal = Leetchi::Withdrawal.create({
                'Tag' => 'test_withdrawal',
                'UserID' => new_user['ID'],
                'WalletID' => 0,
                'Amount' => -123,
                'BeneficiaryID' => new_beneficiary['ID']
                })
            fail_withdrawal['ErrorCode'].must_equal 2001
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
            fail_withdrawal['ErrorCode'].must_equal 2002
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
            fail_withdrawal['ErrorCode'].must_equal 2003
        end
    end

    describe "GET" do
        it "get the withdrawal" do
            withdrawal = Leetchi::Withdrawal.details(new_withdrawal['ID'])
            withdrawal['ID'].must_equal new_withdrawal['ID']
        end
    end
end
