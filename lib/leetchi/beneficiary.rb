module Leetchi
  class Beneficiary < Leetchi::Ressource

    def self.create(data)
      post_request('beneficiaries', data)
    end

    def self.details(beneficiary_id)
      get_request(File.join('beneficiaries', beneficiary_id.to_s))
    end

    def self.create_strong_authentication(beneficiary_id, data)
        post_request(File.join('beneficiaries', beneficiary_id.to_s, 'strongAuthentication'), data)
    end

    def self.get_strong_authentication(beneficiary_id)
        get_request(File.join('beneficiaries', beneficiary_id.to_s, 'strongAuthentication'))
    end

    def self.update_strong_authentication(beneficiary_id, data)
        put_request(File.join('beneficiaries', beneficiary_id.to_s, 'strongAuthentication'), data)
    end

  end
end
