require_relative '../../spec_helper'

describe Leetchi::Contribution do

    include Capybara::DSL

    before do
        VCR.insert_cassette 'contribution', :record => :new_episodes
    end
    after do
        VCR.eject_cassette
    end

    let(:new_user) {
        Leetchi::User.create({
            'Tag' => 'test',
            'Email' => 'my@email.com',
            'FirstName' => 'John',
            'LastName' => 'Doe',
            'CanRegisterMeanOfPayment' => true
            })
    }

    let(:new_contribution) do
        contribution = Leetchi::Contribution.create({
            'Tag' => 'test_contribution',
            'UserID' => new_user['ID'],
            'WalletID' => 0,
            'Amount' => 10000,
            'ReturnURL' => 'https://leetchi.com',
            'BankAccountBIC' => 'AGRIFRPP879'
            })
        visit(contribution['PaymentURL'])
        fill_in('number', :with => '4970100000000154')
        fill_in('cvv', :with => '123')
        click_button('paybutton')
        contribution
    end

    let(:new_contribution_refund) {
        Leetchi::Contribution.refund({
            'ContributionID' => new_contribution['ID'],
            'UserID' => new_user['ID'],
            'Tag' => 'test_contribution_refund'
            })
    }

    describe "CREATE" do
        it "creates a contribution" do
            new_contribution['ID'].wont_be_nil
            new_contribution['PaymentURL'].wont_be_nil
        end
    end

    describe "GET" do
        it "get the contribution" do
            contribution = Leetchi::Contribution.details(new_contribution['ID'])
            contribution['ID'].must_equal new_contribution['ID']
        end
    end

    describe "REFUND" do
        it "creates a refund request for the contribution" do
            new_contribution_refund['ID'].wont_be_nil
        end
        it "gets the refund request" do
            contribution_refund = Leetchi::Contribution.get_refund(new_contribution_refund['ID'])
            contribution_refund['ID'].must_equal new_contribution_refund['ID']
        end
    end
end
