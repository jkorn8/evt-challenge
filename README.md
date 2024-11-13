[![Deploy Website to AWS S3](https://github.com/jkorn8/evt-challenge/actions/workflows/main.yaml/badge.svg)](https://github.com/jkorn8/evt-challenge/actions/workflows/main.yaml)

# EVT Technology Challenge

This is my submission for the EVT Technology Challenge! I chose to deploy my website with AWS Cloudfront and AWS S3. The code for every piece of my application is stored here and managed either through Terraform or GitHub Actions. You can access my website [here!](https://d3mzzn9qw2asif.cloudfront.net/index.html)

### What did I make?
I am a huge Harry Potter fan, so I made a simple web application that provides the ability to create, and list table rows within a database. I used Harry Potter Spells to have some fun with a use-case, but this generic structure could be used for any use-case. If I continued to develop this project, I would next add functionality to update and delete spells to have full CRUD operations.

### Tech Stack
I wanted to take things to the next step and deploy a full stack application! I built the backend using AWS Lambda, DynamoDB, and API Gateway, and tested my code locally with AWS SAM and docker. After testing my code, I deployed it using Terraform. 
For the frontend, I build a simple React app with Typescript. This web app is then compiled and uploaded to AWS S3 through GitHub Actions any time a push or pull request is made. 

### How long did this take?
I was working off and on on the project for half of Sunday, and half of Tuesday, so collectively I would say this took me about 5 hours.

### Why did I chose these technologies?
It is what I am familiar with as I have been working in AWS, Terraform, and React for the past 4 years in some of my classes, internships, and side-projects.

### Further Questions
If you have any questions or follow-up items, feel free to reach out at josh.korngiebel@gmail.com(mailto:josh.korngiebel@gmail.com).
