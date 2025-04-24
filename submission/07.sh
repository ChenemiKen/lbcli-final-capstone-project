# what is the coinbase tx in this block 243,834
blockHash=$(bitcoin-cli -signet getblockhash 243834)
bitcoin-cli -signet getblock $blockHash 2 | jq -r '.tx[0].txid'