require_relative '../../spec_helper'

describe Leetchi::Transfer, :type => :feature do

    let(:new_payer) {
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
        contribution = Leetchi::Contribution.details(contribution['ID'])
        while contribution["IsSucceeded"] == false do
            contribution = Leetchi::Contribution.details(contribution['ID'])
        end
        user
    }

    let(:new_beneficiary) {
        user = Leetchi::User.create({
            'Tag' => 'test',
            'Email' => 'my@email.com',
            'FirstName' => 'John',
            'LastName' => 'Doe',
            'CanRegisterMeanOfPayment' => true
            })
        Leetchi::Wallet.create({
                'Name' => 'test',
                'Owners' => [ user['ID'] ],
                'RaisingGoalAmount' => 12000
                 })
        user
    }

    let(:new_transfert) {
        Leetchi::Transfer.create({
            'Tag' => 'test transfer',
            'PayerID' => new_payer['ID'],
            'BeneficiaryID' => new_beneficiary['ID'],
            'Amount' => 1000,
            'PayerWalletID' => 0,
            'BeneficiaryWalletID' => Leetchi::User.get_wallets(new_beneficiary['ID'])[0]['ID']
            })
    }

    let(:new_transfer_refund) {
        Leetchi::Transfer.refund({
            'TransferID' => new_transfert['ID'],
            'UserID' => new_transfert['BeneficiaryID']
            })
    }

    describe "CREATE" do
        it "create a transfer" do
            expect(new_transfert['ID']).not_to be_nil
        end
    end

    describe "GET" do
        it "gets the transfer" do
            transfert = Leetchi::Transfer.details(new_transfert['ID'])
            expect(transfert['ID']).to eq(new_transfert['ID'])
        end
    end

    describe "REFUND" do
        it "create a refund for the transfer" do
            expect(new_transfer_refund['ID']).not_to be_nil
        end
        it "gets a the transfer refund" do
            transfer_refund = Leetchi::Transfer.get_refund(new_transfer_refund['ID'])
            expect(transfer_refund['ID']).to eq(new_transfer_refund['ID'])
        end
    end
end
