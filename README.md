# leetchi-api-ruby-sdk

The gem for interacting with Leetchi API.
See the [API documentation](http://doc.api.leetchi.com/) for more details on the API.

Tested on the following versions of Ruby: 1.9.2, 1.9.3

## Requirements

This gem uses mainly ruby stdlib and the *json* gem.

## Configuration

Setup the following ENV:

```ruby
ENV['LEETCHI_API_BASE_URL'] = "https://api-preprod.leetchi.com" # once you've run your test using the preproduction environment use the production one
ENV['LEETCHI_KEY_PATH'] = "abcd"                                # the full path to your leetchi key
ENV['LEETCHI_PASSPHRASE'] = "efgh"                              # you key's passphrase (leave blank if none)
ENV['LEETCHI_PARTNER_ID'] = "myID"                              # your Leetchi API ID
```

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
