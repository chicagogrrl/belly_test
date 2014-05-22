class CreateCheckIn < ActiveRecord::Migration
  def change
    create_table :check_ins do |t|
      t.string :user
      t.string :business
      t.timestamps
    end
  end
end
