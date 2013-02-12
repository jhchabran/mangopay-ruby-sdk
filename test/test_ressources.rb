require 'test_helper'

class TestTransfer < Test::Unit::TestCase

  context 'a new user' do

    setup do
      @data = {
        'Email' => "alpha@test.com",
        'FirstName' => 'alpha',
        'LastName' => 'gamma',
        'CanRegisterMeanOfPayment' => true,
        'Password' => 'abcabc',
        'IP' => '88.189.197.115',
        'Tag' => 'beta',
        'Birthday' => 123456789
      }
      @user = Leetchi::User.create(@data)
    end

    should "be ok" do
      assert_kind_of(Object, @user, 'response should be a object')
      assert_nil(@user['ErrorCode'], 'response is an error')
      assert_equal(@data['Email'], @user['Email'], 'Email attribute is wrong')
      assert_equal(@data['FirstName'], @user['FirstName'], 'FirstName attribute is wrong')
      assert_equal(@data['LastName'], @user['LastName'], 'LastName attribute is wrong')
      assert_equal(@data['Tag'], @user['Tag'], 'Tag attribute is wrong')
      assert_equal(@data['CanRegisterMeanOfPayment'], @user['CanRegisterMeanOfPayment'], 'CanRegisterMeanOfPayment attribute is wrong')
      assert_equal(false, @user['HasRegisteredMeansOfPayment'], 'HasRegisteredMeansOfPayment wrong value')
      assert_equal(0, @user['PersonalWalletAmount'], 'PersonalWalletAmount wrong value')
      assert_kind_of(Fixnum, @user['ID'], 'ID wrong type')
      assert_kind_of(Fixnum, @user['CreationDate'], 'CreationDate wrong type')
      assert_kind_of(Fixnum, @user['UpdateDate'], 'UpdateDate wrong type')
    end

    context 'modified' do

      setup do
        @update_data = {
          'Email' => 'abc@abc.abc',
          'FirstName' => 'abc',
          'LastName' => 'def',
          'CanRegisterMeanOfPayment' => false,
          'Tag' => 'ghi',
          'Password' => 987654321
        }
        @user = Leetchi::User.update(@user['ID'], @update_data)
      end

      should "be updated" do
        assert_kind_of(Object, @user, 'response should be a object')
        assert_nil(@user['ErrorCode'], 'response is an error')
        assert_equal(@update_data['Email'], @user['Email'], 'Email attribute is wrong')
        assert_equal(@update_data['FirstName'], @user['FirstName'], 'FirstName attribute is wrong')
        assert_equal(@update_data['LastName'], @user['LastName'], 'LastName attribute is wrong')
        assert_equal(@update_data['CanRegisterMeanOfPayment'], @user['CanRegisterMeanOfPayment'], 'CanRegisterMeanOfPayment attribute is wrong')
        assert_equal(@update_data['Tag'], @user['Tag'], 'Tag attribute is wrong')
      end

      context 'then retrieved' do

        setup do
          @details = Leetchi::User.details(@user['ID'])
        end

        should "be ok" do
          assert_kind_of(Object, @details, 'response should be a object')
          assert_nil(@details['ErrorCode'], 'response is an error')
          assert_equal(@user['ID'], @details['ID'], 'ID does not match')
          assert_equal(@user['Email'], @details['Email'], 'Email does not match')
          assert_equal(@user['FirstName'], @details['FirstName'], 'FirstName does not match')
          assert_equal(@user['LastName'], @details['LastName'], 'LastName does not match')
          assert_equal(@user['Tag'], @details['Tag'], 'Tag does not match')
          assert_equal(@user['CanRegisterMeanOfPayment'], @details['CanRegisterMeanOfPayment'], 'CanRegisterMeanOfPayment does not match')
          assert_equal(@user['HasRegisteredMeansOfPayment'], @details['HasRegisteredMeansOfPayment'], 'HasRegisteredMeansOfPayment does not match')
          assert_equal(@user['CreationDate'], @details['CreationDate'], 'CreationDate does not match')
          assert_equal(@user['UpdateDate'], @details['UpdateDate'], 'UpdateDate does not match')
          assert_equal(@user['PersonalWalletAmount'], @details['PersonalWalletAmount'], 'PersonalWalletAmount does not match')
        end

      end # a new user modified then retrieved

    end # a new user modified modified

    context 'wallets' do

      setup do
        @wallets = Leetchi::User.get_wallets(@user['ID'])
      end

      should "be ok" do
        assert_kind_of(Array, @wallets, 'response should be an Array')
      end

      should "be empty" do
        assert_equal(0, @wallets.length, 'user should not have wallets yet')
      end

    end # a new user wallets

    context 'a new wallet' do

      setup do
        @data = {
          'Tag' => 'abc',
          'Owners' => [@user['ID']],
          'Name' => 'def',
          'Description' => 'iop',
          'RaisingGoalAmount' => 100,
          'ContributionLimitDate' => 3000000000
        }
        @wallet = Leetchi::Wallet.create(@data)
      end

      should "be ok" do
        assert_kind_of(Object, @wallet, 'response should be a object')
        assert_nil(@wallet['ErrorCode'], 'response is an error')
        assert_equal(@data['Tag'], @wallet['Tag'], 'Tag attribute is wrong')
        assert_equal(@data['Owners'], @wallet['Owners'], 'Owners attribute is wrong')
        assert_equal(@data['Name'], @wallet['Name'], 'Name attribute is wrong')
        assert_equal(@data['Description'], @wallet['Description'], 'Description attribute is wrong')
        assert_equal(@data['RaisingGoalAmount'], @wallet['RaisingGoalAmount'], 'RaisingGoalAmount attribute is wrong')
        assert_equal(@data['ContributionLimitDate'], @wallet['ContributionLimitDate'], 'ContributionLimitDate attribute is wrong')
        assert_kind_of(Fixnum, @wallet['CollectedAmount'], 'CollectedAmount wrong type')
        assert_kind_of(Fixnum, @wallet['CreationDate'], 'CreationDate wrong type')
        assert_kind_of(Fixnum, @wallet['ID'], 'ID wrong type')
        assert_kind_of(Fixnum, @wallet['UpdateDate'], 'UpdateDate wrong type')
        assert_equal(true, @wallet['IsClosed'], 'IsClosed wrong type')
        assert_equal(0, @wallet['SpentAmount'], 'SpentAmount wrong type')
      end

      context 'modified' do

        setup do
          @update_data = {
            'Name' => 'zxc',
            'Description' => 'vbn',
            'RaisingGoalAmount' => 2000,
            'Tag' => 'fgh'
          }
          @wallet = Leetchi::Wallet.update(@wallet['ID'], @update_data)
        end

        should "be updated" do
          assert_kind_of(Object, @wallet, 'response should be a object')
          assert_nil(@wallet['ErrorCode'], 'response is an error')
          assert_equal(@update_data['Name'], @wallet['Name'], 'Name is wrong')
          assert_equal(@update_data['Description'], @wallet['Description'], 'Description is wrong')
          assert_equal(@update_data['RaisingGoalAmount'], @wallet['RaisingGoalAmount'], 'RaisingGoalAmount is wrong')
          assert_equal(@update_data['Tag'], @wallet['Tag'], 'Tag is wrong')
        end

        context 'then retrieved' do

          setup do
            @details = Leetchi::Wallet.details(@wallet['ID'])
          end

          should "be ok" do
            assert_kind_of(Object, @details, 'response should be a object')
            assert_nil(@details['ErrorCode'], 'response is an error')
            assert_equal(@wallet['Tag'], @details['Tag'], 'Tag attribute is wrong')
            assert_equal(@wallet['Owners'], @details['Owners'], 'Owners attribute is wrong')
            assert_equal(@wallet['Name'], @details['Name'], 'Name attribute is wrong')
            assert_equal(@wallet['Description'], @details['Description'], 'Description attribute is wrong')
            assert_equal(@wallet['RaisingGoalAmount'], @details['RaisingGoalAmount'], 'RaisingGoalAmount attribute is wrong')
            assert_equal(@wallet['ContributionLimitDate'], @details['ContributionLimitDate'], 'ContributionLimitDate attribute is wrong')
            assert_equal(@wallet['CollectedAmount'], @details['CollectedAmount'], 'CollectedAmount attrinute is wrong')
            assert_equal(@wallet['CreationDate'], @details['CreationDate'], 'CreationDate attrinute is wrong')
            assert_equal(@wallet['ID'], @details['ID'], 'ID attrinute is wrong')
            assert_equal(@wallet['UpdateDate'], @details['UpdateDate'], 'UpdateDate attrinute is wrong')
            assert_equal(@wallet['IsClosed'], @details['IsClosed'], 'IsClosed attrinute is wrong')
            assert_equal(@wallet['SpentAmount'], @details['SpentAmount'], 'SpentAmount attrinute is wrong')
          end

        end # a new user new wallet modified then retrieved

      end # a new user new wallet modified

      context 'owners' do

        setup do
          @owners = Leetchi::Wallet.get_owners(@wallet['ID'])
        end

        should "be ok" do
          assert_kind_of(Array, @owners, 'response should be an Array')
        end

        should "be one" do
          assert_equal(1, @owners.length, 'wallet should have one owner')
        end

        should "be the user" do
          assert_equal(@user['ID'], @owners.first['ID'], 'wallet\'s owner is not the right one')
        end

      end # new user new wallet owners

      context 'contributors' do

        setup do
          @contributors = Leetchi::Wallet.get_contributors(@wallet['ID'])
        end

        should "be ok" do
          assert_kind_of(Array, @contributors, 'response should be an Array')
        end

        should "be empty" do
          assert_equal(1, @contributors.length, 'wallet should have no contributors')
        end

      end # new user new wallet contributors

      context 'refunded users' do

        setup do
          @refunded = Leetchi::Wallet.get_refunded(@wallet['ID'])
        end

        should "be ok" do
          assert_kind_of(Array, @refunded, 'response should be an Array')
        end

        should "be empty" do
          assert_equal(1, @refunded.length, 'wallet should have no refunded')
        end

      end # new user new wallet refunded users


      context 'a new contributor' do

        setup do
          @data = {
            'Email' => "beta@test.com",
            'FirstName' => 'beta',
            'LastName' => 'omega',
            'CanRegisterMeanOfPayment' => true,
            'Password' => 'abcabc',
            'IP' => '88.189.197.116',
            'Tag' => 'omega',
            'Birthday' => 123456789
          }
          @contributor = Leetchi::User.create(@data)
          @contributor_wallet = Leetchi::Wallet.create({'Owners' => [@contributor['ID']]})
        end

        context 'a 10 euros contribution to the wallet' do

          setup do
            @data = {
              'Tag' => 'abc',
              'UserID' => @contributor['ID'],
              'WalletID' => @wallet['ID'],
              'Amount' => 1000,
              'ClientFeeAmount' => 0,
              'ReturnURL' => 'http://www.return.com/',
              #'TemplateURL' => 'http://www.template.com/something.html',
              'RegisterMeanOfPayment' => false,
              'PaymentCardID' => 0,
            }
            @contribution = Leetchi::Contribution.create(@data)
          end

          should "be ok" do
            assert_kind_of(Object, @contribution, 'response should be a object')
            assert_nil(@contribution['ErrorCode'], 'response is an error')
            assert_equal(@data['Tag'], @contribution['Tag'], 'Tag attribute is wrong')
            assert_equal(@data['UserID'], @contribution['UserID'], 'UserID attribute is wrong')
            assert_equal(@data['WalletID'], @contribution['WalletID'], 'WalletID attribute is wrong')
            assert_equal(@data['Amount'], @contribution['Amount'], 'Amount attribute is wrong')
            assert_equal(@data['ClientFeeAmount'], @contribution['ClientFeeAmount'], 'ClientFeeAmount attribute is wrong')
            assert_equal(@data['ReturnURL'] + '?ContributionID=' + @contribution['ID'].to_s, @contribution['ReturnURL'], 'ReturnURL attribute is wrong')
            #assert_equal(@data['TemplateURL'], @contribution['TemplateURL']TemplateURL, 'TemplateURL attribute is wrong')
            assert_equal(@data['RegisterMeanOfPayment'], @contribution['RegisterMeanOfPayment'], 'RegisterMeanOfPayment attribute is wrong')
            assert_equal(@data['PaymentCardID'], @contribution['PaymentCardID'], 'PaymentCardID attribute is wrong')
            assert_kind_of(Fixnum, @contribution['ID'], 'ID wrong type')
            assert_kind_of(Fixnum, @contribution['CreationDate'], 'CreationDate wrong type')
            assert_kind_of(Fixnum, @contribution['UpdateDate'], 'UpdateDate wrong type')
            assert_equal(false, @contribution['IsSucceeded'], 'IsSucceeded wrong type')
            assert_equal(false, @contribution['IsCompleted'], 'IsCompleted wrong type')
            assert_kind_of(String, @contribution['PaymentURL'], 'PaymentURL wrong type')
            assert_kind_of(String, @contribution['Culture'], 'Culture wrong type')
            assert_kind_of(String, @contribution['Type'], 'Type wrong type')
          end

          context 'retrieved details' do

            setup do
              @details = Leetchi::Contribution.details(@contribution['ID'])
            end

            should "match" do
              assert_kind_of(Object, @contribution, 'response should be a object')
              assert_nil(@contribution['ErrorCode'], 'response is an error')
              assert_equal(@contribution['ID'], @details['ID'], 'ID attribute is wrong')
              assert_equal(@contribution['Tag'], @details['Tag'], 'Tag attribute is wrong')
              assert_equal(@contribution['CreationDate'], @details['CreationDate'], 'CreationDate attribute is wrong')
              assert_equal(@contribution['UpdateDate'], @details['UpdateDate'], 'UpdateDate attribute is wrong')
              assert_equal(@contribution['UserID'], @details['UserID'], 'UserID attribute is wrong')
              assert_equal(@contribution['WalletID'], @details['WalletID'], 'WalletID attribute is wrong')
              assert_equal(@contribution['Amount'], @details['Amount'], 'Amount attribute is wrong')
              assert_equal(@contribution['ClientFeeAmount'], @details['ClientFeeAmount'], 'ClientFeeAmount attribute is wrong')
              assert_equal(@contribution['LeetchiFeeAmount'], @details['LeetchiFeeAmount'], 'LeetchiFeeAmount attribute is wrong')
              assert_equal(@contribution['IsSucceeded'], @details['IsSucceeded'], 'IsSucceeded attribute is wrong')
              assert_equal(@contribution['IsCompleted'], @details['IsCompleted'], 'IsCompleted attribute is wrong')
              assert_equal(@contribution['PaymentURL'], @details['PaymentURL'], 'PaymentURL attribute is wrong')
              #assert_equal(@contribution['TemplateURL'], @details['TemplateURL'], 'TemplateURL attribute is wrong')
              assert_equal(@contribution['ReturnURL'], @details['ReturnURL'], 'ReturnURL attribute is wrong')
              assert_equal(@contribution['RegisterMeanOfPayment'], @details['RegisterMeanOfPayment'], 'RegisterMeanOfPayment attribute is wrong')
              assert_equal(@contribution['PaymentCardID'], @details['PaymentCardID'], 'PaymentCardID attribute is wrong')
              assert_equal(@contribution['Culture'], @details['Culture'], 'Culture attribute is wrong')
              assert_equal(@contribution['Type'], @details['Type'], 'Type attribute is wrong')
            end

          end # new user new wallet new contributor a contribution to the wallet retrieved

          context 'a 5 euros transfert from the wallet' do

            setup do
              @data = {
                'Tag' => 'abc',
                'PayerID' => @user['ID'],
                'BeneficiaryID' => @contributor['ID'],
                'Amount' => 500,
                'PayerWalletID' => @wallet['ID'],
                'BeneficiaryWalletID' => @contributor_wallet['ID'],
              }
              @transfer = Leetchi::Transfer.create(@data)
              puts @transfer
            end

            should "be ok" do
              # TODO we cannot test this has the transfert will fail because te contribution was not completed by a payement
            end

            # TODO retrieved details...

          end # new user new wallet new contributor a 10 euros contribution to the wallet a 5 euros transfert from the wallet

        end # new user new wallet new contributor a 10 euros contribution to the wallet

        context 'a new card' do

          setup do
            @data = {
              'Tag' => 'abc',
              'OwnerID' => @contributor['ID'],
              'ReturnURL' => 'http://www.return.com/',
              'TemplateURL' => 'http://www.template.com/index.html'
            }
            @card = Leetchi::Card.create(@data)
          end

          should "be ok" do
            assert_kind_of(Object, @card, 'response should be a object')
            assert_nil(@card['ErrorCode'], 'response is an error')
            assert_equal(@data['Tag'], @card['Tag'], 'Tag attribute is wrong')
            assert_equal(@data['OwnerID'], @card['OwnerID'], 'OwnerID attribute is wrong')
            assert_equal(@data['ReturnURL'], @card['ReturnURL'], 'ReturnURL attribute is wrong')
            assert_equal(@data['TemplateURL'], @card['TemplateURL'], 'TemplateURL attribute is wrong')
            assert_kind_of(Fixnum, @card['ID'], 'ID wrong type')
            assert_kind_of(Fixnum, @card['CardNumber'], 'CardNumber wrong type')
            assert_kind_of(Fixnum, @card['RedirectURL'], 'RedirectURL wrong type')
          end

        end

      end # new user new wallet new contributor

    end # new user new wallet

  end # new user

end
