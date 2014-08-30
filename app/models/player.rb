require 'csv'

class Player < ActiveRecord::Base
  include RankedModel

  ranks :position_rank, :with_same => :position_name
  ranks :overall_rank

  def self.import_from_csv(file_path, defense = false)
    rank = Player.count

    CSV.foreach(Rails.root.join(file_path), headers: true) do |row|
      name_pos_team = row[0].split(" ")

      Player.create(
        name: name_pos_team[0] + " " + name_pos_team[1],
        team: name_pos_team[4],
        fpts: row[row.length-1],
        bye_week: row[2],
        position_name: defense ? "DST" : name_pos_team[2],
        overall_rank: rank
      ) if name_pos_team.length > 1

      rank = rank + 1
    end
  end

  def self.import
    positions = PlayerPosition.all

    Player.create(
      name: "Drew Brees",
      team: "NO",
      fpts: 222,
      bye_week: 6,
      position_name: "QB",
      drafted_by: "me"
    )

    Player.create(
      name: "Antonio Brown",
      team: "PIT",
      fpts: 222,
      bye_week: 12,
      position_name: "WR",
      drafted_by: "me"
    )

    Player.create(
      name: "Matt Forte",
      team: "CHI",
      fpts: 222,
      bye_week: 9,
      position_name: "RB",
      drafted_by: "me"
    )

    import_from_csv('csvs/kickers.csv')
    import_from_csv('csvs/players.csv')
    import_from_csv('csvs/dst.csv', true)
  end
end
