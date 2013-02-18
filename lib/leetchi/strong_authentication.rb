module Leetchi
    class StrongAuthentication < Leetchi::Ressource
        def self.get
            get_request(File.join('strongAuthentication'))
        end
    end
end
