module Leetchi
    # Get all the strongAuthentication created who need to be validated.
    # It's important to understand that Leetchi can create himself the request of strongAuthentication, if a user reaches some limits.
    class StrongAuthentication < Leetchi::Ressource

        # Get all the strongAuthentication created who need to be validated
        #
        # * *Returns* :
        #   - A array of strongAuthentication objects
        #
        def self.get
            get_request(File.join('strongAuthentication'))
        end
    end
end
