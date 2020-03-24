# Defined in /tmp/fish.50IjAh/tag_mv.fish @ line 2
function tag_mv
	mv -t $argv[2] (ranger --list-tagged-files=$argv[1])
end
