# How many satoshis did this transaction pay for fee?: b71fb9ab7707407cc7265591e0c0d47d07afede654f91de1f63c0cb522914bcb
rawTxn=$(bitcoin-cli -signet getrawtransaction b71fb9ab7707407cc7265591e0c0d47d07afede654f91de1f63c0cb522914bcb)
tx=$(bitcoin-cli -signet decoderawtransaction "$rawTxn" | jq '.')
readarray -t vins < <(echo "$tx" | jq -c '.vin[]')
readarray -t vouts < <(echo "$tx" | jq -c '.vout[]')

vinValues=()
for vn in "${vins[@]}"; do
    txId=$(echo "$vn" | jq -r '.txid')
    voutn=$(echo "$vn" | jq -r '.vout')
    utxoRaw=$(bitcoin-cli -signet getrawtransaction "$txId")
    utxo=$(bitcoin-cli -signet decoderawtransaction "$utxoRaw" | jq '.')
    readarray -t utxoVouts < <(echo "$utxo" | jq -c '.vout[]')
    refVout="${utxoVouts[voutn]}"
    val=$(echo "$refVout" | jq -r '.value')
    vinValues+=($val)
done
vinSum=$(printf "%s\n" "${vinValues[@]}" | awk '{s+=$1} END {printf "%.10f", s}')

voutValues=()
for vo in "${vouts[@]}"; do
    val=$(echo "$vo" | jq -r '.value')
    voutValues+=($val)
done
voutSum=$(printf "%s\n" "${voutValues[@]}" | awk '{s+=$1} END {printf  "%.10f", s}')

fee=$( awk "BEGIN {print ($vinSum - $voutSum) *100000000 }")
echo "$fee"