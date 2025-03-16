extends Button

@export var names = "Item name"
@export var price = 0
@export var quantity_in_store = 0


@onready var labelPrice = $"../Price"
@onready var labelQuantity = $"../Quantity"
@onready var labelName = $"../Name"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	labelName.text = names
	labelQuantity.text = "Quantité: %d" % quantity_in_store
	labelPrice.text = "Prix: %d" % price

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func recharge() -> void:	
	quantity_in_store += 1
	print(str(names) + "+1")
	labelQuantity.text = "Quantité: %d" % quantity_in_store

func update_value_label() -> void:
	
	if quantity_in_store == 1:
		labelPrice.text = "Prix: -"
		labelQuantity.text = "Plus de " + str(names)
	else:
		quantity_in_store -= 1
		labelQuantity.text = "Quantité: %d" % quantity_in_store
	
	

func _on_pressed() -> void:
	print("names : " + str(names) + "- price: " + str(price) + " - quantity: " + str(quantity_in_store))
	update_value_label()
