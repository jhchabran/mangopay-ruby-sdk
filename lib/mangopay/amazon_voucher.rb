module MangoPay
  # With this feature you can generate Amazon Gift-Cards.
  # Special conditions are required to use this feature.
  # Please contact our team prior to integration: it-support@mangopay.com
  class AmazonVoucher < MangoPay::Ressource

    # Create an Amazon Gift-Card by spending money from a Wallet or a Personal Wallet.
    # The maximum amount is set to 5000€.
    #
    # * *Args*    :
    #   - +data+ -> A JSON with the following attributes (Square brackets for optionals):
    #               * UserId
    #               * WalletID
    #               * Store ("FR" or "DE")
    #               * Amount
    #               * [Tag]
    # * *Returns* :
    #   - An Amazon Gift-Card object
    #
    def self.create(data)
      post_request('amazonvoucher', data)
    end

    # Get an Amazon Gift-Card based on an ID
    #
    # * *Args*    :
    #   - +voucher_id+ -> The id of the voucher you want to retrieve
    # * *Returns* :
    #   - An Amazon Gift-Card object
    #
    def self.details(voucher_id)
      get_request(File.join('amazonvoucher', voucher_id.to_s))
    end
    
  end
end
