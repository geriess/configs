GITCOMMIT := $(shell git rev-parse --short=7 HEAD 2>/dev/null)
NAME=dev

all: build

build:
	docker build -t geries/${NAME}:${GITCOMMIT} .

push:
	@echo "==> Publishing geries/${NAME}:$(GITCOMMIT)"
	@docker tag geries/${NAME}:$(GITCOMMIT) geries/${NAME}:latest
	@docker push geries/${NAME}:$(GITCOMMIT)
	@docker push geries/${NAME}:latest
	@echo "==> Your image is now available at geries/${NAME}:$(GITCOMMIT)"

run: kill
	docker run -it -h dev -d -p 1313:1313 --net=host --rm -v /var/run/docker.sock:/var/run/docker.sock -v /home/geries/code:/home/geries/code -v /home/geries/.ssh:/home/geries/.ssh -v /home/geries/.zsh_private:/home/geries/.zsh_private -v /home/geries/.zsh_history:/home/geries/.zsh_history --cap-add=SYS_PTRACE --security-opt seccomp=unconfined --privileged --name dev geries/dev

ssh:
	mosh --no-init --ssh="ssh -o StrictHostKeyChecking=no -i ~/.ssh/github_rsa -p 3222" root@localhost -- tmux new-session -AD -s main

kill:
	docker kill dev | true


.PHONY: all build run kill
