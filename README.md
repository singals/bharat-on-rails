### Circle CI [![CircleCI](https://circleci.com/gh/singals/bharat.svg?style=svg)](https://circleci.com/gh/singals/bharat)

### Summary
<b>Bharat</b> is a RoR based app, intended to help people running small scale businesses by managing almost everything 
(s)he is concerned with; like the Sales, Purchase, Stock and Accounts. 

### Prerequisites
This projects uses the following:

* Ruby (version 2.5.0)

* Rails (version 5.1.2)

* Postgres (version 10)

### Running the application
* Bundle install all gems

    In the project root directory, execute:
    > bundle install


* Database

    Expects a postgres connection, see database.yml for configuration. 

* Database initialization

    After setting up the DB, in the project root directory, execute:

    > rails db:migrate
    
* (Optional) Seeding the database

    seeds.rb contains of seed data for a Fertilizers & Pesticide ship. Please feel free to update the list for yourself 
    and execute the following command to insert into DB:
    > rails db:setup
    
    ```Please note that this is not intended to be executed on PROD as-is```

* How to run the test suite

    After setting up the DB, in the project root directory, execute:

    > rails test

* How to run the app

    From the root directory of the project, execute
    > rails s

    Now the application shall be accessible at port 3000 (unless changed) 


### TODO (functionalities)
1. Allow sale/purchase item to be created on sale/purchase creation.
2. Implement Profit and Loss Account.
3. Add UI tests using Capybara or something else.
4. Improve test coverage
5. Use JQuery-UI to make the UI look better
6. Add name to Sale model
7. Default village, phone and name for Credit sale on debtor selection.
8. Add nature of transaction (Cash/Credit) for Purchase and maintain account
9. Implement Accounts functionality for debtors and creditors.
