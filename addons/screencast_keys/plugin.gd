tool
extends EditorPlugin


func _enter_tree() -> void:
	var type := "ScreencastKeys"
	var base := "Label"
	var script := load("res://addons/screencast_keys/ScreencastKeys.gd")
	var icon := load("res://addons/screencast_keys/ScreencastKeys.svg")

	add_custom_type(type, base, script, icon)


func _exit_tree() -> void:
	pass
