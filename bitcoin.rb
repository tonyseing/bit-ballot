require 'rest_client'
require 'pry'
require 'json'

test_candidates = [{ :address => "akH7Jk2rbcDXcZQ8XJwx5h1Jj6JRMiu7kfP", :name => "tony"}, { :address => "akDJxttL9PdceUj5nKznAr17sUv59BfHPMq", :name => "the other guy"}]
asset_divisibility_factor = 9 # 9  for test

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

  def Bitcoin.count_votecoins(candidate_address, asset_divisibility_factor)
    Bitcoin.balance(candidate_address)["assets"].select { |asset|  asset["id"] == candidate_address }[0]["balance"].to_i / (10 ** asset_divisibility_factor)   
  end

  def Bitcoin.count_unconfirmed_votecoins(candidate_address, color_asset_id)
  end
  

end
