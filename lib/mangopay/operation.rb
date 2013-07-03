module MangoPay
    # Operation
    class Operation < MangoPay::Ressource

        # Get an operation
        #
        # * *Args*    :
        #   - +operation_id+ -> The id of the operation you want to retrieve
        # * *Returns* :
        #   - An operation object
        #
        def self.get(operation_id)
            get_request(File.join('operations', operation_id.to_s))
        end
    end
end
