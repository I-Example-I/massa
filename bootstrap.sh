#!/bin/bash
systemctl stop massa
echo "applying massa bootstrap fix"
echo '[bootstrap]
max_ping = 10000
bootstrap_list = [
["185.197.195.252:31245", "7a6nX4kFkC5EyBL9SkMPG5AMaYp4vNJ7m2kEP4Tv9bUqusgQH5"],
  ["23.88.41.157:31245", "6hyjefimSzgkZ4sdDb359i2ENCGRZ26HNBeY9TJ4vbnPDwCQ1S"],
  ["45.153.230.45:31245", "5NSmh61swzoW9ek72oLemRxFGfwdoZK8iFivELwUfxrXcA4i7a"],
  ["65.21.179.246:31245", "5zybn9b5KFqNknU5xdXpLkWjkzcc4yQuQhfvkZYeNxEge4VDDf"],
  ["139.64.165.94:31245", "83ZXoJJ44tvQwios54N3Vv8h9SVxGPZWGDMCMcGxsFCfWJrGY2"],
  ["38.242.205.229:31245", "7KSECihFbAcnfY7a1jqAVDJ9U1GdGSrkWMt7oSz3ZG6H5BfRti"],
  ["194.163.167.238:31245", "6E9RrGeZRHEmxw5u1D9bsAm47H5LQUM9Qyxib6d4bw2Esq7WfX"],
  ["161.97.146.128:31245", "51yji8sMuzYSvzW3vJtHEvnpDesQJkBDhi62N3HNJzUZ4AGTQj"],
  ["173.249.42.118:31245", "4tYFyB6QW1ZQd3p12kenXprVyZidQGFd3gri8fqo5WMeHbx1NR"],
  ["31.186.136.216:31245", "5dVXQnzghH6HVhxvypWsW75WaZAFMs6jtQ8WwMyctwADMLYZ7f"],
  ["49.12.194.174:31245", "6cihnHRzHvU9CS9yn8Y6rqLpPynaMFBwwC6dSZs7F125gY2hL4"],
  ["194.61.116.34:31245", "74TfDTuHqJddicVCmLXDLDQXtkWnSUHG3ewJBB3LfjwQzLiQ4c"],
  ["135.181.250.24:31245", "6KQk27HC22dzqzoTH7GsU4PGLcFSTb6UJp4fhgarL9qUqrUWMF"],
  ["65.108.219.137:31245", "83wf2StrEVBQBUX4NGsXQvkqdM9ZxXZJT2bqDu59H74eJv12zy"],
  ["23.88.105.81:31245", "8BfRPy8LBJFwBQw4bTqqjdvRPyrZB499PssRVgK1vNhGS7Vh78"],
  ["144.91.112.242:31245", "7JioBE2GRSMKcvguK3ZHfrT3pmeKpSP28sx5hahh4dfnTiyXa7"],
  ["46.101.78.25:31245", "4vdM2uNjMQ9PyDzFrvVdT58hWH1fdkoK27q2f5S6TqfGJmjBzK"],
  ["78.107.234.44:31245", "8mm26R9fTKKS3UmXoLwBo59Vgg5cJtgQrQJU4ZEFJyxuESreei"],
  ["164.92.210.114:31245", "6KBNjsPKgNqomDmoo5jDQgn2hNWuRJjb8bBMoX5nieTV39DNyd"],
  ["138.201.156.188:31245", "674nM9FVr2tbgEFQAiM1Qqgom8Feha65CqAVvt7Azt1EF9xqrM"],
  ["65.21.233.251:31245", "86vMuYD4VsbEwBgNxqCaRj32vYvQUdLezojZ6meu6jTLEGbhJr"],
  ["38.242.209.151:31245", "71RsSsMTyj2zS9dUHyT9YUKGiNAiGELtCeU9iVVBG5dCVJUTub"],
  ["139.59.160.209:31245", "6T8SLoTwSDbAXDXEWad3hn8iNypETPyMeeKbZBjn4fiUJCHZG7"],
  ["65.108.89.180:31245", "5VVaGEYM9jRw56wbE8P2n88zfzERmA4Kr6HNYbKzsPLBNjrG5G"],
  ["65.108.83.152:31245", "7VxXXcUgME5kTTBmQwFEbdMz7uo6znTLNYWFVocHbybVeVnP3b"]
]
connect_timeout = 15000
retry_delay = 60000
' > massa/massa-node/config/config.toml
systemctl restart massa
echo "fixed applied, wait a few minutes and check logs:"
echo "journalctl -n 100 -f -u massa"