
1. connect to remote: `ssh -i ~/path/to/pem.pem username@35.176.252.186`
2. locally: `ssh -i ~/path/to/pem.pem -NfL 8888:localhost:8888 wgrimes@35.176.252.186`
3. remote: `jupyter notebook --no-browser --port 8888`

This will launch the notebook and it is recommended that you 

`http://localhost:8888/?token=d9a1ffb999abde515c1d81b6c6fb3ff50d9cc08bbecbc58e`

Please proceed to the python tutorials:

https://github.com/williamgrimes/teach_python_in_notebooks

https://github.com/dssg/hitchhikers-guide/tree/master/curriculum/2_data_exploration_and_analysis/data-exploration-in-python

