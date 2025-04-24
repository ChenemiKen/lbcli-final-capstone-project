# Only one tx in block 243,821 signals opt-in RBF. What is its txid?
blockHash=$(bitcoin-cli -signet getblockhash 243821)
tx=$(bitcoin-cli -signet getblock $blockHash 2 | jq -r '.tx')
readarray -t txnsArr < <(echo "$tx" | jq -c '.[]')

for tx in "${txnsArr[@]}"; do
    txId=$(echo "$tx" | jq -r '.txid')
    readarray -t vin < <(echo "$tx" | jq -c '.vin[]')
    for vn in "${vin[@]}"; do
        sequence=$(echo "$vn" | jq -r '.sequence')
        if [ $sequence -lt 4294967294 ]; then 
            echo "$txId"
            break
        fi
    done
done