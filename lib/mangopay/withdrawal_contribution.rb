module MangoPay

  class WithdrawalContribution < MangoPay::Ressource

    # Create a withdrawal contribution
    #
    # * *Args*    :
    #   - +data+ -> A JSON with the following attributes (Square brackets for optionals):
    #               * [Tag]
    #               * UserID
    #               * WalletID
    #               * AmountDeclared
    # * *Returns* :
    #   - A withdrawal contribution object
    #
    def self.create(data)
      post_request('contributions-by-withdrawal', data)
    end


    # Get a withdrawal contribution
    #
    # * *Args*    :
    #   - +withdrawal_contribution_id+ -> The id of the withdrawal contribution you want to retrieve
    # * *Returns* :
    #   - A withdrawal contribution object
    #
    def self.get(withdrawal_contribution_id)
      get_request(File.join('contributions-by-withdrawal', withdrawal_contribution_id.to_s))
    end
  end
end
