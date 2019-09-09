function codebuild-status
	aws codebuild batch-get-builds --ids $argv[1] | jq -r '.builds[0] | {start: .startTime, status: .buildStatus, phases: .phases, log: .logs.deepLink}'
end
