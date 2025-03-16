extends Node2D

@export var spawn_position: Vector2  # Position where items appear
@export var accepted_items = ["poudre_f", "essence_champi"]  # List of accepted item types

var item_scenes = {
	"poudre_f": preload("res://Ingrédients/moulus/poudre_f.tscn"),
	"poudre_os": preload("res://Ingrédients/raw/os.tscn"), # A modifier
	"essence_champi": preload("res://Ingrédients/moulus/essence_champi.tscn")
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
