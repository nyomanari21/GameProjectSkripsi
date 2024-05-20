# Class main menu
extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Fungsi tombol 'ButtonPlay' untuk pindah ke scene utama permainan
func _on_ButtonPlay_pressed():
	$ButtonPopSfx.play()

func _on_button_pop_sfx_finished():
	get_tree().change_scene_to_file("res://Scenes/Game.tscn")
