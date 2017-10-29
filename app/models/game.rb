class Game < ApplicationRecord
  belongs_to :black_player, class_name: "User", foreign_key: "black_player_id", optional: true
  belongs_to :white_player, class_name: "User", foreign_key: "white_player_id"
  has_many :pieces

  scope :available, -> { where(black_player_id: nil)  }
  scope :inprogress, -> { where.not(black_player_id: nil) }
end
