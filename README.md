Welcome to TaskGrabber! This is a utility in Ruby to convert Asana tasks to GitHub issues. Functionality exists to import issues to any public or private GitHub repository, and issues will be marked as "open" or "closed" depending on their status at time of import.

Running the Utility:

The utility was built in Ruby version 2.2.4. While an installaton of Ruby is required to get the utility to run, it relies on no external dependencies. The utility makes use of Ruby's built-in net/http and JSON libraries, in addition to its unit testing suite. After downloading the files in the repository to your local drive, navigate to the location in which the files have been downloaded and run "launch.rb" to start the application. Run "tests.rb" to access the test suite.

Prerequisites:

Ruby
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

After entering these tokens in the console, you will see all available Asana workspaces for your account. Please select a workspace by entering in its id number as prompted, then select a project that holds the tasks you wish to migrate by entering its id. Finally, you will be prompted to enter the GitHub destination username and repository name. The console will print out a confirmation message when the migration is complete, and you can visit your GitHub account to view migrated Issues!  

Design Strategies

This utility was designed to connect to the Asana and GitHub APIs. A series of GET requests to the Asana API allow the user to query for tasks associated with a specific project. The JSON response is parsed by a separate JSON class. Central to the design is the TaskProcessor class, which converts the JSON parsed tasks from the Asana pull into a format that is readable by the GitHub API. The GitHub class establishes a connection to GitHub and posts the task title and body in a series of POST requests. After each request, the application checks to see whether the status of the task is open or closed, and a PATCH request is sent to the GitHub API to update accordingly.

Features to Add

The utility's querying capacity can be expanded. In addition to querying for tasks tied to a specific project, the Asana API can also query for tasks associated with a given assignee and workspace. Additionally, authentication may be expanded into the more robust OAuth authentication system instead of the personal-access token approach used in the current utility.  

Thank you for using TaskGrabber!  









