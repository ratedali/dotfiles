function jupyter-server
	set -l env root
    if [ (count $argv) -gt 0 ]
        set env $argv[1]
    end
    sudo docker run -id -v /home/ali/Workspace:/root/workspace -p 8888:8888 -p 6006:6006 machinelearning bash -c 'source activate '$env' && jupyter-notebook --ip="*" --no-browser --notebook-dir=/root/workspace/jupyter-notebooks'
end
