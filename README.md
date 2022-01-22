### CI [![CircleCI](https://circleci.com/gh/singals/bharat.svg?style=svg)](https://circleci.com/gh/singals/bharat)

### Summary
<b>Bharat</b> is a RoR based app, intended to help people running small scale businesses by managing almost everything 
(s)he is concerned with; like the Sales, Purchase, Stock and Accounts. 

### Prerequisites
This projects uses the following:

* Ruby (version 3.0.3)

* Rails (version 7.0.1)

* Postgres (version 10)

* Docker (version 17.06.2-ce-mac27 (19124))

* Docker Compose (version 1.14.0)

### Running the application using docker
* Install Docker

* How to run the app using docker

    From the root directory of the project, execute
    > docker-compose build
    
    > docker-compose up &

    Now the application shall be accessible at port 3000 (unless changed) 

### Running the application natively
* Ensure postgres is running
* `bin/setup`
* `bin/rails s`

### TODO (functionalities)
Moved to [Trello](https://trello.com/b/4TpMkaB4/bharat-story-board)