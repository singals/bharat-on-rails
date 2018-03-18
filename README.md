### Summary
<b>Bharat</b> is a RoR based app, intended to help people running small scale businesses by managing almost everything 
(s)he is concerned with; like the Sales, Purchase, Stock and Accounts. 

### Prerequisites
This projects uses the following:

* Ruby (version 2.5.0)

* Rails (version 5.1.2)

* Postgres (version 10)

* Docker (version 17.06.2-ce-mac27 (19124))

* Docker Compose (version 1.14.0)

### Running the application
* Install Docker

* How to run the app

    From the root directory of the project, execute
    > docker-compose build
    
    > docker-compose up &

    Now the application shall be accessible at port 3000 (unless changed) 


### TODO (functionalities)
1. Implement Profit and Loss Account.
2. Add UI tests using Capybara or something else.
3. Improve test coverage, add End-End tests
4. Use JQuery-UI to make the UI look better
5. Add name to Sale model
6. Default village, phone and name for Credit sale on debtor selection.
7. Add nature of transaction (Cash/Credit) for Purchase and maintain account
8. Implement Accounts functionality for debtors and creditors.
9. Option to print bill
10. Authentication + Authorization
11. Localisation
12. Payment support for Credit & Debit Cards, UPI
