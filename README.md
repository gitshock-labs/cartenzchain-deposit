## Depositing steps

1. We start by getting a cartenz testnet (tGTFX), either from a faucet or from someone who has a bunch.

2. Our mnemonic is the source of the validator's private key. Losing this mnemonic means losing all funds, so please keep the mnemonic safe. We can create validator and withdrawal mnemonics using the eth2-val-tools tool.

In your terminal, type:

`eth2-val-tools mnemonic`

3. The output should contain a list of 24 words. Copy those words into the deposit.sh file under the vmnemonic & mnemonic variables.

> Please back up these mnemonics safely! Ideally in a password manager as a secure record.

4. Decide how many deposits you want to make. Usually this is (number of ether testnets you have)/32. Set smin and smax in deposit.sh accordingly.

5. Now we can finally add the private key and the address where the deposit will be made. This will require metamask, open a metamask account click the three dots > click Account details > click export
private key. We need the private key in the script to access the funds and make deposits, so keep this in a safe place. Fill in the address and privkey as per deposit.sh. and both should start with 0x.

6. Before running the script Run ./setup.sh and then ./deposit.sh

The deposit data will be a set of json with the following format:

```sh
{
  "account": "m/12381/3600/1/0/0",
  "deposit_data_root": "",
  "pubkey": "xxxxxx", # Compare your pubkey deposit.sh and staking-cli 
  "signature": "",
  "value": 32000000000,
  "version": 1,
  "withdrawal_credentials": ""
}
```

7. Manually check if it looks okay to start. The account format is m/12381/3600/key_number/0/0. The key_number should be related to the smin and smax entered earlier.

8. Generate the public key manually using eth2-val-tools to cross-check that the generated public key is correct.

eth2-val-tools pubkeys --validators-mnemonic="YOUR-MNEMONIC" --source-min=smin --source-max=smax

9. You should get a list of public keys in order of min and max entered. I usually check the first and last public key as a sanity check.

## Make a deposit

./deposit.sh existing-mnemonic

follow how the staking-cli runs and when it's done you should have deposit_data.json then you should have the same pubkey as the deposit.sh you created, if you think you have the same one you created. import it into consensus and run the validator.

format of staking-cli:
```sh
[
    {
        "pubkey": "xxxxxx", # Compare your pubkey staking-cli and deposit.sh 
        "withdrawal_credentials": "",
        "amount": ,
        "signature": "",
        "deposit_message_root": "",
        "deposit_data_root": "",
        "fork_version": "00677693",
        "network_name": "cartenz",
        "deposit_cli_version": "2.5.0"
    }
]
```
