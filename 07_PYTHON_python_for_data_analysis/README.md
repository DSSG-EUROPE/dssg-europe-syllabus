## 1. Python for Data Science 
Python is a popular programming language for _data science_ since it is powerful, fast, extensible, runs everywhere, is easy to learn, highly readable, and is open. The following Python libraries are some of the most frequently used in data science projects:
* [Pandas](https://pandas.pydata.org/) - powerful Python data structures and data analysis toolkit
* [Numpy](http://www.numpy.org/) - N-dimensional array for numerical computation
* [SQLAlchemy](http://www.numpy.org/) - SQLAlchemy is the Python SQL toolkit and Object Relational Mapper that gives application developers the full power and flexibility of SQL
* [scikit-learn](http://scikit-learn.org/stable/) - Machine learning library for the Python.
* [Matplotlib](https://matplotlib.org/) - 2D Plotting library for Python
* [Seaborn](https://seaborn.pydata.org/) - Statistical graphics library for Python
* [Bokeh](https://bokeh.pydata.org/en/latest/) - Interactive web visualisation library
* [Jupyter Notebook](http://jupyter.org/) - Web-based interactive computational environment for creating, executing, and visualising Jupyter notebooks.

Concurrently managing and maintaining Python environments is going to be very important for your team's success, this allows you to collaborate and easily repliacte each others work. There are several approaches to managing environments in Python namely using `pip` and virtual environments or `conda`. 

* **Conda** is an open source, cross-platform, language-agnostic package manager and environment management system that installs, runs, and updates packages and their dependencies.
* **Anaconda** uses Python and the conda python package management system bundled with ~ 150 scientific Python libraries. 
* **Miniconda** uses the conda package management system, without bundling in the Python libraries. 

For your projects we recommend using Miniconda, and manually installing the required libraries within environments. These environments can be used to collaborate in teams, and keep for example different environments for development and production. This approach using Miniconda saves on disk space and reduces the risk of package conflicts, and redundant packages.

## 2. Adding Miniconda to PATH
On your EC2 instances you will have Miniconda installed with Python 3.6 at the `/opt/` directory (for optional application software packages). Before we can discuss package management we have to add Miniconda to the `PATH` variable.

The `PATH` variable defines where the operating systems searches for executables. The path is stored in an environment variable, which is a named string maintained by the operating system. This variable contains information available to the command shell and other programs. So in the following commands we are telling the OS whereto find the Python files in the `/opt/` directories.

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

**Remove an environment**
```
conda env remove -n <venv>
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


## 5. Pandas basics
<img src="https://media.giphy.com/media/EPcvhM28ER9XW/giphy.gif" width="40%" />

Pandas is very useful for handing dataframes/tables in Python and especially for dealing with `csv` or `xls` files, and doing data manipulation. 

As other libraries, import pandas and for convenience/convention reference it as pd.

```
import pandas as pd
```
#### Data structures:
**Series** - a one-dimensional labelled array capable of holding any data type
```
s = pd.Series([3, -5, 7, 4],  index=['a',  'b',  'c',  'd'])
```

**DataFrame** - a two-dimensional labelled data structure with columns of potentially different types
```
data = {'Country': ['Belgium',  'India',  'Brazil'],
'Capital': ['Brussels',  'New Delhi',  'Brasilia'],
'Population': [11190846, 1303171035, 207847528]}

df = pd.DataFrame(data, columns=['Country',  'Capital',  'Population'])
```

#### Getting help:
```
help(pd.Series.loc)
```

#### input/output:
**Read csv** - read in a csv file
```
pd.read_csv('./data/chicago_past_year_crimes.csv', header=None, nrows=5)
```
**Write a dataframe to file** - write a csv file
```
pd.to_csv('myDataFrame.csv')
```

**Information on Series/DataFrame** 
Basic Information
```
df.shape
```
Describe index
```
df.index
```
Describe DataFrame columns
```
df.columns
```
Info on DataFrame
```
df.info()
```
Number of non-NA values
```
df.count()
```
Sum of values
```
df.sum()
```
Cumulative sum of values
```
df.cumsum()
```
Minimum/Maximum values
```
df.min()
df.max()
```
Summary statistics
```
df.describe()
```
Mean of values
```
df.mean()
```
Median of values
```
df.median()
```

#### Data Selection:
**Subset of a DataFrame** - 
```
df[1:]
```

**By Position** - select single value by row and and column
```
df.iloc([0], [0])
```

**By Label** - select single value by row and column labels
```
df.loc([0],  ['Country'])
```

**By Label/Position** - select single row of subset of rows
```
df.ix[2]
```

**Boolean Indexing:** - Series s where value is not >1
```
s[~(s > 1)]
```
where value is <-1 or >2
```
s[(s < -1) | (s > 2)]
```
Use filter to adjust DataFrame
```
df[df['Population']>1200000000]
```

**Setting** - set index a of Series s to 6
```
s['a'] = 6
```

#### Dropping:
Drop values from rows (axis=0)
```
s.drop(['a',  'c'])
```

Drop values from columns(axis=1)
```
df.drop('Country', axis=1) 
```

**Sort and rank** - sort by labels along an axis
```
df.sort_index()
```
Sort by the values along an axis
```
df.sort_values(by='Country') 
```
Assign ranks to entries
```
df.rank()
```

## 6. Tutorial
Please complete the following exercises:

1. [Notebook: working_with_data_in_python](./working_with_data_in_python.ipynb)
