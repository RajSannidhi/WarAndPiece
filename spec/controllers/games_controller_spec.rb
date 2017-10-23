require 'rails_helper'

RSpec.describe GamesController, type: :controller do
  describe "games#index action" do
    it "should require player to be logged in" do
      get :new 
      expect(response).to redirect_to new_user_session_path
    end
    it "should successfully show all current games" do
      player = FactoryGirl.create(:user)
      sign_in player
      get :index
      expect(response).to have_http_status(:success)
    end
  end
  
  describe "games#new action" do
    it "should require player to be logged in" do
      get :new 
      expect(response).to redirect_to new_user_session_path
    end
    it "should successfully show form for new game" do
    #a popup/modal asking if the player would like to start a new game
      player = FactoryGirl.create(:user)
      sign_in player
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "games#show action" do
    it "should require player to be logged in" do
      get :new
      expect(response).to redirect_to new_user_session_path
    end

    it "should return a 404 error if the game is not found" do
      player = FactoryGirl.create(:user)
      
      sign_in player

      get :show, params: { id: 'notreal' }
      expect(response).to have_http_status(:not_found)
    end

    it "should successfully show the game if the game is found" do
      player = FactoryGirl.create(:user)
      
      sign_in player
      post :create, params: { game: { white_player_id: player.id, game_state: "new" } }      
      game = Game.last
      get :show, params: { id: game.id }
      expect(response).to have_http_status(:success)
    end

  end
  
  describe "games#create action" do
    it "should require player to be logged in" do
      get :new 
      expect(response).to redirect_to new_user_session_path
    end
    it "should successfully create a new game in our database" do
      player = FactoryGirl.create(:user)
      
      sign_in player
      post :create, params: { game: { white_player_id: player.id, game_state: "new" } }
      
      expect(response).to redirect_to root_path
      game = Game.last
      expect(game.game_state).to eq("new")
      expect(game.white_player).to eq(player)
    end
  end
end
