# Class game engine, penyimpan semua fungsi game
extends Control


@onready var shop = get_node("Shop") # Variabel penyimpan class Shop
var timerStartDayStart = false # Variabel penyimpan status 'TimerStartDay'
var timerTransactionStart = false # Variabel penyimpan status 'TimerTransaction'
var panelShopSettingsOpened = true # Variabel penyimpan status 'PanelShopSettings'
var foodStockIncrease = 0 # Variabel penyimpan jumlah penambahan stok makanan

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$UI/LabelMoney.text = "Rp" + str(shop.getMoney()) # Menampilkan uang yang dimiliki pemain saat ini
	$UI/PanelShopSettings/LabelFoodPrice.text = "Rp" + str(shop.getFoodPrice()) # Menampilkan harga makanan saat ini
	$UI/PanelShopSettings/LabelLevelProduct.text = "Level " + str(shop.getLevelProduct()) # Menampilkan level kualitas makanan
	$UI/PanelShopSettings/LabelLevelPromotion.text = "Level " + str(shop.getLevelPromotion()) # Menampilkan level promosi
	$UI/PanelShopSettings/LabelLevelPlacement.text = "Level " + str(shop.getLevelPlacement()) # Menampilkan level distribusi
	$UI/PanelShopSettings/LabelFoodStock.text = str(shop.getFoodStock()) # Menampilkan stok makanan
	$UI/PanelShopSettings/LabelFoodStockIncrease.text = "Tambah " + str(foodStockIncrease)
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
		
		# Jika panel 'PanelShopSettings' masih terbuka, panel akan ditutup
		if panelShopSettingsOpened == true:
			$UI/PanelShopSettings/AnimationPlayer.play_backwards("Popup")
			panelShopSettingsOpened = false

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
	shop.setMoney(shop.getMoney() + shop.getFoodPrice())

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

# Fungsi penaik harga makanan
func _on_ButtonFoodPricePlus_pressed():
	# Jika tombol di klik, naikkan harga makanan sebesar 500
	shop.setFoodPrice(shop.getFoodPrice() + 50)

# Fungsi penurun harga makanan
func _on_ButtonFoodPriceMin_pressed():
	# Jika tombol di klik dan harga makanan tidak 0, naikkan harga makanan sebesar 500
	# (harga makanan tidak akan bernilai negatif)
	if shop.getFoodPrice() != 0:
		shop.setFoodPrice(shop.getFoodPrice() - 50)

# Fungsi meningkatkan level kualitas makanan
func _on_buttonLevelProductUpgrade_pressed():
	# Jika tombol di klik, naikkan level kualitas makanan sebesar 1
	shop.setLevelProduct(shop.getLevelProduct() + 1)

# Fungsi meningkatkan level promosi
func _on_buttonLevelPromotionUpgrade_pressed():
	# Jika tombol di klik, naikkan level promosi sebesar 1
	shop.setLevelPromotion(shop.getLevelPromotion() + 1)

# Fungsi meningkatkan level distribusi
func _on_buttonLevelPlacementUpgrade_pressed():
	# Jika tombol di klik, naikkan level distribusi sebesar 1
	shop.setLevelPlacement(shop.getLevelPlacement() + 1)

# Fungsi penaik jumlah stok makanan yang ingin ditambah
func _on_buttonFoodStockPlus_pressed():
	# Jika tombol di klik, naikkan penambah stok makanan sebesar 1
	foodStockIncrease += 1

# Fungsi penurun jumlah stok makanan yang ingin ditambah
func _on_buttonFoodStockMinus_pressed():
	# Jika tombol di klik dan penambah stok makanan tidak 0, naikkan penambah stok makanan sebesar 1
	# (penambah stok makanan tidak akan bernilai negatif)
	if foodStockIncrease != 0:
		foodStockIncrease -= 1

# Fungsi membeli stok makanan
func _on_buttonFoodStockPurchase_pressed():
	# Jika penambah stok makanan tidak 0, tambah stok makanan
	# lalu reset penambah stok makanan menjadi 0
	if foodStockIncrease != 0:
		shop.setFoodStock(shop.getFoodStock() + foodStockIncrease)
		foodStockIncrease = 0
