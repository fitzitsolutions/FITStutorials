# BLUF (bottom line up front):

## Set your local machine with globals
<pre>
git config --global user.email "email@address.com"
git config --global user.name "username"
</pre>

## Download your repo project
### make sure you use the git protocol
<pre>
git clone git clone git@github.com:"username"/"repo"
git status
git log
git commit -a -m "message"
</pre

## Send updates to GitHub
<pre>
git status
git push
</pre>

# HOW GIT WORKS WITH UBUNTU

## Directions from the GitHub site (new repository)

### …or create a new repository on the command line
<pre>
echo "# FITStutorials" >> README.md
git init
git add README.md
OR
git add . (for entire directory)
git commit -m "first commit"
git branch -M main
git remote add origin https://github.com/fitzitsolutions/FITStutorials.git
git push -u origin main
</pre>

### …or push an existing repository from the command line
<pre>
git remote add origin https://github.com/fitzitsolutions/FITStutorials.git
git branch -M main
git push -u origin main
</pre>

## Directions from YouTube

### https://www.youtube.com/watch?v=_kAV059yZ_s

### Install Git

<pre>
$ sudo apt get install git
</pre>

### Pushing to Git
<pre>
$ git init
$ git status
$ git add .
$ git config --global user.name "username"
$ git config --global user.email "user email"
$ git commit -m "commit message"
$ git remote add origin "github repository website link"
$ git push -u origin master
</pre>

# GUI for git

SourceTree
GitKraken

# commands

<pre>
create repo
git status
git clone
git status
git log
git add
git commit -a -m "commit message"
git push

git fetch
git pull
# use merge when it throws errors
</pre>
