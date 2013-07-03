module MangoPay
  # Use the User class for any operations related to the user
  class User < MangoPay::Ressource

    # Create a new user
    #
    # * *Args*    :
    #   - +data+ -> A JSON with the following attributes (Square brackets for optionals):
    #               * [Tag]
    #               * [Email]
    #               * [FirstName]
    #               * [LastName]
    #               * [CanRegisterMeanOfPayment] true by default
    #               * IP
    #               * [Birthday]
    #               * [Password]
    # * *Returns* :
    #   - A user object
    #
    def self.create(data)
      post_request('users', data)
    end

    # Get a user
    #
    # * *Args*    :
    #   - +user_id+ -> The id of the user you want to retrieve
    # * *Returns* :
    #   - A user object
    #
    def self.details(user_id)
      get_request(File.join('users', user_id.to_s))
    end

    # Update a given user
    #
    # * *Args*    :
    #   - +user_id+ -> The id of the user you want to update
    #   - +data+ -> A JSON with the following attributes (Square brackets for optionals):
    #               * [Tag]
    #               * [Email]
    #               * [FirstName]
    #               * [LastName]
    #               * [CanRegisterMeanOfPayment]
    #               * [Password]
    # * *Returns* :
    #   - A user object
    #
    def self.update(user_id, data)
      put_request(File.join('users', user_id.to_s), data)
    end

    # Get a list of the given user wallets
    #
    # * *Args*    :
    #   - +user_id+ -> The id of the user you want to retrieve wallets from
    # * *Returns* :
    #   - An array of wallets objects
    #
    def self.get_wallets(user_id)
      get_request(File.join('users', user_id.to_s, 'wallets'))
    end

    # Get a list of the given user payment cards
    #
    # * *Args*    :
    #   - +user_id+ -> The id of the user you want to retrieve cards from
    # * *Returns* :
    #   - An array of registered payment cards objects
    #
    def self.cards(user_id)
      get_request(File.join('users', user_id.to_s, 'cards'))
    end

    # Get operations associated with a user
    #
    # * *Args*    :
    #   - +user_id+ -> The id of the user you want to retrieve operations from
    # * *Returns* :
    #   - An array of operations objects
    #
    def self.operations(user_id)
      get_request(File.join('users', user_id.to_s, 'operations'))
    end

    # Get operations from the given user personal account
    #
    # * *Args*    :
    #   - +user_id+ -> The id of the user you want to retrieve operations from
    # * *Returns* :
    #   - An array of operations objects
    #
    def self.personal_operations(user_id)
      get_request(File.join('users', user_id.to_s, 'operations', 'personal'))
    end

    # Create a request of strong user authentication.
    # If a strongAuthentication object already exist for the user, this request returns the existing object.
    #
    # * *Args*    :
    #   - +user_id+ -> The id of the user you want to strongly authenticate
    #   - +data+ -> A JSON with the following attributes (Square brackets for optionals):
    #               * [Tag]
    # * *Returns* :
    #   - A Strong Authentication object
    #
    def self.create_strong_authentication(user_id, data)
      post_request(File.join('users', user_id.to_s, 'strongAuthentication'), data)
    end

    # Get a Strong Authentication object
    #
    # * *Args*    :
    #   - +user_id+ -> The id of the user you want to retrieve the strong authentication object from
    # * *Returns* :
    #   - A Strong Authentication object
    #
    def self.get_strong_authentication(user_id)
      get_request(File.join('users', user_id.to_s, 'strongAuthentication'))
    end

    # Update a Strong Authentication object
    #
    # * *Args*    :
    #   - +user_id+ -> The id of the user you want to update the strong authentication object from
    #   - +data+ -> A JSON with the following attributes (Square brackets for optionals):
    #               * [Tag]
    #               * [IsDocumentsTransmitted]
    # * *Returns* :
    #   - A Strong Authentication object
    #
    def self.update_strong_authentication(user_id, data)
      put_request(File.join('users', user_id.to_s, 'strongAuthentication'), data)
    end

    # Get the expense sites for a given user
    #
    # * *Args*    :
    #   - +user_id+ -> The id of the user you want to retrieve the expense sites from
    #   - +wallet_id+ -> The id of the wallet you want to retrieve the expense sites from
    # * *Returns* :
    #   - An array of expense site objects
    #
    def self.expense_sites(user_id, wallet_id)
      get_request(File.join('expense-sites'), "userID=#{user_id.to_s}&walletID=#{wallet_id.to_s}")
    end
  end
end
