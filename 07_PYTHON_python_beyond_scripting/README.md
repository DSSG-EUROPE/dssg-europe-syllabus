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
* [miniconda](https://conda.io/miniconda.html)
    * Essential libraries:
        * Data handling:
            * [Pandas](https://pandas.pydata.org/) - _powerful Python data structures and data analysis toolkit_
            * [Numpy](http://www.numpy.org/) - _N-dimensional array for numerical computation_
        * Plotting:
            * [Matplotlib](https://matplotlib.org/) - _2D Plotting library for Python_
            * [Seaborn](https://seaborn.pydata.org/) - _Statistical graphics library for Python_
            * [Bokeh](https://bokeh.pydata.org/en/latest/) - _Interactive web visualisation library_
        * Machine learning:
            * [scikit-learn](http://scikit-learn.org/stable/) - _Machine learning library for the Python_
* [Conda environment cheat sheet](http://know.continuum.io/rs/387-XNW-688/images/conda-cheatsheet.pdf?mkt_tok=eyJpIjoiWkRJNU1UZzBOV0ptTnpsayIsInQiOiJ6K3VQQkhtSUMrcGxoSUwxd0IxTkxFWUxpa052UnVlak1FK1RMRm1kcWplN1pDdlZIbWZWUWFpTmtFTHFYK0gxRzRMb1c1K3ViZnBoa21yZjhzaUlUMzlxM1NpMGdRSHl1VlJTMHcyeWZvYz0ifQ%3D%3D)

1. connect to remote: `ssh -i ~/path/to/pem.pem username@35.176.252.186`
2. locally: `ssh -i ~/path/to/pem.pem -NfL 8888:localhost:8888 wgrimes@35.176.252.186`
3. remote: `jupyter notebook --no-browser --port 8888`

This will launch the notebook and it is recommended that you 

`http://localhost:8888/?token=d9a1ffb999abde515c1d81b6c6fb3ff50d9cc08bbecbc58e`

Please proceed to the python tutorials:

https://github.com/williamgrimes/teach_python_in_notebooks

https://github.com/dssg/hitchhikers-guide/tree/master/curriculum/2_data_exploration_and_analysis/data-exploration-in-python


1. Setup Jupyter on the training instance, Prepare a plot in pandas
2. 

## Further reading:
* https://github.com/dssg/hitchhikers-guide/tree/master/curriculum/2_data_exploration_and_analysis/data-exploration-in-python
