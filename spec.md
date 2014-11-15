How it works
---
- A user can create an election
- Elections consists of eligible voters, eligible candidates, and votes, represented by colored bitcoins
- Each election's eligibile voters are made public for transparency
- After voters are entered for an election, voters can receive their vote coin by going to a voting machine where they verify their eligibility and identity, and then enter their wallet address into the application
- The application then shuffles the addresses and then sends one vote coin to each
- Voters can now send the received coin to the address of their candidate of choice 
- Coins are counted for each candidate to tally the winner

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
