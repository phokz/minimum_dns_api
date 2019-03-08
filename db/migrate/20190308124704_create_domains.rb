class CreateDomains < ActiveRecord::Migration[5.2]
  def change
    create_table :domains do |t|
      t.string :name
      t.string :master, limit: 128
      t.integer :last_check
      t.string :type, limit: 6
      t.integer :notified_serial
      t.string :account, limit: 40

      t.timestamps
    end
  end
end
