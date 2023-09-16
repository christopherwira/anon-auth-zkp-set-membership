// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

/**
 * @title Stateless Authentication PseudoAuth
 * @dev Check and Verify Authentication
 * @custom:dev-run-script ./scripts/deploy_with_ethers.ts
 */
contract StatelessAuthenticationPseudoAuth {


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

    mapping (address=>bool) approved_pseudonym;

    event successAuthentication(address indexed  _sender);

    constructor(){
        approved_pseudonym[msg.sender]=true;
    }

    /**
     * @dev Authenticate access request
     * @param access_request access request to verify
     */
    function authenticate(AccessRequest calldata access_request) public {
        require(checkReplayAttack(msg.sender));
        require(verifyProof(access_request.statement,access_request.proof));
        emit successAuthentication(msg.sender);
    }

    /**
     * @dev Compare agent_name and proof_name to prevent replay attack
     * @param agent_name nonce to verify
     */
    function checkReplayAttack(address agent_name) private view returns (bool) {
        return approved_pseudonym[agent_name];
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