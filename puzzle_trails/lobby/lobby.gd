extends Node


onready var puzzle_handler: Control = $"%PuzzleHandler"


func _ready() -> void:
	puzzle_handler.connect("puzzle_finished", self, "_on_PuzzleHandler_puzzle_finished")


func _on_Door_player_entered() -> void:
	puzzle_handler.init_puzzle("res://puzzle_handler/puzzles/connection/connection.tscn")


func _on_PuzzleHandler_puzzle_finished(result: bool) -> void:
	if result:
		print("Puzzle was completed!")
		get_tree().change_scene("res://game/game.tscn")

	else:
		print("Puzzle was canceled!")
