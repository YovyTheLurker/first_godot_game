extends CanvasLayer

signal start_game

var score
var playing
var level
var time_left
var playtime
var Coin
var screensize
var position

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
	
func spawn_coins():
	for i in range(4 + level):
		var c = Coin.instance()
		$CoinContainer.add_child(c)
		c.screensize = screensize
		c.position = Vector2(rand_range(0, screensize.x), 
		rand_range(0, screensize.y))

func start(pos):
	set_process(true)
	position = pos
	$AnimatedSprite.animation = "idle"

func new_game():
	 playing = true    
	 level = 1    
	 score = 0    
	 time_left = playtime    
	 $Player.start($PlayerStart.position)    
	 $Player.show()    
	 $GameTimer.start()    
	 spawn_coins()