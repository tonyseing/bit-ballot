require './bitcoin.rb'

describe Bitcoin do
  test_candidates = [{ :address => "akH7Jk2rbcDXcZQ8XJwx5h1Jj6JRMiu7kfP", :name => "tony"}, { :address => "akDJxttL9PdceUj5nKznAr17sUv59BfHPMq", :name => "the other guy"}]
  asset_divisibility_factor = 9 # 9  for test
  color_id = "AZLXxQUnWYHnJ7XZf1rqKE594G3KSRqTTY" # test asset id

  describe "Counting" do
    it "counts only votecoins allocated to a candidate wallet address" do
      expect(Bitcoin::count_votecoins(test_candidates[0][:address], color_id, asset_divisibility_factor)).to eq(1)
      expect(Bitcoin::count_votecoins(test_candidates[1][:address], color_id, asset_divisibility_factor)).to eq(1)
      
    end
    
  end
end
