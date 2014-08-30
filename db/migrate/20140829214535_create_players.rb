class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.text :name
      t.string  :position_name
      t.string  :drafted_by
      t.string  :team
      t.string  :bye_week
      t.integer :fpts
      t.integer :overall_rank
      t.integer :position_rank

      t.timestamps
    end
  end
end
