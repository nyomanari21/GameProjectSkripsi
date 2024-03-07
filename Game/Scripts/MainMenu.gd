extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Fungsi tombol 'ButtonPlay' untuk pindah ke scene utama permainan
func _on_ButtonPlay_pressed():
	get_tree().change_scene("res://Scenes/Game.tscn")
