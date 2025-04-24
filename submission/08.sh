# what block height was this tx mined ?
# 49990a9c8e60c8cba979ece134124695ffb270a98ba39c9824e42c4dc227c7eb
rawTxn=$(bitcoin-cli -signet getrawtransaction 49990a9c8e60c8cba979ece134124695ffb270a98ba39c9824e42c4dc227c7eb true)
blockHash=$(echo $rawTxn | jq -r '.blockhash')
bitcoin-cli -signet getblock $blockHash | jq -r '.height'
