# bunq devops homework

ASSUMPTIONS
===========

- Each loadbalance server has already been deployed to in the past, SSH keys, etc are already in place. 

- Assume that the paths all exist and that the servers are functionally identical. 

- Building to be able to push rollback version manually.  
ansible-playbook update.yml --extra-vars "pullversion=1.2.4"


PLAN
====

1. remove a node from load balance in haproxy
2. stop nginx on the node
3. deploy application
4. start nginx on the node


IMPROVEMENTS
============

Improvements could add roles and tasks to 

- Install new load balanced nodes outside of code update push; 
- push ssh authorized keys out to nodes, deploy nginx in a clean state, build local paths, etc. 
- Stop monitoring systems to avoid series of alerts


QUESTIONS
=========

> a) How would your system cope with failed upgrades and rollbacks?

If an nginx server doesn't load on a node, it should stay offline from the haproxy round robin and the upgrade of the remaining nodes should stop, in the event there's a larger problem. Rollback should be to a local backup in the event the git clone is part of the problem. This would assume that the nodes were all up and running pre-update code without problems.

> b) What is the impact of node update time on the upgrade procedure?

With 50 nodes, the updates could likely be done in parallel groups of 5-10 nodes at a time to speed up the deployment. Serial deployment to fifty nodes would take a non-trivial amount of time to complete - hours with even 2-3 minutes per node.

> c) What are the implications of introducing breaking changes to the project deployed via your solution?

It's going to depend on where and how the break happens. If the break prevents the startup of the app server, then we should rollback immediately. If the change is runtime, functional, etc, but doesn't prevent compilation and startup, that should be seen by post implementation verification steps

> d) What happens when multiple projects, which depend on each other, need to be updated simultaneously and how does this affect the proposed solution?

With multiple projects, I'd likely break out roles to encompass all the project pulls from git (or package installation via yumm, etc, depending on where the code lives. 

As the node's down, bringing all the projects down, loading the app server should be fine while out of the load balance. 

> e) What is a possible issue from the proposed solution? Anything we should be aware of?

This solution uses one host group, and deploys to all the nodes. It may be a good idea to stage the deployment to a restricted host group on the production network that could have PIV run to ensure there are no breaking changes, before pushing to the remaining nodes. 

Now, if this were a major version increment in the project, with database and large structural changes that might make sessions an issue with a load balancer that has nodes at different release version, I might consider a more drastic approach.

Perhaps splitting the application servers into multiple pools in haproxy - one for the old version and one for the new version. I might turn the weight up for the new version nodes, set server affinity, and then after a substantial number of the nodes have been updated successfully, flip the new pool on. If it's possible to spin up temporary nodes to help with potential load, that might be helpful as well. 

> f) Write a small tool which allows you to block users on the fly using the pf firewall in Freebsd. Note that blocks should be persistent.

This is illustrated in the 'pf' directory. It uses a file table, and explicitly syncs the in-memory table to the conf file on any change. 

