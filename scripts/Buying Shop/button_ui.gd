extends Button

@onready var book = $"../../BookUI"
@onready var buttonOpen = $"../../ButtonOpening"
@onready var buttonClose = $"../../ButtonClosing"
@onready var background = $"../../Grey_background"

var book_open = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	background.hide()
	book.hide()
	buttonClose.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func show_receipt() -> void:
	background.show()
	buttonOpen.hide()
	buttonClose.show()
	book.show()
	print("show receipt")
	


func _receipt_pressed() -> void:
	show_receipt()


func _receipt_close() -> void:
	background.hide()
	buttonOpen.show()
	buttonClose.hide()
	book.hide()
	print("hide receipt")
