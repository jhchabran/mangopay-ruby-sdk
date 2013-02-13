require_relative '../../spec_helper'

describe Leetchi::Contribution do
    describe "GET" do
        before do
            VCR.insert_cassette 'contribution', :record => :new_episodes
        end
        after do
            VCR.eject_cassette
        end

        it "records the fixture" do
            Leetchi::Contribution.details("1")
        end
    end
end
