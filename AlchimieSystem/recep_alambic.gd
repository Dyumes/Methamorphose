extends StaticBody2D

signal item_placed(item_type)  # Signal to notify other nodes

@export var name_transformations = {
	"mix_a": "Potion de soin",
	"mix_b": "Potion au pif"
}

var accepted_items = ["mix_a", "mix_b"]  # List of items the receiver accepts
var processing_timer  # Timer for processing delay
@onready var timer_label = $TimerLabel  # Reference to the label
var is_brewing = false  # Track brewing status

func _ready():
	modulate = Color(Color.MEDIUM_AQUAMARINE, 0.3)
	# Create and configure a timer
	processing_timer = Timer.new()
	processing_timer.wait_time = 10.0  # 10 seconds
	processing_timer.one_shot = true  # Runs once per item
	processing_timer.timeout.connect(_on_timer_timeout)
	add_child(processing_timer)

	# Set label properties
	timer_label.visible = false
	timer_label.modulate.a = 1.0
	timer_label.add_theme_color_override("font_color", Color.BLACK)  # Ensure the text is black

func _process(delta):
	# Update the timer's visibility and text
	if is_brewing:
		timer_label.visible = true
		timer_label.text = "Temps restant: %.1f sec" % processing_timer.time_left
		timer_label.modulate.a = 1.0  # Ensure text stays fully opaque
	else:
		timer_label.visible = false  # Hide when brewing is done

	# Keep platform visible during brewing or dragging
	visible = global.is_dragging or is_brewing

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
			print("Starting brewing process for:", transformed_name)
			processing_timer.set_meta("transformed_item", transformed_name)
			processing_timer.start()
			is_brewing = true  # Brewing starts
			
			# Show and reset the label
			timer_label.visible = true
			timer_label.text = "Temps restant: 10.0 sec"
		else:
			print("Error: No transformation found for", item.name)
	else:
		print("Error: Item not accepted by this receiver")

# Function triggered when the timer finishes
func _on_timer_timeout():
	var transformed_item = processing_timer.get_meta("transformed_item", null)
	if transformed_item:
		print("Brewing complete, emitting:", transformed_item)
		item_placed.emit(transformed_item)
	else:
		print("Error: No item stored in timer metadata")

	# Hide label and reset brewing state when done
	is_brewing = false
	timer_label.visible = false
