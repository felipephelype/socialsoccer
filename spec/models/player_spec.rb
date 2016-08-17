require "rails_helper"

RSpec.describe Player, :type => :model do

  describe "Associations" do
    it { should have_many :presences }
    it { should have_many :matches }
  end

  let!(:unfinished_match) { FactoryGirl.create(:match) }
  let!(:finished_match) { FactoryGirl.create(:match, finished: true) }

  describe "Scope 'confirmed_match(id)'" do
    it "Return true or false if is confirmed in a certain match" do
      player = FactoryGirl.create(:player)
      presence = FactoryGirl.create(:presence,  player_id: player.id, match_id: unfinished_match.id, confirmation: false )
      expect(player.confirmed_match(unfinished_match.id)).to eq(false)
      presence.confirmation = true
      presence.save
      expect(player.confirmed_match(unfinished_match.id)).to eq(true)
    end

    describe "Scope 'presence(player_id, match_id)'" do
      it "Always return a presence" do
        new_player = FactoryGirl.create(:player)
        expect(Player.presence(new_player.id, finished_match.id)).to be_an_instance_of(Presence)
      end
    end

    describe "Scope 'goals_match(match_id)'" do
      subject(:player) { FactoryGirl.create(:player) }
      it 'Return 0 unless the played have scored on that match' do
        expect(player.goals_match(finished_match.id)).to eq(0)
      end

      it "Return the number of gols the player scored on that match" do
        presence = FactoryGirl.create(:presence,  player_id: player.id, match_id: finished_match.id, goals: 3, presence: true)
        expect(player.goals_match(finished_match.id)).to eq(3)
      end
    end

    describe "Scope payed_match(match_id)" do
      it "Return true or false if the player payed the match" do
        player = FactoryGirl.create(:player)
        expect(player.payed_match(finished_match.id)).to eq(false)
        presence = FactoryGirl.create(:presence,  player_id: player.id, match_id: finished_match.id, goals: 3, payed: true)
        expect(player.payed_match(finished_match.id)).to eq(true)
      end
    end

    describe "Scope played_match(match_id)" do
      it "Return true or false if the player palyed the match" do
        player = FactoryGirl.create(:player)
        expect(player.played_match(finished_match.id)).to eq(false)
        presence = FactoryGirl.create(:presence,  player_id: player.id, match_id: finished_match.id, goals: 3, presence: true)
        expect(player.played_match(finished_match.id)).to eq(true)
      end
    end

    describe "Scope team_played(match_id)" do
      it "Return the team id or nil (when someone does not register the team)" do
        player = FactoryGirl.create(:player)
        expect(player.team_played(finished_match.id)).to be_nil
        presence = FactoryGirl.create(:presence,  player_id: player.id, match_id: finished_match.id, presence: true, team_id: 1)
        expect(player.team_played(finished_match.id)).to eq(1)
      end
    end

    describe "Scope best_team(matches)" do
      it "must group teams that scored the most and less" do
        player = FactoryGirl.create(:player)
        good_player = FactoryGirl.create(:player)
        bad_player = FactoryGirl.create(:player)
        first_match =  FactoryGirl.create(:match, finished: true)
        second_match =  FactoryGirl.create(:match, finished: true)
        #first match (good team)
        FactoryGirl.create(:presence,  player_id: player.id, match_id: first_match.id, goals: 2, presence: true, team_id: 2)
        FactoryGirl.create(:presence,  player_id: good_player.id, match_id: first_match.id, goals: 6, presence: true, team_id: 2)
        #second match (bad team)
        FactoryGirl.create(:presence,  player_id: player.id, match_id: second_match.id, goals: 2, presence: true, team_id: nil)
        FactoryGirl.create(:presence,  player_id: bad_player.id, match_id: second_match.id, goals: 0, presence: true, team_id: nil)
        report = player.best_team(Presence.all.where("player_id = ? and presence is true", player.id))
        expect(report[:top_goals]).to eq(8)
        expect(report[:worst_goals]).to eq(2)
        expect(report[:top_team]).to eq([[player, 2],[good_player, 6]])
        expect(report[:bad_team]).to eq([[player, 2],[bad_player, 0]])
        expect(report[:best_id]).to eq(first_match.id)
        expect(report[:worst_id]).to eq(second_match.id)
      end

    end
  end
end
