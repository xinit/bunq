# bunq devops homework


- Each loadbalance server has already been deployed to in the past, SSH authentication, etc, is already in place. Could add actions to push the authorized keys out
- Assume that the paths all exist and that the servers are functionally identical.

- git version 
ansible-playbook update.yml --extra-vars "pullversion=1.2.4"

stop monitoring
remove from load balance
stop nginx
deploy application

2 a) If an nginx server doesn't load on a node, it should stay offline from the haproxy round robin and the upgrade of the remaining nodes should stop, in the event there's a larger problem. Rollback should be to a local backup in the event the git clone is part of the problem. This would assume that the nodes were all up and running pre-update code without problems.
b) With 50 nodes, the updates could likely be done in parallel groups of 5-10 nodes at a time to speed up the deployment. Serial deployment would take a non-trivial amount of time to complete
c) It's going to depend on where and how the break happens. If the break prevents the startup of the app server, then we should rollback immediately. If the change is runtime, functional, etc, but doesn't prevent compilation and startup, that should be seen by post implementation verification steps
d) If the projects are installed on the same 
e) This solution uses one host group, and deploys to all the nodes. It may be a good idea to stage the deployment to a restricted host group on the production network  that could have PIV run to ensure there are no breaking changes, before pushing to the remaining nodes.

