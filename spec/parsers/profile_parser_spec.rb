require "spec_helper"

describe TriviaCrack::Parsers::ProfileParser do

  let(:profile_data) { SpecData.get "profile.json" }

  it "should parse raw data from the profile API" do
    profile = TriviaCrack::Parsers::ProfileParser.parse profile_data

    expect(profile.id).to eq(111)
    expect(profile.is_friend).to eq(false)
    expect(profile.is_blocked).to eq(false)
    expect(profile.username).to eq("example")
    expect(profile.country).to eq(:us)
    expect(profile.email).to eq("user@example.com")

    expect(profile.games_won).to eq(530)
    expect(profile.games_lost).to eq(240)
    expect(profile.games_resigned).to eq(0)
    expect(profile.consecutive_games_won).to eq(3)
    expect(profile.consecutive_answers_correct).to eq(0)
    expect(profile.level).to eq(167)
    expect(profile.challenges_won).to eq(35)
    expect(profile.challenges_lost).to eq(6)
    expect(profile.my_wins_vs_user).to eq(0)
    expect(profile.my_losses_vs_user).to eq(1)
  end

  it "should parse statistics data correctly" do
    profile = TriviaCrack::Parsers::ProfileParser.parse profile_data

    expect(profile.categories.count).to eq(6)
    expect(profile.categories[:arts].correct).to eq(2147)
  end

end
