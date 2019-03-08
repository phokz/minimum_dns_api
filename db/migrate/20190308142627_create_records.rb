class CreateRecords < ActiveRecord::Migration[5.2]
  def change
    create_table :records do |t|
      t.references :domain
      t.string :name
      t.string :type, limit: 10
      t.string :content, limit: 20000
      t.integer :ttl
      t.integer :prio
      t.integer :change_date
      t.boolean :disabled, default: false
      t.string :ordername
      t.boolean :auth, default: 1

      t.timestamps
    end
    add_index :records, [:name, :type]
    add_index :records, [:domain_id, :ordername]
  end
end
