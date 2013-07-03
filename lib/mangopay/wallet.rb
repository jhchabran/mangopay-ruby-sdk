module MangoPay
  class Wallet < MangoPay::Ressource

    # Create a Wallet
    #
    # * *Args*    :
    #   - +data+ -> A JSON with the following attributes (Square brackets for optionals):
    #               * [Tag]
    #               * Owners (an array of user IDs, but only one is supported now)
    #               * [Name]
    #               * [Description]
    #               * [RaisingGoalAmount]
    #               * [ContributionLimitDate]
    # * *Returns* :
    #   - A wallet object
    #
    def self.create(data)
      post_request('wallets', data)
    end

    # Get a wallet
    #
    # * *Args*    :
    #   - +wallet_id+ -> The id of the wallet you want to retrieve
    # * *Returns* :
    #   - A wallet object
    #
    def self.details(wallet_id)
      get_request(File.join('wallets', wallet_id.to_s))
    end

    # Update a wallet
    #
    # * *Args*    :
    #   - +wallet_id+ -> The id of the wallet you want to update
    #   - +data+ -> A JSON with the following attributes (Square brackets for optionals):
    #               * [Name]
    #               * [Description]
    #               * [RaisingGoalAmount]
    #               * [SuggestedAmount]
    #               * [ExpirationDate] [Tag]
    # * *Returns* :
    #   - A wallet object
    #
    def self.update(wallet_id, data)
      put_request(File.join('wallets', wallet_id.to_s), data)
    end

    # Get the owners of a wallet
    #
    # * *Args*    :
    #   - +wallet_id+ -> The id of the wallet you want to retrieve the owners from
    # * *Returns* :
    #   - An array of users objects
    #
    def self.get_owners(wallet_id)
      get_request(File.join('wallets', wallet_id.to_s, 'users'), 'owners=1')
    end

    # Get the contributors of a wallet
    #
    # * *Args*    :
    #   - +wallet_id+ -> The id of the wallet you want to retrieve the contributors from
    # * *Returns* :
    #   - An array of users objects
    #
    def self.get_contributors(wallet_id)
      get_request(File.join('wallets', wallet_id.to_s, 'users'), 'contributors=1')
    end

    # Get the refunded users of a wallet
    #
    # * *Args*    :
    #   - +wallet_id+ -> The id of the wallet you want to refunded users the owners from
    # * *Returns* :
    #   - An array of users objects
    #
    def self.get_refunded(wallet_id)
      get_request(File.join('wallets', wallet_id.to_s, 'users'), 'refunded=1')
    end

    # Get the operations for a given wallet
    #
    # * *Args*    :
    #   - +wallet_id+ -> The is of the wallet you want to retrieve operations from
    # * *Returns* :
    #   - An array of operations objects
    #
    def self.operations(wallet_id)
      get_request(File.join('wallets', wallet_id.to_s, 'operations'))
    end
  end
end
