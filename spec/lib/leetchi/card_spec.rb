require_relative '../../spec_helper'

describe Leetchi::Card do
    describe "GET" do
        before do
            VCR.insert_cassette 'card', :record => :new_episodes
        end
        after do
            VCR.eject_cassette
        end

        it "records the fixture" do
            Leetchi::Card.details("1")
        end
    end
end
