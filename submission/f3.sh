bitcoin-cli -signet -rpcwallet=ChenemiKen getnewaddress -addresstype bech32
bitcoin-cli -signet -rpcwallet=ChenemiKen getbalance
bitcoin-cli -signet -rpcwallet=ChenemiKen listtransactions
$ bitcoin-cli -signet -rpcwallet=ChenemiKen getblock 000000eb5db5f9f64ab98ada3b23a4ac105fa80b45136f97e9201689a912d9ca 2 > myfile.json