extends Control
var configPressed = false
var credPressed = false

func _ready() -> void:
	pass 

func loadGame(mode):
	var scene = load("res://src/Game/game.tscn").instantiate()
	scene.mode = mode
	scene.agua = $"Config-panel/AguaCheck".button_pressed
	scene.sonido = $"Config-panel/SonidoCheck".button_pressed
	scene.colorLeft = $"Config-panel/ColorLeft".selected
	scene.colorRight = $"Config-panel/ColorRight".selected
	scene.PTS = $"Config-panel/SpinBox".value
	get_tree().root.add_child(scene)
	get_tree().current_scene.queue_free()
	get_tree().current_scene = scene

func _on_pv_m_pressed() -> void:
	loadGame(true)

func _on_pv_p_pressed() -> void:
	loadGame(false)

func _on_config_pressed() -> void:
	if configPressed:
		$"Config-panel".visible = false
		configPressed = false
	else:
		$"Config-panel".visible = true
		configPressed = true

func _on_creditos_pressed() -> void:
	if credPressed:
		$"Cred-panel".visible = false
		credPressed = false
	else:
		$"Cred-panel".visible = true
		credPressed = true
