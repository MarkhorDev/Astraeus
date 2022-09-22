tool
extends HBoxContainer


signal toggled(button_pressed);


export var text: String;
export var pressed: bool setget setter_pressed;


func setter_pressed(value: bool):
	pressed = value;
	get_node("Button").pressed = value;


func _process(_delta):
	get_node("Label").text = text;


func _on_Button_toggled(button_pressed):
	if (!Engine.editor_hint):
		emit_signal("toggled", button_pressed);
