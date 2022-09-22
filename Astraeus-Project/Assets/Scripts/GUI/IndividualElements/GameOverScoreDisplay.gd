extends Control


func setup():
	var playerHighScore: int = PlayerSettings.config.get_value("HighScore", "value", 0);
	var playerScore: int = PlayerSettings.playerScore;
	get_node("Score").text = "score:" + str(playerScore); # Score Setting
	
	# High Score Notification
	var highScoreAnim = get_node("NewHighScore/AnimationPlayer");
	if (playerScore > playerHighScore):
		highScoreAnim.play("blink");
		
		playerHighScore = playerScore
		PlayerSettings.config.set_value("HighScore", "value", playerHighScore);
		PlayerSettings.save_settings();
	else:
		highScoreAnim.play("off");
		
	get_node("HighScore").text = "high score:" + str(playerHighScore); # High Score Setting
	
	get_node("DifficultyContainer/ProgressBar").value = PlayerSettings.difficultyValue; # Difficulty setting
	get_node("Time").text = "time: " + PlayerSettings.gameTime;
	
