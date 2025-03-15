extends Node2D

@onready var sprite = %CharacterSprite

const CHARACTERS_SPRITES = {
	"Sir Roland": preload("res://Assets/Idle Sprites/buffsuki_mudry.png"),
	"Glimpo": preload("res://Assets/Idle Sprites/Miku.png"),
	"Mage Alaric": preload("res://Assets/Idle Sprites/png-clipart-重音teto-vocaloid-utau-hatsune-miku-megurine-luka-hatsune-miku-black-hair-fictional-characters.png"),
	"The Bald Goblin": preload("res://Assets/Idle Sprites/just_mudry_scoliose.png"),
	"Octavius": preload("res://Assets/Idle Sprites/bennoFreaky.png"),
	"Claude": preload("res://Assets/Idle Sprites/pixil-frame-0_25.png"),
	"Macaron": preload("res://Assets/Idle Sprites/png-transparent-emmanuel-macron-france-selfie-france-face-head-business-thumbnail.png"),
	"Kadjit":preload("res://Assets/Idle Sprites/sayori_mudry.png"),
	

	
}

func change_character(name: String) -> void:
	if name in CHARACTERS_SPRITES:
		sprite.texture = CHARACTERS_SPRITES[name]
	else:
		print("Character not found: ", name)

func _ready() -> void:
	pass
