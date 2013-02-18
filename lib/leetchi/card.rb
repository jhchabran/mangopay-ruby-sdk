module Leetchi
  # A payment card.
  class Card < Leetchi::Ressource

    # Create a payment card
    #
    # * *Args*    :
    #   - +data+ -> A JSON with the following attributes (Square brackets for optionals):
    #               * [Tag]
    #               * OwnerID
    #               * ReturnURL
    #               * [TemplateURL]
    # * *Returns* :
    #   - A payment card object
    #
    def self.create(data)
      post_request('cards', data)
    end

    # Get a payment card
    #
    # * *Args*    :
    #   - +card_id+ -> The id of the card you want to retrieve
    # * *Returns* :
    #   - A payment card object
    #
    def self.details(card_id)
      get_request(File.join('cards', card_id.to_s))
    end

    # Delete a payment card
    #
    # * *Args*    :
    #   - +card_id+ -> The id of the card you want to delete
    # * *Returns* :
    #   - A "OK" string on success
    #
    def self.delete(card_id)
      delete_request(File.join('cards', card_id.to_s))
    end
  end
end
