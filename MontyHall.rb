class MontyHall

  def car_random_location_index             #метод для рандомного определения местонахождение автомобиля
    car_location_index = (rand(0..2)).to_i
  end

  def player_random_pick_index              #метод для рандомного определения первоначальный выбор игрока
    player_picked_door = (rand(0..2)).to_i
  end

  def host_opened_door_index(player, car)   #метод для рандомного открытия двери ведущего, учитовая местонахождение автомобиля и первоначальный выбор игрока
    host_opened_index = 0
    loop do
      host_opened_index = (rand(0..2)).to_i
      #puts "loop"
      if ((player == car) && (host_opened_index != car))
        #puts "breaked_1"
        break 
      elsif ((player != car) && (host_opened_index == car))
        #puts "breaked_2"
        break
      end
    end
    return host_opened_index
  end

  def player_random_decision
    player_decision = (rand(1..2)).to_i
  end
  
  def player_decision_result(player_decision, car_location) #метод возвращает результат выбора игрока
    if player_decision == car_location
      #puts "Congrats you win!"
      return 1
    else
      #puts "You lose."
      return 0
    end  
  end
end
