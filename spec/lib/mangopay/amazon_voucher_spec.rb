require_relative '../../spec_helper'

describe MangoPay::AmazonVoucher, :type => :feature do

    let(:new_user) {
        MangoPay::User.create({
            'Tag' => 'test',
            'Email' => 'my@email.com',
            'FirstName' => 'John',
            'LastName' => 'Doe',
            'CanRegisterMeanOfPayment' => true
            })
    }

   let(:new_wallet) {
        MangoPay::Wallet.create({
            'Name' => 'test',
            'Owners' => [ new_user['ID'] ]
            })
    }

    let(:new_card) do
        card = MangoPay::Card.create({
            'Tag' => 'test-card',
            'OwnerID' => new_user['ID'],
            'ReturnURL' => 'http://leetchi.com'
            })
        visit(card['RedirectURL'])
        fill_in('number', :with => '4970100000000154')
        fill_in('cvv', :with => '123')
        click_button('paybutton')
        card = MangoPay::Card.details(card['ID'])
        while (card["CardNumber"] || []).length != 16 do
            card = MangoPay::Card.details(card['ID'])
        end
        card
    end

    let(:new_immediate_contribution) do
        MangoPay::ImmediateContribution.create({
            'Tag' => 'test_contribution',
            'UserID' => new_user['ID'],
            'PaymentCardID' => new_card['ID'],
            'WalletID' => new_wallet['ID'],
            'Amount' => 33300
            })
    end

    let(:new_voucher) {
        MangoPay::AmazonVoucher.create({
            'Tag' => 'test_voucher',
            'UserID' => new_user['ID'],
            'WalletID' => new_wallet['ID'],
            'Store' => 'FR',
            'Amount' => 10000
            })
    }

    describe "CREATE" do
        it "creates a voucher" do
            new_immediate_contribution
            expect(new_voucher['VoucherCode']).not_to be_nil
        end
    end

    describe "GET" do
        it "get the voucher" do
            new_immediate_contribution
            voucher = MangoPay::AmazonVoucher.details(new_voucher['ID'])
            expect(voucher['ID']).to eq(new_voucher['ID'])
        end
    end

end
