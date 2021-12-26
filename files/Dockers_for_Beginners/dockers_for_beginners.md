# DOCKER

## WHAT IS DOCKER?
Why explain things here?  These are a couple links if you need to know more:
<br>
[GitHub Get-starte Page](https://docs.docker.com/get-started/) - the basics
<br>
[CTF creation article](https://cryptokait.com/2020/08/17/containerizing-your-ctf-stack-using-docker-for-ctfs-and-ncl/) - more of the basics explained
<br>
More links will be given throughout this learning experience...
<hr>

## QUICK COMMANDS

After creating a dockerfile, you can build it using this:
```
sudo docker build . -t name-of-build
```
After the build, you can run it using this (ports explained in the links above):
```
sudo docker run -p 8000:80 -d name-of-build:latest
```

<hr>

<br>

## BUILDING A DOCKERFILE
this is an exerpt from the article above for quick reference:
<br><br>

```
FROM kalilinux/kali-rolling  
 
RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y nmap john dirb
 
VOLUME /wordlists
VOLUME /ctf
```

<br>
I created a basic ubuntu container to test this process...
<br><br>

```
FROM ubuntu/latest

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y net-tools nmap vim

VOLUME /wordlists
VOLUME /ctf

CMD ifconfig
```

<br>
Of course... I got an error when I built it because of the syntax... 
<br>

```
@ubuntu:~/Docker/ctfpractice$ sudo docker build . -t ubuntuctfpractice
Sending build context to Docker daemon  2.048kB
Step 1/6 : FROM ubuntu/latest
pull access denied for ubuntu/latest, repository does not exist or may require 'docker login': denied: requested access to the resource is denied
```

The first line requires a colon and not a forward slash
<br>

```
FROM ubuntu:latest
```

<br>

And now it worked...

```
@ubuntu:~/Docker/ctfpractice$ sudo docker build . -t ubuntuctfpractice
Sending build context to Docker daemon  2.048kB
Step 1/6 : FROM ubuntu:latest
 ---> ba6acccedd29
Step 2/6 : RUN apt-get update && apt-get upgrade -y
 ---> Running in 3a3451583f9b
```

<br>
However, it didn't do what I thought it was going to do with the ifconfig command
<br>

```
Step 6/6 : CMD ifconfig
 ---> Running in bfb3ff4681dd
```

<br><br>
no output... I won't see the results of this command until I run the container...
<br><br>

```
@ubuntu:~/Docker/ctfpractice$ sudo docker run ubuntuctfpractice
eth0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 172.17.0.2  netmask 255.255.0.0  broadcast 172.17.255.255
        ether 02:42:ac:11:00:02  txqueuelen 0  (Ethernet)
        RX packets 2  bytes 220 (220.0 B)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 0  bytes 0 (0.0 B)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

lo: flags=73<UP,LOOPBACK,RUNNING>  mtu 65536
        inet 127.0.0.1  netmask 255.0.0.0
        loop  txqueuelen 1000  (Local Loopback)
        RX packets 0  bytes 0 (0.0 B)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 0  bytes 0 (0.0 B)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
```

<br>
<br>
And the docker exits after running that command... if I do a docker ps command, it's gone

```
@ubuntu:~/Docker/ctfpractice$ sudo docker ps
CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES
```

<br><br>
this is simply becaue if there is no process running in the container, it will exit
<br>
this can be solved (if actually needed) by adding a sleep command to the container
<br>
when I build out the challenge, there will be processes running, so I won't have to worry about that
<br>
but for now, I'll use it to learn a bit more about the basic commands...
<br><br>

```
@ubuntu:~/Docker/ctfpractice$ sudo docker run -d ubuntuctfpractice sleep infinity
5092ed449b837939dfffc7509c1dfeb2935a1467464d7f37a28cb60a9ed9f256

ubuntu:~/Docker/ctfpractice$ sudo docker ps
CONTAINER ID   IMAGE               COMMAND            CREATED         STATUS         PORTS     NAMES
5092ed449b83   ubuntuctfpractice   "sleep infinity"   3 seconds ago   Up 2 seconds             ecstatic_mclean
```

<br><br>
Lastly... you can give it your own name instead of getting a random one (shown under NAME)
<br>
simply add the name tag to the run command... this will help you organize
<br><br>

```
@ubuntu:~/Docker/ctfpractice$ sudo docker run --name=ubuntuctfpractice -d ubuntuctfpractice sleep infinity
bbb364cb8169e67f7d3d645106e37317a7068bc74bde214fa54c53883c9547c7

@ubuntu:~/Docker/ctfpractice$ sudo docker ps
CONTAINER ID   IMAGE               COMMAND            CREATED         STATUS         PORTS     NAMES
bbb364cb8169   ubuntuctfpractice   "sleep infinity"   5 seconds ago   Up 4 seconds             ubuntuctfpractice
```

<br>
and now you can reference the NAME (ubuntuctfpractice) to manage the container
<br><br>
Much of this can be found here:
<br><br>

[Docker Docs](https://docs.docker.com/engine/reference/run/) - reference for run command

<hr>

## FILE MANAGEMENT WITHIN CONTAINERS
<br>
Now that we have everything set, it's time to start placing files in the container
<br>
the container above had a /wordlist and /ctf folder added.  They can be seen through an interactive terminal
<br>

```
@ubuntu:~/Docker/ctfpractice$ sudo docker exec -it ubuntuctfpractice /bin/bash
root@bbb364cb8169:/# ls
bin  boot  ctf  dev  etc  home  lib  lib32  lib64  libx32  media  mnt  opt  proc  root  run  sbin  srv  sys  tmp  usr  var  wordlists
root@bbb364cb8169:/# ls wordlists/
root@bbb364cb8169:/# ls ctf/
```

<br><br>
Now I'm going to change those volumes to be in the temp folder and put files in there...
<br><br>

From the dockerfile
```
VOLUME /tmp/wordlists
VOLUME /tmp/ctf
```

<br><br>
I added a couple of text files into the new directories on my host machine that I will be mounting (-v command below)

```
@ubuntu:/tmp$ mkdir ctfpractice
@ubuntu:/tmp$ cd ctfpractice/
@ubuntu:/tmp/ctfpractice$ pwd
/tmp/ctfpractice
@ubuntu:/tmp/ctfpractice$ mkdir wordlist
@ubuntu:/tmp/ctfpractice$ mkdir ctf
@ubuntu:/tmp/ctfpractice$ touch wordlist/testwordlist.txt
@ubuntu:/tmp/ctfpractice$ touch ctf/testctf.txt
```

<br><br>

The build was REALY fast...

```
ubuntu:~/Docker/ctfpractice$ sudo docker build . -t ctfpractice
[sudo] password for fitsadmin: 
Sending build context to Docker daemon  4.096kB
Step 1/6 : FROM ubuntu:latest
 ---> ba6acccedd29
Step 2/6 : RUN apt-get update && apt-get upgrade -y
 ---> Using cache
 ---> 8eb57112853f
Step 3/6 : RUN apt-get install -y net-tools nmap vim
 ---> Using cache
 ---> 0ee44e9645ba
Step 4/6 : VOLUME /tmp/wordlists
 ---> Running in 7c9b23c5137b
Removing intermediate container 7c9b23c5137b
 ---> abcd7f9771f0
Step 5/6 : VOLUME /tmp/ctf
 ---> Running in 492035e71fb2
Removing intermediate container 492035e71fb2
 ---> ff601f59a595
Step 6/6 : CMD ifconfig
 ---> Running in 3791920cb1ca
Removing intermediate container 3791920cb1ca
 ---> 944741c9f63c
Successfully built 944741c9f63c
Successfully tagged ctfpractice:latest
```

```
@ubuntu:~/Docker/ctfpractice$ sudo docker run -d --name=ctfpractice -v /tmp/ctfpractice/wordlist:/tmp/wordlist:rw -v /tmp/ctfpractice/ctf:/tmp/ctf:rw ctfpractice sleep infinity
```

<br><br>
... and discovered by accident through a syntax error... I don't need the volumes in the docker file
<br>
reference that there are three directories in /tmp, and one is plural by accident
<br><br>

```
@ubuntu:~/Docker/ctfpractice$ sudo docker run -d --name=ctfpractice -v /tmp/ctfpractice/wordlist:/tmp/wordlist:rw -v /tmp/ctfpractice/ctf:/tmp/ctf:rw ctfpractice sleep infinity
020d03be8359411de04a5f76d8bd1e87a4d09db79f279f8ca86492804c80283a
@ubuntu:~/Docker/ctfpractice$ sudo docker ps
CONTAINER ID   IMAGE         COMMAND            CREATED         STATUS         PORTS     NAMES
020d03be8359   ctfpractice   "sleep infinity"   7 seconds ago   Up 6 seconds             ctfpractice
@ubuntu:~/Docker/ctfpractice$ sudo docker exec -it ctfpractice /bin/bash
root@020d03be8359:/# ls
bin  boot  dev  etc  home  lib  lib32  lib64  libx32  media  mnt  opt  proc  root  run  sbin  srv  sys  tmp  usr  var
root@020d03be8359:/# cd tmp/
root@020d03be8359:/tmp# ls
ctf  wordlist  wordlists
root@020d03be8359:/tmp# ls wordlist
testwordlist.txt
root@020d03be8359:/tmp# ls ctf/
testctf.txt
root@020d03be8359:/tmp#
```

<br><br>
and now it can be seen that I can write to that directory (because of the :rw) on the host

```
root@020d03be8359:/tmp/ctf# ls
testctf.txt
root@020d03be8359:/tmp/ctf# touch withinthecontainer.txt
root@020d03be8359:/tmp/ctf# ls
testctf.txt  withinthecontainer.txt

@ubuntu:/tmp/ctfpractice/ctf$ ls
testctf.txt  withinthecontainer.txt
```

<br><br>
Now that I have the basics figured out... I can move to using docker-compose to orchestrate all of this...
<br><br>

[Docker Docs](https://docs.docker.com/storage/volumes/) - Reference for volumes

<hr>

## EXTRA LEARNING FOR DOCKER WORKINGS
### NOTE:  container stopped but can't be run again with the same command
<br><br>

```
@ubuntu:~/Docker/ctfpractice$ sudo docker run -d --name=ctfpractice -v /tmp/ctfpractice/wordlist:/tmp/wordlist:rw -v /tmp/ctfpractice/ctf:/tmp/ctf:rw ctfpractice sleep infinity
docker: Error response from daemon: Conflict. The container name "/ctfpractice" is already in use by container "020d03be8359411de04a5f76d8bd1e87a4d09db79f279f8ca86492804c80283a". You have to remove (or rename) that container to be able to reuse that name.
See 'docker run --help'.
```

<br><br>
Always fun to figure things out by mistake... 
<br>
since the container was built and run, all I have to do now is start it again
<br>
as you can see, I just tried the commands without the flags, then figured out to simply start it.
<br><br>

```
@ubuntu:~/Docker/ctfpractice$ sudo docker ps -a
CONTAINER ID   IMAGE               COMMAND                  CREATED             STATUS                           PORTS     NAMES
020d03be8359   ctfpractice         "sleep infinity"         25 minutes ago      Exited (137) 6 minutes ago                 ctfpractice
bbb364cb8169   ubuntuctfpractice   "sleep infinity"         About an hour ago   Exited (137) 35 minutes ago                ubuntuctfpractice
5092ed449b83   ubuntuctfpractice   "sleep infinity"         About an hour ago   Exited (137) About an hour ago             ecstatic_mclean
647cb8e9e48a   ubuntuctfpractice   "/bin/sh -c ifconfig"    About an hour ago   Exited (0) About an hour ago               eager_sanderson
5e42db3c2d35   ubuntuctfpractice   "/bin/sh -c ifconfig"    About an hour ago   Exited (0) About an hour ago               admiring_easley
accdbe9028ea   ubuntuctfpractice   "/bin/sh -c ifconfig"    2 hours ago         Exited (0) 2 hours ago                     confident_thompson
bd5d9ad1bfbd   ubuntudocker        "/bin/sh -c '/usr/sb…"   20 hours ago        Exited (137) 20 hours ago                  hopeful_moser
4d32a663871e   wordpress           "docker-entrypoint.s…"   20 hours ago        Created                                    some-wordpress
cfc2f0b85293   webexample          "/bin/sh -c '/usr/sb…"   27 hours ago        Exited (137) 21 hours ago                  clever_driscoll

@ubuntu:~/Docker/ctfpractice$ sudo docker start -d --name=ctfpractice -v /tmp/ctfpractice/wordlist:/tmp/wordlist:rw -v /tmp/ctfpractice/ctf:/tmp/ctf:rw ctfpractice sleep infinity
unknown shorthand flag: 'd' in -d
See 'docker start --help'.

@ubuntu:~/Docker/ctfpractice$ sudo docker ps
CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES

@ubuntu:~/Docker/ctfpractice$ sudo docker start --name=ctfpractice -v /tmp/ctfpractice/wordlist:/tmp/wordlist:rw -v /tmp/ctfpractice/ctf:/tmp/ctf:rw ctfpractice sleep infinity
unknown flag: --name
See 'docker start --help'.

@ubuntu:~/Docker/ctfpractice$ sudo docker start ctfpractice
ctfpractice

@ubuntu:~/Docker/ctfpractice$ sudo docker ps
CONTAINER ID   IMAGE         COMMAND            CREATED          STATUS         PORTS     NAMES
020d03be8359   ctfpractice   "sleep infinity"   26 minutes ago   Up 4 seconds             ctfpractice
```

<hr>

## DO THINGS WITH THE CONTAINER...
It's time to build out a simple web server.  I'm going to use apache2 on ubunu
<br><br>



<hr>

## THE YML (OR YAML) FILE
You can orchestrate multiple docker containers using a .yml file
<br>