// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

/**
 * @title Stateful Authentication AnonParking
 * @dev Check and Verify Authentication
 * @custom:dev-run-script ./scripts/deploy_with_ethers.ts
 */
contract StatefulAuthenticationAnonParking {


    struct Statement {
        bytes32 nonce;
        bytes32 statement;
    }

    struct Proof{
        bytes32[5] groth_proof;
    }

    struct AccessRequest {
        Statement statement;
        Proof proof;
    }

    mapping (bytes32 => bool) is_submitted;
    bytes32 public current_nonce;

    event successAuthentication(address indexed  _sender);

    constructor() {
        current_nonce = keccak256(abi.encodePacked(block.timestamp));
    }

    /**
     * @dev Authenticate access request
     * @param access_request access request to verify
     */
    function authenticate(AccessRequest calldata access_request) public {
        require(checkReplayAttack(access_request.statement.nonce));
        require(verifyProof(access_request.statement,access_request.proof));
        emit successAuthentication(msg.sender);
    }

    /**
     * @dev Check nonce for replay attack
     * @param nonce nonce to verify
     */
    function checkReplayAttack(bytes32 nonce) private returns (bool) {
        if (nonce != current_nonce){
            return false;
        }
        if (is_submitted[nonce]){
            return false;
        }
        is_submitted[nonce] = true;
        bytes32 random_nonce = keccak256(abi.encodePacked(block.timestamp, nonce));
        current_nonce = random_nonce;
        return true;
    }

    /**
     * @dev Verify proof for set-membership
     * @param proof proof to verify
     */
    function verifyProof(Statement calldata statement, Proof calldata proof) private pure returns (bool) {
        require(statement.statement==statement.statement);
        require(proof.groth_proof[0]==proof.groth_proof[0]);
        /*insert proof verification process here */
        return true;
    }
}