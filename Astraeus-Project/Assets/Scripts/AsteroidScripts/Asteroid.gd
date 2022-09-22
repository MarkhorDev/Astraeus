extends Node2D


# General
var isSetup: bool = false;
var asteroidType: String;
var asteroidScene: PackedScene = load("res://Assets/Scenes/Objects/Asteroid.tscn");
var particlesScene: PackedScene = preload("res://Assets/Scenes/Particles/AsteroidParticles.tscn");

# Score
export var largeAsteroidScore: int = 10;
export var smallAsteroidScore: int = 5;

# Movement Vars
export var moveSpeedRange: Vector2;
export var moveDirectionOffsetRange: Vector2;
export var rotationSpeedRange: Vector2;

var moveSpeed: float;
var moveDirection: Vector2;
var rotationSpeed: float;


func _physics_process(delta):
	if (isSetup):
		position += moveDirection * moveSpeed * delta;
		rotation_degrees += rotationSpeed * delta;


func _on_VisibilityBox_viewport_exited(_viewport):
	queue_free();
	

func _on_LargeAsteroid_area_entered(area):		
	if (area.is_in_group("Bullet")):
		PlayerSettings.playerScore += largeAsteroidScore;
		area.queue_free();
	elif (area.is_in_group("Player")):
		if (area.monitoring == false):
			return;
		elif (PlayerSettings.playerHealth <= 0):
			return;
	else:
		return;
	
	for _x in range(0, 2):
		get_parent().spawn_asteroid(position, false, true);
	
	AudioPlayer.play_audio_stream("LargeAsteroidBreak");
	
	spawn_asteroid_particles();
	queue_free();


func _on_SmallAsteroid_area_entered(area):
	if (area.is_in_group("Bullet")):
		PlayerSettings.playerScore += smallAsteroidScore;
		area.queue_free();
	elif (area.is_in_group("Player")):
		if (area.monitoring == false):
			return;
		elif (PlayerSettings.playerHealth <= 0):
			return;
	else:
		return;
		
	AudioPlayer.play_audio_stream("SmallAsteroidBreak");
	spawn_asteroid_particles();
	queue_free();


func spawn_asteroid_particles():
	# Start Particles
	var particlesNode = particlesScene.instance();
	particlesNode.position = global_position;
	get_tree().get_nodes_in_group("ParticleParent")[0].add_child(particlesNode);
	

func setup(largeChance: float, moveTowardsCenter: bool = true):
	var random = RandomNumberGenerator.new();
	random.randomize();
	
	# Large/Small Decider
	var sizeGen = random.randf();
	if (sizeGen >= largeChance):
		asteroidType = "SmallAsteroid";
		get_node("LargeAsteroid").queue_free(); # Deleting unused node
	else:
		asteroidType = "LargeAsteroid";
		get_node("SmallAsteroid").queue_free(); # Deleting unused node
	
	# Animation
	var sprite = get_node(asteroidType).get_node("Sprite");
	sprite.frame = random.randi_range(0, sprite.frames.get_frame_count("default"));
	
	# Movement
	if (moveTowardsCenter):
		var quadrant := -position;
		moveDirection = quadrant;
		moveDirection.x += random.randf_range(moveDirectionOffsetRange.x, moveDirectionOffsetRange.y);
		moveDirection.y += random.randf_range(moveDirectionOffsetRange.x, moveDirectionOffsetRange.y);
		moveDirection = moveDirection.normalized();
	else:
		moveDirection.x = random.randf_range(-1.0, 1.0);
		moveDirection.y  = random.randf_range(-1.0, 1.0);
		moveDirection = moveDirection.normalized();
	
	moveSpeed = random.randf_range(moveSpeedRange.x, moveSpeedRange.y);
	
	# Rotation
	rotationSpeed = random.randf_range(rotationSpeedRange.x, rotationSpeedRange.y);
	
	isSetup = true;
