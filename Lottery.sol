// SPDX-License)Identifier: MIT
pragma solidity ^0.8.15;

contract Lottery {
     //State / Storage Variables
    address public owner;
    address payable []  public players;
    address[]   public winners;
    uint public lotteryId;

    //Constructor - this runs when the contract is deployed
    constructor(){
        owner = msg.sender;
        lotteryId = 0;
    }

    //Enter Function
    function enter() public payable {
        require(msg.value >= 0.1 ether);
        players.push(payable(msg.sender));
    }

    //Get Players
    function getPlayers() public view returns (address payable [] memory){
        return players;
    }

    //Get Balance
    function    GetBalance()    public view returns (uint) {
        //Solidity works in WEI
         return address(this).balance;
         }

    //Get Lottery ID
     function getLotteryI() public view returns (uint){
            return lotteryId;
         }

    //Get Random Number (helper function for picking number)
    function getRandomNumber() public view returns (uint) {
        return uint(keccak256(abi.encodePacked(owner, block.timestamp)));
    }
    
    //Pick Winner!
    function pickwinner()   public {
        require (msg.sender == owner);
        uint randomIndex = getRandomNumber() % players.length;
        players [randomIndex].transfer(address(this).balance);
        winners.push(players[randomIndex]);
        lotteryId++;

         //Clear the players array. ('player1','player2'] --> []
    players = new address payable [](0);
    }    

    //Get Winners
    function getWinners() public view returns (address[] memory){
        return winners;
    }   
}
