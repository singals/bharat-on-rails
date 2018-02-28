# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

articles = Article.create([{name: 'Urea', package_quantity: '50 KG', availabe_units: 500, mrp: 278.5, cost: 242, is_active: true},
                           {name: 'DAP', package_quantity: '50 KG', availabe_units: 120, mrp: 278.5, cost: 242, is_active: true},
                           {name: 'Potash', package_quantity: '50 KG', availabe_units: 10, mrp: 278.5, cost: 242, is_active: true},
                           {name: 'Chloropyriphos', package_quantity: '1 Lt', availabe_units: 20, mrp: 278.5, cost: 242, is_active: true},
                           {name: '24D', package_quantity: '500 ml', availabe_units: 10, mrp: 278.5, cost: 242, is_active: true},
                           {name: 'Endosulfan', package_quantity: '1 lt', availabe_units: 0, mrp: nil, cost: nil, is_active: false}])

debtors = Debtor.create([{name: 'Om Prakash', village: 'Navarsi', phone: '9876543210', is_active: true},
                         {name: 'Ram Kumar', village: 'Bafdi', phone: '9875564321', is_active: true}])