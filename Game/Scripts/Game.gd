extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var money = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$LabelMoney.text = str(money)


# Fungsi tombol 'ButtonTambah' ketika di klik akan menambah nilai 'money'
func _on_ButtonTambah_pressed():
	money += 1
