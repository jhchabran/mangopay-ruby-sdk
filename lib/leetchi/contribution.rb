module Leetchi
  class Contribution < Leetchi::Ressource

    def self.create(data)
      post_request('contributions', data)
    end

    def self.details(contribution_id)
      get_request(File.join('contributions', contribution_id.to_s))
    end

  end
end
