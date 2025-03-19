extends SinglePlayerSelectionTrait


class_name WolfTrait

var wolf_paw

func _init():
	name = "wolf"
	wolf_paw = preload("res://resources/sprites/high_res_emojis/wolf_paw.png")


## Executa a ação do lobo (votar em quem matar)
func _perform_action():
	WolfVotingSystem.register_vote(player_selected)

func _get_available_player_buttons(action_display: ActionDisplay):
	var buttons = action_display.display_alive_players_except_owner(owner)
	var vote_counts = WolfVotingSystem.get_votes()

	for button in buttons:
		var player = button.player
		var vote_count = vote_counts.get(player, 0)

		# Add an icon of a wolf paw if the player is also a wolf
		if player.has_trait(WolfTrait):
			button.add_icon(wolf_paw)

		# Add a small number showing how many votes the player has
		if vote_count > 0:
			button.add_text(" (%d)" % vote_count)  # Shows like "PlayerName (2)"

	return buttons

func _get_action_description() -> String:
	return TranslationManager.get_translation("wolf_action_description")
