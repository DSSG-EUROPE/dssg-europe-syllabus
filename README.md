# Overview and Softare Setup

This repository contains teaching resources that we will use over the fellowship. It is supplementary to the [DSSG Hitchiker's Guide](https://github.com/dssg/hitchhikers-guide) and heavily sourced from it, which is an invaluable resource for doing any DSSG project. This repository is tailored specifically to the tutorials/classes we will be giving over the 2018 summer fellowship in Lisbon.

## Technical support:
* **Nuno Brás** - lead technical mentor
* **Qiwei Han** - junior technical mentor
* **William Grimes** - junior technical mentor
* **Iñigo Martínez de Rituerto de Troya** - infrastructure and technical support
* **João Fonseca** - infrastructure support

## Technical mentor’s role: 
* Project mentor/consultant on technical side
* Core infrastructure maintenance (data, computing resources)
* Technical training/support

Ask us anything about technical stuff. We will try our best to help you address the difficulties or direct you to the right person whenever necessary.

### Local software setup for tutorials
* SSH (PuTTY for Windows)
* Git (for version control)
* psql (PostgreSQL command line interface)
* Python (Anaconda/Miniconda https://www.continuum.io/downloads) or pip + virtualenv
* IDE / text editor (Sublime, Vim, VS studio, PyCharm, Spyder, ...)
* DBeaver (http://dbeaver.jkiss.org/)
* Python Packages
    * pandas/numpy/scipy
    * matplotlib (https://matplotlib.org/)
    * scikit-learn (http://scikit-learn.org)
    * psycopg2 (http://initd.org/psycopg/)
    * ipython (https://ipython.org/)
    * jupyter (http://jupyter.org/)

## Local software setup for development
* SSH (PuTTY for Windows)
* IDE / text editor (Sublime, Vim, VS studio, PyCharm, Spyder, ...)
* DBeaver (http://dbeaver.jkiss.org/)
* IDE

For more detail on the software setup have a look [here](https://github.com/dssg/hitchhikers-guide/tree/master/curriculum/0_before_you_start/software-setup).

Try it out!
You should give all installed software a quick spin to check that it did install. For your python packages, try to import them. Type `python` in your shell, and then once you are in your python session, try for example `import numpy`, `import matplotlib`, and so on. (You can quit with exit().) Also try ipython and jupyter notebook in your terminal, and see if you get any errors.

## Working in the cloud
Project work over the summer will be done in a cloud computing environment, where each project will have a seperate server (AWS EC2 instance) as their main server for large-scale data processing tasks, and a database to securely store the data. This is advantageous since data is maintained in one place, teams can collaborate easily, and you have access to scalable computing resources.

![stack](images/stack.png)

Good news: DSSG is supported by Amazon Web Service Cloud Credits for Research program and Microsoft Azure for Research awards!
Amazon Web Service (AWS) https://aws.amazon.com/

Each fellow will be assigned a user account that allows you to make use of AWS service

# Technical Syllabus
