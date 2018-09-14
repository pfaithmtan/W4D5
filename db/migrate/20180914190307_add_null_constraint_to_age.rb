class AddNullConstraintToAge < ActiveRecord::Migration[5.2]
  def change
    change_column_null :users, :age, false
  end
end
