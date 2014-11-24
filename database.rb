require 'mongoid'

# set database config and connect to database here

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
  field :state, type: String, default: "pre-registration"

  validates_inclusion_of :state, in: ["registration", "commenced", "concluded"]
  embeds_many :voters
  embedded_in :organizer
end

class Voter
  include Mongoid::Document
  field :encrypted_address, type: String
  field :received_token, type: Boolean, default: false
end
