# frozen_string_literal: true

json.array! @debtors, partial: 'debtors/debtor', as: :debtor
