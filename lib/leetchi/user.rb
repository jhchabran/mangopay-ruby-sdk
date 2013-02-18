module Leetchi
  class User < Leetchi::Ressource

    def self.create(data)
      post_request('users', data)
    end

    def self.details(user_id)
      get_request(File.join('users', user_id.to_s))
    end

    def self.update(user_id, data)
      put_request(File.join('users', user_id.to_s), data)
    end

    def self.get_wallets(user_id)
      get_request(File.join('users', user_id.to_s, 'wallets'))
    end

    def self.cards(user_id)
      get_request(File.join('users', user_id.to_s, 'cards'))
    end

    def self.operations(user_id)
      get_request(File.join('users', user_id.to_s, 'operations'))
    end

    def self.personal_operations(user_id)
      get_request(File.join('users', user_id.to_s, 'operations', 'personal'))
    end

    def self.create_strong_authentication(user_id, data)
      post_request(File.join('users', user_id.to_s, 'strongAuthentication'), data)
    end

    def self.get_strong_authentication(user_id)
      get_request(File.join('users', user_id.to_s, 'strongAuthentication'))
    end

    def self.update_strong_authentication(user_id, data)
      put_request(File.join('users', user_id.to_s, 'strongAuthentication'), data)
    end

    def self.expense_sites(user_id, wallet_id)
      get_request(File.join('expense-sites'), "userID=#{user_id.to_s}&walletID=#{wallet_id.to_s}")
    end
  end
end
