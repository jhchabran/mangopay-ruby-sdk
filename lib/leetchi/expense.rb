module Leetchi
  class Expense < Leetchi::Ressource

    def self.get(expense_id)
      get_request(File.join('expenses', expense_id.to_s))
    end
  end
end
