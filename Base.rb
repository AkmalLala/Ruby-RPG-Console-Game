class BaseClass
    def initialize
        @player = {}
    end
    def nPlayerSet(player)
        # @player[player['name']].store 'name',player['name']
        # @player[player['mana']].store 'mana',player['mana']
        # @player[player['blood']].store 'blood',player['blood']
        @player.store(player["name"], player)
    end
    def updateStatus(player)
        @player.each do |val,key|
            if @player[key]['name'] == player['name']
                @player[key]['mana'] = player['mana']
                @player[key]['blood'] = player['blood']
            end
        end
    end
    def validateInput(input)
        if input.empty?
            raise "Input can't be empty !, Press any button."
        end
        return input
    end
    def validatePlayerName(input)
        if !@player.nil? 
            @player.each_value do |val|
                if val['name'] == input
                    raise "Player already exist !, Press any button."
                end
            end
        end
        return input
    end
    def validateExistPlayer(input)
        check = false
        @player.each_value do |val|
            if val['name'] == input || input == "exit"
                check = true
                if val['mana'] == 0 || val['blood'] == 0 
                    print "Player is dead, choose another player !, Press any button."
                    gets.chomp
                end
            end
        end
        if check == false
            raise "Player not found !, Press any button." 
        else
            return input
        end
    end
    def survivePlayer()
        count = 0
        @player.each_value do |val|
            if val['mana'] > 0 && val['blood'] > 0
                count+=1
            end
        end
        return count
    end
    def winnerPlayer()
        @player.each do |val|
            if (val['mana'] > 0) && ( val['blood'] > 0 )
                return val['name']
            end
        end
        return "not fond"
    end
    def isDeath(player)
        @player.each_value do |val|
            if val['name'] == player['name']
                if val['mana'] == 0 || val['blood'] == 0 
                    return true
                end
            end
        end
        return false
    end
    def disHome()
        system('clear')
        puts "=====================================\n"
        puts "    Welcome to the Battle Arena\n"
        puts "-------------------------------------\n"
        puts "Descripotion :\n"
        puts "1. type \"new\" to create a character\n"
        puts "2. type \"start\" to begin the fight \n"
        puts "-------------------------------------\n"
        if !@player.empty?
        puts "Current Player : #{@player.count}\n"
            @player.each_key {|key| puts "- #{key} \n" }
        else
            puts"-#\n"
        end
        
        puts "*Max player 2 or 3\n"
        puts "-------------------------------------\n"
        print "input : "
        return input = gets.chomp
    end

    def disNewChar()
        system('clear')
        puts "=====================================\n"
        puts "    Welcome to the Battel Arena\n"
        puts "-------------------------------------\n"
        puts "Player Exist : \n"
        if !@player.empty?
            @player.each_key {|key| puts "- #{key} \n" }
        else
            puts "-#\n"    
        end
        puts "-------------------------------------\n"
        print "Put Player Name :"
        input = gets.chomp
        return input
    end

    def disBattle(name)
        system('clear')
        puts "=====================================\n"
        puts "    Welcome to the Battel Arena\n"
        puts "-------------------------------------\n"
        puts "Player Status : \n"
        if !@player.empty?
            @player.each_value do |val|
                (val['mana'] == 0 || val['blood'] == 0) ? stat = " (Your Dead)" : stat = ""
                puts "- [#{val['name']}] : mana = #{val['mana']}, blood = #{val['blood']} #{stat} \n"
            end
            puts "-------------------------------------\n"
            puts "Player role : #{name}\n"
            puts "-------------------------------------\n"
            print "Attack player  : "
        else
            puts "- No character found !, Press any button \n"    
        end
        return gets.chomp
    end
    def dispLogAttack(info)
        puts "-------------------------------------\n"
        puts "Attack log :\n"
        puts " Basic Demage : #{info['basic']} \n"
        puts " Miss  Demage : #{info['miss']} \n"
        puts " Crit  Demage : #{((info['crit']/info['basic'])*100)} % \n"
        puts "-------------------------------------\n"
        puts "Press any button to continue \n"
        gets.chomp
    end
end

class Player
    def initialize(name,mana,blood)  
        @name = name
        @mana = mana
        @blood = blood
    end
    def reset(mana,blood)
        @mana = mana
        @blood = blood
    end
    def setName(name)
        @name = name #untuk set nama player
    end
    def getName()
        return @name #untuk get nama player
    end
    def setMana(mana)
        @mana = mana #untuk mengambil set nama player
    end
    def getMana()
        return @mana #untuk get nama player
    end
    def setBlood(blood)
        @blood = blood #untuk mengambil set blood player
    end
    def getBlood()
        return @blood #untuk mengambil get hp player  
    end  
    def getPlayerStat()
        return {"name"=>@name,"mana"=>@mana,"blood"=>@blood}
    end
    def decreaseBlood(blood)
        @blood = @blood - blood
        if @blood < 0
            @blood = 0
        end
    end
    def demageAttack(name)
        @player
        return ["basic"=>20,"crit"=>rand(0..10),"miss"=>rand(0..1)]
    end
end