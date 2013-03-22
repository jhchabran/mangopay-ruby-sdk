require_relative '../../spec_helper'

describe Leetchi::StrongAuthentication do

  let(:new_user) {
    Leetchi::User.create({
      'Tag' => 'test',
      'Email' => 'my@email.com',
      'FirstName' => 'John',
      'LastName' => 'Doe',
      'CanRegisterMeanOfPayment' => true
      })
  }

  let(:new_beneficiary) {
    Leetchi::Beneficiary.create({
      'Tag' => 'test',
      'UserID' => new_user['ID'],
      'BankAccountOwnerName' => new_user['FirstName'],
      'BankAccountOwnerAddress' => '1 bis cite paradis',
      'BankAccountIBAN' => 'FR76 1790 6000 3200 0833 5232 973',
      'BankAccountBIC' => 'AGRIFRPP879'
      })
  }

  let(:new_strong_authentication) {
    Leetchi::Beneficiary.create_strong_authentication(new_beneficiary['ID'], {
      'Tag' => 'test_beneficiary_strong_authentication'
      })
  }

  describe "GET" do
    it "get the pending strong authentication requests" do
      strong_authentication = Leetchi::StrongAuthentication.get
      expect(strong_authentication).to be_kind_of(Array)
    end
  end

  describe "UPLOAD" do
    it "uploads a PDF file to complete a beneficiary strong authentication request" do
      document_upload = Leetchi::StrongAuthentication.upload(new_strong_authentication['UrlRequest'], 'spec/support-files/test_upload.pdf')
      expect(document_upload).to be_true
    end
    it "uploads a JPG file to complete a beneficiary strong authentication request" do
      document_upload = Leetchi::StrongAuthentication.upload(new_strong_authentication['UrlRequest'], 'spec/support-files/test_upload.jpg')
      expect(document_upload).to be_true
    end
    it "uploads a PNG file to complete a beneficiary strong authentication request" do
      document_upload = Leetchi::StrongAuthentication.upload(new_strong_authentication['UrlRequest'], 'spec/support-files/test_upload.png')
      expect(document_upload).to be_true
    end
    it "uploads a GIF file to complete a beneficiary strong authentication request" do
      document_upload = Leetchi::StrongAuthentication.upload(new_strong_authentication['UrlRequest'], 'spec/support-files/test_upload.gif')
      expect(document_upload).to be_true
    end
  end
end
