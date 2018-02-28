# README

###Summary
<b>Bharat</b> is a RoR based app, intended to help people running small scale businesses by managing almost everything 
(s)he is concerned with; like the Sales, Purchase, Stock and Accounts. 

###Prerequisites
This projects uses the following:

* Ruby (version 2.5.0)

* Rails (version 5.1.2)

* Postgres (version 10)

###Running the application
* Bundle install all gems

    In the project root directory, execute:
    > bundle install


* Database

    Expects a postgres connection, see database.yml for configuration. 

* Database initialization

    After setting up the DB, in the project root directory, execute:

    > rails db:migrate

* How to run the test suite

    After setting up the DB, in the project root directory, execute:

    > rails test

* How to run the app

    From the root directory of the project, execute
    > rails s

    Now the application shall be accessible at port 3000 (unless changed) 


# TODO
1. Implement Profit and Loss Account.
2. Allow sale/purchase item to be created on sale/purchase creation.
3. Add UI tests using Capybara or something else.
4. Improve test coverage
5. Build CI pipeline
6. Use JQuery-UI to make the UI look better