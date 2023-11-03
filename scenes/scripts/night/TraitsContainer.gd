extends ExpandingContainer


const TRAIT_SELECTION_BUTTON_SCENE = preload("res://scenes/TraitSelectionButton.tscn")
const THEME = preload("res://resources/themes/game.tres")
const MAX_TRAITS_PER_LINE = 2


func display_traits(traits: Array[Trait]) -> Array:
	return display_elements(traits, TRAIT_SELECTION_BUTTON_SCENE, MAX_TRAITS_PER_LINE)
