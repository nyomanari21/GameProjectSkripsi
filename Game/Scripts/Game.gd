extends Control


var money = 0 # Variabel penyimpan jumlah uang
var timerStart = false # Variabel penyimpan status timer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$LabelMoney.text = "Rp" + str(money)

# Fungsi tombol 'ButtonStartDay' ketika di klik akan memulai timer 'TimerStartDay'
func _on_ButtonStartDay_pressed():
	# Jika tombol di klik, jalankan timer dan nonaktifkan tombol 'ButtonStartDay'
	if timerStart == false:
		timerStart = true
		$TimerStartDay.start()
		$ButtonStartDay.disabled = true

# Fungsi timer timeout 'TimerStartDay' ketika waktu selesai akan menambahkan uang
func _on_TimerStartDay_timeout():
	# Ketika timer selesai, matikan timer, aktifkan tombol 'ButtonStartDay', dan tambah uang sebanyak 1
	if timerStart == true:
		timerStart = false
		$TimerStartDay.stop()
		$ButtonStartDay.disabled = false
		money += 1
