// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract FakeProductRegistry {
    address public owner;
    mapping(uint => bool) private productRegistry;
    mapping(address => bool) private isSeller;


    constructor() {
        owner = msg.sender;
    }

    modifier Auth() {
        require(msg.sender == owner || isSeller[msg.sender] == true,"Only authorized access");
        _;
    }

    modifier onlyOwner(){
        require(msg.sender == owner,"Only owner access");
        _;
    }

    function giveAccess(address seller) external onlyOwner {
        require(!isSeller[seller],"Seller already registered");
        isSeller[seller] = true;
    }

    
    function registerProduct(uint barcode) external Auth {
        require(!productRegistry[barcode], "Product already registered");
        productRegistry[barcode] = true;
    }

    function verifyProduct(uint barcode) external view returns (bool) {
        return productRegistry[barcode];
    }
}
