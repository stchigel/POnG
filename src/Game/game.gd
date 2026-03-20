extends Node2D

var EnemyScene = preload("res://src/OpponentPaddle/opponent_paddle.tscn")
var Player2Scene = preload("res://src/Player2Paddle/player_2_paddle.tscn")

var skins = [
	"res://assets/img/paddles/bluePaddle.png",
	"res://assets/img/paddles/bluePaddle.png",
	"res://assets/img/paddles/cyanPaddle.png",
	"res://assets/img/paddles/greenPaddle.png",
	"res://assets/img/paddles/lightgreenPaddle.png",
	"res://assets/img/paddles/redPaddle.png",
	"res://assets/img/paddles/violetPaddle.png"
]
var PScore = 0
var EScore = 0
var mode = false
var agua = false
var sonido = false
var colorLeft = 0
var colorRight = 0
var PTS = 0

func _ready():
	$PlayerPaddle.get_node("Sprite2D").texture = load(skins[colorLeft])
	if sonido:
		AudioServer.set_bus_mute(0, false)
	else:
		AudioServer.set_bus_mute(0, true)
	if mode:
		var enemy = EnemyScene.instantiate()
		enemy.position = Vector2(1056, 320)
		enemy.get_node("Sprite2D").texture = load(skins[colorRight])
		add_child(enemy)
	else:
		var player2 = Player2Scene.instantiate()
		player2.position = Vector2(1056, 320)
		player2.get_node("Sprite2D").texture = load(skins[colorRight])
		add_child(player2)
	if !agua:
		$Agua1.disable_mode=true
		$Agua2.disable_mode=true
		$Agua3.disable_mode=true

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
	if EScore==PTS or PScore==PTS: 
		var scene = load("res://src/Endgame/endgame.tscn").instantiate()
		scene.mode = mode
		scene.colorLeft = colorLeft
		scene.colorRight = colorRight
		scene.PScore = PScore
		scene.EScore = EScore
		scene.agua = agua
		scene.sonido = sonido
		scene.PTS = PTS
		get_tree().root.add_child(scene)
		get_tree().current_scene.queue_free()
		get_tree().current_scene = scene
	$Ball.position = Vector2(576, 320)
	get_tree().call_group("BallGroup", "stop_ball")
	$Timer.start()
	$PlayerPaddle.position.x = 96
	if mode:
		$OpponentPaddle.position.x = 1056
	else: 
		$Player2Paddle.position.x = 1056


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://src/Menu/menu.tscn")
