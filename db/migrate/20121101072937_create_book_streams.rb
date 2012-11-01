class CreateBookStreams < ActiveRecord::Migration
  def change
    create_table :book_streams do |t|
      t.references :book
      t.references :stream

      t.timestamps
    end
    add_index :book_streams, :book_id
    add_index :book_streams, :stream_id
  end
end
