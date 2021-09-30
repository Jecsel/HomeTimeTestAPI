class CreatePhones < ActiveRecord::Migration[6.1]
  def change
    create_table :phones do |t|
      t.belongs_to        :guest, index:true
      t.string            :phone
      t.timestamps
    end
  end
end
