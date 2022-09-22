extends Label

func _process(_delta):
	text = "Health: " + str(PlayerSettings.playerHealth) + " ";
