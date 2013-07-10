module MangoPay

  require 'json'
  require 'base64'
  require 'openssl'
  require 'net/http'
  require 'net/http/post/multipart'

  require 'mangopay/ressource'
  require 'mangopay/user'
  require 'mangopay/wallet'
  require 'mangopay/card'
  require 'mangopay/contribution'
  require 'mangopay/immediate_contribution'
  require 'mangopay/withdrawal_contribution'
  require 'mangopay/transfer'
  require 'mangopay/beneficiary'
  require 'mangopay/withdrawal'
  require 'mangopay/strong_authentication'
  require 'mangopay/operation'
  require 'mangopay/expense'
  require 'mangopay/recurrent_contribution'


  class Configuration
    attr_accessor :base_url, :partner_id, :key_path, :key_password, :preproduction

    def preproduction
      @preproduction || false
    end

    def base_url
      @base_url || (@preproduction == true  ? "https://api-preprod.leetchi.com" : "https://api.leetchi.com")
    end
  end

  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield configuration
  end
end
