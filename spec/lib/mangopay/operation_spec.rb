require_relative '../../spec_helper'

describe MangoPay::Operation do

    it "gets the operation" do
        operation = MangoPay::Operation.get(1)
    end
end
