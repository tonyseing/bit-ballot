require './bitcoin.rb'

describe Bitcoin do
  test_candidates = [{ :address => "179RVs3G8jdvh9yAGKqu39Q9khFBkTv7QE", :name => "tony"}, { :address => "13M5eiWov9ixcUvRHNfzC9DJ9JtyJNPcK7", :name => "the other guy"}]
  asset_divisibility_factor = 9 # 9  for test
  color_id = "AZLXxQUnWYHnJ7XZf1rqKE594G3KSRqTTY" # test asset id

  describe "Counting" do
    it "counts only votecoins allocated to a candidate wallet address" do
      expect(Bitcoin::count_votecoins(test_candidates[0][:address], color_id, asset_divisibility_factor)).to eq(1)
      expect(Bitcoin::count_votecoins(test_candidates[1][:address], color_id, asset_divisibility_factor)).to eq(1)
      
    end
  end

  describe "Transparency" do
    it "shows all the addresses on the Blockchain that are allocated this particular votecoin" do
      expect(Bitcoin.addresses_holding_asset(color_id).map { |address| address["address"]}.include?(test_candidates[0][:address])).to eq(true)
       expect(Bitcoin.addresses_holding_asset(color_id).map { |address| address["address"]}.include?(test_candidates[0][:address])).to eq(true)      
    end
  end
end
