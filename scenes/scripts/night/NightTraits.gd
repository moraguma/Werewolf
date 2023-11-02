extends Control


signal action_selected(action)


@onready var player_name = $PlayerName
@onready var traits_container = $TraitsContainer
@onready var action_display: ActionDisplay = $"../Action"


func choose_action(player: Player) -> Array:
	show()
	
	player_name.text = "[center]" + player.name
	# TODO - Add skip button
	
	var buttons = traits_container.display_traits(player.traits)
	for button in buttons:
		button.connect("selected_trait", display_trait)
	
	var selected_action = await action_selected
	
	return selected_action


func display_trait(t: Trait):
	hide()
	var action = await t.display_actions(action_display)
	show()
	
	if action[0] != null:
		action_selected.emit(action)
