extends Control


signal puzzle_response(response)


func _unhandled_input(event):
	if event.is_action_pressed("ui_accept"):
		# Puzzle completed
		emit_signal("puzzle_response", true)

#	if event.is_action_pressed("exit"):
#		# Puzzle canceled
#		emit_signal("puzzle_response", false)


func _on_Close_pressed() -> void:
	emit_signal("puzzle_response", false)
