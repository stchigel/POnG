extends Node2D

var EnemyScene = preload("res://src/OpponentPaddle/opponent_paddle.tscn")
var Player2Scene = preload("res://src/Player2Paddle/player_2_paddle.tscn")

var PScore = 0
var EScore = 0
var Mode = true
# true es VS IA, false es 1v1 local

func _ready():
	if Mode:
		var enemy = EnemyScene.instantiate()
		enemy.position = Vector2(1056, 320)
		add_child(enemy)
	else:
		var player2 = Player2Scene.instantiate()
		player2.position = Vector2(1056, 320)
		add_child(player2)

func _on_player_goal_body_entered(body: Node2D) -> void:
	EScore += 1
	scored()
	$RightScore.play()

func _on_enemy_goal_body_entered(body: Node2D) -> void:
	PScore += 1
	scored()
	$LeftScore.play()

func _process(delta):
	$PScore.text = str(PScore)
	$EScore.text = str(EScore)

func _on_timer_timeout() -> void:
	get_tree().call_group("BallGroup", "restart_ball")
	
func scored():
	$Ball.position = Vector2(576, 320)
	get_tree().call_group("BallGroup", "stop_ball")
	$Timer.start()
	$PlayerPaddle.position.x = 96
	if Mode:
		$OpponentPaddle.position.x = 1056
	else: 
		$Player2Paddle.position.x = 1056
