require_relative '../MontyHall'

RSpec.describe MontyHall do
  let(:obj) {described_class.new }

  it "checking host_opened_door_index" do
    puts "RSpec test1"
    expect(obj.host_opened_door_index(0, 1)).to eq(1) #(player_pick, car_location).to eq(host_opened_door)
    expect(obj.host_opened_door_index(0, 2)).to eq(2)
    expect(obj.host_opened_door_index(1, 0)).to eq(0)
    expect(obj.host_opened_door_index(1, 2)).to eq(2)
    expect(obj.host_opened_door_index(2, 0)).to eq(0)
    expect(obj.host_opened_door_index(2, 1)).to eq(1)
  end

  it "checking player_decision_result" do
    puts "RSpec test2"
    expect(obj.player_decision_result(1, 1)).to eq("Congrats you win!") #(player_decision, car_location)
    expect(obj.player_decision_result(0, 2)).to eq("You lose.")
  end

  it "checking user/player input" do
    puts "RSpec test3"
    allow($stdin).to receive(:gets).and_return(1, 2) #(player_decision, player_decision)
    expect(obj.player_input).to eq(1)
    expect(obj.player_input).to eq(2)
  end
end
