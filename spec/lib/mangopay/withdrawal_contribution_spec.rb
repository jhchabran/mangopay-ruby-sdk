require_relative '../../spec_helper'

describe MangoPay::WithdrawalContribution do

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
      'Owners' => [ new_user['ID'] ],
      'RaisingGoalAmount' => 10000
      })
  }

  let(:new_withdrawal_contribution) do
    withdrawal_contribution = MangoPay::WithdrawalContribution.create({
      'Tag' => 'test_withdrawal_contribution',
      'UserID' => new_user['ID'],
      'WalletID' => new_wallet['ID'],
      'AmountDeclared' => 1000
      })
  end

  describe "CREATE" do
    it "creates a withdrawal contribution to a shared wallet" do
      expect(new_withdrawal_contribution['ID']).not_to be_nil
    end
  end

  describe "GET" do
    it "fetches a withdrawal contribution" do
      withdrawal_contribution = MangoPay::WithdrawalContribution.get(new_withdrawal_contribution['ID'])
      expect(withdrawal_contribution['ID']).to eq(new_withdrawal_contribution['ID'])
    end
  end
end
