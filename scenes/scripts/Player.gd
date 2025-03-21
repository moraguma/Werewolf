extends Resource


class_name Player


const LOG_SCENE = preload("res://scenes/Log.tscn")


var icon: Texture
var name: String
var game: Game
var color_scheme: ColorScheme

var traits: Array[Trait] = []

var alive = true
var votable = true
var protected = false


func _init(param_icon: Texture, param_name: String, param_color_scheme: ColorScheme):
	self.icon = param_icon
	self.name = param_name
	self.color_scheme = param_color_scheme


func give_trait(t: Trait):
	t.owner = self
	t.game = game
	
	traits.append(t)
	
func has_trait(t: Script) -> bool:
	for x in traits:
		if x.get_script() == t:
			return true
	return false

func set_game(new_game: Game):
	self.game = new_game
	
	for t in traits:
		t.game = new_game


func win_election():
	var new_log: Log = LOG_SCENE.instantiate()
	new_log.add_image(icon)
	new_log.add_text(name + TranslationManager.get_translation("died_at_gallows"))
	game.create_public_log(new_log)
	
	alive = false
	votable = false


## Tries to attack player. Returns whether or not the attack was successful
func receive_attack() -> bool:
	if protected == false:
		alive = false
	return not alive


## Called at the start of the night. Should reset any variable that might have
## been set the night before
func reset_actions():
	protected = false
