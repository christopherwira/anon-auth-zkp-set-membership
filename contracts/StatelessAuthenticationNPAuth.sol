// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

/**
 * @title Stateless Authentication NPAuth
 * @dev Check and Verify Authentication
 * @custom:dev-run-script ./scripts/deploy_with_ethers.ts
 */
contract StatelessAuthenticationNPAuth {


    struct Statement {
        address proof_name;
        bytes32 statement;
    }
                                                                        
    struct Proof{
        bytes32[5] groth_proof;
    }

    struct AccessRequest {
        Statement statement;
        Proof proof;
    }
    event successAuthentication(address indexed  _sender);

    /**
     * @dev Authenticate access request
     * @param access_request access request to verify
     */
    function authenticate(AccessRequest calldata access_request) public {
        require(checkReplayAttack(msg.sender, access_request.statement.proof_name));
        require(verifyProof(access_request.statement,access_request.proof));
        emit successAuthentication(msg.sender);
    }

    /**
     * @dev Compare agent_name and proof_name to prevent replay attack
     * @param agent_name nonce to verify
     * @param proof_name proof name to comapre
     */
    function checkReplayAttack(address agent_name,address proof_name) private pure returns (bool) {
        return agent_name == proof_name;
    }

    /**
     * @dev Verify proof for set-membership
     * @param proof proof to verify
     */
    function verifyProof(Statement calldata statement, Proof calldata proof) private pure returns (bool) {
        require(statement.statement==statement.statement);
        require(proof.groth_proof[0]==proof.groth_proof[0]);
        return true;
    }
}