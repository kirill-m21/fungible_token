# Fungible Token

MANAGED: a token managed by a treasurer trusted for minting and burning. This is how (e.g.) a fiat-backed stablecoin or an in-game virtual currency would work.

## Install Sui (Linux)

### Other OS

Install steps for macOS or WIndows 11 could be found [here](https://docs.sui.io/build/install#prerequisites).

### Rust and cargo

Use the following command to install **Rust** and **Cargo** on Linux:

`curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs  | sh`

Use the following command to update **Rust**:

`rustup update stable`

### Linux prerequisites

You should make sure that your system has the latest version of **apt-get**. Use the following command to **update apt-get**:

`sudo apt-get update`

Install **cURL** with the following command:

`sudo apt install  curl`

Run the following command to install **Git**, including the **Git CLI**:

`sudo apt-get install git-all`
 
Install **CMake** using the instructions at [Installing CMake](https://cmake.org/install/) on the CMake website.

Use the following command to **install libssl-dev**:

`sudo apt-get install libssl-dev`

Use the following command to **install libclang-dev**:

`sudo apt-get install libclang-dev`

### Install Sui binaries

`cargo install --locked --git https://github.com/MystenLabs/sui.git --branch devnet sui`

### Integrated development environment

The recommended IDE for Move development is [Visual Studio Code](https://code.visualstudio.com/) with the move-analyzer extension. Follow the Visual Studio Marketplace instructions to install the [move-analyzer extension](https://marketplace.visualstudio.com/items?itemName=move.move-analyzer), passing address20 using the --features flag:

`cargo install --git https://github.com/move-language/move move-analyzer --features  "address20"`

## Sui test tokens request

To request **SUI test tokens** in Discord (**once per two hours**):

1.  Join the [Sui Discord](https://discord.com/invite/sui).
    
2.  Identify your address by running the following command and electing to connect to a Sui RPC server if prompted:
    
	`sui client active-address`

3.  Request tokens in the [#devnet-faucet](https://discord.com/channels/916379725201563759/971488439931392130) channel using the syntax: !faucet <YOUR_ADDRESS>, for example:  
*!faucet 0xd72c2c90ed9d923cb0ed2ca91db5be9e1c9b5ccb*

## Sui Move Explorer

You might search for information through [sui move explorer](https://explorer.sui.io/) by Addresses / Objects / Transactions.

## Building a package

Ensure that directory contains your package, and then use the following command to build it:

`sui move build`

## Testing a package
An individual Move unit test is encapsulated in a public function that has no parameters, no return values, and has the `#[test]` annotation. Such functions are executed by the testing framework upon executing the following command:

`sui move test`

## Deploy a package

After succesful **SUI test tokens request**, check the current address:

`sui client active-address`

Output:

![](https://lh6.googleusercontent.com/d1cN7sNsFWMyUQ02csXBtvgrA9wbLozabAJuAjXPSNKzsM7R6kaJajkAuQxX9pGidT8XGPNVtKsYHKHm3se607Hn5oufgQZOX0m5Vs1x0gPCaEvjmq5x7u5DruJuBIWSZJBoxa5hGOHUE1Q-9QeaBM3OteNVdHM4RZ0bJa7YNJW0eozZuWbXK830Dot1Vw)

To simplify the next steps – Assign a new address to the var. In this case example:
`ACCOUNT_ID=0xaa5a31455935d79607dadac2a446b355bcf71ef4`

To deploy (you should be in the root folder):

`sui client publish --gas-budget 1000`

Output:

![](https://lh5.googleusercontent.com/bVfz0fyvObi5qDzmcaHt0JEAB3_JyuEjFiQ2-tl-vc6hSY1C6t8m2b__4e2DQQv4CdC8C0RyatmJeWuS19mo40l1eGGVl9PYDpbJvjWr-DJ2jzXfaws90NwrzdJ4qiEdz7wg2XvSM86RAinZn1IG-r7oiCDpIVR-b9YR0rFa5SSJJu2E6NHzDYqbWYDaog)

Current transaction details could be found [here](https://explorer.sui.io/transaction/Ad5StceVjgpd5q2bRW7VbaFZws3Fia5CW1vNHbzj7vra).

## Interact with a package

Let’s see all the objects on the current account.

`sui client objects`

Output:

![](https://lh3.googleusercontent.com/FmVt08y3ZP3wLn_VEiCuXxo08ytlve-mkgXCztz0EzEriuCWRBdM7FVGqMcBdcCn27XxXqEreME33JMBQkvo9jUb4C4H4vSOFBQKr4wDaqLbWDnhi-cI9hrPTWOqEr3oBLFy3MP0MCfneOBGpNj690fInGpcMzYXC9gUJ4Coi8yLMXpa-d60jZ8Jp6_EqQ)

From the output besides airdropped coins we could see deployed package:
|  |  |
|--|--|
| Object ID |  0xcfd4e997d7e3524f4beb80162b75252c00eb1331|
| Version | 1110 |
| Digest | QAdY0mb+Ce4fiwuLFMxUOUwgC6rpM1IHgd/w+EGGno8= |
| Owner Type | AddressOwner |
| Object Type | 0x2::coin::TreasuryCap<0xd163b8ae41129c2ccd3497cf6657b825099ae136::managed::MANAGED> |
|  |  |

To simplify the next steps (in the current case):

`PACKAGE_ID=0xd163b8ae41129c2ccd3497cf6657b825099ae136`

`MANAGED_ID=0xcfd4e997d7e3524f4beb80162b75252c00eb1331`

to call the method with the entry modifier (in our case, the **mint** method) requires the following command:

`sui client call --function mint --module managed --package $PACKAGE_ID --args \"$MANAGED_ID\" \"42\" \"$ACCOUNT_ID\" --gas-budget  10000`

Output:

![](https://lh5.googleusercontent.com/9aenXezwuKKwWt7otmobgE3pA66UtFl9dWBBwAuYmLugq7-_Bnst-KV0FbQf0TOWxC9bTjeP61q1NLkn4NAgaORyZGwn9f_ab2LMTC_YlQpF_M0KGLfoM1UiSskzh01y7Y745LVdWYuZch2MfMTHA42wZheMApL_OYlb4MCHxDrwB0u3Y9dMOLdwtiKQZg)

Let’s see all the objects on the current account.

`sui client objects`

Output:

![](https://lh6.googleusercontent.com/3brXzswMLdPPy7XhPBMmi6UEEsE6sjewF1BK16SFJnG3JsqFV4t9cmw9cp0qiOrjAjmQ_vSpGsV5eQKmwQrXhddfLWhdf3Q-zBfoRC3PSVjP2toJWdOxTupJN_0K9_O8uXr3_brVvPio_LcxlJ7mbQUv_xw16U3H9uEpciJ1fjTIPIG4PRtAyz5rKmmJLQ)

From the output besides airdropped coins and deployed package we could see minted managed coins:
|  |  |
|--|--|
| Object ID |  0xaa049d6b61a5e467375f9e72ae4b60fd356debde|
| Version | 1111 |
| Digest | jTG8BQ2CH1liVXla4gjwdlzA6G/ctgwnqH7F6/Bg+7M= |
| Owner Type | AddressOwner |
| Object Type | 0x2::coin::Coin<0xd163b8ae41129c2ccd3497cf6657b825099ae136::managed::MANAGED> |
|  |  |

For the next steps (in the current case):

`COIN_ID=0xaa049d6b61a5e467375f9e72ae4b60fd356debde`

to call the method with the entry modifier (in our case, the **burn** method) requires the following command:

`sui client call --function mint --module managed --package $PACKAGE_ID --args \"$MANAGED_ID\" \"$COIN_ID\" --gas-budget  10000`

Output:

![](https://lh4.googleusercontent.com/m6sRtx2HrNy75l07toeCfV1ZdwvgQgUhm81cK3Hi1wB0b8jZkSH9fY9Oc_lLinB4-n5vScSHRym5cRPoxo--YmYgOFj1r0Zv9jDi0kxhCptyYp-sQXJN41lfgPM4Kn98HyOsZrBCLOEvYcj261gmhClP5IFLB3StULGCWr-d2PvBmHptU2sBvAAN_4dsaQ)

Let’s see all the objects on the current account.

`sui client objects`

Output:

![](https://lh3.googleusercontent.com/3fIcn2avHjTNCkds2pSc-FxQqI05mQ3dLVeAhjUlmGNsFVc0GLYFJFLK-MORnptRZrKaVnRs49wDR4rglcENFvVAAdxok-T20MQvk-AzL5as64qR9IDhpw-bpJJ-cg1Y54bJeuo-EGlM7N93bio0M4yCy3-3Dog8uMMZ_K0G1K3Iy9wBCHIe6V0gnLIOVw)

As a result – minted coins were burned.

