#!/usr/bin/env bash

# Install Vault if missing
which vault &>/dev/null || {
  echo Installing Vault
  tmp1=$(mktemp -d --tmpdir=/var/tmp)
  pushd ${tmp1}
  wget -nv https://releases.hashicorp.com/vault/0.11.4/vault_0.11.4_linux_amd64.zip
  unzip vault_0.11.4_linux_amd64.zip
  mv vault /usr/sbin/
  popd
  rm -rf ${tmp1}
}

# Due to using "-dev" we need to tell Vault CLI to use HTTP instead of HTTPS
grep VAULT_ADDR ~/.bash_profile || {
  echo export VAULT_ADDR=http://127.0.0.1:8200 | sudo tee -a ~/.bash_profile
}

grep VAULT_ADDR /home/vagrant/.bash_profile || {
  echo export VAULT_ADDR=http://127.0.0.1:8200 | sudo tee -a /home/vagrant/.bash_profile
  chown vagrant: /home/vagrant/.bash_profile
}

# read variables
. ~/.bash_profile

# Start Vault (if not running)
vault status &>/dev/null || {
  vault server -dev &>vault.log &
  echo vault started
  # wait to make sure vault is working
  sleep 3
}

# Add the DB credentials to the Vault KV store
vault kv put secret/mysql user=test password=pass
vault kv get secret/mysql