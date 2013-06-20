module Leetchi

  require 'json'
  require 'base64'
  require 'openssl'
  require 'net/http'
  require 'net/http/post/multipart'

  require 'leetchi/ressource'
  require 'leetchi/user'
  require 'leetchi/wallet'
  require 'leetchi/card'
  require 'leetchi/contribution'
  require 'leetchi/immediate_contribution'
  require 'leetchi/withdrawal_contribution'
  require 'leetchi/transfer'
  require 'leetchi/beneficiary'
  require 'leetchi/withdrawal'
  require 'leetchi/strong_authentication'
  require 'leetchi/operation'
  require 'leetchi/expense'
  require 'leetchi/recurrent_contribution'


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
