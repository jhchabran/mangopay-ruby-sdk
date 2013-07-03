module MangoPay

  # Recurrent Contribution are available in test environment only, soon in production.
  class RecurrentContribution < MangoPay::Ressource

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

    # Update a recurrent contribution
    #
    # * *Args*    :
    #   - +data+ -> A JSON with the following attributes (Square brackets for optionals):
    #               * IsEnabled
    #               * [Tag]
    # * *Returns* :
    #   - A recurrent contribution object
    #
    def self.update(recurrent_contributions_id, data)
      put_request(File.join('recurrent-contributions', recurrent_contributions_id.to_s), data)
    end

    # Fetch the list of a recurrent contribution executions
    #
    # * *Args*    :
    #   - +recurrent_contributions_id+ -> The id of the recurrent contribution you want to retrieve operations from
    # * *Returns* :
    #   - An array of payment execution
    #
    def self.get_executions(recurrent_contributions_id)
      get_request(File.join('recurrent-contributions', recurrent_contributions_id.to_s, 'executions'))
    end
  end
end
