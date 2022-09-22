extends Control


func _on_PlayButton_pressed():
	get_tree().paused = false;
	SceneChanger.change_scene("res://Assets/Scenes/Levels/MainGame.tscn");


func _on_OptionsButton_pressed():
	SceneChanger.change_scene("res://Assets/Scenes/Levels/Options.tscn");


func _on_HowToPlayButton_pressed():
	SceneChanger.change_scene("res://Assets/Scenes/Levels/HowToPlay.tscn");
	

func _on_CreditsButton_pressed():
	SceneChanger.change_scene("res://Assets/Scenes/Levels/Credits.tscn");


func _on_QuitButton_pressed():
	get_tree().quit();
