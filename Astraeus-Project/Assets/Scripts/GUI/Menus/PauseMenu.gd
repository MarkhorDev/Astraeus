extends Control


onready var animator: AnimationPlayer = get_node("AnimationPlayer");
var internallyPaused: bool = false;


func _ready():
	get_node("HighScoreLabel").text = "high score:" + str(PlayerSettings.config.get_value("HighScore", "value", 0));


func _physics_process(_delta):
	if (Input.is_action_just_pressed("game_exit")):
		var tree = get_tree();
	
		if (tree.paused == false):
			internallyPaused = true;
			animator.play("FadeIn");
			tree.get_nodes_in_group("AudioTheme")[0].get_node("AnimationPlayer").play("Pause");
			
			tree.paused = internallyPaused;
		elif (internallyPaused == true):
			internallyPaused = false;
			animator.play("FadeOut");
			tree.get_nodes_in_group("AudioTheme")[0].get_node("AnimationPlayer").play("Unpause");
		
			tree.paused = internallyPaused;


func _on_ResumeButton_pressed():
	get_tree().paused = false;
	animator.play("FadeOut");


func _on_MenuButton_pressed():
	SceneChanger.change_scene("res://Assets/Scenes/Levels/Menu.tscn");


func _on_QuitButton_pressed():
	get_tree().quit();
