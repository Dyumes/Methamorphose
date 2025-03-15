extends Control

@onready var dialog_line = %DialogLine
@onready var speaker_name = %SpeakerName
#@onready var scroll_sprite: TextureRect = %ScrollSprite
#@onready var quest_text: Label = %QuestText

const ANIMATION_SPEED : int = 30
var animate_text: bool = false
var current_visible_characters: int = 0
var current_quest_item: String = ""

# Preload scroll background
const SCROLL_SPRITE = preload("res://Assets/UI_Sprites/old-parchment-paper-scroll-sheet-vintage-aged-or-texture-background-png.png")


func _ready() -> void:
	pass


func _process(delta: float) -> void:
	if animate_text:
		if dialog_line.visible_ratio < 1:
			dialog_line.visible_ratio += (1.0 / dialog_line.text.length()) * (ANIMATION_SPEED * delta)
			current_visible_characters = dialog_line.visible_characters
		else:
			animate_text = false

func change_line(speaker: String, line: String):
	speaker_name.text = speaker
	current_visible_characters = 0
	dialog_line.text = line
	dialog_line.visible_characters = 0
	animate_text = true
	check_for_quest_item(line)

func check_for_quest_item(line: String):
	var start_keyword = "request the "
	var end_keyword = "!"
	var start_index = line.find(start_keyword)
	if start_index != -1:
		start_index += start_keyword.length()
		var end_index = line.find(end_keyword, start_index)
		if end_index != -1:
			current_quest_item = line.substr(start_index, end_index - start_index)
			if scroll_sprite and quest_text:
				print("QuestText found, updating text.")
				Global.scroll_sprite_visible = true
				Global.quest_text = "Current Quest: " + current_quest_item
				Global.quest_text_visible = true
			else:
				print("ScrollSprite or QuestText not found when trying to update!")
