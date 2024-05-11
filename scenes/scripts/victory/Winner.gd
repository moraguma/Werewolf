extends Resource
class_name Winner


var player: Player
var explanation: Log


## Explains a winner. Includes the player and the explanation of their victory
## that will be included in the victory screen
func _init(player: Player, explanation: Log):
	self.player = player
	self.explanation = explanation
