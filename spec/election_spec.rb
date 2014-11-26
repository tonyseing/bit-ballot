require './database.rb'
require 'pry'


describe Election do
  before :all do
    @test_organizer = Organizer.create(name: "Tester", email: "tester@test.com")
    @test_election = @test_organizer.elections.create(name: "Test Election", description: "This is a test election")
    @test_voter = { userid: "tester", encrypted_address: "fdsafasfasfasf" }
  end
  
  describe "Initial state" do
    it "begins in the voter registration state" do
      expect(@test_election.state).to eq("registration")
    end
  end

  describe "State transitions" do
    it "moves from **registration** to **commenced** when move_next_state is triggered during election state" do
      @test_election.state = "registration"
      @test_election.move_next_state!
      expect(@test_election.state).to eq("commenced")
    end

    it "moves from **commenced** to **concluded** when move_next_state is triggered during commenced state" do
      @test_election.state = "commenced"
      @test_election.move_next_state!
      expect(@test_election.state).to eq("concluded")
    end

  end

  describe "Voter registration" do
    it "adds voters to registry" do
      @test_election.add_voter(@test_voter)
      expect(@test_election.voters.count).to eq(1)
    end

    it "initalizes each voter with false value for sent token as the status" do
      @test_election.add_voter(@test_voter)
      @newvoter = @test_election.voters.first
      expect(@newvoter.sent_token).to eq(false)
    end

    it "initalizes each voter with false value for requested token status" do
      @test_election.add_voter(@test_voter)
      @newvoter = @test_election.voters.first
      expect(@newvoter.requested_token).to eq(false)
    end
  end


  
  after :each do
    @test_election.state = "registration"
  end

  after :all do
    Organizer.delete_all
  end
  
end
