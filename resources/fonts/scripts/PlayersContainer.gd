extends ExpandingContainer


const PLAYER_BUTTON_SCENE = preload("res://scenes/PlayerButton.tscn")
const THEME = preload("res://resources/themes/game.tres")
const MAX_PLAYERS_PER_LINE = 3


func display_players(players: Array[Player]) -> Array:
	return display_elements(players, PLAYER_BUTTON_SCENE, MAX_PLAYERS_PER_LINE)
