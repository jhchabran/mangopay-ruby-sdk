require_relative '../../spec_helper'

describe Leetchi::Transfer do
    before do
        VCR.insert_cassette 'transfer', :record => :new_episodes
    end
    after do
        VCR.eject_cassette
    end

    describe "GET" do
        it "records the fixture" do
            Leetchi::Transfer.details("1")
        end
    end
end
