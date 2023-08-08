extends KinematicBody


signal hit


# How fast the player moves in meters per second.
export var speed: float = 14.0
# The downward acceleration when in the air, in meters per second squared.
export var fall_acceleration: float = 75.0
export var jump_impulse: float = 20.0
export var bounce_impulse: float = 16.0


var velocity: Vector3 = Vector3.ZERO


func _ready() -> void:
	pass


func _physics_process(delta) -> void:
	movement(delta)
	squash_mobs()


func movement(delta: float) -> void:
	# We create a local variable to store the input direction.
	var direction: Vector3 = Vector3.ZERO

	# We check for each move input and update the direction accordingly.
	if Input.is_action_pressed("move_right"):
		direction.x += 1
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
	if Input.is_action_pressed("move_back"):
		# Notice how we are working with the vector's x and z axes.
		# In 3D, the XZ plane is the ground plane.
		direction.z += 1
	if Input.is_action_pressed("move_forward"):
		direction.z -= 1

	if is_on_floor() and Input.is_action_just_pressed("jump"):
		velocity.y += jump_impulse

	if direction != Vector3.ZERO:
		direction = direction.normalized()
		$Pivot.look_at(translation + direction, Vector3.UP)

	# Ground velocity
	velocity.x = direction.x * speed
	velocity.z = direction.z * speed
	# Vertical velocity
	velocity.y -= fall_acceleration * delta
	# Moving the character
	velocity = move_and_slide(velocity, Vector3.UP)


func squash_mobs() -> void:
	for index in range(get_slide_count()):
		# We check every collision that occurred this frame.
		var collision = get_slide_collision(index)
		# If we collide with a monster...
		if collision.collider.is_in_group("mob"):
			var mob = collision.collider
			# ...we check that we are hitting it from above.
			if Vector3.UP.dot(collision.normal) > 0.1:
				# If so, we squash it and bounce.
				mob.squash()
				velocity.y = bounce_impulse


# And this function at the bottom.
func die() -> void:
	emit_signal("hit")
	queue_free()


func _on_MobDetector_body_entered(body: Node) -> void:
	die()
