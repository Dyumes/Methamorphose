extends Node2D

@export var spawn_position: Vector2  # Position where items appear
@export var accepted_items = ["mix_a", "mix_b"]  # List of accepted item types

var item_scenes = {
	"mix_a": preload("res://Ingrédients/mix/mix_a.tscn"),
	"mix_b": preload("res://Ingrédients/mix/mix_b.tscn")
}

func _ready():
	visible = false  # This platform is purely functional

func connect_to_absorber(marmAbsorber):
	if marmAbsorber:
		marmAbsorber.item_placed.connect(_on_item_received)

func _on_item_received(item_name):
	print("Spawner received:", item_name)

	if item_name in item_scenes:
		var new_item = item_scenes[item_name].instantiate()
		new_item.position = global_position  # Use the Spawner's custom position
		get_parent().add_child(new_item)
	else:
		print("Error: No scene found for item:", item_name)
