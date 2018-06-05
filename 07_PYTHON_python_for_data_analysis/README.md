## 1. Python Setup for Data Science 

Python is a popular choice for data science since it is powerful, fast, plays well with others, runs everywhere, is easy to learn, highly readable, and is open. The following Python libraries are some of the most frequently used in data science projects:
* [Pandas](https://pandas.pydata.org/) - _powerful Python data structures and data analysis toolkit_
* [Numpy](http://www.numpy.org/) - _N-dimensional array for numerical computation_
* [SQLAlchemy](http://www.numpy.org/) - _SQLAlchemy is the Python SQL toolkit and Object Relational Mapper that gives application developers the full power and flexibility of SQL._
* [scikit-learn](http://scikit-learn.org/stable/) - _Machine learning library for the Python_
* [Matplotlib](https://matplotlib.org/) - _2D Plotting library for Python_
* [Seaborn](https://seaborn.pydata.org/) - _Statistical graphics library for Python_
* [Bokeh](https://bokeh.pydata.org/en/latest/) - _Interactive web visualisation library_
* [Jupyter Notebook](http://jupyter.org/) - _Web-based interactive computational environment for creating, executing, and visualising Jupyter notebooks._

Concurrently managing and maintaining Python environments is essential to your teams success. There are several approaches to do this namely using `pip` and virtual environments  or `conda`. 

* **Conda** is an open source, cross-platform, language-agnostic package manager and environment management system that installs, runs, and updates packages and their dependencies.
* **Anaconda** uses Python and the conda python package management system bundled with ~ 150 scientific Python libraries. 
* **Miniconda** uses the conda package management system, without bundling in the Python libraries. 

For your projects we recommend using Miniconda, and manually installing the required libraries within environments. These environments can be used to collaborate on teams, and keep for example different environments for development and production. This approach using Miniconda saves on disk space and reduces the risk of package conflicts, and redundant packages.

## 2. Adding Miniconda to PATH
On your EC2 instances you will have Miniconda installed with Python 3.6 at the `/opt/` directory (for optional application software packages). Before we can discuss package management we have to add Miniconda to the `PATH` variable.

The `PATH` variable defines where the operating systems searches for executables. The path is stored in an environment variable, which is a named string maintained by the operating system. This variable contains information available to the command shell and other programs.

1. SSH into your EC2 server `ssh -i </path/to/pem>.pem <username>@<ip_address>`

2. Append the Miniconda path to your `~/.bashrc` file, and source to execute. 
```
echo "export PATH=\"/opt/miniconda3/bin:\$PATH\"" >> ~/.bashrc;
source ~/.bashrc
```

#### Further reading:
* [Linux Filesystem Hierarchy Standard](https://en.wikipedia.org/wiki/Filesystem_Hierarchy_Standard).

## 3. Package management with Conda
Now to use virtual environments in Conda. Create yourself a virtual environment where you can install your own Python packages (change <venv> to your virtual environment name of choice - I suggest something short, like your initials, or your project initials):

**Create a new environment**
```
conda create -n <venv>
```

**Activate an existing environment**
```
source activate <venv>
```

**De-activate an environment**
```
source deactivate
```
**Install packages in the environment**
```
source activate <venv>
conda install pandas
```

**Check what  packages are installed in the environment**
```
conda list
```

**For help using conda and it's functions look here**
```
conda help
```


**Please only install packages inside your own environment.** This will ensure your packages don't clash with your other team members'.

Once you start coding, it will be important to maintain a shared list of Python packages required for your project. Here's an example from last year: https://github.com/DSSG-EUROPE/jdms/blob/master/requirements.txt With this file, someone else (a new team member, a project partner, a future repo contributor) will be able to recreate a conda environment on their machine with all the correct package versions to run your code, and avoid clashing with other packages they have already installed on their machine.

#### Further reading:
* [Why you need Python environments and how to manage them with Conda](https://medium.freecodecamp.org/why-you-need-python-environments-and-how-to-manage-them-with-conda-85f155f4353c)
* [Conda: Myths and Misconceptions](http://jakevdp.github.io/blog/2016/08/25/conda-myths-and-misconceptions/)
* [Conda environment cheat sheet](http://know.continuum.io/rs/387-XNW-688/images/conda-cheatsheet.pdf?mkt_tok=eyJpIjoiWkRJNU1UZzBOV0ptTnpsayIsInQiOiJ6K3VQQkhtSUMrcGxoSUwxd0IxTkxFWUxpa052UnVlak1FK1RMRm1kcWplN1pDdlZIbWZWUWFpTmtFTHFYK0gxRzRMb1c1K3ViZnBoa21yZjhzaUlUMzlxM1NpMGdRSHl1VlJTMHcyeWZvYz0ifQ%3D%3D)

## 4. How to connect Jupyter notebook to a remote instance
This tutorial requires the use of Jupyter notebooks to document your work. We will run Jupyter on the instance (remotely), this requires port forwarding  as follows:

1. Connect to the remote: `ssh -i ~/path/to/pem.pem username@35.176.252.186`
2. Run the following locally: `ssh -i ~/path/to/pem.pem -NfL 8888:localhost:8888 wgrimes@35.176.252.186`. 
This sets up an ssh tunnel between a port on our machine and the port our Jupyter session is using on the remote server. For those not familiar with ssh tunneling, we’ve just created a secure, encrypted connection between port 8888 on our local machine and port 8888 on our remote server. 

> The `-N` flag tells ssh we won’t be running any remote processes using the connection. This is useful for situations like this where all we want to do is port forwarding.

> The `-f` runs ssh in the background, so we don’t need to keep a terminal session running just for the tunnel.

> The `-L` specifies that we’ll be forwarding a local port to a remote address and port. In this case, we’re forwarding port 8888 on our machine to port 8888 on the remote server. The name ‘localhost’ just means ‘this computer’.

3. Run the following remotely: `jupyter notebook --no-browser --port 8888` to launch a session
4. From the newly running session get the URL and paste it into your browser locally, it will look something like this for example, but with a different token: `http://localhost:8888/?token=d9a1ffb999abde515c1d81b6c6fb3ff50d9cc08bbecbc58e`


## 5. Pandas Cookbook
<img src="https://media.giphy.com/media/EPcvhM28ER9XW/giphy.gif" width="40%" />

## 6. Tutorial
Please complete the following exercises:

1. [Notebook: working_with_data_in_python](./working_with_data_in_python.ipynb)
