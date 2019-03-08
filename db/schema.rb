# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_03_08_151531) do

  create_table "audits", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "auditable_id"
    t.string "auditable_type"
    t.integer "associated_id"
    t.string "associated_type"
    t.integer "user_id"
    t.string "user_type"
    t.string "username"
    t.string "action"
    t.text "audited_changes"
    t.integer "version", default: 0
    t.string "comment"
    t.string "remote_address"
    t.string "request_uuid"
    t.datetime "created_at"
    t.index ["associated_type", "associated_id"], name: "associated_index"
    t.index ["auditable_type", "auditable_id", "version"], name: "auditable_index"
    t.index ["created_at"], name: "index_audits_on_created_at"
    t.index ["request_uuid"], name: "index_audits_on_request_uuid"
    t.index ["user_id", "user_type"], name: "user_index"
  end

  create_table "domains", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.string "master", limit: 128
    t.integer "last_check"
    t.string "type", limit: 6
    t.integer "notified_serial"
    t.string "account", limit: 40
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "records", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "domain_id"
    t.string "name"
    t.string "type", limit: 10
    t.string "content", limit: 20000
    t.integer "ttl"
    t.integer "prio"
    t.integer "change_date"
    t.boolean "disabled", default: false
    t.string "ordername"
    t.boolean "auth", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["domain_id", "ordername"], name: "index_records_on_domain_id_and_ordername"
    t.index ["domain_id"], name: "index_records_on_domain_id"
    t.index ["name", "type"], name: "index_records_on_name_and_type"
  end

end
