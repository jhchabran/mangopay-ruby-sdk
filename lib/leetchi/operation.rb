module Leetchi
    class Operation < Leetchi::Ressource
        def self.get(operation_id)
            get_request(File.join('operations', operation_id.to_s))
        end
    end
end
