#!/bin/bash

set -eu

echo "pull-secrets.sh needs work"
echo "Authenticating with xxxxx"
export OP_SESSION_my=$(op signin https://my.1password.com geries.simon@gmail.com --output=raw)

echo "Pulling secrets"
# private keys
op get document 'github_rsa' > github_rsa
# op get document 'zsh_private' > zsh_private
op get document 'zsh_history' > zsh_history
op get document 'dokey' > dokey

rm -f ~/.ssh/github_rsa
rm -f ~/.ssh/dokey
# rm -f ~/.zsh_private
rm -f ~/.zsh_history

ln -s $(pwd)/github_rsa ~/.ssh/github_rsa
chmod 0600 ~/.ssh/github_rsa
ln -s $(pwd)/dokey ~/.ssh/dokey
chmod 0600 ~/.ssh/dokey
# ln -s $(pwd)/zsh_private ~/.zsh_private
ln -s $(pwd)/zsh_history ~/.zsh_history

echo "Done!"
