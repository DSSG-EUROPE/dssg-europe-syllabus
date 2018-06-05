## Python Setup for Data Science 
* [Miniconda](https://conda.io/miniconda.html) - _a mini version of Anaconda that includes only conda and its dependencies._
* Commonly used packages:
   * [Pandas](https://pandas.pydata.org/) - _powerful Python data structures and data analysis toolkit_
   * [Numpy](http://www.numpy.org/) - _N-dimensional array for numerical computation_
   * [SQLAlchemy](http://www.numpy.org/) - _SQLAlchemy is the Python SQL toolkit and Object Relational Mapper that gives application developers the full power and flexibility of SQL._
   * [scikit-learn](http://scikit-learn.org/stable/) - _Machine learning library for the Python_
   * [Matplotlib](https://matplotlib.org/) - _2D Plotting library for Python_
   * [Seaborn](https://seaborn.pydata.org/) - _Statistical graphics library for Python_
   * [Bokeh](https://bokeh.pydata.org/en/latest/) - _Interactive web visualisation library_
   * [Jupyter Notebook](http://jupyter.org/) - _Web-based interactive computational environment for creating, executing, and visualising Jupyter notebooks._

Anaconda uses the conda python package management system bundled with ~ 150 scientific Python libraries. On the other hand Miniconda just ships the conda package management system, without bundling in the Python libraries. On your projects we recommend using miniconda, and manually installing the required libraries within environments. These environments can be used to collaborate on teams, and keep for example different environments for development and production. This approach using Miniconda saves on disk space and reduces the risk of package conflicts, and redundant packages. For more information have a look at:

* [Why you need Python environments and how to manage them with Conda](https://medium.freecodecamp.org/why-you-need-python-environments-and-how-to-manage-them-with-conda-85f155f4353c)
* [Conda: Myths and Misconceptions](http://jakevdp.github.io/blog/2016/08/25/conda-myths-and-misconceptions/)
* [Conda environment cheat sheet](http://know.continuum.io/rs/387-XNW-688/images/conda-cheatsheet.pdf?mkt_tok=eyJpIjoiWkRJNU1UZzBOV0ptTnpsayIsInQiOiJ6K3VQQkhtSUMrcGxoSUwxd0IxTkxFWUxpa052UnVlak1FK1RMRm1kcWplN1pDdlZIbWZWUWFpTmtFTHFYK0gxRzRMb1c1K3ViZnBoa21yZjhzaUlUMzlxM1NpMGdRSHl1VlJTMHcyeWZvYz0ifQ%3D%3D)

## How to connect Jupyter notebook to a remote instance
This tutorial requires the use of Jupyter notebooks to document your work. We will run Jupyter on the instance (remotely), this requires port forwarding  as follows:

1. Connect to the remote: `ssh -i ~/path/to/pem.pem username@35.176.252.186`
2. Run the following locally: `ssh -i ~/path/to/pem.pem -NfL 8888:localhost:8888 wgrimes@35.176.252.186`. 
This sets up an ssh tunnel between a port on our machine and the port our Jupyter session is using on the remote server. For those not familiar with ssh tunneling, we’ve just created a secure, encrypted connection between port 8888 on our local machine and port 8888 on our remote server. 

> The `-N` flag tells ssh we won’t be running any remote processes using the connection. This is useful for situations like this where all we want to do is port forwarding.

> The `-f` runs ssh in the background, so we don’t need to keep a terminal session running just for the tunnel.

> The `-L` specifies that we’ll be forwarding a local port to a remote address and port. In this case, we’re forwarding port 8888 on our machine to port 8888 on the remote server. The name ‘localhost’ just means ‘this computer’.

3. Run the following remotely: `jupyter notebook --no-browser --port 8888` to launch a session
4. From the newly running session get the URL and paste it into your browser locally, it will look something like this for example, but with a different token: `http://localhost:8888/?token=d9a1ffb999abde515c1d81b6c6fb3ff50d9cc08bbecbc58e`

## Tutorial
Please complete the following exercises:

1. [Working with data in Python](./working_with_data_in_python.ipynb)

2. 
