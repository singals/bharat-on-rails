# frozen_string_literal: true

# Please note that this is seed data for making development task easy, not intended to run this on PROD
# Another point to note is that the cost, mrp and other attributes holds mock data and may not be same as in real world

Article.create([{ name: 'Urea', package_quantity: '50 KG', availabe_units: 500, mrp: 278.5, cost: 242, is_active: true },
                         { name: 'DAP', package_quantity: '50 KG', availabe_units: 120, mrp: 800, cost: 720, is_active: true },
                         { name: 'Potash', package_quantity: '50 KG', availabe_units: 10, mrp: 320, cost: 305, is_active: true },
                         { name: 'Chloropyriphos', package_quantity: '1 Lt', availabe_units: 20, mrp: 200, cost: 110, is_active: true },
                         { name: '24D', package_quantity: '500 ml', availabe_units: 10, mrp: 180, cost: 160, is_active: true },
                         { name: 'Endosulfan', package_quantity: '1 lt', availabe_units: 0, mrp: nil, cost: nil, is_active: false }])

Debtor.create([{ name: 'Om Prakash', village: 'Navarsi', phone: '9876543210', is_active: true },
               { name: 'Ram Kumar', village: 'Bafdi', phone: '9875564321', is_active: true }])

sale_one = Sale.create!(nature: 'CASH', village: 'Indri', phone: '8976543201', total_amount: 2955)
sale_one.sale_items.create(article_id: 1, quantity: 5, price: 275, amount: 1375)
sale_one.sale_items.create(article_id: 2, quantity: 2, price: 790, amount: 1580)

sale_two = Sale.create(nature: 'CREDIT', debtor_id: 1, village: 'Navarsi', phone: '9876543210', total_amount: 1180)
sale_two.sale_items.create(article_id: 1, quantity: 2, price: 270, amount: 540)
sale_two.sale_items.create(article_id: 3, quantity: 2, price: 320, amount: 640)

Deposit.create([{ nature: 'From Debtor', amount: 500, debtor_id: 1 },
                { nature: 'From Debtor', amount: 100, debtor_id: 1 }])

ProfitAndLossAccount.create([{ description: 'Sold article 1', amount: 20, current_balance: 20, financial_year: '2017-2018' },
                                      { description: 'Sale-return article 1', amount: -20, current_balance: 0, financial_year: '2017-2018' }])
