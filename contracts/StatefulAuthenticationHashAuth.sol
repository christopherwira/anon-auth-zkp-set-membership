// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

/**
 * @title Stateful Authentication HashAuth
 * @dev Check and Verify Authentication
 * @custom:dev-run-script ./scripts/deploy_with_ethers.ts
 */
contract StatefulAuthenticationHashAuth {


    struct Statement {
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

    event successAuthentication(address indexed  _sender);

    /**
     * @dev Authenticate access request
     * @param access_request access request to verify
     */
    function authenticate(AccessRequest calldata access_request) public {
        require(checkReplayAttack(access_request));
        require(verifyProof(access_request.statement,access_request.proof));
        emit successAuthentication(msg.sender);
    }

    /**
     * @dev Check access_request for replay attack
     * @param access_request acccess_request to verify
     */
    function checkReplayAttack(AccessRequest calldata access_request) private returns (bool) {
        bytes32 hash_result = keccak256(abi.encode(access_request));
        if (is_submitted[hash_result]){
            return false;
        }
        is_submitted[hash_result] = true;
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