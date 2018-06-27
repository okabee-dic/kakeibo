class AddColumnInputdayToMonthlyinputs < ActiveRecord::Migration[5.1]
  def change
    add_column :monthlyinputs, :inputday, :integer
  end
end
