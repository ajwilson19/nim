# Nim player in ruby
class NimPlayer
    def nimber(board)
        nim_sum = 0
        board.each { |pile|
            nim_sum = nim_sum^pile
        }
        return nim_sum
    end

    def logic(game)
        possible_moves = game.possible_boards
        possible_moves.each do |move|
            if move.sum == 1
                return move
            end
        end
        possible_moves.each do |move|
            if nimber(move) == 0
                return move
            end
        end
        return possible_moves[0]
    end

end

class Nim
    def initialize
      @board = [1, 3, 5, 7]
    end
  
    def display
      @board.each_with_index do |pile, i|
        puts ' ' * (3 - i) + '|' * pile
      end
      puts
    end

    def possible_boards
        temp = []
        possible_boards = []
        (0...@board.length).each do |i|
            pile = @board[i]
            (1..pile).each do |j|
                temp = @board.dup
                temp[i] = @board[i] - j
                possible_boards << temp
            end
        end
        return possible_boards
    end
end

class User
    def turn
        print ("Enter move [?, ?, ?, ?]: ")
        input = gets.chomp
        return input.split(',').map(&:to_i)
    end
end