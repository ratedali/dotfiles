function rm_youtube_id
	perl-rename -v 's/-\w*\.(\w+)$/\.\1/' $argv
end
