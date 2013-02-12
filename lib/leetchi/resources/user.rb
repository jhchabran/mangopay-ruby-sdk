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
      get_request(File.join('users',user_id.to_s, 'wallets'))
    end

  end
end
