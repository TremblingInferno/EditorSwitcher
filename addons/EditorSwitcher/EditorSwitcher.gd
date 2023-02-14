tool
extends EditorPlugin


var panel1
var SwitchEditorButton = preload("EditorButton.gd")

func _enter_tree():
	var editor_node = get_tree().get_root().get_child(0)
	var gui_base = editor_node.get_gui_base()
	var icon = preload("icon.png")
	var icon_activated = gui_base.get_icon("ScriptCreateDialog", "EditorIcons") #ToolConnect
	var icon_unactivated = gui_base.get_icon("ScriptExtend", "EditorIcons")
	
	panel1 = _add_toolbar_button("_switch_pressed", icon_unactivated, icon_activated)


func _switch_pressed(is_activated:bool):
	if is_activated:
		get_editor_interface().get_editor_settings().set_setting("text_editor/external/use_external_editor", true)
		print("hello")
	else:
		get_editor_interface().get_editor_settings().set_setting("text_editor/external/use_external_editor", false)
		print("woah")
	get_editor_interface().edit_script(
		get_editor_interface().get_script_editor().get_current_script())
	

func _exit_tree():
	_remove_panels()

func _remove_panels():
	if panel1:
		remove_control_from_container(CONTAINER_TOOLBAR, panel1)
		panel1.free()


func _add_toolbar_button(action:String, icon_deactivated, icon_activated):
	var panel = PanelContainer.new()
	var is_activated = get_editor_interface().get_editor_settings().get_setting("text_editor/external/use_external_editor")
	var b = SwitchEditorButton.new(icon_deactivated, icon_activated, is_activated);
	b.connect("activated", self, action)
	panel.add_child(b)
	add_control_to_container(CONTAINER_TOOLBAR, panel)
	return panel
	
