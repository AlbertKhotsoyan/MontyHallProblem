require_relative '../MontyHall'
require_relative '../Simulation'

RSpec.describe MontyHall do
  let(:obj) {described_class.new }

  it "Checking host_opened_door_index" do
    puts "RSpec test1"
    expect(obj.host_opened_door_index(0, 1)).to eq(1) #(player_pick, car_location).to eq(host_opened_door)
    expect(obj.host_opened_door_index(0, 2)).to eq(2)
    expect(obj.host_opened_door_index(1, 0)).to eq(0)
    expect(obj.host_opened_door_index(1, 2)).to eq(2)
    expect(obj.host_opened_door_index(2, 0)).to eq(0)
    expect(obj.host_opened_door_index(2, 1)).to eq(1)
  end

  it "Checking player_random_decision" do
    puts "RSpec test2"
    expect(obj.player_random_decision).to eq(1).or eq(2) #player_random_decision equal 1 or 2
  end

  it "Checking player_decision_result" do
    puts "RSpec test3"
    expect(obj.player_decision_result(1, 1)).to eq(1.0) #(player_decision, car_location) 1.0=win 0.0=lose
    expect(obj.player_decision_result(0, 2)).to eq(0.0)
  end

  it "Confirming the Monty Hall problem" do
    puts "RSpec test4"
    expect(Simulation.win_rate_when_decision_changed).to be > (Simulation.win_rate_when_decision_is_not_changed)
  end
end
