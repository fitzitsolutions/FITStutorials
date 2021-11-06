# HOW GIT WORKS WITH UBUNTU

## …or create a new repository on the command line
<pre>
echo "# FITStutorials" >> README.md
git init
git add README.md
git commit -m "first commit"
git branch -M main
git remote add origin https://github.com/fitzitsolutions/FITStutorials.git
git push -u origin main
</pre>

## …or push an existing repository from the command line
<pre>
git remote add origin https://github.com/fitzitsolutions/FITStutorials.git
git branch -M main
git push -u origin main
</pre>
