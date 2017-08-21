require_relative 'Base'  
main = BaseClass.new
player = {}
# pushPlayer = function(name,mp,blood){ return array("name"=>name,"mp"=>mp,"blood"=>blood)}
counter = 1
input = true
while(input != "exit")
input = main.disHome()
    case input
        when "new"
            playerName = main.disNewChar() # get player display
            begin
                if counter > 3
                    raise "has reach maximum slot !, Press any button."
                else
                    playerName = main.validateInput(playerName).downcase
                    playerName = main.validatePlayerName(playerName) # check empty string and exist player name
                    ins = Player.new(playerName,40,100)
                    player[playerName] = ins.getPlayerStat()
                    playerSet = main.nPlayerSet(player[playerName])
                    counter = counter + 1
                end
            rescue StandardError => bang
                print "Error running script: #{bang}"
                gets.chomp
            end
        when "start"
            begin
                if player.count < 2
                    raise "need minimum 2 player for play !, Press any button."
                    gets.chomp
                else
                    while(main.survivePlayer() > 1)
                        player.each_value do |val|
                            begin
                                    if main.isDeath(player[val['name']]) #check player stat
                                        # do nothing, just skip the loser
                                    else #if player not dead
                                        input = main.validateExistPlayer(main.validateInput(main.disBattle(val['name']))) #check empty string and empty player choosen
                                        if input == val['name']
                                            raise "Cant attack your self ! Press any button"
                                        else
                                            demage = demageAttack(val['name']) #get demage from player
                                            puts damage
                                            player[input].decreaseBlood((demage['basic']+demage['crit'])-demage['miss'])
                                            main.updateStatus(player[val['name']].getPlayerStat()) #update status player
                                            main.updateStatus(player[input].getPlayerStat()) #update status enemy
                                            main.dispLogAttack(demage)
                                        end
                                    end
                            rescue StandardError => bang
                                print "Error running script: #{bang}"
                                gets.chomp
                            end
                        end
                        if main.survivePlayer() == 1
                             puts "The one survive is #main.winnerPlayer()}, Congratulation !!"
                             gets.chomp
                        end 
                    end #endwhile
                    player.each do |val,key| # reset player stat
                        player[key] = [40,100]
                        main.updateStatus(player[key].getPlayerStat()) #update status player
                    end
                end
            rescue StandardError => bang
                print "Error running script: #{bang}"
                gets.chomp
            end
        when "exit"
            puts "Undefiend command !, Press any button"
        else
            puts "Undefiend command !, Press any button"
            gets.chomp
        end
end