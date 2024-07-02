extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$PanelPauseMenu/AnimationPlayerPanelPauseMenu.stop()
	$".".top_level = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _resume():
	get_tree().paused = false
	$PanelPauseMenu/AnimationPlayerPanelPauseMenu.play_backwards("Popup")
	$".".top_level = false

func _pause():
	get_tree().paused = true
	$PanelPauseMenu/AnimationPlayerPanelPauseMenu.play("Popup")
	$".".top_level = true

# Fungsi untuk pause game dan membuka panel "PanelPauseMenu"
func _on_button_pause_menu_pressed():
	if !get_tree().paused:
		_pause()
	elif get_tree().paused:
		_resume()

# Fungsi untuk melanjutkan game
func _on_button_resume_pressed():
	_resume()

# Fungsi untuk kembali ke halaman utama
func _on_button_to_main_menu_pressed():
	_resume()
	get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")
