require_relative '../../spec_helper'

describe Leetchi::StrongAuthentication do
    before do
        VCR.insert_cassette 'strong_authentication', :record => :new_episodes
    end
    after do
        VCR.eject_cassette
    end

    describe "GET" do
        it "get the pending strong authentication requests" do
            strong_authentication = Leetchi::StrongAuthentication.get
            strong_authentication.must_be_kind_of Array
        end
    end
end
