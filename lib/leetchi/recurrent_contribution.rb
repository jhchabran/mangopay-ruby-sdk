module Leetchi

  # Recurrent Contribution are available in test environment only, soon in production.
  class RecurrentContribution < Leetchi::Ressource

    # Create a recurrent contribution
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
    #               * StartDate
    #               * FrequencyCode
    #               * NumberOfExecutions
    # * *Returns* :
    #   - A recurrent contribution object
    #
    def self.create(data)
      post_request('recurrent-contributions', data)
    end

    # Get a recurrent contribution
    #
    # * *Args*    :
    #   - +recurrent_contributions_id+ -> The id of the recurrent contribution you want to retrieve
    # * *Returns* :
    #   - A recurrent contribution object
    #
    def self.get(recurrent_contributions_id)
      get_request(File.join('recurrent-contributions', recurrent_contributions_id.to_s))
    end
  end
end
