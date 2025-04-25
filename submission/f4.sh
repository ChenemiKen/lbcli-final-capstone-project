# Spend from funded address by creating a transaction with details below:
# Send exactly 10,000 sats to tb1qddpcyus3u603n63lk7m5epjllgexc24vj5ltp7
# Use transaction Fee: 700 sats
# Make sure transaction fee can be later updated to a higher fee
# Broadcast transaction
# Save txid to transaction-2.txt
# Save transaction block hash to block-2.txt and coinbase transaction to coinbase-2.txt

# recipient="tb1qddpcyus3u603n63lk7m5epjllgexc24vj5ltp7"
# utxo_txid="ec4905dd306cd403a24883f8be912cdf3af8b13164a54cc1cb223bcb5041a7c6"
# utxo_vout="775"
# changeAddr="tb1qcpjpazg4xxn5yp7k6ff7fgt45dck4t4tkhrvhg"
# rawtxhex=$(bitcoin-cli -signet -rpcwallet=ChenemiKen createrawtransaction '''[ { "txid": "'$utxo_txid'", "vout": '$utxo_vout', "sequence": 1 } ]''' "{ \"$recipient\": 0.0001, \"$changeAddr\": 0.00089858 }")
# echo $rawtxhex > myfile.json
# rawtxhex="0200000001c6a74150cb3b22cbc14ca56431b1f83adf2c91bef88348a203d46c30dd0549ec0703000000010000000210270000000000001600146b43827211e69f19ea3fb7b74c865ffa326c2aac025f010000000000160014c0641e891531a74207d6d253e4a175a3716aaeab00000000"
# signedtx=$(bitcoin-cli -signet -rpcwallet=ChenemiKen -named signrawtransactionwithwallet hexstring=$rawtxhex | jq -r '.hex')
# bitcoin-cli -signet -rpcwallet=ChenemiKen -named sendrawtransaction hexstring=$signedtx
txnId="12781bcc8755754a4dbef5e3678a3c72ede4e5a2f7e31dfc760deb599b30b3d4"
blockhash=$(bitcoin-cli -signet -rpcwallet=ChenemiKen getrawtransaction $txnId true | jq -r '.blockhash')
echo $blockhash > block-2.txt
bitcoin-cli -signet -rpcwallet=ChenemiKen getblock $blockhash | jq -r '.tx[0]' > coinbase-2.txt


