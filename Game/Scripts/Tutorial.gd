extends Control


var tutorialNumber = 1 # Penyimpan nomor step tutorial

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_next_pressed():
	$PopSfx.play()
	tutorialNumber += 1
	
	if tutorialNumber == 2:
		$PanelTutorial/ControlTutorial1.visible = false
		$PanelTutorial/ControlTutorial2.visible = true
	elif tutorialNumber == 3:
		$PanelTutorial/ControlTutorial2.visible = false
		$PanelTutorial/ControlTutorial3.visible = true
	elif tutorialNumber == 4:
		$PanelTutorial/ControlTutorial3.visible = false
		$PanelTutorial/ControlTutorial4.visible = true
		
		$PanelTutorial/ButtonNext.text = "Tutup"
	elif tutorialNumber == 5:
		get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")


func _on_button_prev_pressed():
	$PopSfx.play()
	tutorialNumber -= 1
	if tutorialNumber == 3:
		$PanelTutorial/ControlTutorial4.visible = false
		$PanelTutorial/ControlTutorial3.visible = true
		
		$PanelTutorial/ButtonNext.text = "Selanjutnya"
	elif tutorialNumber == 2:
		$PanelTutorial/ControlTutorial3.visible = false
		$PanelTutorial/ControlTutorial2.visible = true
	elif tutorialNumber == 1:
		$PanelTutorial/ControlTutorial2.visible = false
		$PanelTutorial/ControlTutorial1.visible = true
	elif tutorialNumber == 0:
		get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")
