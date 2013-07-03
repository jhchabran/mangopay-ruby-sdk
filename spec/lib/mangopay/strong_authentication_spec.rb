require_relative '../../spec_helper'

describe MangoPay::StrongAuthentication do

  let(:new_user) {
    MangoPay::User.create({
      'Tag' => 'test',
      'Email' => 'my@email.com',
      'FirstName' => 'John',
      'LastName' => 'Doe',
      'CanRegisterMeanOfPayment' => true
      })
  }

  let(:new_beneficiary) {
    MangoPay::Beneficiary.create({
      'Tag' => 'test',
      'UserID' => new_user['ID'],
      'BankAccountOwnerName' => new_user['FirstName'],
      'BankAccountOwnerAddress' => '1 bis cite paradis',
      'BankAccountIBAN' => 'FR76 1790 6000 3200 0833 5232 973',
      'BankAccountBIC' => 'AGRIFRPP879'
      })
  }

  let(:new_strong_beneficiary_authentication) {
    MangoPay::Beneficiary.create_strong_authentication(new_beneficiary['ID'], {
      'Tag' => 'test_beneficiary_strong_authentication'
      })
  }

  let(:new_strong_user_authentication) {
    MangoPay::User.create_strong_authentication(new_user['ID'], {
      'Tag' => 'test_user_strong_authentication'
      })
  }

  describe "GET" do
    it "get the pending strong authentication requests" do
      strong_authentication = MangoPay::StrongAuthentication.get
      expect(strong_authentication).to be_kind_of(Array)
    end
  end

  describe "UPLOAD BENEFICIARY" do
    it "uploads a PDF file to complete a beneficiary strong authentication request" do
      document_upload = MangoPay::StrongAuthentication.upload(new_strong_beneficiary_authentication['UrlRequest'], 'spec/support-files/test_upload.pdf')
      expect(document_upload).to be_true
    end
    it "uploads a JPG file to complete a beneficiary strong authentication request" do
      document_upload = MangoPay::StrongAuthentication.upload(new_strong_beneficiary_authentication['UrlRequest'], 'spec/support-files/test_upload.jpg')
      expect(document_upload).to be_true
    end
    it "uploads a PNG file to complete a beneficiary strong authentication request" do
      document_upload = MangoPay::StrongAuthentication.upload(new_strong_beneficiary_authentication['UrlRequest'], 'spec/support-files/test_upload.png')
      expect(document_upload).to be_true
    end
    it "uploads a GIF file to complete a beneficiary strong authentication request" do
      document_upload = MangoPay::StrongAuthentication.upload(new_strong_beneficiary_authentication['UrlRequest'], 'spec/support-files/test_upload.gif')
      expect(document_upload).to be_true
    end
  end

  describe "UPLOAD USER" do
    it "uploads a PDF file to complete a user strong authentication request" do
      document_upload = MangoPay::StrongAuthentication.upload(new_strong_user_authentication['UrlRequest'], 'spec/support-files/test_upload.pdf')
      expect(document_upload).to be_true
    end
    it "uploads a JPG file to complete a user strong authentication request" do
      document_upload = MangoPay::StrongAuthentication.upload(new_strong_user_authentication['UrlRequest'], 'spec/support-files/test_upload.jpg')
      expect(document_upload).to be_true
    end
    it "uploads a PNG file to complete a user strong authentication request" do
      document_upload = MangoPay::StrongAuthentication.upload(new_strong_user_authentication['UrlRequest'], 'spec/support-files/test_upload.png')
      expect(document_upload).to be_true
    end
    it "uploads a GIF file to complete a user strong authentication request" do
      document_upload = MangoPay::StrongAuthentication.upload(new_strong_user_authentication['UrlRequest'], 'spec/support-files/test_upload.gif')
      expect(document_upload).to be_true
    end
  end
end
