# bash ipblock.sh -a 1.1.1.2
 \* ADD 1.1.1.2
 
1/1 addresses added.

 \* SAVE


# bash ipblock.sh -l
 \* LIST
 
   1.1.1.1
   
   1.1.1.2
   
   2.2.2.2
   
   5.5.5.5


# bash ipblock.sh -d 2.2.2.2
 \* DELETE 2.2.2.2
 
1/1 addresses deleted.

 \* SAVE


# bash ipblock.sh -d 5.5.5.5
 \* DELETE 5.5.5.5
 
1/1 addresses deleted.

 \* SAVE


# bash ipblock.sh -f 1.1.1.1
 \* DELETE 1.1.1.1
 
1/1 addresses deleted.

 * SAVE


# bash ipblock.sh -a foo.ch
 \* ADD foo.ch
 
1/1 addresses added.

 \* SAVE


# bash ipblock.sh -a 169.0.0.0/24
 \* ADD 169.0.0.0/24
 
1/1 addresses added.

 \* SAVE


# bash ipblock.sh -l
 \* LIST
 
   1.1.1.2
   
   127.0.0.1
   
   169.0.0.0/24


# cat /etc/pf-blocked.conf
   1.1.1.2
   
   127.0.0.1
   
   169.0.0.0/24
