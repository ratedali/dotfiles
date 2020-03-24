# Defined in /tmp/fish.jgmFF1/sync_playlists.fish @ line 2
function sync_playlists --description 'Sync playlists to /mnt/mtp/Phone/Music'
	if test \( -n "$argv[1]" \) -a \( -d "$argv[1]" \)
        pushd (xdg-user-dir MUSIC)
        for playlist in (find . -maxdepth 1 -name '*.m3u' -print)
            cp -v $playlist $argv[1]
            xargs -a $playlist -d '\n' cp --parents -nvt $argv[1]
        end
        popd
    else if test -z "$argv[1]"
        echo "No destination provided."
    else
        echo "No such directory: $argv[1]"
    end
end
