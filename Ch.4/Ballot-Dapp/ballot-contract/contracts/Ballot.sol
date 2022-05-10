pragma solidity >= 0.4.22 <= 0.6.0;
contract BallotV1 {

    struct Voter {
 
		}

    struct Proposal {
   
		}

    address chairperson;
    mapping(address => Voter) voters;
    Proposal[] proposals;

    modifier onlyChair(){
			require(msg.sender == chairperson);
			_;
    }

		modifier validVoter() {
			
			require(voters[msg.sender].weight > 0, "Not a Resigtered Voter");
			_;
		}

    constructor(uint numProposals) public { }

    function register(address voter) public onlyChair { }

    function vote(uint toProposal) public validVoter { }

		function reqWinner() public view returns (uint winningProposal){ }
}
