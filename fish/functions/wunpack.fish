function wunpack
	set -l TEMP (mktemp)
    wget $argv[1] -O $TEMP
    aunpack -x $TEMP
    rm $TEMP
end
