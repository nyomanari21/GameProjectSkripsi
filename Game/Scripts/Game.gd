extends Node


onready var shop = get_node("Shop") # Variabel penyimpan class Shop
var timerStartDayStart = false # Variabel penyimpan status 'TimerStartDay'
var timerTransactionStart = false # Variabel penyimpan status 'TimerTransaction'

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$UI/LabelMoney.text = "Rp" + str(shop.get_money()) # Menampilkan uang yang dimiliki pemain saat ini
	$TimerTransaction.wait_time = 2 # Atur frekuensi transaksi yang terjadi

# Fungsi tombol 'ButtonStartDay' ketika di klik akan memulai timer 'TimerStartDay' dan 'TimerTransaction'
func _on_ButtonStartDay_pressed():
	# Jika tombol di klik, jalankan timer 'TimerStartDay' dan 'TimerTransaction'
	# lalu nonaktifkan tombol 'ButtonStartDay'
	if timerStartDayStart == false and timerTransactionStart == false:
		timerStartDayStart = true
		timerTransactionStart = true
		$TimerStartDay.start()
		$TimerTransaction.start()
		$UI/ButtonStartDay.disabled = true

# Fungsi timer timeout 'TimerStartDay' ketika waktu selesai akan memberhentikan progres hari tersebut
func _on_TimerStartDay_timeout():
	# Ketika timer selesai, matikan timer 'TimerStartDay' dan 'TimerTransaction', aktifkan tombol 'ButtonStartDay'
	if timerStartDayStart == true and timerTransactionStart == true:
		timerStartDayStart = false
		timerTransactionStart = false
		$TimerStartDay.stop()
		$TimerTransaction.stop()
		$UI/ButtonStartDay.disabled = false

# Fungsi timer timeout 'TimerTransaction' untuk mengatur frekuensi banyaknya transaksi yang terjadi
# ketika 'ButtonStartDay' di klik dan 'TimerStartDay' berjalan
func _on_TimerTransaction_timeout():
	# Ketika timer selesai, akan menambahkan uang pemain
	shop.set_money(shop.get_money()+1)
