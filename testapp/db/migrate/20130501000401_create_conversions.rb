class CreateConversions < ActiveRecord::Migration
  def change
    create_table :conversions do |t|
      t.float :revenue
    end
  end
end
