extends Node2D

export var playerStartingHealth: int = 5;


func _ready():
	PlayerSettings.playerHealth = playerStartingHealth;
	PlayerSettings.playerScore = 0;
