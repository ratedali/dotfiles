function ml-docker
	sudo docker run -it -v /home/ali/Workspace/:/root/workspace -p 8888:8888 -p 6006:6006 -P machinelearning bash
end
