extends Control


func _on_RestartButton_pressed():
	SceneChanger.change_scene("res://Assets/Scenes/Levels/MainGame.tscn");


func _on_MenuButton_pressed():
	SceneChanger.change_scene("res://Assets/Scenes/Levels/Menu.tscn");


func _on_QuitButton_pressed():
	get_tree().quit();
