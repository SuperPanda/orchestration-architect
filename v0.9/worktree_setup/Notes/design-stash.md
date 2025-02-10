### Inter-Repository Dynamics

```
--------------
󠂫«View»
---------------
.===================================================================.
|  «Context Label»                                  «CONTEXT TYPE»  |
|  ~~~~~~~~~~~~~~~~                                                 |
|  «Context Paramter Items»                                         |
|                                                                   |
|                                                                   |
|  							                                        |
|                                                                   |
| «Internal Blocks»                                                 |
| .--------.  g .-----------. f  .--------. x  .--------. .-------. |
| |	       |<---|     a     |--->|   a'   |--->|  a''   | |   b   | |
| '--------'    '-----------'    '--------'    '--------' '-------' |
| |__________________________[ structure ]__________________________| 
'==================================================================='                             									    |
                               
.===================================================================.
|  «Context Label»                                  «CONTEXT TYPE»  |
|  			   													    |
|  «Context Description»					                        |
|  «Context Parameter Items»                                        |
|  «Context Components»                                             |
|                             									    |
'==========================«Context Interface»======================'



			
    -------------------------------
	Generate and Display Work Trees
    -------------------------------

 	.=======================================================================. 
	|  User Workspace    										  WORKSPACE | 
    |  ~~~~~~~~~~~~~~~												        |
	|  A directory containing worktrees for the OA project					|
	|  						 						 				        | 
	|  Path: [ /home/$USER/repos/orchestration-architect ]                  | 
	|  						 						 				        | 		   		 				        | 
	|  	  ____worktrees_____       _____paths_____   				        | 
	|  	 |	    ...	        |     |     ...       |  				        | 
	|    |      ...         |  f  |     ...       |   				        | 
	|  	 |	    ...		    | <-> |     ...       |  	  			        | 
	|  	 |      ...         |     |     ...       |   				        |  
	|	 |  0.8.0-sandbox   |     |    sandbox    |    				        |
	|    \__________________/     \_______________/   				        |  
 	'===============================[A]=====================================' 
				   			 	     |
				                     |
									 | 
									 V 
 	.===============================[B]=================================.
	|                                                        REPOSITORY |
	| Repo(Local):    [ /home/$USER/repos/orchestration-architect.git`] |
	| 1. Worktrees tracks the Local Bare Repo							| 
	|                                                                   |
	`------------------------------[B']----------------------------------`
									 |
									 |
									 v
	.-------------------------------[c]----------------------------------.
	|                                                                    |
	|                                                                    |
	|                                                                    |
	`--------------------------------------------------------------------`

```
	# Master System
	- Upstream `ssh://git@scm.OA001-Master:/srv/git/orchestration-architect.git`
	- » System (file:///srv/git/orchestration-architect.git), System (Non-Authorative) -> Remote (GITHUB). Going to plan the way bare repos will work to clean up the remote refs. Make rust app to view 
	
  	**scm.OA001-Master:/srv/git/orchestration-architect**
 

