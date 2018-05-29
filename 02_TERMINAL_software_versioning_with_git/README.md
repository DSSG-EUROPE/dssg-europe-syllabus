# Software Versioning with Git
Version control systems (VCS) are useful to manage source code over time, keeping track of modifications in a special database. This allows developers to return to an earlier state, or compare the code with earlier versions of the itself. VC protects source code from both catastrophe and the casual degradation of human error and unintended consequences. VC helps teams solve conflicting code changes by tracking every individual change by each contributor and helping to prevent concurrent pieces of work from conflicting.

One of the most popular version control systems (VCS) in use today is called Git. Git is a Distributed VCS, a category known as DVCS. Like many of the most popular VCS systems available today, Git is free and open source. Regardless of what they are called, or which system is used, the primary benefits you should expect from version control are as follows:
* A complete change history of every file.
* Branching and merging. Having team members work concurrently is a no-brainer, but even individuals working on their own can benefit from the ability to work on independent streams of changes. Creating a "branch" with VCS tools keeps multiple streams of work independent from each other while also providing the facility to merge that work back together, enabling developers to verify that the changes on each branch do not conflict. Many software teams adopt a practice of branching for each feature or perhaps branching for each release, or both. There are many different workflows that teams can choose from when they decide how to make use of branching and merging facilities in VCS.
* Traceability. Being able to trace each change made to the software and connect it to project management and bug tracking software such as Jira, and being able to annotate each change with a message describing the purpose and intent of the change can help with root cause analysis and other forensics. Having the annotated history of the code at your fingertips when you are reading the code, trying to understand what it is doing and why it is so designed can enable developers to make correct and harmonious changes that are in accord with the intended long-term design of the system.

There are many choices of VCS, but here we are going to focus on just one, Git.

## Installing Git:
Check if you have git already installed on your machine by running the command:
`$ git`

Install Git with Homebrew For OS X, you can follow these instructions to install Git:
`$ brew install git`

for Linux users:
`$ sudo apt-get install git`

## Create your own github account
If you don’t already have one, [create your own GitHub account](https://www.startpage.com/do/search?query=sign%20up%20to%20github)


## Forking a repo
To work on an existing code base you need to “fork” the repository. A [fork](https://help.github.com/articles/fork-a-repo/) is a copy of a repository. Forking a repository allows you to freely experiment with changes without affecting the original project.

We are going to work in the `training2018` repository, so let’s create a copy of it in our GitHub account, by forking it.

In your browser navigate to the original repository @  https://github.com/DSSG-EUROPE/training2018 and select the “Fork” button in the top right of the screen. Now you will have a “forked” copy of the repo under your username: https://github.com/<username>/training2018

## Clone the repo
Navigate to a directory on your computer where you would like to keep your work and clone the forked repository down to your local system using the command:
`$ git clone https://github.com/<username>/training.git`

Git will copy the repository onto your system, along with its  content and the commit history. The repository that was cloned (your fork) is known as the “origin”. To your computer, it is also known as a “remote” (because it is remote relative your own “local” machine). However, if you were only interested in making a fork of the project and not contributing back to the original project, you could stop here. but if you want to contribute …

## ...Add a remote of the original repository
Git already added a Git remote named `origin` to the clone of the Git repository on your system, and this will allow you to push changes back up to the forked repository in your GitHub account using git commit (to add commits locally) and git push.

If you want to eventually share your progress with other developers who working on the original repository, you will need to add a remote

`$ git remote add upstream https://github.com/DSSG-EUROPE/training.git`

Confirm the remote is there:

`$ git remote -v`

Now create a file called `hello_world.txt` and commit it:

`$ git add hello_world.txt`

`$ git commit -m “Comment describing the commit…”`

## Push your changes
Now, you could try pushing changes to the original repository using git push at this point, but it would probably fail because you probably donʼt have permission to push changes directly to the original repository. Besides, it really wouldnʼt be a good idea. Thatʼs because other people might be working on the project as well, and how in the world would we keep track of everyoneʼs changes?

`$ git push upstream master`

## Working in a branch
The purpose of a branch is to help facilitate multiple users making changes to a repository at the same time. So, assuming that your goal is to issue a pull request to have your changes merged (pull means that you ask the owner of the original repo to pull changes from your version) back into the original project, youʼll need to use a branch. Often youʼll see this referred to as a feature branch, because youʼll typically be implementing a new feature in the project.

The basic flow looks something like this (all this is happening on your local Git repository):

Create and checkout a feature branch.  
Make changes to the files.
Commit your changes to the branch.

Because of the way that Git works, itʼs incredibly fast and easy for developers to create multiple branches.

To create a new branch and check it out (meaning tell Git you will be making changes to the branch):
`$ git checkout -b new-feature`
you can always check on which branch you are with:
`$ git branch`
Switch between branches and work on each independently. Do not forget to commit your changes to the your fork.
`$ git checkout master`
`$ git checkout new-feature`  
As a general rule of thumb, you should limit a branch to one logical change. The definition of “one logical change” will vary from project to project and developer to developer, but the basic idea is that you should only make the necessary changes to implement one specific feature or enhancement. As you make changes to the files in the branch, youʼll want to commit those changes, building your changeset with ‘$ git add’, and committing the changes using ‘$ git commit’.

Create another file and commit to this new branch:
`$ git add feature_implementation.py`
`$ git commit -m “Description of the new feature”`

## Pushing Changes to GitHub
When you are ready to share your code with other developers, you can “push” your changes onto GitHub.

So letʼs say youʼve made the changes necessary to implement the specific feature or enhancement (the “one logical change”), and youʼve committed the changes to your local repository. The next step is to push those changes back up to GitHub. Edit the file `hello_world.txt` and commit your changes. If you were working in a branch called new-feature, then pushing the changes you made in that branch back to GitHub would look like this:  

`$ git push origin new-feature`

##  Opening a Pull Request
If you think your new code would make a good addition to the original project, you can ask the repo owners to “pull” your code into theirs.

GitHub makes this part incredibly easy. Once you push a new branch up to your repository, GitHub will prompt you to create a pull request (Iʼm assuming youʼre using your browser and not the GitHub native apps). The maintainers of the original project can use this pull request to pull your changes across to their repository and, if they approve of the changes, merge them into the main repository.

Ask someone on your team accept your pull request. This way you can make sure that somehow has read through your code and check that it makes sense and won’t cause any problems.

## Cleaning up After a Merged Pull Request
If the maintainers accept your changes and merge them into the main repository, then there is a little bit of clean-up for you to do. First, you should update your local clone by using:
`$ git pull upstream master`
`$ git push upstream master`
This pulls the changes from the original repositoryʼs (indicated by upstream) master branch (indicated by master in that command) to your local cloned repository. One of the commits in the commit history will be the commit that merged your feature branch, so after you `git pull`, your local repositoryʼs master branch will have your feature branchʼs changes committed. This means you can delete the feature branch (because the changes are already in the master branch).

## Resolve conflicts
If you encounter a merge conflict when you pull. Remember to first commit your changes , pull and then solve the conflicts. You can use vim or any editor, or even git mergetool to fix the conflicts. Then add the fixed file and commit

`$ git add filename.c`</br>
`$ git commit -m "using theirs"`

If you just want to force a merge either from theirs our ours :
`$ git checkout --ours filename.c`</br>
`$ git checkout --theirs filename.c`

If you want to merge branches then commit all your changes to the branch.

## Merge the branch
`$ git checkout master`
`$ git merge new-feature`

Delete the branch git branch</br>
`$ git branch -d new-feature`

Then you can update the master branch in your forked repository: </br>

`$ git push origin master`
 And push the deletion of the feature branch to your GitHub repository

git push --delete origin

`$ git push --delete origin new-feature`

And thatʼs it! Youʼve just successfully created a feature branch, made some changes, committed those changes to your repository, pushed them to GitHub, opened a pull request, had your changes merged by the maintainers, and then cleaned up.

## Keeping your fork synchronized
By the way, your forked repository doesnʼt automatically stay in sync with the original repository; you need to take care of this yourself. By the way, your forked repository doesnʼt automatically stay in sync with the original repository; you need to take care of this yourself. After all, in a healthy open source project, multiple contributors are forking the repository, cloning it, creating feature branches, committing changes, and submitting pull requests.
To keep your fork in sync with the original repository, use these commands:

`$ git pull upstream master`</br>
`$ git push origin master`

This pulls the changes from the original repository (the one pointed to by the upstream Git remote) and pushes them to your forked repository (the one pointed to by the origin remote).


## Optional
https://confluence.atlassian.com/bitbucketserver/permanently-authenticating-with-git-repositories-776639846.html
