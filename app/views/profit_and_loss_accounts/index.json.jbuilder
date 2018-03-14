# frozen_string_literal: true

json.array! @profit_and_loss_accounts, partial: 'profit_and_loss_accounts/profit_and_loss_account', as: :profit_and_loss_account
