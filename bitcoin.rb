require 'rest_client'
require 'pry'
require 'json'

module Bitcoin
  def Bitcoin.balance(address)
    response = RestClient.get "https://api.coinprism.com/v1/addresses/#{address}"
    JSON.parse(response)["balance"]
  end

  def Bitcoin.addresses_holding_asset(asset_id) # all the addresses
    # holding a certain class of coins
    response = RestClient.get "https://api.coinprism.com/v1/assets/#{asset_id}/owners"
    JSON.parse(response)
  end

  def Bitcoin.send_vote(from, to, metadata)
   values = "{
  'from': #{from}
  'address': to,
  'amount': '1',
  'metadata': 'u=https://site.com/assetdef' }"

    headers = {
      :content_type => 'application/json'
    }

    response = RestClient.post 'https://api.coinprism.com/v1/issueasset?format=json', values, headers
    
  end
end
