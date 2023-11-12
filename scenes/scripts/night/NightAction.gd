extends Control


class_name ActionDisplay


signal interrupt(info)


const PLAYERS_SCROLL_SCENE = preload("res://scenes/PlayersScroll.tscn")
const COLOR_SCHEME_MATERIAL = preload("res://resources/shaders/materials/ColorSchemer.tres")

const BUTTON_MIN_SIZE = Vector2(500, 120)


@onready var game: Game = $"../../../"
@onready var components = $Scroll/Components


func start():
	for component in components.get_children():
		component.queue_free()
	show()


func finish():
	hide()


func go_back():
	interrupt.emit(Interrupt.new(Interrupt.Type.EXIT, null))


func display_alive_players() -> Array:
	return display_players(game.get_alive_players())


func display_alive_players_except_owner(owner_player: Player) -> Array:
	var all = game.get_alive_players()
	all.erase(owner_player)
	return display_players(all)


func display_dead_players() -> Array:
	return display_players(game.get_dead_players())


func display_players(players: Array[Player]) -> Array:
	var players_scroll: PlayersScroll = PLAYERS_SCROLL_SCENE.instantiate()
	components.add_child(players_scroll)
	return players_scroll.display_players(players)	


func add_button(text: String) -> Button:
	var new_button: Button = Button.new()
	new_button.text = text
	new_button.custom_minimum_size = BUTTON_MIN_SIZE
	new_button.set_h_size_flags(Button.SIZE_SHRINK_CENTER)
	new_button.material = COLOR_SCHEME_MATERIAL
	
	components.add_child(new_button)
	return new_button
