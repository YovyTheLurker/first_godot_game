extends CanvasLayer

signal start_game


func update_score(value):
	$MarginContainer/Scorelabel.text = str(value)

func update_timer(value):
	$MarginContainer/TimeLabel.text = str(value)
	
func show_message(text):
	$MessageLabel.text = text
	$MessageLabel.show()
	$MessageTimer.start()
	
func _on_MessageTimer_timeout():
	$MessageLabel.hide()

func _on_StartButton_pressed():
	$StartButton.hide()
	$MessageLabel.hide()
	emit_signal("start_game")
	
func show_game_over():
	show_message("Game Over")
	yield($MessageTimer, "timeout")
	$StartButton.show()
	$MessageLabel.text = "Coin Dash!"
	$MessageLabel.show()
	

func new_game():
	 playing = true    
	 level = 1    
	 score = 0    
	 time_left = playtime    
	 $Player.start($PlayerStart.position)    
	 $Player.show()    
	 $GameTimer.start()    
	 spawn_coins()
	 
 func _on_HUD_start_game():
	pass 
