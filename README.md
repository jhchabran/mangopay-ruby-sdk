# leetchi-api-ruby-sdk

The gem for interacting with Leetchi API.
See the [API documentation](http://doc.api.leetchi.com/) for more details on the API.

Tested on the following versions of Ruby: ruby 1.9.3p125

## Requirements

This gem uses mainly ruby stdlib and the *json* gem.

## Configuration

Setup the following ENV:

```ruby
ENV['LEETCHI_KEY_BASE64'] = "abcd"    # your Base64 encoded Leetchi API key
ENV['LEETCHI_PASSPHRASE'] = "efgh"    # you key's passphrase (leave blank if none)
ENV['LEETCHI_PARTNER_ID'] = "myID"    # your Leetchi API ID
```

## Usage

The gem implements the following ressources:
- Beneficiary
- Card
- Contribution
- Transfer
- User
- Wallet
- Withdrawal

Each ressource has specifics methods such has `create`, `details`, `update`, etc. Those methods must be called with an ID and / or an Object matching the Leetchi API. Calling those methods return the Leetchi API response has an object. Every executions are made synchronously.

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
