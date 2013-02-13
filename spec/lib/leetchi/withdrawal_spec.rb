require_relative '../../spec_helper'

describe Leetchi::Withdrawal do

    before do
        VCR.insert_cassette 'withdrawal', :record => :new_episodes
    end
    after do
        VCR.eject_cassette
    end

    describe "GET" do
        it "records the fixture" do
            Leetchi::Withdrawal.details("1")
        end
    end
end
