require_relative '../../spec_helper'

describe Leetchi::Expense do

    describe "GET" do
        it "get the expense" do
            card = Leetchi::Expense.get(1)
        end
    end
end
