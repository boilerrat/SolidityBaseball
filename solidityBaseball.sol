pragma solidity ^0.8.0;

// Define the struct for a team in the league
struct Team {
    address owner;
    string name;
    uint256 score;
}

// Define the struct for a player in the league
struct Player {
    string name;
    string position;
    bool drafted;
    address owner;
}

contract FantasyBaseballLeague {
    // Define the array of teams in the league
    Team[] public teams;

    // Define the array of players in the league
    Player[] public players;

    // Define the number of teams in the league
    uint256 public numTeams;

    // Define the draft order
    address[] public draftOrder;

    // Define the current draft pick
    uint256 public currentDraftPick;

    // Define the event that will be emitted when a player is drafted
    event LogPlayerDrafted(address indexed team, string player);

    // Define the function to create a new league
    function createLeague(uint256 _numTeams) public {
        // Check that the number of teams is within a valid range
        require(_numTeams >= 4 && _numTeams <= 12, "Invalid number of teams");

        // Set the number of teams in the league
        numTeams = _numTeams;

        // Generate the draft order
        for (uint i = 0; i < numTeams; i++) {
            draftOrder[i] = msg.sender;
        }

        // Set the current draft pick to the first pick
        currentDraftPick = 0;
    }
    
    mapping (address => uint256) public Ccount;
    mapping (address => uint256) public FirstBasemanCount;
    mapping (address => uint256) public SecondBasemanCount;
    mapping (address => uint256) public ThirdBasemanCount;
    mapping (address => uint256) public ShortStopCount;
    mapping (address => uint256) public OutfieldCount;
    mapping (address => uint256) public StartingPitchersCount;
    mapping (address => uint256) public ClosersCount;
    mapping (address => uint256) public OtherPlayersCount;

    // Define the function to draft a player
    function draftPlayer(string _player) public {
        // Check that the player has not already been drafted
        require(players[_player].drafted == false, "Player already drafted");

        // Check that it is the current team's turn to draft
        require(msg.sender == draftOrder[currentDraftPick], "Not your turn to draft");

        // Get the current team
        uint teamIndex = currentDraftPick;

        // Assign the player to the team
        teams[teamIndex].owner = msg.sender;
        players[_player].owner = msg.sender;
        players[_player].drafted = true;

        if(players[_player].position == "C"){
            Ccount[msg.sender]++;
        }else if(players[_player].position == "1B"){
            FirstBasemanCount[msg.sender]++;
        }else if(players[_player].position == "2B"){
            SecondBasemanCount[msg.sender]++;
        }else if(players[_player].position == "3B"){
            ThirdBasemanCount[msg.sender]++;
        }else if(players[_player].position == "SS"){
            ShortStopCount[msg.sender]++;
        }else if(players[_player].position == "OF"){
            OutfieldCount[msg.sender]++;
        }else if(players[_player].position == "SP"){
            StartingPitchersCount[msg.sender]++;
        }else if(players[_player].position == "CP"){
            ClosersCount[msg.sender]++;
        }else{
            OtherPlayersCount[msg.sender]++;
        }

        // Check that the team has drafted at least 1 player at every position
        require(Ccount[msg.sender] >= 1 && FirstBasemanCount[msg.sender] >= 1 && SecondBasemanCount[msg.sender] >= 1 && ThirdBasemanCount[msg.sender] >= 1 && ShortStopCount[msg.sender] >= 1 && OutfieldCount[msg.sender] >= 3 && StartingPitchersCount[msg.sender] >= 2 && ClosersCount[msg.sender] >= 2, "You must draft at least one player from every position and 2 starting pitchers and 2 closers");

        // Check that the team has not drafted more than 4 backup field position players
        require(OtherPlayersCount[msg.sender] <= 8, "You may only draft up to 8 other players");
       
        // Increment the current draft pick
        currentDraftPick++;

        // Emit the LogPlayerDrafted event
        emit LogPlayerDrafted(msg.sender, _player);
    }
}
