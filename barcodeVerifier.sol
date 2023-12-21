// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract FakeProductRegistry {
    address public owner;

    // Mapping to keep track of registered products
    mapping(uint => bool) private productRegistry;

    // Mapping to keep track of authorized sellers
    mapping(address => bool) private isSeller;

    // Constructor sets the owner to the address that deploys the contract
    constructor() {
        owner = msg.sender;
    }

    // Modifier to restrict access to only the owner or authorized sellers
    modifier Auth() {
        require(msg.sender == owner || isSeller[msg.sender] == true, "Only authorized access");
        _;
    }

    // Modifier to restrict access to only the owner
    modifier onlyOwner(){
        require(msg.sender == owner, "Only owner access");
        _;
    }

    // Function to give access to a new seller, can only be called by the owner
    function giveAccess(address seller) external onlyOwner {
        require(!isSeller[seller], "Seller already registered");
        isSeller[seller] = true;
    }

    // Function to register a new product, can be called by the owner or authorized sellers
    function registerProduct(uint barcode) external Auth {
        require(!productRegistry[barcode], "Product already registered");
        productRegistry[barcode] = true;
    }

    // Function to verify if a product is registered
    function verifyProduct(uint barcode) external view returns (bool) {
        return productRegistry[barcode];
    }
}
