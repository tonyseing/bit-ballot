How it works
---
- A user can create an election
- Elections consists of eligible voters, eligible candidates, and votes, represented by colored bitcoins
- Each election's eligibile voters are made public for transparency
- Voters generate a bitcoin address, then go to BitBallot to receive a
  pre-registration number. This pre-registration number is an encryption of
  their Bitcoin wallet address. The voter keeps the encryption key secret.
- Voters go to a voting station and are verified of their identity and their
  voting eligibility. Then they input their pre-registration number (the
  encrypted string of their bitcoin wallet address) into the BitBallot system
- Once the pre-registration ends, and the election is ready to begin, voters
  can vote by
  1. Going to BitBallot and finishing their registration by submitting their
     pre-registration number and their encryption key. The BitBallot system
     checks that the pre-registration number matches one in the database,
     decrypts the pre-registration number, which yields the voter's bitcoin
     wallet address. Then the organizer can issue a colored Satoshi to that
     address. This process ensures that the registrar service that identifies
     voters and ensures they are eligible to vote never knows the identity of
     the owners of any of the respective wallets.
  2. Voter then sends his colored Satoshi (votecoin) to the address of his
     favored candidate.
- Coins are counted for each candidate to tally the winner
- Counting ends once the organizer hits the "End Election Button"

** Front-end

Home Page
---
- allows an organizer to either sign up or sign in

Organizer Page
---
- An can create an *election*
- An election consists of a topic, eg. "Who should be president?", a list of eligible voters, and a list of elibile candidates
- requires a textarea for topic, and a textbox for each eligible voter (with add-one button), and a textbox for eligible candidates (with add-one button) 


Voter Registration Page
---
- Here voters get verified that they are who they say they are by an authority outside of the system. Then the voter enters their bitcoin wallet address, and this address is stored in the database.  
- Once voter registration ends, the original election official and click a button to distribute the vote ballots
- The list of bitcoin addresses from voters for this election is then randomly shuffled, and then a vote coin is distributed to each of the addresses. Voters can now send this votecoin to the address of the candidate of choice.

Vote Check Page
---
- Voters can see the list of addresses for this election and wether they have voted or not. This provides transparency, guaranteeing the voter that their vote has been counted towards the total.
- Voters shoudl be able to see the total number of votes for each candate too
