pragma solidity 0.6.0;
contract BallotV1 {

    struct Voter {
        uint weight;
        bool voted;
        uint vote;
    }

    struct Proposal {
        uint voteCount;
    }

    address chairperson;
    mapping(address => Voter) voters;
    Proposal[] proposals;

    enum Phase {Init, Regs, Vote, Done}
    Phase public state = Phase.Init;

    modifier validPhase(Phase reqPhase){
        require(state == reqPhase);
        _; 
    }

    modifier onlyChair(){
        require(msg.sender == chairperson);
        _;
    }

    constructor(uint numProposals) public {
        chairperson = msg.sender;
        voters[chairperson].weight = 2;
        for (uint prop = 0; prop < numProposals; prop++) {
            proposals.push(Proposal(0));
        }
        state = Phase.Regs;
    }

    function changeState(Phase x) onlyChair public {
        // if (msg.sender != chairperson) revert(); // onlyChair 수정자가 대체
        // if (x < state) revert(); // require() 함수로 대체
        require (x > state)
        state = x; 
    }

    function register(address voter) public validPhase(Phase.Regs) onlyChair { // onlyChair 추가, modifier 순서 중요
        // if (msg.sender != chairperson || voters[voter].voted) revert(); // require() 로 대체
        require (!voters[voter].voted);
        voters[voter].weight = 1;
        // voters[voter].voted = false;
    }

    function vote(uint toProposal) public validPhase(Phase.Vote) {
        Voter memory sender = voters[msg.sender];
        // if (sender.voted || toProposal >= proposals.length) revert(); // require()로 대체
        require (!sender.voted);
        require (toProposal < toProposal.length);
        sender.voted = true;
        sender.vote = toProposal;
        proposals[toProposal].voteCount += sender.weight;
    }

    function reqWinner() public validPhase(Phase.Done) view returns (uint winningProposal) {
        uint winningVoteCount = 0;
        for (uint prop; prop < proposals.length; prop++) {
            if (proposals[prop].voteCount > winningVoteCount) {
                winningVoteCount = proposals[prop].voteCount;
                winningProposal = prop;
            }
        }
        assert(winningVoteCount >= 3); // 투표자가 3미만일 경우 함수 중단
    }

}