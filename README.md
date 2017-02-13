#TaskGrabber

Welcome to TaskGrabber! This is a utility in Ruby to convert Asana tasks to GitHub issues. Functionality exists to import issues to any public or private GitHub repository, and issues will be marked as "open" or "closed" depending on their status at time of import.

###Running the Utility:

1. Make sure you have Git installed. If not, download from the following URL: https://git-scm.com/downloads
2. Navigate using the command line to the desired destination for the repository and enter the following:
   git clone git://github.com/tisenstadt/TaskGrabber.git 
3. Check to make sure that you have all authentication prerequisites, as listed below
4. Run the program by entering ruby launch.rb
5. To run the tests, enter ruby tests.rb

###Prerequisites:

1. Ruby 
2. Git
3. Asana Personal Access Token
4. GitHub Personal Access Token
5. GitHub username of destination repository
6. GitHub destination repository name

TaskGrabber makes use of a light token-based authentication system to connect to the Asana and GitHub APIs. You will need to get encrypted tokens to get the utility to run, as the application will prompt you to enter these tokens in the console window. Be sure to store your tokens in a safe place, as they cannot be retrieved again!

###To get your Asana token:

1. Log into Asana and navigate to your profile icon at the top right-hand corner of the screen.
2. Click the link to My Profile settings.
3. Click on the Apps tab.
4. Click on Manage Developer Apps
5. Click Create New Personal Access Token

###To get your GitHub token:

1. Log into GitHub and navigate to your profile icon at the top right-hand corner of the screen.
2. Click the link to Settings.
3. At the bottom of the navigation bar on the left-hand side of the screen, click the link to Personal access tokens.
4. Click Generate new token.

###Design Strategies:

This utility was designed to connect to the Asana and GitHub APIs. A series of GET requests to the Asana API allow the user to query for tasks. The JSON output for the tasks is parsed by a separate JSON class. Central to the design is the TaskProcessor class, which converts the JSON parsed tasks from the Asana pull into a format that is readable by the GitHub API. The GitHub class establishes a connection to GitHub and posts the task title, body, and label in a series of POST requests. After each request, the application checks to see whether the status of the task is open or closed, and a PATCH request is sent to the GitHub API to update accordingly.

###Features to Add:

The project currently assumes that the migration will complete without any interruption. There could be a scenario where the migration stops before it can complete: for instance, the utility may be shut down by accident after a portion of the data has already migrated. If the user runs the program again, all tasks will be migrated, meaning that duplicate tasks will arise in the destination repository. There are a number of ways to approach this problem. The naive approach is to add a tag with the Asana id to the body of each migrated task. We could then query GitHub for all tasks, and check each Asana task id against the task before it is posted. If a match occurs, the task will not be posted. The downside of this approach is that it is extremely resource-intensive and not ideal for large sets of data: we don't want to query GitHub more than we need to. I would love to discuss any feedback or thoughts on this issue!

The utility's querying capacity can be expanded. In addition to querying for tasks tied to a specific project, the Asana API can also query for tasks associated with a given assignee and workspace. A full interface for the user may be created at a later date that allows the user to select specific tasks and projects to migrate, as opposed to simply migrating all of them. 

Thank you for using TaskGrabber!  









