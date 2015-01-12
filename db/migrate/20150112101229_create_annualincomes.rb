class CreateAnnualincomes < ActiveRecord::Migration
  def change
    create_table :annualincomes do |t|

      t.integer :company_id

      t.string :currency
      t.date :period

      t.decimal :cost_of_revenue_total
      t.decimal :selling_general_admin_expenses_total
      t.decimal :research_development
      t.decimal :depreciation_amortization
      t.decimal :interest_expense_income_net_operating
      t.decimal :unusual_expense_income
      t.decimal :other_operating_expenses_total
      t.decimal :interest_income_expense_net_non_operating
      t.decimal :gain_loss_on_sale_of_assets
      t.decimal :other_net
      t.decimal :net_income_before_extra_items
      t.decimal :extraordinary_item
      t.decimal :income_available_to_common_excl_extra_items
      t.decimal :income_available_to_common_incl_extra_items
      t.decimal :basic_eps_excluding_extraordinary_items
      t.decimal :basic_eps_including_extraordinary_items
      t.decimal :diluted_eps_excluding_extraordinary_items
      t.decimal :diluted_eps_including_extraordinary_items
      t.decimal :dividends_per_share_common_stock_primary_issue
      t.decimal :gross_dividends_common_stock
      t.decimal :net_income_after_stock_based_comp_expense
      t.decimal :basic_eps_after_stock_based_comp_expense
      t.decimal :diluted_eps_after_stock_based_comp_expense
      t.decimal :depreciation_supplemental
      t.decimal :income_taxes_ex_impact_of_special_items
      

      t.decimal :revenue
      t.decimal :other_revenue
      t.decimal :other_revenue_total
      t.decimal :total_revenue
      t.decimal :total_cost_of_revenue
      t.decimal :gross_profit
      t.decimal :general_expense
      t.decimal :randd  
      t.decimal :depreciation
      t.decimal :interest_expense
      t.decimal :unusual_expense
      t.decimal :other_operating_expense
      t.decimal :total_operating_expense
      t.decimal :operating_income 
      t.decimal :interest_income
      t.decimal :gain_on_sale_of_asset
      t.decimal :other_income
      t.decimal :income_before_tax
      t.decimal :income_after_tax
      t.decimal :minority_interest
      t.decimal :equity_in_affiliates
      t.decimal :net_income_before_extra_item
      t.decimal :accounting_change
      t.decimal :discontinued_operations
      t.decimal :extra_item
      t.decimal :net_income
      t.decimal :preferred_dividends
      t.decimal :income_available_to_common_excl_extra
      t.decimal :income_available_to_common_incl_extra
      t.decimal :basic_weighted_average_shares
      t.decimal :basic_eps_excl_extra_items
      t.decimal :basic_eps_incl_extra_items
      t.decimal :dilution_adjustment
      t.decimal :diluted_weighted_average_shares
      t.decimal :diluted_eps_exclextra_items
      t.decimal :diluted_eps_inclextra_items
      t.decimal :dividends_per_share
      t.decimal :gross_dividends
      t.decimal :net_income_after_stock_expense
      t.decimal :basic_eps_after_stock_expense
      t.decimal :diluted_eps_after_stock_expense
      t.decimal :supplement_depreciation
      t.decimal :total_special_items
      t.decimal :normalized_income_before_taxes
      t.decimal :effect_of_special_items_on_income_taxes
      t.decimal :income_taxes_impact_of_special_items
      t.decimal :normalized_income_after_taxes
      t.decimal :normalized_income_avail_to_common
      t.decimal :basic_normalized_eps
      t.decimal :diluted_normalized_eps

      t.timestamps
    end
  end
end
