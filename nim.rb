# Nim game in ruby
# AJ Wilson 2023

class Nim
    def initialize
      @board = [1, 3, 5, 7]
      @move_count = rand(2) # randomly picks who will go first
      @player = User.new(self)
      @bot = NimPlayer.new(self)
    end

    #returns true if board is empty -> game is over
    def over
        if @board.sum == 0
            return true
        else
            false
        end
    end
 
    #update board and display to console
    def update(new_board)
        @board = new_board
        display
    end    

    #displays current game board in console
    def display
      @board.each_with_index do |pile, i|
        puts ' ' * (3 - i) + '|' * pile
      end
      puts
    end

    #generate all possible boards
    def possible_boards
        temp = []
        possible_boards = []
        @board.each_with_index do |pile, i|
            (1..pile).each do |j|
                temp = @board.dup
                temp[i] = @board[i] - j
                possible_boards << temp
            end
        end
        return possible_boards
    end

    def play
        puts "Welcome to nim"
        puts "Current board state is #{@board}"
        puts "Take one or more sticks from a single pile per turn"
        puts "Enter moves as a string of comma separated numbers ex. 1,3,5,7"
        puts "Last player to take a stick wins!"
        display
        if @move_count == 0
            puts "Computer will go first"
        else
            puts "You will go first"
        end

        puts "Press enter to begin"
        gets.chomp

        #game loop
        while !over
            if @move_count % 2 == 0 #if move count is even it is the computer's turn
                puts "Computer move"
                sleep(1)    # delayed computer move for user experience
                update(@bot.logic)
            else
                update(@player.turn)
            end
            @move_count += 1
        end

        if @move_count % 2
            puts "You Lose!"
        else
            puts "You Win!"
        end
    end
end

class NimPlayer
    def initialize(game)
        @nim = game
      end  

    #calculate nim sum
    def nim_sum(board)
        nim = 0
        # if board = [1,3,5,7] -> nim sum = 1 XOR 3 XOR 5 XOR 7 = 0
        board.each { |pile|
            nim = nim^pile
        }
        return nim
    end

    def logic
        # get all possible moves
        possible_moves = @nim.possible_boards
        possible_moves.each do |move|
            if move.sum == 1 # leave opponent one stick, if possible
                return move
            end
        end
        possible_moves.each do |move|
            if nim_sum(move) == 0 # play move with num sum of zero
                return move
            end
        end
        return possible_moves[0] # else play the first (or only remaining) possible move
    end
end

class User
    def initialize(game)
        @nim = game
      end  

    # gets user move and checks if it is valid
    def turn
        print ("Enter move ?,?,?,?: ")
        input = gets.chomp
        user_move = input.split(',').map(&:to_i) #turns user input into array consistent with @board
        if user_move.class == Array && user_move.length == 4 #if user input is a array of length 4
            if @nim.possible_boards.include?(user_move) #if user move is possible
                return user_move # user move is valid
            else
                puts "Error: Invalid move, try again."
                turn
            end
        else
            puts "Error: Enter your move as 4 numbers separated by commas ex. 1, 3, 5, 7"
            turn
        end
    end
end

nim = Nim.new
nim.play