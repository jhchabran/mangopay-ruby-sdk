module Leetchi
  class RecurrentContribution < Leetchi::Ressource

    def self.create(data)
      post_request('recurrent-contributions', data)
    end

    def self.get(recurrent_contributions_id)
      get_request(File.join('recurrent-contributions', recurrent_contributions_id.to_s))
    end
  end
end
