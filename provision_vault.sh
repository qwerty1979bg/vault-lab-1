#!/usr/bin/env bash

# Install Vault if missing
which vault || {
echo Installing Vault
#tmp1=$(mktemp -d --tmpdir=/dev/shm/)
tmp1=$(mktemp -d --tmpdir=/tmp)
pushd .
cd $tmp1
wget -nv https://releases.hashicorp.com/vault/0.11.4/vault_0.11.4_linux_amd64.zip
unzip vault_0.11.4_linux_amd64.zip
mv vault /usr/sbin/
popd
rm -rf $tmp1
}

# Due to using "-dev" we need to tell Vault CLI to use HTTP instead of HTTPS
grep VAULT_ADDR ~/.bash_profile || {
  echo export VAULT_ADDR=http://127.0.0.1:8200 | sudo tee -a ~/.bash_profile
. ~/.bash_profile
}

# Start Vault (if not running)
vault status || {
vault server -dev &
echo vault started
#sleep 3
}

# Add the DB credentials to the Vault KV store (#YOLO)
vault kv put secret/mysql user=test password=pass
vault kv get secret/mysql

echo done

exit 0
