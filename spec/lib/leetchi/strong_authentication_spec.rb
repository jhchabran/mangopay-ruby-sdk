require_relative '../../spec_helper'

describe Leetchi::StrongAuthentication do

    describe "GET" do
        it "get the pending strong authentication requests" do
            strong_authentication = Leetchi::StrongAuthentication.get
            expect(strong_authentication).to be_kind_of(Array)
        end
    end
end
