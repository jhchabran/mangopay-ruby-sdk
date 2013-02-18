module Leetchi
  # A beneficiary is an item who is the target of withdrawal.
  # It's the object that contains the bank details for a withdrawal.
  # A beneficiary can be linked to a user.
  class Beneficiary < Leetchi::Ressource

    # Create a beneficiary
    #
    # * *Args*    :
    #   - +data+ -> A JSON with the following attributes (Square brackets for optionals):
    #               * [Tag]
    #               * [UserID]
    #               * BankAccountOwnerName
    #               * BankAccountIBAN
    #               * BankAccountBIC
    # * *Returns* :
    #   - A beneficiary object in case of success
    #
    def self.create(data)
      post_request('beneficiaries', data)
    end

    # Get a beneficiary
    #
    # * *Args*    :
    #   - +beneficiary_id+ -> The id of the beneficiary you want to get
    # * *Returns* :
    #   - A beneficiary object if it exists
    #
    def self.details(beneficiary_id)
      get_request(File.join('beneficiaries', beneficiary_id.to_s))
    end

    # Create a strong authentication for a given beneficiary
    #
    # * *Args*    :
    #   - +beneficiary_id+ -> The id of the beneficiary you want strongly authenticate
    #   - +data+ -> A JSON with the following attributes (Square brackets for optionals):
    #               * [Tag]
    # * *Returns* :
    #   - A strong authentication object
    #
    def self.create_strong_authentication(beneficiary_id, data)
        post_request(File.join('beneficiaries', beneficiary_id.to_s, 'strongAuthentication'), data)
    end

    # Get the strong authentication for a given beneficiary
    #
    # * *Args*    :
    #   - +beneficiary_id+ -> The id of the beneficiary you want strongly authenticate
    # * *Returns* :
    #   - A strong authentication object
    #
    def self.get_strong_authentication(beneficiary_id)
        get_request(File.join('beneficiaries', beneficiary_id.to_s, 'strongAuthentication'))
    end

    # Update a strong authentication object for a given beneficiary
    #
    # * *Args*    :
    #   - +beneficiary_id+ -> The id of the beneficiary you want strongly authenticate
    #   - +data+ -> A JSON with the following attributes (Square brackets for optionals):
    #               * [Tag]
    #               * [IsDocumentsTransmitted]
    # * *Returns* :
    #   - A strong authentication object
    #
    def self.update_strong_authentication(beneficiary_id, data)
        put_request(File.join('beneficiaries', beneficiary_id.to_s, 'strongAuthentication'), data)
    end

  end
end
