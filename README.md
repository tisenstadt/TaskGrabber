Welcome to TaskGrabber! This is a utility in Ruby to convert Asana tasks to GitHub issues. Functionality exists to import issues to any public or private GitHub repository, and issues will be marked as "open" or "closed" depending on their status at time of import.

Running the Utility:

1. First, ensure that you have Git installed on your local drive. If not, please download Git from the following URL: https://git-scm.com/downloads
2. We'll clone the repository locally. Navigate using the command line to the desired destination for the repository and enter the following:
   git clone git://github.com/tisenstadt/TaskGrabber.git
3. Now you have TaskGrabber on your local drive! 
4. Please check the prerequisites below to get information on tokens you will need for authentication. You must have these tokens and a destination for the data migration or the migration will not be successful.
5. Once you have the necessary tokens, run the program by entering ruby launch.rb
6. To run the tests, enter ruby tests.rb

Prerequisites:

Ruby (uses built-in net/http, JSON, and unit test libraries - no external dependencies)
Asana Personal Access Token
GitHub Personal Access Token
GitHub username of destination repository
GitHub destination repository name

TaskGrabber makes use of a light token-based authentication system to connect to the Asana and GitHub APIs. You will need to get encrypted tokens to get the utility to run, as the application will prompt you to enter these tokens in the console window. Be sure to store your tokens in a safe place, as they cannot be retrieved again!

To get your Asana token:

1. Log into Asana and navigate to your profile icon at the top right-hand corner of the screen.
2. Click the link to My Profile settings.
3. Click on the Apps tab.
4. Click on Manage Developer Apps
5. Click Create New Personal Access Token

To get your GitHub token:

1. Log into GitHub and navigate to your profile icon at the top right-hand corner of the screen.
2. Click the link to Settings.
3. At the bottom of the navigation bar on the left-hand side of the screen, click the link to Personal access tokens.
4. Click Generate new token.

Design Strategies

This utility was designed to connect to the Asana and GitHub APIs. A series of GET requests to the Asana API allow the user to query for tasks. The JSON output for the tasks is parsed by a separate JSON class. Central to the design is the TaskProcessor class, which converts the JSON parsed tasks from the Asana pull into a format that is readable by the GitHub API. The GitHub class establishes a connection to GitHub and posts the task title, body, and label in a series of POST requests. After each request, the application checks to see whether the status of the task is open or closed, and a PATCH request is sent to the GitHub API to update accordingly.

Features to Add

The utility's querying capacity can be expanded. In addition to querying for tasks tied to a specific project, the Asana API can also query for tasks associated with a given assignee and workspace. Additionally, authentication may be expanded into the more robust OAuth authentication system instead of the personal-access token approach used in the current utility.  

Thank you for using TaskGrabber!  









