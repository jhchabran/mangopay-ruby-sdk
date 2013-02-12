module Leetchi
  class Beneficiary < Leetchi::Ressource

    def self.create(data)
      post_request('beneficiaries', data)
    end

    def self.details(beneficiary_id)
      get_request(File.join('beneficiaries', beneficiary_id.to_s))
    end

  end
end
