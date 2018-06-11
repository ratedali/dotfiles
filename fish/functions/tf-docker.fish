function tf-docker
	sudo docker run -id -v /home/ali/Workspace:/root/workspace -p 8888:8888 -p 6006:6006 -P machinelearning \
         bash -c 'source activate tensorflow && tensorboard --logdir=/root/.tensorboard & jupyter-notebook --ip="*" --notebook-dir=/root/workspace/jupyter-notebooks --no-browser'
end
