extends HBoxContainer


func _on_SFXSlider_value_changed(value: float):
	PlayerSettings.sfxVolume = value;


func _on_MusicSlider_value_changed(value: float):
	PlayerSettings.musicVolume = value;


func _on_SFXToggle_toggled(button_pressed):
	PlayerSettings.sfxToggle = button_pressed;


func _on_MusicToggle_toggled(button_pressed):
	PlayerSettings.musicToggle = button_pressed;


func set_toggle_value(value: bool):
	get_node("Toggle").pressed = value;


func set_slider_value(value: float):
	get_node("Slider").value = value;
