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
			position = get_parent().to_local(get_global_mouse_position() - offset)

		elif Input.is_action_just_released("click"):
			global.is_dragging = false
			var tween = get_tree().create_tween()
			if is_inside_droppable:
				tween.tween_property(self, "position", get_parent().to_local(body_ref.global_position), 0.4).set_ease(Tween.EASE_OUT)
				if body_ref and body_ref.is_in_group("receiver_alambic"):  # Only accept certain groups
					body_ref.register_item(self)  # Notify the platform
					queue_free()  # Remove the item
			else:
				tween.tween_property(self, "position", get_parent().to_local(initialPos), 0.4).set_ease(Tween.EASE_OUT)

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
		body_ref = body
		
		# Set platform transparency (only for the ColorRect)
		var color_rect = body.find_child("ColorRect", true, false)  # Assuming ColorRect is here
		if color_rect:
			color_rect.modulate = Color(Color.MEDIUM_AQUAMARINE, 1.0)  # Full visibility for platform

		# Ensure the Label remains visible and fully opaque (black text)
		var label = body.find_child("TimerLabel", true, false)
		if label:
			label.self_modulate = Color(0, 0, 0, 1)  # Fully black and opaque
			label.visible = true  # Make sure it's visible

func _on_body_exited(body):
	if body.is_in_group("dropable"):
		is_inside_droppable = false
		body_ref = null

		# Set platform transparency again (only for the ColorRect)
		var color_rect = body.find_child("ColorRect", true, false)
		if color_rect:
			color_rect.modulate = Color(Color.MEDIUM_AQUAMARINE, 0.1)  # Semi-transparent

		# Keep the Label visible and unaffected
		var label = body.find_child("TimerLabel", true, false)
		if label:
			label.self_modulate = Color(0, 0, 0, 1)  # Keep it black and fully opaque
			label.visible = true  # Ensure it's visible
