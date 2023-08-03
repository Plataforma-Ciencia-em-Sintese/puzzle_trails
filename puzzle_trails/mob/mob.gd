extends KinematicBody


# Emitted when the player jumped on the mob.
signal squashed


# Minimum speed of the mob in meters per second.
export var min_speed: float = 10.0
# Maximum speed of the mob in meters per second.
export var max_speed: float = 18.0


var velocity: Vector3 = Vector3.ZERO


func _ready() -> void:
	pass


func _physics_process(_delta):
	# warning-ignore:return_value_discarded
	move_and_slide(velocity)


# We will call this function from the Main scene.
func initialize(start_position, player_position):
	# We position the mob and turn it so that it looks at the player.
	look_at_from_position(start_position, player_position, Vector3.UP)
	# And rotate it randomly so it doesn't move exactly toward the player.
	rotate_y(rand_range(-PI / 4, PI / 4))

	# We calculate a random speed.
	var random_speed: float = rand_range(min_speed, max_speed)
	# We calculate a forward velocity that represents the speed.
	velocity = Vector3.FORWARD * random_speed
	# We then rotate the vector based on the mob's Y rotation to move in the direction it's looking.
	velocity = velocity.rotated(Vector3.UP, rotation.y)


func squash():
	emit_signal("squashed")
	queue_free()


func _on_VisibilityNotifier_screen_exited() -> void:
	queue_free()
