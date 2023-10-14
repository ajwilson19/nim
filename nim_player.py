# AJ Wilson
# nim player for CPSC 323

class NimPlayer():
    #calculate nim sum using bitwise XOR
    def nim(self, state):
        nim=0
        for pile in state:
            nim=nim^pile
        return nim

    # returns array of all posible moves
    def all_boards(self, state):
        change = []
        possible_states = []
        for i in range(len(state)):
            for j in range(1, state[i]+1):
                change = state[:]
                change[i] = state[i]-j
                possible_states.append(change)
        return possible_states

    # uses nim sum to find best possible move
    def best_move(self, state):
        possible_states = self.all_boards(state)
        for pos_state in possible_states:
            if sum(pos_state) == 1:
                return pos_state
        for pos_state in possible_states:
            if self.nim(pos_state) == 0:
                return pos_state
        return possible_states[0]
    
    def play(self, state):
        return self.best_move(state)  