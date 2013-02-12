module Leetchi
  class Card < Leetchi::Ressource

    def self.create(data)
      post_request('cards', data)
    end

    def self.details(card_id)
      get_request(File.join('cards', card_id.to_s))
    end

    def self.delete(card_id, data)
      put_request(File.join('cards', card_id.to_s), data)
    end

  end
end
