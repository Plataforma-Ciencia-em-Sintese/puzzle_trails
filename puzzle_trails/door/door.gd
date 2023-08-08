extends StaticBody


signal player_entered


func _ready() -> void:
	pass


func _on_Area_body_entered(body: Node) -> void:
	emit_signal("player_entered")
