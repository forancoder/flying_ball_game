extends Node2D

signal launch
@export var ball_scene : PackedScene 
@export var bomb_scene : PackedScene
@onready var timer: Timer = $Timer
var p_bomb = 0.5
var ball_scale = 0.05
var max_waittime = 0.3
var max_hspeed = 1200
var balls_nr: int =  0
var score: int = 0
@onready var game_over: CanvasLayer = $GameOver
var is_game_over = false



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	game_over.hide()
	#game_over.connect("restart", self, "_on_game_over_restart")

#func _input(event):
	#if event.is_action_pressed("move_left"):
		#$Container.constant_linear_velocity -= Vector2 (50,0)
	#elif event.is_action_pressed("move_right"):
		#$Container.constant_linear_velocity += Vector2 (50,0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#if is_game_over and Input.is_anything_pressed():
			#get_tree().reload_current_scene()


func _on_timer_timeout() -> void:
	#print ("sono passati " + str(timer.wait_time) + " secondi")
	#timer.wait_time += timer.wait_time
	timer.wait_time = randf()* max_waittime
	launch.emit()


func _on_launch() -> void:
	var ball
	if randf() > p_bomb:
		ball = ball_scene.instantiate()
	else:
		ball = bomb_scene.instantiate()
	ball.position = Vector2 (0,0)
	#ball.get_node("Sprite2D").scale = Vector2 (1,1)
	ball.modulate = Color(randf(),randf(),randf())
	ball.linear_velocity = Vector2(randf()*max_hspeed,-50)
	add_child(ball)
	balls_nr = balls_nr + 1 
	$BallsCounter.text = str(balls_nr) + " balls "




#func _on_resetter_body_entered(body: Node2D) -> void:
	#body.queue_free()





func _on_point_counter_body_entered(body: Node2D) -> void:
	if body.name == "Ball":
		score +=1
		$ScoreCounter.text = "Score: " + str(score)
	elif body.name == "Bomb":
		print("game over")
		#queue_free()
		end_game()
		
		
	body.queue_free()


func end_game():
	game_over.show()
	get_tree().paused = true
	await get_tree().create_timer(0.8).timeout
	is_game_over = true
	#get_tree().paused = true
	
func _on_game_over_restart():
	get_tree().reload_current_scene()
		
	
