module MangoPay
    # Get all the strongAuthentication created who need to be validated.
    # It's important to understand that MangoPay can create himself the request of strongAuthentication, if a user reaches some limits.
    class StrongAuthentication < MangoPay::Ressource

        # Get all the strongAuthentication created who need to be validated
        #
        # * *Returns* :
        #   - A array of strongAuthentication objects
        #
        def self.get
            get_request(File.join('strongAuthentication'))
        end

        # Upload your Strong Authentication required files using the MangoPay API
        #
        # * *Args*    :
        #   - +upload_url+ -> The url to where the StrongAuthentication documents need to be uploaded
        #   - +file_path+ -> Local path to the file
        # * *Returns* :
        #   - true if the request is done
        #   - false if the request failed
        #
        def self.upload(upload_url, file_path)
            form_request(upload_url, "StrongValidationDto.Picture", file_path)
        end
    end
end
