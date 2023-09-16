# Experiment Setup Instruction

## Overview

We provide the instruction to reproduce our results in our paper.

Here in this directory, we provide the following Solidity files:

- StatefulAnonParking
- StatefulHashAuth
- StatelessPseudoAuth
- StatelessNPAuth

## Dependencies

While it is possible to use any IDE to work with our Solidity files, we recommend the readers to utilize [Online Remix IDE](https://remix.ethereum.org/) as it provides an easy way to deploy and debug our smart contract.

In this instruction, we explain all the information using the Remix IDE.

## Deploying the Smart Contract

Here is our instruction to deploy our Solidity files into the Ethereum Testnet using Remix IDE:

1. Open the Online Remix IDE using your browser
2. Create a new workspace, choose the `Blank` template, and write the workspace name
3. After cloning our repository, upload this `contracts` directory using the upload button on the Remix's File Explorer
4. Compile each Solidity files in the `contracts` directory
5. Using the `Deploy & run transactions` button on the sidebar, press the `Deploy` button to deploy our smart contract to the Ethereum Testnet (in this case is Remix VM)

Using the information on the `Deployed Contracts` section, we can interact with the deployed smart contract and invoke the `authenticate` function on our algorithms.

## Invoking the function in the Smart Contract

### Smart Contract Code Input Explanation

On general, the input to our smart contract is an access request object.

Access request object consists of two object:

- Statement: an object which contain all public information which can be examined by the smart contract or audited by the other people
- Proof: an object which contain a witness, a hidden information which need to be encapsulated using the SNARK zero-knowledge property, that can be verified using SNARK verification algorithm.

It needs to be noted that we didn't implement any SNARK verification logic into our smart contract because our focus is to analyze the gas cost on the replay attack prevention algorithm on each scheme.

By assuming we used [Groth16](https://eprint.iacr.org/2016/260) as our SNARK, the size of the proof is 144 bytes if we implement it using [BLS12-381](https://electriccoin.co/blog/new-snark-curve/). To upload this proof to the smart contract, we create a data structure which contains 5 `bytes32` variables (160 bytes).

#### AnonParking Input

The input can be explain as the following:

```
AccessRequests = 
{
 "Statement":
 {
  "current_nonce": "(bytes32 data, received by invoking the current_nonce)",
  "statement": "(bytes32 data, a dummy statement data that comes with the Groth16 proof)",
 },
 "Proof":
 {
  "(bytes 32 data, dummy value for the Groth16 proof)",
  "(bytes 32 data, dummy value for the Groth16 proof)",
  "(bytes 32 data, dummy value for the Groth16 proof)",
  "(bytes 32 data, dummy value for the Groth16 proof)",
  "(bytes 32 data, dummy value for the Groth16 proof)",
 }
}
```

Example of the Decoded Input from Remix:

```
{
  "tuple access_request": [
    [
      "0x6161616161616161616161616161616161616161616161616161616161616161",
      "0x6161616161616161616161616161616161616161616161616161616161616161"
    ],
    [
      [
        "0x6161616161616161616161616161616161616161616161616161616161616161",
        "0x6161616161616161616161616161616161616161616161616161616161616161",
        "0x6161616161616161616161616161616161616161616161616161616161616161",
        "0x6161616161616161616161616161616161616161616161616161616161616161",
        "0x6161616161616161616161616161616161616161616161616161616161616161"
      ]
    ]
  ]
}
```

#### HashAuth Input

The input can be explain as the following:

```
AccessRequests = 
{
 "Statement":
 {
  "statement": "(bytes32 data, a dummy statement data that comes with the Groth16 proof)",
 },
 "Proof":
 {
  "(bytes 32 data, dummy value for the Groth16 proof)",
  "(bytes 32 data, dummy value for the Groth16 proof)",
  "(bytes 32 data, dummy value for the Groth16 proof)",
  "(bytes 32 data, dummy value for the Groth16 proof)",
  "(bytes 32 data, dummy value for the Groth16 proof)",
 }
}
```

Unlike the AnonParking scheme, there are no `current_nonce` information on this access request. The smart contract only check whether this proof is unique or not.

#### PseudoAuth Input

The input to this smart contract is identical to the HashAuth scheme.
This scheme recognize whether the agent is malicious or not by comparing the msg.sender with an AllowList inside the smart contract.

On our implementation, the initial Ethereum's account that deploy the transaction is automatically added to the AllowList.

The constructor function of this scheme can be seen at the following code:

```
constructor(){

        approved_pseudonym[msg.sender]=true;

    }
```

#### NPAuth Input

The input to this smart can be explain as the following:

```
AccessRequests = 
{
 "Statement":
 {
  "proof_name": "(address data), the account address that submits the transaction",
  "statement": "(bytes32 data, a dummy statement data that comes with the Groth16 proof)",
 },
 "Proof":
 {
  "(bytes 32 data, dummy value for the Groth16 proof)",
  "(bytes 32 data, dummy value for the Groth16 proof)",
  "(bytes 32 data, dummy value for the Groth16 proof)",
  "(bytes 32 data, dummy value for the Groth16 proof)",
  "(bytes 32 data, dummy value for the Groth16 proof)",
 }
}
```

Example of decoded input from Remix:

```
{
 "tuple access_request": [
  [
   "0x5B38Da6a701c568545dCfcB03FcB875f56beddC4",
   "0x6161616161616161616161616161616161616161616161616161616161616161"
  ],
  [
   [
    "0x6161616161616161616161616161616161616161616161616161616161616161",
    "0x6161616161616161616161616161616161616161616161616161616161616161",
    "0x6161616161616161616161616161616161616161616161616161616161616161",
    "0x6161616161616161616161616161616161616161616161616161616161616161",
    "0x6161616161616161616161616161616161616161616161616161616161616161"
   ]
  ]
 ]
}
```

### Dummy Value for the Smart Contracts

We provide the dummy values for each scheme to invoke the `authenticate` function in the smart contract.

For our dummy value, we use the string of:

```
"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",              ("a" symbol repeated 32 times)
```

which is converted to the following Hex value:

```
"0x6161616161616161616161616161616161616161616161616161616161616161".
```

#### AnonParking Dummy Value

```
[["(change to the current_nonce value)","0x6161616161616161616161616161616161616161616161616161616161616161"],[["0x6161616161616161616161616161616161616161616161616161616161616161","0x6161616161616161616161616161616161616161616161616161616161616161","0x6161616161616161616161616161616161616161616161616161616161616161","0x6161616161616161616161616161616161616161616161616161616161616161","0x6161616161616161616161616161616161616161616161616161616161616161"]]]
```

The `current_nonce` value is a `public` variable, thus can be queried by everyone. In Remix IDE, this value can be queried using the `current_nonce` button inside the deployed smart contract section.

#### HashAuth and PseudoAuth Dummy Value

```
[["0x6161616161616161616161616161616161616161616161616161616161616161"],[["0x6161616161616161616161616161616161616161616161616161616161616161","0x6161616161616161616161616161616161616161616161616161616161616161","0x6161616161616161616161616161616161616161616161616161616161616161","0x6161616161616161616161616161616161616161616161616161616161616161","0x6161616161616161616161616161616161616161616161616161616161616161"]]]
```

#### NPAuth Dummy Value

```
[["(change to your Ethereum Account value)","0x6161616161616161616161616161616161616161616161616161616161616161"],[["0x6161616161616161616161616161616161616161616161616161616161616161","0x6161616161616161616161616161616161616161616161616161616161616161","0x6161616161616161616161616161616161616161616161616161616161616161","0x6161616161616161616161616161616161616161616161616161616161616161","0x6161616161616161616161616161616161616161616161616161616161616161"]]]
```

## Debugging the Smart Contract

After successfully invoke the `authenticate` function on each scheme, we can check the transaction receipts in the Remix IDE to get the rough gas costs from each scheme.

We could get the following information only from the transaction receipt:

- The initial gas
- The execution cost
- The transaction cost (which also includes the execution cost)

In our experiment, we focus our interest on the execution cost, as it is varied across the scheme and depends on how we design the algorithms.

We analyzed the detailed execution cost using the `Debug` button on the transaction receipt in the Remix IDE.

By recording the remaining gas from each step in the source codes, we can pin-point some lines that contribute a significant gas cost to the execution cost.

We provided the results of our debugging session in the `'./data'` directory.
