class CreateReservations < ActiveRecord::Migration[6.1]
  def change
    create_table :reservations do |t|
      t.belongs_to        :guest, index:true
      t.date              :start_date
      t.date              :end_date
      t.integer           :nights
      t.integer           :guests
      t.integer           :adults
      t.integer           :children
      t.integer           :infants
      t.boolean           :status
      t.string            :currency
      t.string            :payout_price
      t.string            :security_price
      t.string            :total_price
      t.timestamps
    end
  end
end
