# How many new outputs were created by block 243,825?
blockHash=$(bitcoin-cli -signet getblockhash 243825)
bitcoin-cli -signet getblock $blockHash 2 | jq -r '[.tx[].vout | length] | add'