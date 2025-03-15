extends Control

@onready var scroll_sprite: TextureRect = %ScrollSprite
@onready var quest_text: Label = %QuestText

const SCROLL_SPRITE = preload("res://Assets/UI_Sprites/old-parchment-paper-scroll-sheet-vintage-aged-or-texture-background-png.png")

#var scroll_sprite_visible = Global.scroll_sprite_visible
#var scroll_sprite_texture = ""
#var quest_text_instance = Global.quest_text
#var quest_text_visible = Global.quest_text_visible
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Global.scroll_sprite_visible:
		Global.scroll_sprite_visible.texture = SCROLL_SPRITE
		Global.scroll_sprite.visible = false
	else:
		print("ScrollSprite not found! Check the scene tree.")
	
	if Global.quest_text_instance:
		Global.quest_text_instance = "No quest available"
		Global.quest_text_instance = false
	else:
		print("QuestText not found! Check the scene tree.")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
