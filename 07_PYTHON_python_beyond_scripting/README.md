# The Zen of Python
``` python
python -c "import this"
```
```
The Zen of Python, by Tim Peters

Beautiful is better than ugly.
Explicit is better than implicit.
Simple is better than complex.
Complex is better than complicated.
Flat is better than nested.
Sparse is better than dense.
Readability counts.
Special cases aren't special enough to break the rules.
Although practicality beats purity.
Errors should never pass silently.
Unless explicitly silenced.
In the face of ambiguity, refuse the temptation to guess.
There should be one-- and preferably only one --obvious way to do it.
Although that way may not be obvious at first unless you're Dutch.
Now is better than never.
Although never is often better than *right* now.
If the implementation is hard to explain, it's a bad idea.
If the implementation is easy to explain, it may be a good idea.
Namespaces are one honking great idea -- let's do more of those!
```

## Python for data science
* [Miniconda](https://conda.io/miniconda.html) - _a mini version of Anaconda that includes only conda and its dependencies._
   * [Pandas](https://pandas.pydata.org/) - _powerful Python data structures and data analysis toolkit_
   * [Numpy](http://www.numpy.org/) - _N-dimensional array for numerical computation_
   * [scikit-learn](http://scikit-learn.org/stable/) - _Machine learning library for the Python_
   * [Matplotlib](https://matplotlib.org/) - _2D Plotting library for Python_
   * [Seaborn](https://seaborn.pydata.org/) - _Statistical graphics library for Python_
   * [Bokeh](https://bokeh.pydata.org/en/latest/) - _Interactive web visualisation library_
   * [Jupyter Notebook](http://jupyter.org/) - _Web-based interactive computational environment for creating, executing, and visualizing Jupyter notebooks._

On your projects use miniconda and environments to manage dependenices. See the [conda environment cheat sheet](http://know.continuum.io/rs/387-XNW-688/images/conda-cheatsheet.pdf?mkt_tok=eyJpIjoiWkRJNU1UZzBOV0ptTnpsayIsInQiOiJ6K3VQQkhtSUMrcGxoSUwxd0IxTkxFWUxpa052UnVlak1FK1RMRm1kcWplN1pDdlZIbWZWUWFpTmtFTHFYK0gxRzRMb1c1K3ViZnBoa21yZjhzaUlUMzlxM1NpMGdRSHl1VlJTMHcyeWZvYz0ifQ%3D%3D).

## How to work on this tutorial
This tutorial requires the use of Jupyter notebooks to document your work. We will run Jupyter on the instance (remotely), this requires port forwarding  as follows:

1. Connect to the remote: `ssh -i ~/path/to/pem.pem username@35.176.252.186`
2. Run the following locally: `ssh -i ~/path/to/pem.pem -NfL 8888:localhost:8888 wgrimes@35.176.252.186`. 
This sets up an ssh tunnel between a port on our machine and the port our Jupyter session is using on the remote server. For those not familiar with ssh tunneling, we’ve just created a secure, encrypted connection between port 8888 on our local machine and port 8888 on our remote server. 
* The `-N` flag tells ssh we won’t be running any remote processes using the connection. This is useful for situations like this where all we want to do is port forwarding.
* The `-f` runs ssh in the background, so we don’t need to keep a terminal session running just for the tunnel.
* The `-L` specifies that we’ll be forwarding a local port to a remote address and port. In this case, we’re forwarding port 8888 on our machine to port 8888 on the remote server. The name ‘localhost’ just means ‘this computer’.
3. Run the following remotely: `jupyter notebook --no-browser --port 8888` to launch a session
4. From the newly running session get the URL and paste it into your browser locally, it will look something like this for example, but with a different token: `http://localhost:8888/?token=d9a1ffb999abde515c1d81b6c6fb3ff50d9cc08bbecbc58e`
## Tutorial
Please proceed to the python tutorials:

https://github.com/williamgrimes/teach_python_in_notebooks

https://github.com/dssg/hitchhikers-guide/tree/master/curriculum/2_data_exploration_and_analysis/data-exploration-in-python


1. Setup Jupyter on the training instance, Prepare a plot in pandas
2. 

## Further reading:
* https://github.com/dssg/hitchhikers-guide/tree/master/curriculum/2_data_exploration_and_analysis/data-exploration-in-python
