extends Control


func _ready():
	get_node("%SightToggle").pressed = PlayerSettings.config.get_value("Settings", "sightToggle", PlayerSettings.sightToggleDefault);
	get_node("%SFXControl").set_toggle_value(PlayerSettings.config.get_value("Settings", "sfxToggle", PlayerSettings.sfxToggleDefault));
	get_node("%SFXControl").set_slider_value(PlayerSettings.config.get_value("Settings", "sfxVolume", PlayerSettings.sfxVolumeDefault));
	get_node("%MusicControl").set_toggle_value(PlayerSettings.config.get_value("Settings", "musicToggle", PlayerSettings.musicToggleDefault));
	get_node("%MusicControl").set_slider_value(PlayerSettings.config.get_value("Settings", "musicVolume", PlayerSettings.musicVolumeDefault));
	
	get_node("%CooldownToggle").pressed = PlayerSettings.config.get_value("Settings", "cooldownToggle", PlayerSettings.cooldownToggleDefault);
	get_node("%TimerToggle").pressed = PlayerSettings.config.get_value("Settings", "timerToggle", PlayerSettings.timerToggleDefault);
	get_node("%DifficultyToggle").pressed = PlayerSettings.config.get_value("Settings", "difficultyToggle", PlayerSettings.difficultyToggleDefault);
	
	get_node("%BulletColour").set_colour(PlayerSettings.config.get_value("Settings", "bulletColour", PlayerSettings.bulletColourDefault));
	get_node("%SightColour").set_colour(PlayerSettings.config.get_value("Settings", "sightColour", PlayerSettings.sightColourDefault));
	get_node("%TrailColour").set_colour(PlayerSettings.config.get_value("Settings", "trailColour", PlayerSettings.trailColourDefault));


func _on_value_toggled(button_pressed: bool, valueName: String):
	PlayerSettings.config.set_value("Settings", valueName, button_pressed);
	PlayerSettings.save_settings();
	

func _on_SFX_toggled(button_pressed):
	AudioServer.set_bus_mute(AudioServer.get_bus_index("SFX"), !button_pressed);
	PlayerSettings.config.set_value("Settings", "sfxToggle", button_pressed);
	PlayerSettings.save_settings();


func _on_Music_toggled(button_pressed):
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Music"), !button_pressed);
	PlayerSettings.config.set_value("Settings", "musicToggle", button_pressed);
	PlayerSettings.save_settings();


func _on_BulletColour_changed(colour):
	PlayerSettings.config.set_value("Settings", "bulletColour", colour);
	PlayerSettings.save_settings();


func _on_SightColour_changed(colour):
	PlayerSettings.config.set_value("Settings", "sightColour", colour);
	PlayerSettings.save_settings();


func _on_TrailColour_changed(colour):
	PlayerSettings.config.set_value("Settings", "trailColour", colour);
	PlayerSettings.save_settings();


func _on_ResetHighScore_pressed():
	get_node("ResetCheckPanel/AnimationPlayer").play("On");


func _on_ResetHighScoreConfirm():
	PlayerSettings.config.set_value("HighScore", "value", 0);
	PlayerSettings.save_settings();
	get_node("ResetCheckPanel/AnimationPlayer").play("Off");
