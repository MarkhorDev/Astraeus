extends Node2D


# General Vars
var asteroidScene: PackedScene = preload("res://Assets/Scenes/Objects/Asteroid.tscn");
export var spawnBoundaries: Vector2;
export var defaultSizeChance: float;

# Timer Vars
var timer: Timer;
export var startingInterval: float;
export var minimumInterval: float;
export var rateOfChange: float;
var currentInterval: float;


func _ready():
	timer = get_node("Timer");
	currentInterval = startingInterval;
	timer.wait_time = currentInterval;
	PlayerSettings.difficultyValue = 0;
	timer.start();


func _process(delta):
	if (currentInterval >= minimumInterval):
		currentInterval -= rateOfChange * delta;
		timer.wait_time = max(currentInterval, minimumInterval);
		PlayerSettings.difficultyValue = (startingInterval - currentInterval) / max(startingInterval - minimumInterval, 1) * 100;


func _on_Timer_timeout():
	spawn_asteroid();


func spawn_asteroid(asteroidSpawnPos: Vector2 = Vector2.ZERO, moveTowardsCenter: bool = true, isSmall: bool = false):
	var random := RandomNumberGenerator.new();
	random.randomize();
	
	# Position
	if (asteroidSpawnPos == Vector2.ZERO):
		var spawnCode = random.randi_range(0, 3);
		match spawnCode:
			0:
				asteroidSpawnPos = Vector2(spawnBoundaries.x, random.randf_range(-spawnBoundaries.y, spawnBoundaries.y));
			1:
				asteroidSpawnPos = Vector2(-spawnBoundaries.x, random.randf_range(-spawnBoundaries.y, spawnBoundaries.y));
			2:
				asteroidSpawnPos = Vector2(random.randf_range(-spawnBoundaries.x, spawnBoundaries.x), spawnBoundaries.y);
			3:
				asteroidSpawnPos = Vector2(random.randf_range(-spawnBoundaries.x, spawnBoundaries.x), -spawnBoundaries.y);
	
	var asteroid = asteroidScene.instance();
	asteroid.global_position = asteroidSpawnPos;
	
	var sizeChance = defaultSizeChance;
	if (isSmall):
		sizeChance = 0.0;
	asteroid.setup(sizeChance, moveTowardsCenter);
	
	call_deferred("add_child", asteroid, true);
