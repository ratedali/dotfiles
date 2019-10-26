function pass_copy
	pass show $argv[1] | head -n1 | tr -d \[:cntrl:\] | wl-copy
end
