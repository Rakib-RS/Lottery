pragma solidity ^0.4.17;
contract Lottery{
    address public manager;
    address[] public players;
    function Lottery() public {
        manager = msg.sender;
        
    }
    function enter() public payable {
        require(msg.value > 0.1 ether);
        players.push(msg.sender);
    }

    function random() private view returns(uint){
            return unit(keccak(block.difficulty,now,players)); 
    }
    function pickWinner() public restricted{
        uint index = random() % players.length;
        players[index].transfer( this.balance);
        players = new address [](0)
    }
    modifier restricted() {
        require(msg.sender == manager)
        _;
    }
    function getPlayers() view public returns (address []) {
        return players;
        
    }
}