extends Label


enum Appearance {AT_THE_TOP, AT_THE_BOTTOM, AT_THE_LEFT, AT_THE_RIGHT}
export(Appearance) var new_keys_appear: int setget _set_new_keys_appear

enum Scancode {NORMAL, NORMAL_WITH_MODIFIERS, PHYSICAL, PHYSICAL_WITH_MODIFIERS}
export(Scancode) var scancode_mode: int

var pressed_keys := PoolStringArray()
var last_key_scancode: int
var last_key_scancode_count: int


func _set_new_keys_appear(value: int) -> void:
	new_keys_appear = value
	update_alignment()


func _ready() -> void:
	update_alignment()


func update_alignment():
	align = ALIGN_RIGHT if new_keys_appear == Appearance.AT_THE_RIGHT else ALIGN_LEFT
	valign = VALIGN_BOTTOM if new_keys_appear == Appearance.AT_THE_BOTTOM else VALIGN_TOP

	if max_lines_visible == 1:
		align = ALIGN_CENTER
		valign = VALIGN_CENTER


func _input(event: InputEvent) -> void:
	var key = event as InputEventKey

	if key and key.pressed:
		add_key_event(key)


func add_key_event(key: InputEventKey) -> void:
	var key_scancode := get_key_scancode(key)

	# update/reset counter for pressed key
	if last_key_scancode == key_scancode:
		last_key_scancode_count += 1
	else:
		last_key_scancode_count = 1

	if new_keys_appear == Appearance.AT_THE_TOP or new_keys_appear == Appearance.AT_THE_LEFT:
		# previously pressed keys fall down respectively go to the right
		# and disappear at the bottom or at the right side
		trim_from_end()
		prepend_at_start(key_scancode)
	else:
		# previously pressed keys rise up respectivly go to the left
		# and disappear at the top or at the left side
		trim_from_start()
		append_at_end(key_scancode)

	if new_keys_appear == Appearance.AT_THE_TOP or new_keys_appear == Appearance.AT_THE_BOTTOM:
		# pressed keys are stacked
		text = pressed_keys.join("\n")
	else:
		# pressed keys are lined up
		text = pressed_keys.join(" ")

	# keep pressed key in mind
	last_key_scancode = key_scancode


func get_key_scancode(key: InputEventKey) -> int:
	match scancode_mode:
		Scancode.NORMAL:
			return key.scancode
		Scancode.NORMAL_WITH_MODIFIERS:
			return key.get_scancode_with_modifiers()
		Scancode.PHYSICAL:
			return key.physical_scancode
		Scancode.PHYSICAL_WITH_MODIFIERS:
			return key.get_physical_scancode_with_modifiers()

	push_error("Invalid scancode_mode %s" % scancode_mode)
	return 0


func trim_from_start() -> void:
	pressed_keys.invert()
	trim_from_end()
	pressed_keys.invert()


func trim_from_end() -> void:
	while \
		max_lines_visible > 0 and \
		pressed_keys.size() >= max_lines_visible and \
		not last_key_scancode_count > 1:

		pressed_keys.remove(pressed_keys.size() - 1)


func append_at_end(key_scancode: int) -> void:
	var pressed_key := OS.get_scancode_string(key_scancode)

	if last_key_scancode_count > 1:
		pressed_keys.remove(pressed_keys.size() - 1)
		pressed_key += " x%s" % last_key_scancode_count

	pressed_keys.push_back(pressed_key)


func prepend_at_start(key_scancode: int) -> void:
	pressed_keys.invert()
	append_at_end(key_scancode)
	pressed_keys.invert()
