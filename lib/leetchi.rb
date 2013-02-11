module Leetchi

  require 'json'
  require 'base64'
  require 'openssl'
  require 'net/http'

  require 'leetchi/ressource'
  require 'leetchi/ressources/user'
  require 'leetchi/ressources/wallet'
  require 'leetchi/ressources/card'
  require 'leetchi/ressources/contribution'
  require 'leetchi/ressources/transfer'
  require 'leetchi/ressources/beneficiary'
  require 'leetchi/ressources/withdrawal'

  API_BASE_URL = 'https://api-preprod.leetchi.com'

end
