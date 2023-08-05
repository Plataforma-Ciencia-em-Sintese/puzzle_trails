extends Line2D


const _START: int = 1
const _END: int = 0


func change_start(position: Vector2) -> void:
	set_point_position(_START, position)


func change_end(position: Vector2) -> void:
	set_point_position(_START, position)
