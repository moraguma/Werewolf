extends SinglePlayerSelectionTrait


class_name SerialKillerTrait

func _init():
	name = "serial_killer"

## Performs action
func _perform_action():
	if player_selected.receive_attack():
		var public_log: Log = LOG_SCENE.instantiate()
		public_log.add_player_received_action_log(player_selected, TranslationManager.get_translation("serial_killer_public_action"))
		game.create_public_log(public_log)


func _get_available_player_buttons(action_display: ActionDisplay):
	return action_display.display_alive_players_except_owner(owner)


func try_win_condition(players: Array[Player]):
	var won = true
	for player in players:
		if player.alive and player != owner:
			won = false
			break
	
	if won:
		game.add_winner(Winner.new(owner, Log.win_template(self, "serial_killer_victory")))
