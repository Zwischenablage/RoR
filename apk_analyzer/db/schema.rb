# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_11_19_124152) do

  create_table "apps", force: :cascade do |t|
    t.string "filename"
    t.string "package"
    t.boolean "hasActivity"
    t.boolean "hasRO"
    t.integer "numOfServices"
    t.integer "numOfReceivers"
    t.integer "numOfProviders"
    t.integer "createdPermissions"
    t.integer "usedPermissions"
    t.integer "bootCompleted"
    t.integer "persistent"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "hasApplication"
    t.string "supplier"
    t.string "usedPermissionsList"
    t.string "createdPermissionsList"
    t.string "provdersList"
    t.string "receiversList"
    t.string "servicesList"
    t.string "project"
    t.string "deployment"
  end

end
