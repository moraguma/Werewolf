extends Control


@onready var title: RichTextLabel = $Title
@onready var components: VBoxContainer = $Scroll/Components
@onready var next: Button = $Next


func add_log(announcements_log: Log):
	components.add_child(announcements_log)


func display_victory(winners: Array[Winner]):
	title.text = TranslationManager.get_translation("game_over") if len(winners) == 0 else TranslationManager.get_translation("victory")
	
	for winner in winners:
		add_log(winner.explanation)
	
	await next.pressed
	print("Ended game!")

