require 'rest_client'
require 'pry'
require 'json'


module Bitcoin
  def Bitcoin.balance(address)
    response = RestClient.get "https://api.coinprism.com/v1/addresses/#{address}"
    JSON.parse(response)
  end

  def Bitcoin.addresses_holding_asset(asset_id) # all the addresses
    # holding a certain class of coins
    response = RestClient.get "https://api.coinprism.com/v1/assets/#{asset_id}/owners"
    JSON.parse(response)["owners"]
  end

  def Bitcoin.count_votecoins(candidate_address, color_id, asset_divisibility_factor)
    Bitcoin.balance(candidate_address)["assets"].select { |asset|  asset["id"] == color_id  }[0]["balance"].to_i / (10 ** asset_divisibility_factor)   
  end

  def Bitcoin.get_asset_definition(asset_id)
    response = RestClient.get "https://api.coinprism.com/v1/assets/#{asset_id}"
    JSON.parse(response)
  end

  def Bitcoin.get_asset_divisibility(asset_id)
    Bitcoin.get_asset_definition(asset_id)["divisibility"]
  end

end
