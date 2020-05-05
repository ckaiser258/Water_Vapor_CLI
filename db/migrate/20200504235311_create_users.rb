class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table(:users) do |column|
      column.string(:name)
      column.datetime(:birthday)
      column.integer(:age)
    end
  end
end
