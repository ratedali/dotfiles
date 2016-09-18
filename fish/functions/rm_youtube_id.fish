function rm_youtube_id
	perl-rename -v 's/[(^\d?)]-\w+((\.\w+)+)$/\1\2/' $argv
end
