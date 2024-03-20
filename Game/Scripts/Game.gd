# Class game engine, penyimpan semua fungsi game
extends Control


onready var shop = get_node("Shop") # Variabel penyimpan class Shop
var timerStartDayStart = false # Variabel penyimpan status 'TimerStartDay'
var timerTransactionStart = false # Variabel penyimpan status 'TimerTransaction'
var panelShopSettingsOpened = true # Variabel penyimpan status 'PanelShopSettings'

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$UI/LabelMoney.text = "Rp" + str(shop.getMoney()) # Menampilkan uang yang dimiliki pemain saat ini
	$UI/PanelShopSettings/LabelFoodPrice.text = "Rp" + str(shop.getFoodPrice()) # Menampilkan harga makanan saat ini
	$TimerTransaction.wait_time = 2 # Atur frekuensi transaksi yang terjadi

# Fungsi tombol 'ButtonStartDay' ketika di klik akan memulai timer 'TimerStartDay' dan 'TimerTransaction'
func _on_ButtonStartDay_pressed():
	# Jika tombol di klik, jalankan timer 'TimerStartDay' dan 'TimerTransaction'
	# lalu nonaktifkan tombol 'ButtonStartDay' dan 'ButtonShopSettings'
	if timerStartDayStart == false and timerTransactionStart == false:
		timerStartDayStart = true
		timerTransactionStart = true
		$TimerStartDay.start()
		$TimerTransaction.start()
		$UI/ButtonStartDay.disabled = true
		$UI/ButtonShopSettings.disabled = true

# Fungsi timer timeout 'TimerStartDay' ketika waktu selesai akan memberhentikan progres hari tersebut
func _on_TimerStartDay_timeout():
	# Ketika timer selesai, matikan timer 'TimerStartDay' dan 'TimerTransaction',
	# aktifkan tombol 'ButtonStartDay' dan 'ButtonShopSettings'
	if timerStartDayStart == true and timerTransactionStart == true:
		timerStartDayStart = false
		timerTransactionStart = false
		$TimerStartDay.stop()
		$TimerTransaction.stop()
		$UI/ButtonStartDay.disabled = false
		$UI/ButtonShopSettings.disabled = false

# Fungsi timer timeout 'TimerTransaction' untuk mengatur frekuensi banyaknya transaksi yang terjadi
# ketika 'ButtonStartDay' di klik dan 'TimerStartDay' berjalan
func _on_TimerTransaction_timeout():
	# Ketika timer selesai, akan menambahkan uang pemain
	shop.setMoney(shop.getMoney()+1)


# Fungsi pengatur panel PanelShopSettings
func _on_ButtonShopSettings_pressed():
	# Jika panel belum terbuka, ketika di klik akan membuka panel
	if panelShopSettingsOpened == false:
		$UI/PanelShopSettings/AnimationPlayer.play("Popup")
		panelShopSettingsOpened = true
	# Jika panel sudah terbuka, ketika di klik akan menutup panel
	else:
		$UI/PanelShopSettings/AnimationPlayer.play_backwards("Popup")
		panelShopSettingsOpened = false
