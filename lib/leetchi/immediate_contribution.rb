module Leetchi
  # An immediate contribution is a request to process directly a payment with a payment card already registred by the user.
  class ImmediateContribution < Leetchi::Ressource

    # Create an immediate contribution
    #
    # * *Args*    :
    #   - +data+ -> A JSON with the following attributes (Square brackets for optionals):
    #               * [Tag]
    #               * UserID
    #               * WalletID
    #               * Amount
    #               * PaymentCardID
    #               * [ClientFeeAmount]
    # * *Returns* :
    #   - An immediate contribution object
    #
    def self.create(data)
      post_request('immediate-contributions', data)
    end

    # Get an immediate contribution
    #
    # * *Args*    :
    #   - +immediate_contribution_id+ -> The id of the immediate contribution you want to retrieve
    # * *Returns* :
    #   - An immediate contribution object
    #
    def self.details(immediate_contribution_id)
      get_request(File.join('immediate-contributions', immediate_contribution_id.to_s))
    end

    # Refund a given immediate contribution
    #
    # * *Args*    :
    #   - +data+ -> A JSON with the following attributes (Square brackets for optionals):
    #               * [Tag]
    #               * ImmediateContributionID
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
    #   - +immediate_contribution_refund_id+ -> The id of the refund you want to retrieve
    # * *Returns* :
    #   - A refund object
    #
    def self.get_refund(immediate_contribution_refund_id)
      get_request(File.join('refunds', immediate_contribution_refund_id.to_s))
    end
  end
end
