require_relative '../../spec_helper'

describe Leetchi::Transfer do
    before do
        VCR.insert_cassette 'transfer', :record => :new_episodes
    end
    after do
        VCR.eject_cassette
    end

    let(:new_payer) {
        Leetchi::User.create({
            'Tag' => 'test',
            'Email' => 'my@email.com',
            'FirstName' => 'John',
            'LastName' => 'Doe',
            'CanRegisterMeanOfPayment' => true
            })
    }

    let(:new_beneficiary) {
        Leetchi::User.create({
            'Tag' => 'test',
            'Email' => 'my@email.com',
            'FirstName' => 'John',
            'LastName' => 'Doe',
            'CanRegisterMeanOfPayment' => true
            })
    }

    let(:new_transfert) {
        Leetchi::Transfer.create({
            'Tag' => 'test transfer',
            'PayerID' => new_payer['ID'],
            'BeneficiaryID' => new_beneficiary['ID'],
            'Amount' => 1000,
            'PayerWalletID' => 0,
            'BeneficiaryWalletID' => 0
            })
    }

    let(:new_transfer_refund) {
        Leetchi::Transfer.refund({
            'TransferID' => new_transfert['ID'],
            'UserID' => new_payer['ID']
            })
    }

    describe "CREATE" do
        it "create a transfer" do
            new_transfert['ID'].wont_be_nil
        end
    end

    describe "GET" do
        it "gets the transfer" do
            transfert = Leetchi::Transfer.details(new_transfert['ID'])
            transfert['ID'].must_equal new_transfert['ID']
        end
    end

    describe "REFUND" do
        it "create a refund for the transfer" do
            new_transfer_refund['ID'].wont_be_nil
        end
        it "gets a the transfer refund" do
            transfer_refund = Leetchi::Transfer.get_refund(new_transfer_refund['ID'])
            transfer_refund['ID'].must_equal new_transfer_refund['ID']
        end
    end
end
