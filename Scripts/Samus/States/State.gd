extends Node

class_name State

signal finished(next_state_name)


# Initialize the state. E.g. change the animation
func enter() -> void:
	return


# Clean up the state. Reinitialize values like a timer
func exit() -> void:
	return


func handle_input(event: InputEvent) -> void:
	return


func update(delta: float) -> void:
	return
