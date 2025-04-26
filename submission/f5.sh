# Create 2-of-3 multisig address:

# Save to multisig-address.txt
# Save redeemScript to multisig-redeem.txt
# Fund using this faucet(alt.signetfaucet.com), and save txid to multisig-transaction.txt
# Save transaction block hash to multisig-block.txt and coinbase transaction to multisig-coinbase.txt

# address1=$(bitcoin-cli -signet -rpcwallet=ChenemiKen getnewaddress -addresstype bech32)
# address2=$(bitcoin-cli -signet -rpcwallet=ChenemiKen getnewaddress -addresstype bech32)
# address3=$(bitcoin-cli -signet -rpcwallet=ChenemiKen getnewaddress -addresstype bech32)
# pubkey1=$(bitcoin-cli -signet -rpcwallet=ChenemiKen getaddressinfo $address1 | jq -r '.pubkey')
# pubkey2=$(bitcoin-cli -signet -rpcwallet=ChenemiKen getaddressinfo $address2 | jq -r '.pubkey')
# pubkey3=$(bitcoin-cli -signet -rpcwallet=ChenemiKen getaddressinfo $address3 | jq -r '.pubkey')

# multisig=$(bitcoin-cli -signet -rpcwallet=ChenemiKen -named createmultisig nrequired=2 keys='''["'$pubkey1'","'$pubkey2'", "'$pubkey3'"]''')
# echo $multisig | jq -r '.address' > multisig-address.txt
# echo $multisig | jq -r '.redeemScript' > multisig-redeem.txt
# echo $multisig | jq -r '.descriptor' > multisig-desc.txt

# desc=$(< multisig-desc.txt)
# bitcoin-cli -signet -rpcwallet=ChenemiKen importdescriptors "[{\"desc\": \"$desc\", \"timestamp\": \"now\", \"watchonly\": true}]"

txid=$(<multisig-transaction.txt)
blockHash=$(bitcoin-cli -signet -rpcwallet=ChenemiKen getrawtransaction $txid true | jq -r '.blockhash')
echo $blockHash > multisig-block.txt
bitcoin-cli -signet -rpcwallet=ChenemiKen getblock $blockHash | jq -r '.tx[0]' > multisig-coinbase.txt

