# Which tx in block 216,351 spends the coinbase output of block 216,128?
blockHash1=$(bitcoin-cli -signet getblockhash 216128)
coinbaseTxnId=$(bitcoin-cli -signet getblock $blockHash1 | jq -r '.tx[0]')

blockHash2=$(bitcoin-cli -signet getblockhash 216351)
txns=$(bitcoin-cli -signet getblock $blockHash2 2 | jq '.tx' | jq '.[1:]')
readarray -t txnsArr < <(echo "$txns" | jq -c '.[]')

for tx in "${txnsArr[@]}"; do
    readarray -t vin < <(echo "$tx" | jq -c '.vin[]')
    for vn in "${vin[@]}"; do
        txId=$(echo "$vn" | jq -r '.txid')
        if [[ "$txId" == "$coinbaseTxnId" ]]; then 
                echo "$tx" | jq -r '.txid'
                break
        fi
    done
done
