#!/bin/bash

echo "
░█▀▀█ ─█▀▀█ ░█▀▀█ ▀▀█▀▀ ░█▀▀▀ ░█▄─░█ ░█▀▀▀█ 　 ░█▀▀▄ ░█▀▀▀ ░█▀▀█ ░█▀▀▀█ ░█▀▀▀█ ▀█▀ ▀▀█▀▀ 
░█─── ░█▄▄█ ░█▄▄▀ ─░█── ░█▀▀▀ ░█░█░█ ─▄▄▄▀▀ 　 ░█─░█ ░█▀▀▀ ░█▄▄█ ░█──░█ ─▀▀▀▄▄ ░█─ ─░█── 
░█▄▄█ ░█─░█ ░█─░█ ─░█── ░█▄▄▄ ░█──▀█ ░█▄▄▄█ 　 ░█▄▄▀ ░█▄▄▄ ░█─── ░█▄▄▄█ ░█▄▄▄█ ▄█▄ ─░█──"

amount=32000000000
smin= #change-me
smax= #change-me
vmnemonic= #change-me
mnemonic= #change-me

# they should start with 0x.
address= #change-me
privkey= #change-me

eth2-val-tools deposit-data \
--amount=$amount \
--fork-version=0x00677693 \
--source-min=$smin \
--source-max=$smax \
--withdrawals-mnemonic="$mnemonic" \
--validators-mnemonic="$vmnemonic" > cartenz_deposits_$smin\_$smax.txt

while read x; do
   account_name="$(echo "$x" | jq '.account')"
   pubkey="$(echo "$x" | jq '.pubkey')"
   echo "Sending deposit for validator $account_name $pubkey"
   ethereal beacon deposit \
      --allow-unknown-contract=true \
      --address="0x4242424242424242424242424242424242424242" \
      --connection=https://rpc-phase1.cartenz.works \
      --data="$x" \
      --allow-excessive-deposit \
      --value="$amount" \
      --from="$address" \
      --privatekey="$privkey"
   echo "Sent deposit for your validator $account_name $pubkey"
   sleep 2
done < cartenz_deposits_$smin\_$smax.txt
