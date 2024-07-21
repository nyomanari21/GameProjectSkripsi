# Class main menu
extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Fungsi tombol 'ButtonPlay' untuk pindah ke scene utama permainan
func _on_ButtonPlay_pressed():
	$ButtonPopSfx.play()
	_playGame()

func _playGame():
	get_tree().change_scene_to_file("res://Scenes/Game.tscn")

# Fungsi tombol 'ButtonExit' untuk keluar dari game
func _on_buttonExit_pressed():
	$ButtonPopSfx.play()
	get_tree().quit()

# Fungsi tomboo 'ButtonCredits' untuk menampilkan credits
func _on_buttonCredits_pressed():
	$ButtonPopSfx.play()

# Fungsi untuk loop audio 'MainMusic'
func _on_mainMusic_finished():
	$MainMusic.play()
