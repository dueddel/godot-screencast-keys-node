extends Label


enum Appearance {AT_THE_TOP, AT_THE_BOTTOM}
export(Appearance) var new_keys_appear setget _set_new_keys_appear


func _set_new_keys_appear(value: int) -> void:
	new_keys_appear = value
	update_valign()


func _ready() -> void:
	update_valign()


func update_valign():
	valign = VALIGN_TOP if new_keys_appear == Appearance.AT_THE_TOP else VALIGN_BOTTOM


func _unhandled_key_input(key: InputEventKey) -> void:
	if key and key.pressed:
		add_key_event(key)


func add_key_event(key: InputEventKey) -> void:
	match(new_keys_appear):

		# previously pressed keys rise up
		Appearance.AT_THE_BOTTOM:
			trim_from_top()
			append_at_bottom(key.scancode)

		# previously pressed keys fall down
		Appearance.AT_THE_TOP:
			trim_from_bottom()
			prepend_at_top(key.scancode)


func trim_from_top() -> void:
	while max_lines_visible > 0 and get_line_count() >= max_lines_visible:
		text = text.substr(text.find("\n") + 1)


func trim_from_bottom() -> void:
	while max_lines_visible > 0 and get_line_count() >= max_lines_visible:
		text = text.substr(0, text.find_last("\n"))


func append_at_bottom(key_scancode: int) -> void:
	text += "\n" + OS.get_scancode_string(key_scancode)


func prepend_at_top(key_scancode: int) -> void:
	text = OS.get_scancode_string(key_scancode) + "\n" + text
