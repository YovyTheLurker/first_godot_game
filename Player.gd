extends Area2D

signal pickup
signal hurt


export (int) var speed
var velocity = Vector2()
var screensize = Vector2(480, 720)
var playing = false
var level = 1
var time_left = playtime
var playtime = 30
var Coin =  "res://Coin.tscn"
var score

func get_input():
	velocity = Vector2()
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed

func spawn_coins():
	for i in range(4 + level):
		var c = Coin.instance()
		$CoinContainer.add_child(c)
		c.screensize = screensize
		c.position = Vector2(rand_range(0, screensize.x), 
		rand_range(0, screensize.y))
		
func _process(delta):
	if playing and $CoinContainer.get_child_count() == 0:
		level += 1
		time_left += 5
		spawn_coins()
	get_input()
	
	position += velocity * delta
	position.x = clamp(position.x, 0, screensize.x)
	position.y = clamp(position.y, 0, screensize.y)
	
	if velocity.length() > 0:
		$AnimatedSprite.animation = "run"
		$AnimatedSprite.flip_h = velocity.x < 0
	else:
		$AnimatedSprite.animation = "idle"
	
	

func start(pos):
	set_process(true)
	position = pos
	$AnimatedSprite.animation = "idle"
	
func die():
	$AnimatedSprite.animation = "hurt"
	set_process(false)
	

func _on_Player_area_entered( area ):
	if area.is_in_group("coins"):
		area.pickup()
		emit_signal("pickup")
	if area.is_in_group("obstacle"):
		emit_signal("hurt")
		die()


func _on_Player_pickup():
	score += 1
	$HUD.update_score(score)

func _on_Player_hurt():
	game_over()
	
func game_over():
	playing = false
	$GameTimer.stop()
	for Coin in $CoinContainer.get_children():
		Coin.queue_free()
	$HUD.show_game_over()
	$Player.die()
