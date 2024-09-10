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

  def player_input
    player_decision = $stdin.gets.to_i;
  end
  
  def player_decision_result(player_decision, car_location) #метод возвращает результат выбора игрока
    if player_decision == car_location
      return "Congrats you win!"
    else
      return "You lose."
    end  
  end
end

monty_hall = MontyHall.new

doors = ["empty", "empty", "empty"]                 #изначально все двери пустые

car_location = monty_hall.car_random_location_index #рандомно определяется местонахождение автомобиля
doors[car_location] = "car"
#puts doors.inspect

player_picked = monty_hall.player_random_pick_index #рандомно определяется первоначальный выбор игрока
doors[player_picked] = "player picked " + doors[player_picked]
#puts doors.inspect

host_opened = monty_hall.host_opened_door_index(player_picked, car_location) #ведущий открывает дверь на основе автомобиля и выбора игрока
doors[host_opened] = "host opened " + doors[host_opened]
puts doors.inspect

puts "Player(you) picked door №#{player_picked + 1}, " + "Host has opened door №#{host_opened + 1}" #frontend
puts "Do you want to change your decision?"
puts "Press 1 if you want, press 2 if you dont"

player_decision = monty_hall.player_input #Игрок вводит свое решение 1 или 2
loop do #Зашита от дурака
  if player_decision == 1
    puts "You opened the door №#{host_opened + 1}"
    puts monty_hall.player_decision_result(host_opened, car_location)    #Вызываем метод который показывает результат если игрок изменил свое решение
    break
  elsif player_decision == 2
    puts "You opened the door №#{player_picked + 1}"
    puts monty_hall.player_decision_result(player_picked, car_location)  #Вызываем метод который показывает результат если игрок не изменил свое решение
    break
  else
    puts "Press 1 if you want, press 2 if you dont. Again"
    player_decision = gets.to_i                                          #Игрок вводит свое решение снова если ввел не 1 или 2
  end
end
