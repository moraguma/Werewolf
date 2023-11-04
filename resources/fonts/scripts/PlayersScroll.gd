extends ScrollContainer


class_name PlayersScroll


@onready var container: ExpandingContainer = $PlayersContainer


func display_players(players: Array[Player]) -> Array:
	return container.display_players(players)
