class AddReturnLabels < ActiveRecord::Migration
  def change
    create_table "spree_return_labels", :force => true do |t|
      t.belongs_to :return_authorization
      t.decimal  "weight",             precision: 8, scale: 2
      t.datetime "created_at",                                       :null => false
      t.datetime "updated_at",                                       :null => false
      t.string   "easypost_shipment_id",  length: 255
      t.string   "tracking",   length: 255
      t.text     "label_info"
    end

    add_index :spree_return_labels, [:return_authorization_id], name: :idx_spree_shipping_labels_on_return_authorization
  end
end
