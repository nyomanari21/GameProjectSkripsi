extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


# Fungsi tombol 'ButtonPlay' untuk pindah ke scene utama permainan
func _on_ButtonPlay_pressed():
	get_tree().change_scene("res://Scenes/Game.tscn")