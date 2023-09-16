# Cost-Efficient Anonymous Authentication Scheme based on Set-Membership Zero-Knowledge Proof

by Christopher Wiraatmaja, Shoji Kasahara.

This paper has been submitted for publication in ***5th Conference on Blockchain Research & Applications for Innovative Networks and Services (BRAINS23)***.

>We proposed a technique to prevent replay attack into an authentication setting which preserve its user's privacy. Using our previous technique, we developed a blockchain-based authentication scheme that achieves cheaper gas cost and provides better scalability compared to prior works.

![[desired-authentication-scheme.jpg]]
*Our Proposed Authentication Scheme*

| **Process Detail**   |   **Stateful**  |          |  **Stateless** |               |
|------------------|:-----------:|:--------:|:----------:|:-------------:|
|                  | *AnonParking*[^1] | *HashAuth* | *PseudoAuth*[^2] | *NPAuth (Ours)* |
| Write Operation  |    22,900   |  20,000  |      -     |       -       |
| Read Operation   |    4,200    |   2,100  |    2,100   |       -       |
| Hash Calculation |     472     |    960   |      -     |       -       |
| Minor Operation  |     494     |    442   |     185    |      395      |
| Total Gas Cost   |    28,066   |  23,502  |    2,285   |      **395**      |
*Replay Attack Prevention Gas Cost Comparison*

## Abstract

>In this paper, we propose zero-knowledge named proof, a replay attack prevention scheme that ensures the user's anonymity against malicious administrators. We begin with adopting the zero-knowledge set-membership proof into an authentication setting in which users would delegate their requests to an agent that obstructs the user's identity from the administrator. This anonymous agent carries the guarantee of authenticity, which the administrator through the set-membership proof can confirm. Next, we prevent replay attacks from other parties by binding the agent's identity to the delegation request verifiable by the administrators. By leveraging these properties, a blockchain-based authentication scheme is then built. We quantitatively evaluate the security, cost-efficiency, and performance of our scheme and provide a third-party authorization scheme from our authentication framework to demonstrate its real-world relevancy.

## Experiment Implementation

> We utilized Online Remix IDE and its debugger to investigate the gas cost of each operation inside the smart contracts. Using these results, we compile the findings regarding the replay attack prevention gas cost as our experiment results.

We provided all replay attack prevention algorithms for each scheme in the `contracts` folder.  We wrote our algorithms in [Solidity](https://soliditylang.org/) and deployed them to an Ethereum Testnet using [Online Remix IDE](https://remix.ethereum.org/).

After investigating the results of each algorithms, we provided the CSV files of our raw data and a Jupyter Notebook file that are used to create our experiment results in the `data` folder.

## Getting our repository

Please clone this repository using your Git client by running

```
git clone https://github.com/christopherwira/anon-auth-zkp-set-membership.git
```

[^1]: J. C. L. Ho and C. Lin, “An anonymous on-street parking authentication scheme via zero-knowledge set membership proof,” CoRR, vol. abs/2108.03629, 2021.
[^2]: D. A. Luong and J. H. Park, “Privacy-preserving blockchain-based healthcare system for iot devices using zk-snark,” IEEE Access, vol. 10, pp. 55 739–55 752 ,2022.
