module Leetchi
  class Transfer < Leetchi::Ressource

    def self.create data
      post_request('transfers', data)
    end

    def self.details transfer_id
      get_request(File.join('transfers', transfer_id.to_s))
    end

  end
end
