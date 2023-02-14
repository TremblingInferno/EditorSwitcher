extends TextureButton

signal activated(is_activated)

var activated_texture
var deactivated_texture

var is_activated:= false

func _init(_deactivated_texture, _activated_texture, should_activate):
	activated_texture = _activated_texture
	deactivated_texture = _deactivated_texture
	texture_normal = deactivated_texture
	hint_tooltip = "Activates the external Editor"
	if should_activate:
		texture_normal = activated_texture
		is_activated = true
	connect("pressed", self, "activated")
	


func activated():
	if is_activated:
		texture_normal = deactivated_texture
		is_activated = false
		hint_tooltip = "Activates the external Editor"
	else:
		texture_normal = activated_texture
		is_activated = true
		hint_tooltip = "Deactivates the external Editor"
	emit_signal("activated", is_activated)
