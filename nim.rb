# Nim player in ruby
class NimPlayer
    #calculate nim sum
    def nimber(board)
        nim_sum = 0
        # if board = [1,3,5,7] -> nim sum = 1 XOR 3 XOR 5 XOR 7 -> 0
        board.each { |pile|
            nim_sum = nim_sum^pile
        }
        return nim_sum
    end

    def logic(game)
        # get all possible moves
        possible_moves = game.possible_boards
        possible_moves.each do |move|
            if move.sum == 1 # leave opponent one stick, if possible
                return move
            end
        end
        possible_moves.each do |move|
            if nimber(move) == 0 # play move with num sum of zero
                return move
            end
        end
        return possible_moves[0] # else play the first (or only remaining) possible move
    end

end

class Nim
    def initialize
      @board = [1, 3, 5, 7]
    end

    def get_board
        return @board
    end
  
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

    #update board and display to console
    def update(new_board)
        @board = new_board
        display
    end
end

class User
    # gets user move and checks if it is valid
    def turn(game)
        print ("Enter move [?, ?, ?, ?]: ")
        input = gets.chomp
        user_move = input.split(',').map(&:to_i)
        if user_move.class == Array && user_move.length == 4 #if user input is a array of length 4
            if game.possible_boards.include?(user_move) #if user move is possible
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

game = Nim.new
bot = NimPlayer.new
user = User.new
# game.display
# puts "User move:"
# game.update(user.turn(game))
# puts "Computer move:"
# game.update(bot.logic(game))