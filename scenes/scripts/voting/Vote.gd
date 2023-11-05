extends Control


signal voted(player)


var selection = null
var selected_button = null


@onready var players_scroll: PlayersScroll = $PlayersScroll


func vote(player: Player, votable_players: Array[Player]):
	show()
	
	# Excludes self from votable players
	var effective_votable_players: Array[Player] = []
	for p in votable_players:
		if p != player:
			effective_votable_players.append(p)
	
	var buttons = players_scroll.display_players(effective_votable_players)
	for button in buttons:
		button.connect("selected_player", selected_player.bind(button))
	
	var result = await voted
	hide()
	return result


func selected_player(p: Player, button: PlayerSelectionButton):
	if selected_button != null:
		selected_button.enable()
	
	selection = p
	selected_button = button
	button.disable()


func confirm_vote():
	if selection != null:
		voted.emit(selection)


func skip_vote():
	voted.emit(null)
