function gitcl
	if [ (count $argv) -gt 0 ]
        for repo in $argv
            echo 'Cloning:' $argv
            git clone 'git@github.com:'$repo
        end
    else
        echo 'You need to specify at least one repo to clone'
    end
end
