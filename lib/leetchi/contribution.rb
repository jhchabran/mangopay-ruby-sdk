module Leetchi
  # A contribution help you deposit money to a wallet.
  class Contribution < Leetchi::Ressource

    # Create a contribution
    #
    # * *Args*    :
    #   - +data+ -> A JSON with the following attributes (Square brackets for optionals):
    #               * [Tag]
    #               * UserID
    #               * WalletID
    #               * Amount
    #               * [ClientFeeAmount]
    #               * ReturnURL
    #               * [TemplateURL]
    #               * [RegisterMeanOfPayment]
    #               * [PaymentCardID]
    # * *Returns* :
    #   - A contribution object
    #
    def self.create(data)
      post_request('contributions', data)
    end

    # Get a contribution
    #
    # * *Args*    :
    #   - +contribution_id+ -> The id of the contribution you want to retrieve
    # * *Returns* :
    #   - A contribution object
    #
    def self.details(contribution_id)
      get_request(File.join('contributions', contribution_id.to_s))
    end

    # Refund a given contribution
    #
    # * *Args*    :
    #   - +data+ -> A JSON with the following attributes (Square brackets for optionals):
    #               * [Tag]
    #               * ContributionID
    #               * UserID
    # * *Returns* :
    #   - A refund object
    #
    def self.refund(data)
      post_request(File.join('refunds'), data)
    end

    # Get a refund object
    #
    # * *Args*    :
    #   - +contribution_refund_id+ -> The id of the refund you want to retrieve
    # * *Returns* :
    #   - A refund object
    #
    def self.get_refund(contribution_refund_id)
      get_request(File.join('refunds', contribution_refund_id.to_s))
    end
  end
end
