module Leetchi
  class Transfer < Leetchi::Ressource

    def self.create(data)
      post_request('transfers', data)
    end

    def self.details(transfer_id)
      get_request(File.join('transfers', transfer_id.to_s))
    end

    def self.refund(data)
      post_request(File.join('transfer-refunds'), data)
    end

    def self.get_refund(transfer_refund_id)
      get_request(File.join('transfer-refunds', transfer_refund_id.to_s))
    end
  end
end
