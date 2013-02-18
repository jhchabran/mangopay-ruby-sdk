module Leetchi
  class Withdrawal < Leetchi::Ressource

    def self.create(data)
      post_request('withdrawals', data)
    end

    def self.details(withdrawal_id)
      get_request(File.join('withdrawals', withdrawal_id.to_s))
    end

  end
end
