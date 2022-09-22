extends Node


func _ready():
	AudioServer.set_bus_mute(AudioServer.get_bus_index("SFX"), !PlayerSettings.config.get_value("Settings", "sfxToggle", PlayerSettings.sfxToggleDefault));
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), PlayerSettings.config.get_value("Settings", "sfxVolume", PlayerSettings.sfxVolumeDefault));
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Music"), !PlayerSettings.config.get_value("Settings", "musicToggle", PlayerSettings.musicToggleDefault));
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), PlayerSettings.config.get_value("Settings", "musicVolume", PlayerSettings.musicVolumeDefault));


func play_audio_stream(nodeName: String):
	for audioNode in get_tree().get_nodes_in_group("AudioStream"):
		if (audioNode.name == nodeName and audioNode.playing == false):
			audioNode.playing = true;
			

func stop_audio_stream(nodeName: String):
	for audioNode in get_tree().get_nodes_in_group("AudioStream"):
		if (audioNode.name == nodeName):
			audioNode.playing = false;
