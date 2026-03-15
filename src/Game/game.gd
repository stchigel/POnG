extends Node2D

var PScore = 0
var EScore = 0

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
	$TimerLabel.text = str(round($Timer.time_left * 10.0) / 10.0)

func _on_timer_timeout() -> void:
	get_tree().call_group("BallGroup", "restart_ball")
	$TimerLabel.visible = false
	
func scored():
	$Ball.position = Vector2(576, 320)
	get_tree().call_group("BallGroup", "stop_ball")
	$Timer.start()
	$TimerLabel.visible = true
	$PlayerPaddle.position.x = 96
	$OpponentPaddle.position.x = 1056
