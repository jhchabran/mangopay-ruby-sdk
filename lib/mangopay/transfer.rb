module MangoPay
  # The Transfer class if you want to make any transfer between two wallets
  class Transfer < MangoPay::Ressource

    # Create a transfer from one personal wallet to another wallet
    #
    # * *Args*    :
    #   - +data+ -> A JSON with the following attributes (Square brackets for optionals):
    #               * [Tag]
    #               * [PayerID]
    #               * [BeneficiaryID]
    #               * Amount
    #               * [ClientFeeAmount] (In preproduction environnment only, soon in production)
    #               * [PayerWalletID]
    #               * [BeneficiaryWalletID]
    # * *Returns* :
    #   - A transfer object
    #
    def self.create(data)
      post_request('transfers', data)
    end

    # Get a transfer
    #
    # * *Args*    :
    #   - +tranfer_id+ -> The id of the transfer you want to retrieve
    # * *Returns* :
    #   - A transfer object
    #
    def self.details(transfer_id)
      get_request(File.join('transfers', transfer_id.to_s))
    end

    # Refund a contribution from a personal wallet to a shared walletTransferID
    #
    # * *Args*    :
    #   - +data+ -> A JSON with the following attributes (Square brackets for optionals):
    #               * TransfertID
    #               * UserID
    # * *Returns* :
    #   - A transfer refund object
    #
    def self.refund(data)
      post_request(File.join('transfer-refunds'), data)
    end

    # Get a refund transfer object
    #
    # * *Args*    :
    #   - +transfer_refund_id+ -> The id of the transfer refund you want to retrieve
    # * *Returns* :
    #   - A transfer refund object
    #
    def self.get_refund(transfer_refund_id)
      get_request(File.join('transfer-refunds', transfer_refund_id.to_s))
    end
  end
end
