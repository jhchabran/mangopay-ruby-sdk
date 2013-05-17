# leetchi-api-ruby-sdk

The gem for interacting with Leetchi API.
See the [API documentation](http://www.mangopay.com/api-references/) for more details on the API.

Tested on the following versions of Ruby: 1.9.2, 1.9.3, 2.0.0

## Code Status
[![Build Status](https://travis-ci.org/Leetchi/leetchi-api-ruby-sdk.png?branch=master)](https://travis-ci.org/Leetchi/leetchi-api-ruby-sdk)
[![Code Climate](https://codeclimate.com/github/Leetchi/leetchi-api-ruby-sdk.png)](https://codeclimate.com/github/Leetchi/leetchi-api-ruby-sdk)
[![Dependency Status](https://gemnasium.com/Leetchi/leetchi-api-ruby-sdk.png)](https://gemnasium.com/Leetchi/leetchi-api-ruby-sdk)

## Requirements

This gem uses mainly ruby stdlib and the *json* gem.

## Configuration

Please note that the gem configuration process change between 0.0.1 and 1.0.0.

### Version 0.0.1

Setup the following ENV:

```
ENV['LEETCHI_API_BASE_URL'] = "https://api-preprod.leetchi.com" # once you've run your test using the preproduction environment use the production one
ENV['LEETCHI_KEY_PATH'] = "abcd"                                # the full path to your leetchi key
ENV['LEETCHI_PASSPHRASE'] = "efgh"                              # you key's passphrase (leave blank if none)
ENV['LEETCHI_PARTNER_ID'] = "myID"                              # your Leetchi API ID
```

### Version 1.0.0

You can now call the Leetchi.configure method like this:

```ruby
Leetchi.configure do |c|
    c.preproduction = true
    c.partner_id = 'example'
    c.key_path = './spec/support-files/example.pem'
    c.key_password = ''
end
```

The **preproduction** attribute let you specify if you want to use the preproduction api endpoint.

The **partner_id** is the id that was issue to you during you registration process.

The **key_path** and **key_password** arguments are here to let you use the key you've created before the registration process.

This configure method can of course be use to define a Ruby on Rails initialiser.

## Usage

The gem implements the following resources:  
- Beneficiary  
- Card  
- Contribution  
- Expense  
- Operation  
- Recurrent Contribution (only available in preproduction)  
- Strong Authentication  
- Transfer  
- User  
- Wallet  
- Withdrawal  

Each resource has specifics methods such has `create`, `details`, `update`, etc. Those methods must be called with an ID and / or an Object matching the Leetchi API.
Calling those methods return the Leetchi API response has an object. Every executions are made synchronously.

### Example

This example creates a user and returns its informations:

```ruby
Leetchi::User.create({
    'Tag' => 'test',
    'Email' => 'my@email.com',
    'FistName' => 'Jack',
    'LastName' => 'Nelson',
    'CanRegisterMeanOfPayment' => true
})
```

This example returns a specific user's data:

```ruby
Leetchi::User.details(123)
```

### Tests
Make sure that you have run: ```bundle install```  
Then you just have to run the rake task ```rake test``` to run all the test suite.  
Feel free to report any test failure by creating an issue on the [Gem's Github](https://github.com/Leetchi/leetchi-api-ruby-sdk/issues)

