extends Node

# Settings
var config: ConfigFile;

var playerHealth: int setget setter_playerHealth;
var playerScore: int;
var sfxToggle: bool setget setter_sfxToggle;
var sfxVolume: float setget setter_sfxVolume;
var musicToggle: bool setget setter_musicToggle;
var musicVolume: float setget setter_musicVolume;
var difficultyValue: float;
var gameTime: String;


var sightToggleDefault: bool = true;
var sfxToggleDefault: bool = true;
var sfxVolumeDefault: float = -10.0;
var musicToggleDefault: bool = true;
var musicVolumeDefault: float = 0;
var cooldownToggleDefault: bool = true;
var timerToggleDefault: bool = true;
var difficultyToggleDefault: bool = true;
var bulletColourDefault: Color = Color.greenyellow;
var sightColourDefault: Color = Color.red;
var trailColourDefault: Color = Color.orange;


func _ready():
	config = ConfigFile.new();
	var err = config.load("user://playerSettings.cfg");
	if (err != OK or !config.has_section("HighScore") or !config.has_section("Settings")):
		config.set_value("HighScore", "value", 0);
		config.set_value("Settings", "sightToggle", sightToggleDefault);
		config.set_value("Settings", "sfxToggle", sfxToggleDefault);
		config.set_value("Settings", "sfxVolume", sfxVolumeDefault);
		config.set_value("Settings", "musicToggle", musicToggleDefault);
		config.set_value("Settings", "musicVolume", musicVolumeDefault);
		config.set_value("Settings", "cooldownToggle", cooldownToggleDefault);
		config.set_value("Settings", "timerToggle", timerToggleDefault);
		config.set_value("Settings", "difficultyToggle", difficultyToggleDefault);
		config.set_value("Settings", "bulletColour", bulletColourDefault);
		config.set_value("Settings", "sightColour", sightColourDefault);
		config.set_value("Settings", "trailColour", trailColourDefault);
		save_settings();


func setter_playerHealth(value: int):
	playerHealth = value;
	if (playerHealth <= 0):
		trigger_game_over();


func setter_sfxToggle(value: bool):
	sfxToggle = value;
	config.set_value("Settings", "sfxToggle", value);
	AudioServer.set_bus_mute(AudioServer.get_bus_index("SFX"), !value);

	save_settings();


func setter_sfxVolume(value: float):
	sfxVolume = value;
	config.set_value("Settings", "sfxVolume", value);
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), value);
	
	save_settings();
	

func setter_musicToggle(value: bool):
	musicToggle = value;
	config.set_value("Settings", "musicToggle", value);
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Music"), !value);
	
	save_settings();


func setter_musicVolume(value: float):
	musicVolume = value;
	config.set_value("Settings", "musicVolume", value);
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), value);
	
	save_settings();


func trigger_game_over():
	var tree = get_tree();
	tree.paused = true;
	AudioPlayer.stop_audio_stream("AudioTheme");
	AudioPlayer.play_audio_stream("PlayerDeath");
	
	yield(tree.create_timer(1.5), "timeout");
	
	tree.get_nodes_in_group("GameUI")[0].get_node("AnimationPlayer").play("FadeOut");
	tree.get_nodes_in_group("GameOverAnimator")[0].play("FadeIn");
	tree.get_nodes_in_group("GameOverScoreDisplay")[0].setup();
	AudioPlayer.play_audio_stream("GameOver");


func save_settings():
	if (config == null):
		return;
	
# warning-ignore:return_value_discarded
	config.save("user://playerSettings.cfg");
