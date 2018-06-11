function rmorphans
	sudo pacman -Rns (pacman -Qdtq)
end
