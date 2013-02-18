require_relative '../../spec_helper'

describe Leetchi::Operation do
    before do
        VCR.insert_cassette 'operation', :record => :new_episodes
    end
    after do
        VCR.eject_cassette
    end

    it "gets the operation" do
        operation = Leetchi::Operation.get(1)
    end
end
