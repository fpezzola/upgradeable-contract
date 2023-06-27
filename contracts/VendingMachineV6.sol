// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";

contract VendingMachineV6 is Initializable {
    // these state variables and their values
    // will be preserved forever, regardless of upgrading
    uint public numSodas;
    address public owner;
    mapping(address => uint) public tracking;

    function initialize(uint _numSodas) public initializer {
        numSodas = _numSodas;
        owner = msg.sender;
    }

    function purchaseSoda() public payable {
        require(msg.value >= 1000 wei, "You must pay 1000 wei for a soda!");
        require(numSodas > 0, "There are not enough sodas to buy");
        numSodas--;
        tracking[msg.sender] += 1;
    }

    function withdrawProfits() public onlyOwner {
        require(
            address(this).balance > 0,
            "Profits must be greater than 0 in order to withdraw!"
        );
        (bool sent, ) = owner.call{value: address(this).balance}("");
        require(sent, "Failed to send ether");
    }

    function addStock(uint _numSodas) external onlyOwner {
        require(_numSodas > 0, "You need to add at least 1 soda");
        numSodas += _numSodas;
    }

    function removeStock(uint _numSodas) external onlyOwner {
        require(
            numSodas - _numSodas > 0,
            "Remove quantity cannot be bigger than the current number of sodas"
        );
        numSodas -= _numSodas;
    }

    function transferOwnership(address _newOwner) external onlyOwner {
        require(_newOwner != owner, "Address is already owner.");
        owner = _newOwner;
    }

    function setNewOwner(address _newOwner) public onlyOwner {
        owner = _newOwner;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function.");
        _;
    }
}
