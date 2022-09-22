extends Area2D


# Movement
export var maxSpeed: float = 250.0;
export var moveAcc: float = 3.0; # Movement Acceleration
export var friction: float = 1.0;
var moveVelocity: Vector2 = Vector2.ZERO;
var particlesScene: PackedScene = preload("res://Assets/Scenes/Particles/PlayerParticles.tscn");

# Rotation Speed
export var preciseRotationSpeed: float = 100.0;
export var regularRotationSpeed: float = 200.0;
export var movingRotationSpeed: float = 300.0;

# Other
var trailColour: Color;


func _ready():
	var laserSight = get_node("LaserSight");
	laserSight.visible = PlayerSettings.config.get_value("Settings", "sightToggle", PlayerSettings.sightToggleDefault);
	laserSight.modulate = PlayerSettings.config.get_value("Settings", "sightColour", PlayerSettings.sightColourDefault);
	get_node("Gun").bulletColour = PlayerSettings.config.get_value("Settings", "bulletColour", PlayerSettings.bulletColourDefault);
	trailColour = PlayerSettings.config.get_value("Settings", "trailColour", PlayerSettings.trailColourDefault);


func _on_area_entered(area):
	if (!area.is_in_group("Asteroid")):
		return;
	
	PlayerSettings.playerHealth -= 1;
	AudioPlayer.play_audio_stream("PlayerHit");
	get_node("AnimationPlayer").play("Hit");


func _physics_process(delta):
	# Movement
	var inputMovement = Input.get_action_strength("game_forward") - Input.get_action_strength("game_backwards"); # Getting Input
	if (inputMovement == 0):
		moveVelocity -= Vector2(friction, 0); # Deceleration
	else:
		moveVelocity += Vector2(inputMovement * moveAcc, 0); # Accelerating
	moveVelocity.x = clamp(moveVelocity.x, 0, maxSpeed); # Clamping velocity
	
	if (inputMovement > 0):
		var particles = particlesScene.instance();
		particles.modulate = trailColour;
		particles.global_position = position;
		particles.global_rotation_degrees = rotation_degrees;
		get_tree().get_nodes_in_group("ParticleParent")[0].add_child(particles);
	
	position += moveVelocity.rotated(deg2rad(rotation_degrees)) * delta; # Rotating & Applying movement
	
	# Rotation
	var rotation = Input.get_action_strength("game_right") - Input.get_action_strength("game_left");
	
	var currentRotationSpeed: float;
	if (inputMovement <= 0):
		if (Input.is_action_pressed("game_precise")):
			currentRotationSpeed = preciseRotationSpeed;
		else:
			currentRotationSpeed = regularRotationSpeed;
	else:
		currentRotationSpeed = movingRotationSpeed; 
	
	rotation_degrees += rotation * currentRotationSpeed * delta;
	
	# Sound
	if (inputMovement > 0):
		AudioPlayer.play_audio_stream("Engine");
	else:
		AudioPlayer.stop_audio_stream("Engine");


