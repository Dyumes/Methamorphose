extends Node2D

@export var spawn_position: Vector2  # Position where items appear
@export var accepted_items = ["Potion de soin", "Potion au pif"]  # List of accepted item types

var item_scenes = {
	"Potion de soin": preload("res://potions/potion_de_soin.tscn"),
	"Potion au pif": preload("res://potions/potion_au_pif.tscn")
}

func _ready():
	visible = false  # This platform is purely functional

func connect_to_absorber(absorber):
	if absorber:
		absorber.item_placed.connect(_on_item_received)

func _on_item_received(item_name):
	if item_name in accepted_items:
		print("Spawning new item based on:", item_name)
		if item_name in item_scenes:
			var new_item = item_scenes[item_name].instantiate()
			new_item.position = global_position
			get_parent().add_child(new_item)
		else:
			print("Error: No scene found for item:", item_name)
	else:
		print("Spawner rejected item:", item_name)
