/*** The Address Book

The Chairperson:    0x5B38Da6a701c568545dCfcB03FcB875f56beddC4

Proposal names:     
(name, bytes32-encoded name, account)

Narendra Modi:      0x4e6172656e647261204d6f646900000000000000000000000000000000000000  0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2
       
Rahul Gandhi:       0x526168756c2047616e6468690000000000000000000000000000000000000000  0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db
     
Arvind Kejriwal:    0x417276696e64204b656a726977616c0000000000000000000000000000000000  0x78731D3Ca6b7E34aC0F824c42a7cC18A495cabaB

Yogi Adityanath:    0x596f6769204164697479616e6174680000000000000000000000000000000000  0x617F2E2fD72FD9D5503197092aC168c91465E7f2
     
Contract input argument:
["0x5B38Da6a701c568545dCfcB03FcB875f56beddC4","0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2","0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db","0x78731D3Ca6b7E34aC0F824c42a7cC18A495cabaB","0x617F2E2fD72FD9D5503197092aC168c91465E7f2","0x17F6AD8Ef982297579C203069C1DbfFE4348c372","0x5c6B0f7Bf3E7ce046039Bd8FABdfD3f9F5021678"]
***/

// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.20;

contract Voting_System {
    //Structure for Voter
    struct Voter {
        uint256 weight; // No. of times vote can be given.
        bool voted; // Vote given or not ie. TRUE or FALSE
        uint256 vote; //Whom Vote is given by the voter.
    }

    //For Party
    struct Proposal {
        bytes32 name; // Party Name
        uint256 voteCount; //Votes Given
    }

    address public chairperson; //Head of Voting Authority

    //Address of Voter can be called with help of Voters
    mapping(address => Voter) public voters; // Key=>voters  Values=>Voter

    Proposal[] public proposals; //Array containing all the names of candidates. 
    address[] public voter_List; //Array containing all addresses of voters who are eligible to vote.

    uint start; //Time Stamp Start
    uint end; //Nomination Time Stamp end
    uint end_Voting; //Voting Time Stamp Stop
    


    constructor(address[] memory voter_list) {
        chairperson = msg.sender; //Gives Address of Owner to chairperson
        voter_List = voter_list; //Puts the list of the address eligible for votes

        //Increase the weight of all the voters to 1
        for (uint256 i = 0; i < voter_List.length; i++) {
             voters[voter_List[i]].weight = 1;
        }
        start = block.timestamp; //Starting the timestamp
        end = start + 60; //Declaring the limit of time stamp
        end_Voting = end + 60;
    }

    // Function to file the nomination
    function nomination_file(bytes32 proposalNames) external {
        require(msg.sender == chairperson,"You are not the chairperson");
        require(block.timestamp < end,"Nomination Closed");
        proposals.push(Proposal({name: proposalNames, voteCount: 0}));

    }

    //Function to show the remaining time
    function time_left() public view returns (uint){
        return end-block.timestamp;
    }

    //Function to Show the remaining time for voting
    function Voting_Time_left() public view returns (uint){
        require(block.timestamp > end,"Voting Not Started");
        return end_Voting-block.timestamp;
    }

    //Function to vote
    function vote(uint256 proposal) external {
        require(block.timestamp > end,"Nomination not Closed Hence Voting Not Started");
        require(block.timestamp < end_Voting,"Voting Booth closed");
        Voter storage sender = voters[msg.sender];
        require(sender.weight != 0, "Not in the Voter List"); //Check if he has the right to vote
        require(!sender.voted, "Already voted."); //Checks if the person has already voted or not!
        sender.voted = true;
        sender.vote = proposal; //Stores the index no. of the person who got the vote
        // sender.weight = sender.weight - 1; //After Voting Decrease the weight of the voter so that he can't vote twice
        proposals[proposal-1].voteCount += 1; //Increase the no. of vote of the candidates by 1
    }



    //Count the winner and returns the index of the candidate who won
    function winningProposal() public view  returns (uint256 winningProposal_) {
        require(msg.sender == chairperson,"You are not the chairperson");
        require(block.timestamp > end,"Nomination not Closed");
        require(block.timestamp > end_Voting,"Voting Not Closed");
        uint256 winningVoteCount = 0;
        for (uint256 p = 0; p < proposals.length; p++) {
            if (proposals[p].voteCount > winningVoteCount) {
                winningVoteCount = proposals[p].voteCount;
                winningProposal_ = p;
            }
        }
    }

    //Returns the name of the candidate who won
    function winnerName() external view returns (string memory) {
        require(msg.sender == chairperson,"You are not the chairperson");
        require(block.timestamp > end,"Nomination not Closed");
        require(block.timestamp > end_Voting,"Voting Not Closed");
        bytes32 winnerName1 = proposals[winningProposal()].name;
        uint8 i = 0;
        while (i < 32 && winnerName1[i] != 0) {
            i++;
        }
        bytes memory winnerName_ = new bytes(i);
        for (i = 0; i < 32 && winnerName1[i] != 0; i++) {
            winnerName_[i] = winnerName1[i];
        }
        return string(winnerName_);
    }
}
