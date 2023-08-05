extends Panel


func drop_data(position: Vector2, data) -> void:
	print(position, ", ", data)


func can_drop_data(_position: Vector2, _data) -> bool:
	return true
