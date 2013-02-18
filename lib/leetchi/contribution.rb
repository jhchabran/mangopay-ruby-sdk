module Leetchi
  class Contribution < Leetchi::Ressource

    def self.create(data)
      post_request('contributions', data)
    end

    def self.details(contribution_id)
      get_request(File.join('contributions', contribution_id.to_s))
    end

    def self.refund(data)
      post_request(File.join('refunds'), data)
    end

    def self.get_refund(contribution_refund_id)
      get_request(File.join('refunds', contribution_refund_id.to_s))
    end
  end
end
