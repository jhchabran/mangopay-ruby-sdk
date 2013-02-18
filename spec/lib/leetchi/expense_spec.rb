require_relative '../../spec_helper'

describe Leetchi::Expense do

    before do
        VCR.insert_cassette 'expense', :record => :new_episodes
    end
    after do
        VCR.eject_cassette
    end

    describe "GET" do
        it "get the expense" do
            card = Leetchi::Expense.get(1)
        end
    end
end
