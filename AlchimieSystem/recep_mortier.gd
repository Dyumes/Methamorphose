extends StaticBody2D

signal item_placed(item_type)  # Signal to notify other nodes

# Map accepted names to the names the spawner should accept
@export var name_transformations = {
	"fée": "poudre_f",
	"os": "poudre_os",
	"champignons": "essence_champi"
}

var accepted_items = ["fée", "os", "champignons"]  # List of items the receiver accepts

func _ready():
	modulate = Color(Color.MEDIUM_AQUAMARINE, 0.1)

func _process(delta):
	if global.is_dragging:
		visible = true
	else:
		visible = false

# Function to transform item name for the spawner
func transform_item_name(item_name):
	if item_name in name_transformations:
		return name_transformations[item_name]
	return null  # Return null if no transformation exists

# Function to register the item when placed
func register_item(item):
	if item.name in accepted_items:
		print("Item absorbed:", item.name)
		var transformed_name = transform_item_name(item.name)
		if transformed_name:
			print("Transformed name for spawner:", transformed_name)
			item_placed.emit(transformed_name)  # Emit the transformed name
		else:
			print("Error: No transformation found for", item.name)
	else:
		print("Error: Item not accepted by this receiver")
