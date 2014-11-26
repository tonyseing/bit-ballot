require 'mongoid'
require 'gibberish'

Mongoid.load!("./mongoid.yml", :development)

class Organizer
  include Mongoid::Document
  field :name, type: String
  field :email, type: String
  field :password, type: String
  embeds_many :elections
end

class Election
  include Mongoid::Document
  field :name, type: String
  field :description, type: String
  field :state, type: String, default: "registration"
  
  validates_inclusion_of :state, in: ["registration", "commenced", "concluded"]
  
  embeds_many :voters
  embedded_in :organizer
  
  def move_next_state!
    if self.state == "registration"
      self.state = "commenced"
      self.save!
    elsif self.state == "commenced"
      self.state = "concluded"
      self.save!
    else
      raise "Election already ended"
    end
  end

  
  def is_over?
    self.state == "concluded"
  end

  def add_voter(voter)
    self.voters.create!(voter)
  end

  def self.encrypt_address(wallet_address, key)
    Gibberish::AES.new(key).enc(wallet_address)
  end

  def self.decrypt_address(enc_wallet_address, key)
    Gibberish::AES.new(key).dec(wallet_address)
  end
  
end


class Voter
  include Mongoid::Document
  field :userid, type: String
  field :encrypted_address, type: String
  field :requested_token, type: Boolean, default: false
  field :sent_token, type: Boolean, default: false


  validates_presence_of :userid, :encrypted_address
  embedded_in :election
end
