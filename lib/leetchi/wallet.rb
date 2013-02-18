module Leetchi
  class Wallet < Leetchi::Ressource

    def self.create(data)
      post_request('wallets', data)
    end

    def self.details(wallet_id)
      get_request(File.join('wallets', wallet_id.to_s))
    end

    def self.update(wallet_id, data)
      put_request(File.join('wallets', wallet_id.to_s), data)
    end

    def self.get_owners(wallet_id)
      get_request(File.join('wallets', wallet_id.to_s, 'users'), 'owners=1')
    end

    def self.get_contributors(wallet_id)
      get_request(File.join('wallets', wallet_id.to_s, 'users'), 'contributors=1')
    end

    def self.get_refunded(wallet_id)
      get_request(File.join('wallets', wallet_id.to_s, 'users'), 'refunded=1')
    end

  end
end
