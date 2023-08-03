extends Node


export (PackedScene) var mob_scene


func _ready() -> void:
	randomize()

	$UserInterface/Retry.hide()


func _unhandled_input(event):
	if event.is_action_pressed("ui_accept") and $UserInterface/Retry.visible:
		# This restarts the current scene.
		get_tree().reload_current_scene()


	if event.is_action_pressed("exit")  and $UserInterface/Retry.visible:
		get_tree().change_scene("res://lobby/lobby.tscn")


func _on_MobTimer_timeout() -> void:
	# Create a new instance of the Mob scene.
	var mob: KinematicBody = mob_scene.instance()

	# Choose a random location on the SpawnPath.
	# We store the reference to the SpawnLocation node.
	var mob_spawn_location: PathFollow = get_node("SpawnPath/SpawnLocation")
	# And give it a random offset.
	mob_spawn_location.unit_offset = randf()

	var player_position: Vector3 = $Player.transform.origin
	mob.initialize(mob_spawn_location.translation, player_position)

	add_child(mob)

	# We connect the mob to the score label to update the score upon squashing one.
	mob.connect("squashed", $UserInterface/ScoreLabel, "_on_Mob_squashed")


func _on_Player_hit() -> void:
	$MobTimer.stop()

	$UserInterface/Retry.show()