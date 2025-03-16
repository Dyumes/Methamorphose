extends StaticBody2D

signal item_placed(item_type)  # Signal to notify when crafting is done

@export var accepted_items = ["eau", "poudre_f", "essence_champi"]  # Items the stand can accept
@export var recipes = {  
	"poudre_f,essence_champi": "mix_a",
	"poudre_f,essence_champi,eau": "mix_b"
}


@export var crafted_item_scenes := {
	"mix_a": preload("res://Ingrédients/mix/mix_a.tscn"),
	"mix_b": preload("res://Ingrédients/mix/mix_b.tscn")
}

var inventory = []  # List to hold items
var max_ingredients = 3  # Maximum number of items the stand can hold

func _ready():
	modulate = Color(Color.LIGHT_BLUE, 0.5)

func _process(delta):
	if global.is_dragging:
		visible = true
	else:
		visible = false

func register_item(item):
	if item.name in accepted_items:
		if len(inventory) < max_ingredients:
			inventory.append(item.name)
			print("Item added:", item.name)
			check_crafting()  # Check if a recipe can be crafted
		else:
			print("Inventory full, cannot add:", item.name)
	else:
		print("Item not accepted:", item.name)

func check_crafting():
	var sorted_inventory = Array(inventory).duplicate()
	sorted_inventory.sort()
	var inventory_key = ",".join(sorted_inventory)  # Convert inventory list to a string key

	print("Checking recipes for:", inventory_key)  # Debugging print

	if recipes.has(inventory_key):
		var crafted_item = recipes[inventory_key]
		craft_item(crafted_item)
	else:
		print("No matching recipe found")



func craft_item(crafted_item_name):
	print("Crafted item:", crafted_item_name)  # Check if this is printed
	item_placed.emit(crafted_item_name)  # Emit the crafted item
	clear_inventory()

func clear_inventory():
	inventory.clear()
	print("Inventory cleared")
