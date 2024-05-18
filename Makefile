deploy:
	nix build .#darwinConfigurations.nmac.system \
	   --extra-experimental-features 'nix-command flakes' 
	./result/sw/bin/darwin-rebuild switch --flake .#nmac

test:
	nix build .#darwinConfigurations.nmac.system 
	./result/sw/bin/darwin-rebuild check --flake .#nmac