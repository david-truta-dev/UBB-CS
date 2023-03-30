
===============
Adding images to docker
===============

        _.---.__
      .'        `-.
     /      .--.   |
     \/  / /    |_/
      `\/|/    _(_)
   ___  /|_.--'    `.   .
   \  `--' .---.     \ /|
    )   `       \     //|
    | __    __   |   '/||
    |/  \  /  \      / ||
    ||  |  |   \     \  |
    \|  |  |   /        |
   __\\@/  |@ | ___ \--'
  (     /' `--'  __)|
 __>   (  .  .--' &"\
/   `--|_/--'     &  |
|                 #. |
|                 q# |
 \              ,ad#'
  `.________.ad####'
    `#####""""""''
     `&#"
      &# "&
      "#ba"

===========
The docker images that we'll use
===========
- Usually you would run a docker-compose up command and images would be build on your local machine.
BUUUUUTTT. Due to time considerents and slow internet connection, we provide 3 pre-built docker containers that 
you just need to load intro your docker client:

-bitnami-mariadb.tar
-bitnami-testlink.tar
-vvss-jenkins.tar

===========
Loading the docker images
===========
Make sure you are in the correct directory in your terminal:
./step2/


docker load -i bitnami-mariadb.tar
docker load -i bitnami-testlink.tar
docker load -i vvss-jenkins.tar


===========
Verify the images have loaded
===========

* SPOOF *
* You can pass to step3 *
