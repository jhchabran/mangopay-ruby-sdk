require_relative '../../spec_helper'

describe MangoPay::Transfer, :type => :feature do

    let(:new_payer) {
        user = MangoPay::User.create({
            'Tag' => 'test',
            'Email' => 'my@email.com',
            'FirstName' => 'John',
            'LastName' => 'Doe',
            'CanRegisterMeanOfPayment' => true
            })
        contribution = MangoPay::Contribution.create({
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
        contribution = MangoPay::Contribution.details(contribution['ID'])
        while contribution["IsSucceeded"] == false do
            contribution = MangoPay::Contribution.details(contribution['ID'])
        end
        user
    }

    let(:new_beneficiary) {
        user = MangoPay::User.create({
            'Tag' => 'test',
            'Email' => 'my@email.com',
            'FirstName' => 'John',
            'LastName' => 'Doe',
            'CanRegisterMeanOfPayment' => true
            })
        MangoPay::Wallet.create({
                'Name' => 'test',
                'Owners' => [ user['ID'] ],
                'RaisingGoalAmount' => 12000
                 })
        user
    }

    let(:new_transfert) {
        MangoPay::Transfer.create({
            'Tag' => 'test transfer',
            'PayerID' => new_payer['ID'],
            'BeneficiaryID' => new_beneficiary['ID'],
            'Amount' => 1000,
            'PayerWalletID' => 0,
            'BeneficiaryWalletID' => MangoPay::User.get_wallets(new_beneficiary['ID'])[0]['ID']
            })
    }

    let(:new_transfer_refund) {
        MangoPay::Transfer.refund({
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
            transfert = MangoPay::Transfer.details(new_transfert['ID'])
            expect(transfert['ID']).to eq(new_transfert['ID'])
        end
    end

    describe "REFUND" do
        it "create a refund for the transfer" do
            expect(new_transfer_refund['ID']).not_to be_nil
        end
        it "gets a the transfer refund" do
            transfer_refund = MangoPay::Transfer.get_refund(new_transfer_refund['ID'])
            expect(transfer_refund['ID']).to eq(new_transfer_refund['ID'])
        end
    end
end
