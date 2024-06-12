dirs = zsh nvim zellij

install:
	@for dir in $(dirs); do \
		stow $$dir; \
	done

tidy:
	@for dir in $(dirs); do \
		stow -D $$dir; \
	done

.PHONY: install tidy
