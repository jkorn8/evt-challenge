[![Deploy Website to AWS S3](https://github.com/jkorn8/evt-challenge/actions/workflows/main.yaml/badge.svg)](https://github.com/jkorn8/evt-challenge/actions/workflows/main.yaml)

# EVT Technology Challenge

This is my submission for the EVT Technology Challenge! I chose to deploy my website with AWS Cloudfront and AWS S3. The code for every piece of my application is stored here and managed either through Terraform or GitHub Actions. You can access my website [here!](https://d3mzzn9qw2asif.cloudfront.net/index.html)

### What did I make?
I am a huge Harry Potter fan, so I made a simple web application that displays a small database of spells! New spells can be added as well and if I continue to develop this project, I will also add functionality to edit and delete spells in the database.

### Tech Stack
I wanted to take things to the next step and deploy a full stack application! I built the backend using AWS Lambda, DynamoDB, and API Gateway, and tested my code locally with AWS SAM and docker. After testing my code, I deployed it using Terraform. 
For the frontend, I build a simple React app with Typescript. This web app is then compiled and uploaded to AWS S3 through GitHub Actions any time a push or pull request is made. 

### How long did this take?
I was working off and on on the project for half of Sunday, and half of Tuesday, so collectively I would say this took me about 5 hours.

### Why did I chose these technologies?
It is what I am familiar with! I have been working to build experience in AWS, Terraform, and React for the past 4 years and I wanted to show off what I could do in a short period of time.

### Further Questions
If further testing is needed, I can provide the link to my API in the cloud along with the API key which I stored in an .env file and did not upload to GitHub. Also if you have any other questions, feel free to reach out to me at josh.korngiebel@gmail.com.