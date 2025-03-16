extends Node2D

var draggable = false
var is_inside_droppable = false
var body_ref
var offset: Vector2
var initialPos: Vector2

func _process(delta):
	if draggable:
		if Input.is_action_just_pressed("click"):
			initialPos = global_position
			offset = get_global_mouse_position() - global_position
			global.is_dragging = true
			var draggable = false

		if Input.is_action_pressed("click"):
			# Use to_local to ensure correct positioning
			position = get_parent().to_local(get_global_mouse_position() - offset)

		elif Input.is_action_just_released("click"):
			global.is_dragging = false
			var tween = get_tree().create_tween()
			if is_inside_droppable:
				tween.tween_property(self, "position", get_parent().to_local(body_ref.global_position), 0.2).set_ease(Tween.EASE_OUT)
				if body_ref and body_ref.is_in_group("client"):  # Only accept certain groups
					body_ref.register_item(self)  # Notify the platform
					queue_free()  # Remove the item
			else:
				tween.tween_property(self, "position", get_parent().to_local(initialPos), 0.2).set_ease(Tween.EASE_OUT)

func _on_mouse_entered():
	if not global.is_dragging:
		draggable = true
		scale = Vector2(1.05, 1.05)

func _on_mouse_exited():
	if not global.is_dragging:
		draggable = false
		scale = Vector2(1, 1)

func _on_body_entered(body: StaticBody2D):
	if body.is_in_group("dropable"):
		is_inside_droppable = true
		body.modulate = Color(Color.MEDIUM_AQUAMARINE, 1.0)
		body_ref = body

func _on_body_exited(body):
	if body.is_in_group("dropable"):
		is_inside_droppable = false
		body.modulate = Color(Color.MEDIUM_AQUAMARINE, 0.1)
		body_ref = null
