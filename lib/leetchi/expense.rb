module Leetchi
   # In order to make an expense you need to get a list of expense sites and then redirect a user to ExpenseURL.
   # When the user selects a product and pays, you will be notified about an expense through the notification mechanism.
  class Expense < Leetchi::Ressource

    # Get an expense
    #
    # * *Args*    :
    #   - +expense_id+ -> The id of the expense you want to retrieve
    # * *Returns* :
    #   - An expense object
    #
    def self.get(expense_id)
      get_request(File.join('expenses', expense_id.to_s))
    end
  end
end
