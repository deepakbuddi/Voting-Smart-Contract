// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract Voting {
    struct Voter {
        string name;
        uint age;
        string residencyProof;
        bool registered;
    }

    struct Candidate {
        string name;
        uint voteCount;
    }

    address public owner;
    mapping(uint => Voter) public voters;
    mapping(string => Candidate) public candidates;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "You can't perform this Action!!");
        _;
    }

    function registerVoter(uint _registrationId, string memory _name, uint _age, string memory _residencyProof) public onlyOwner {
        require(!voters[_registrationId].registered, "You are already registerd");
        require(_age >= 18, "Your under age");
        voters[_registrationId] = Voter(_name, _age, _residencyProof, true);
    }

    function addCandidate(string memory _name) public onlyOwner {
        candidates[_name] = Candidate(_name, 0);
    }

    function vote(uint _registrationId, string memory _candidateName) public {
        require(voters[_registrationId].registered, "Voter is not registered");
        require(bytes(candidates[_candidateName].name).length != 0, "Candidate does not exist");

        candidates[_candidateName].voteCount++;
        voters[_registrationId].registered = false; 
    }
}
