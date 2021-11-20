extends Label


enum Appearance {AT_THE_TOP, AT_THE_BOTTOM}
export(Appearance) var new_keys_appear: int setget _set_new_keys_appear


var pressed_keys := PoolStringArray()
var last_key_scancode: int
var last_key_scancode_count: int


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
	var key_scancode := key.scancode

	# update/reset counter for pressed key
	if last_key_scancode == key_scancode:
		last_key_scancode_count += 1
	else:
		last_key_scancode_count = 1

	match(new_keys_appear):

		# previously pressed keys rise up
		Appearance.AT_THE_BOTTOM:
			trim_from_top()
			append_at_bottom(key_scancode)

		# previously pressed keys fall down
		Appearance.AT_THE_TOP:
			trim_from_bottom()
			prepend_at_top(key_scancode)

	text = pressed_keys.join("\n")

	# keep pressed key in mind
	last_key_scancode = key_scancode


func trim_from_top() -> void:
	pressed_keys.invert()
	trim_from_bottom()
	pressed_keys.invert()


func trim_from_bottom() -> void:
	while \
		max_lines_visible > 0 and \
		pressed_keys.size() >= max_lines_visible and \
		not last_key_scancode_count > 1:

		pressed_keys.remove(pressed_keys.size() - 1)


func append_at_bottom(key_scancode: int) -> void:
	var scancode_string := OS.get_scancode_string(key_scancode)

	if last_key_scancode_count > 1:
		pressed_keys.remove(pressed_keys.size() - 1)
		scancode_string += " x%s" % last_key_scancode_count

	pressed_keys.push_back(scancode_string)


func prepend_at_top(key_scancode: int) -> void:
	pressed_keys.invert()
	append_at_bottom(key_scancode)
	pressed_keys.invert()
