require_relative '../../spec_helper'

describe MangoPay::Expense do

    describe "GET" do
        it "get the expense" do
            card = MangoPay::Expense.get(1)
        end
    end
end
