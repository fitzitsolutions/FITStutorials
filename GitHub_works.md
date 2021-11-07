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
