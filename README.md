### Summary
<b>Bharat</b> is a RoR based app, intended to help people running small scale businesses by managing almost everything 
(s)he is concerned with; like the Sales, Purchase, Stock and Accounts. 

### Prerequisites
This projects uses the following:

* Ruby (version 3.0.3)

* Rails (version 7.0.1)

* Postgres (version 13)

* Docker (version 20.10.6 (370c289))

* Docker Compose (version 1.29.1)

### Running the application using docker
* Install Docker

* How to run the app using docker

    From the root directory of the project, execute
    > docker-compose build
    
    > docker-compose up &

    Now the application shall be accessible at port 3000 (unless changed) 

### Running the application natively
* Ensure postgres is running
* add `127.0.0.1       db` to `/etc/hosts`
* `bin/setup`
* `bin/rails s`

### TODO (functionalities)
Moved to [Trello](https://trello.com/b/4TpMkaB4/bharat-story-board)