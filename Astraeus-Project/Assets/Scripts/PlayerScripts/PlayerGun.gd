extends Node2D


var bulletScene: PackedScene = preload("res://Assets/Scenes/Objects/Bullet.tscn");
var bulletColour: Color;
export var fireRate: float = 0.25;
var fireCooldown: float = 0.0;

export var cooldownDisplayOffset: Vector2;


func _physics_process(delta):
	player_gun(delta);
	cooldown_display();


func player_gun(delta):
	rotation_degrees = 0;
	if (Input.is_action_pressed("game_fire") && fireCooldown <= 0.0):
		var bullet = bulletScene.instance();
		get_tree().get_nodes_in_group("BulletParent")[0].add_child(bullet, true);
		bullet.modulate = bulletColour;
		bullet.position = global_position;
		bullet.rotation_degrees = global_rotation_degrees;
		
		AudioPlayer.play_audio_stream("Laser");
		fireCooldown = fireRate;
	
	fireCooldown = max(0, fireCooldown - delta);
	

func cooldown_display():
	if (!PlayerSettings.config.get_value("Settings", "cooldownToggle", PlayerSettings.cooldownToggleDefault)):
		return;
		
	var line = get_tree().get_nodes_in_group("GunCooldownDisplay")[0];
	line.position = get_parent().position + cooldownDisplayOffset;
	line.percent = (fireCooldown/fireRate) * 100;
