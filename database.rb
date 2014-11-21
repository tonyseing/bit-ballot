require 'mongoid'

# set database config and connect to database here

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

end

class Voter
  include Mongoid::Document
  field :encrypted_address, type: String
  field :received_token, type: Boolean, default: false
  embedded_in :election
end
