require './MontyHall'

class Simulation
  
  monty_hall = MontyHall.new                            #Создаем объект класса MontyHall

  $decision_changed_win_counter = 0.0                   #Создаем глобальные переменные счетчики
  $decision_is_not_changed_win_counter = 0.0
  $decision_counter_overal_win = 0.0

  def self.decision_counter(decision_result)            #Метод считает количество выигрышей и возвращает 1 если выиграли
    if decision_result == 1
      $decision_counter_overal_win += 1.0
      return 1.0
    else
      return 0.0
    end
  end

  $loop_counts = 0
  until $loop_counts == 10000 do                         #Simulation loop counts
    $loop_counts += 1
    
    doors = ["empty", "empty", "empty"]                 #изначально все двери пустые

    car_location = monty_hall.car_random_location_index #рандомно определяется местонахождение автомобиля
    doors[car_location] = "car"
    #puts doors.inspect

    player_picked = monty_hall.player_random_pick_index #рандомно определяется первоначальный выбор игрока
    doors[player_picked] = "player picked " + doors[player_picked]
    #puts doors.inspect

    host_opened = monty_hall.host_opened_door_index(player_picked, car_location) #ведущий открывает дверь на основе автомобиля и выбора игрока
    doors[host_opened] = "host opened " + doors[host_opened]
    #puts doors.inspect

    #puts "Player picked door №#{player_picked + 1}, " + "Host has opened door №#{host_opened + 1}" #frontend
    #puts "Do you want to change your decision?"
    #puts "Press 1 if you want, press 2 if you dont"

    player_decision = monty_hall.player_random_decision #Игрок рандомно вводит свое решение 1 или 2

    loop do #Зашита от дурака
      if player_decision == 1
        #puts "You changed decision and opened the door №#{host_opened + 1}"
        decision_result = monty_hall.player_decision_result(host_opened, car_location)    #Вызываем метод который показывает результат если игрок изменил свое решение
        $decision_changed_win_counter += decision_counter(decision_result)                #Считает количество выигрышей при которых игрок сменил свое решение
        break

      elsif player_decision == 2
        #puts "You not changed decision and opened the door №#{player_picked + 1}"
        decision_result = monty_hall.player_decision_result(player_picked, car_location)  #Вызываем метод который показывает результат если игрок НЕ изменил свое решение
        $decision_is_not_changed_win_counter += decision_counter(decision_result)         #Считает количество выигрышей при которых игрок НЕ сменил свое решение
        break

      else
        #puts "Press 1 if you want to change, press 2 if you dont. Again"
        player_decision = monty_hall.player_random_decision                               #Игрок вводит свое решение снова если изначально ввел не 1 или 2
      end
    end
  end

  def self.win_rate_when_decision_changed
    win_rate_when_decision_changed = $decision_changed_win_counter / $loop_counts * 100                #Считаем количество выигрышей при которых игрок сменил свое решение в процентах      
  end

  def self.win_rate_when_decision_is_not_changed
    win_rate_when_decision_is_not_changed = $decision_is_not_changed_win_counter / $loop_counts * 100  #Считаем количество выигрышей при которых игрок НЕ сменил свое решение в процентах
  end

  def self.win_rate_combined_overal
    win_rate_combined_overal = $decision_counter_overal_win / $loop_counts * 100                       #Считаем количество всех выигрышей в процентах
  end

  puts "win_rate_when_decision_changed        = #{win_rate_when_decision_changed}%"                    #Выводим на экран в процетах
  puts "win_rate_when_decision_is_not_changed = #{win_rate_when_decision_is_not_changed}%"
  puts "win_rate_combined_overal              = #{win_rate_combined_overal}%"

end