class PlayersController < ApplicationController
  protect_from_forgery :except => :update
  before_filter :get_players

  def index
    respond_to do |format|
      format.html
      format.json {
        render :json => {
          players: @players,
          drafted_players: @drafted_players
        }.to_json
      }
    end
  end

  def update
    player_params = params.permit(:id, :overall_rank, :position_rank, :drafted_by)
    @player = Player.find(params[:id])
    @player.update_attributes!(player_params)

    @players.reload

    render :json => {
      players: @players,
      drafted_players: @drafted_players
    }.to_json
  end

  def get_players
    @players = Player.where(drafted_by: nil).rank(:overall_rank)
    @drafted_players = Player.where('drafted_by IS NOT NULL').rank(:overall_rank)
  end
end
