extends Control
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
var agua = false
var sonido = false
var mode = false # true cuando es PvIA
var colorLeft = 0
var colorRight = 0
var PTS = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if PScore>EScore:
		$PlayerWin.texture = load(skins[colorLeft])
		$PlayerLoose.texture = load(skins[colorRight])
		if mode: $Label.text = "¡Gano el jugador!"
		else: $Label.text = "¡Gano el jugador 1!"
	else:
		$PlayerWin.texture = load(skins[colorRight])
		$PlayerLoose.texture = load(skins[colorLeft])
		if mode: $Label.text = "¡Gano la máquina!"
		else: $Label.text = "¡Gano el jugador 2!"


func _on_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://src/Menu/menu.tscn")


func _on_revancha_pressed() -> void:
	var scene = load("res://src/Game/game.tscn").instantiate()
	scene.mode = mode
	scene.agua = agua
	scene.sonido = sonido
	scene.colorLeft = colorLeft
	scene.colorRight = colorRight
	scene.PTS = PTS
	get_tree().root.add_child(scene)
	get_tree().current_scene.queue_free()
	get_tree().current_scene = scene
