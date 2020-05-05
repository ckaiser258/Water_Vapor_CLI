class CreateConsoles < ActiveRecord::Migration[5.2]
  def change
    create_table(:consoles) do |column|
      column.string(:name)
      column.integer(:user_id)
    end
  end
end
