module Leetchi

  require 'json'
  require 'base64'
  require 'openssl'
  require 'net/http'

  require 'leetchi/ressource'
  require 'leetchi/user'
  require 'leetchi/wallet'
  require 'leetchi/card'
  require 'leetchi/contribution'
  require 'leetchi/transfer'
  require 'leetchi/beneficiary'
  require 'leetchi/withdrawal'
  require 'leetchi/strong_authentication'
  require 'leetchi/operation'

  API_BASE_URL = 'https://api-preprod.leetchi.com'

end
