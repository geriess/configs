all: download clean sync source

download:
	# zsh-autosuggestions
	git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
	# zsh-syntax-highlighting
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting
	# tmux
	sudo apt-get install tmux
	# jump
	wget https://github.com/gsamokovarov/jump/releases/download/v0.22.0/jump_0.22.0_amd64.deb
	sudo dpkg -i jump_0.22.0_amd64.deb
	# direnv
	sudo apt-get install direnv
	# silver searcher
	sudo apt-get install silversearcher-ag

sync:
	# mkdir -p ~/.config/nvim
	# mkdir -p ~/.config/alacritty

	# [ -f ~/.config/nvim/init.vim ] || ln -s $(PWD)/vimrc ~/.config/nvim/init.vim
	# [ -f ~/.config/alacritty/alacritty.yml ] || ln -s $(PWD)/alacritty.yml ~/.config/alacritty/alacritty.yml
	[ -f ~/.vimrc ] || ln -s $(PWD)/vimrc ~/.vimrc
	[ -f ~/.bashrc ] || ln -s $(PWD)/bashrc ~/.bashrc
	[ -f ~/.zshrc ] || ln -s $(PWD)/zshrc ~/.zshrc
	[ -f ~/.tmux.conf ] || ln -s $(PWD)/tmuxconf ~/.tmux.conf
	# [ -f ~/.tigrc ] || ln -s $(PWD)/tigrc ~/.tigrc
	[ -f ~/.git-prompt.sh ] || ln -s $(PWD)/git-prompt.sh ~/.git-prompt.sh
	[ -f ~/.gitconfig ] || ln -s $(PWD)/gitconfig ~/.gitconfig
	# [ -f ~/.agignore ] || ln -s $(PWD)/agignore ~/.agignore

	# don't show last login message
	touch ~/.hushlogin

clean:
	rm -f ~/.vimrc
	# rm -f ~/.config/nvim/init.vim
	# rm -f ~/.config/alacritty/alacritty.yml
	rm -f ~/.bashrc
	rm -f ~/.zshrc
	rm -f ~/.tmux.conf
	# rm -f ~/.tigrc
	rm -f ~/.git-prompt.sh
	rm -f ~/.gitconfig
	# rm -f ~/.agignore
	# rm -f ~/.ssh/config

source:
	source ~/.zshrc

.PHONY: all download clean sync build run kill source
