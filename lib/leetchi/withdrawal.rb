module Leetchi
  # A withdrawal is a request to get the money from a wallet or a personal account to a bank account.
  class Withdrawal < Leetchi::Ressource

    # Create a withdrawal
    # Only one amount can be present in the withdrawal request: either AmountWithoutFees or Amount (that is amount with fees).
    # Amount = AmountWithoutFees + ClientFeeAmount
    #
    # * *Args*    :
    #   - +data+ -> A JSON with the following attributes (Square brackets for optionals):
    #               * [Tag]
    #               * UserID
    #               * WalletID
    #               * AmountWithoutFees
    #               * Amount
    #               * BeneficiaryID
    #               * [ClientFeeAmount]
    # * *Returns* :
    #   - A withdrawal object
    # * *Raises* :
    #   - +2001+ -> Invalid withdrawal amount
    #   - +2002+ -> Both parameters are specified: Amount and AmountWithoutFees
    #   - +2003+ -> Invalid withdrawal ClientFeeAmount
    #
    def self.create(data)
      post_request('withdrawals', data)
    end

    # Get a withdrawal
    #
    # * *Args*    :
    #   - +withdrawal_id+ -> The id of the withdrawal you want to retrieve
    # * *Returns* :
    #   - A withdrawal object
    #
    def self.details(withdrawal_id)
      get_request(File.join('withdrawals', withdrawal_id.to_s))
    end

  end
end
