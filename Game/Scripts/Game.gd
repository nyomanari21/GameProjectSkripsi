# Class game engine, penyimpan semua fungsi game
extends Control


@onready var shop = get_node("Shop") # Variabel penyimpan class Shop
var timerStartDayStart = false # Variabel penyimpan status 'TimerStartDay'
var timerTransactionStart = false # Variabel penyimpan status 'TimerTransaction'
var timerTransactionBaseTime = 2 # Variabel penyimpan frekuensi dasar transaksi
var timerTransactionNewTime = 0 # Variabel penyimpan frekuensi baru transaksi
var panelShopSettingsOpened = true # Variabel penyimpan status 'PanelShopSettings'
var foodStockIncrease = 0 # Variabel penyimpan jumlah penambahan stok makanan
var foodStockTotalPrice = 0 # Variabel penyimpan total harga stok makanan
var season = "Kemarau" # Variabel penyimpan musim dalam permainan (kemarau dan penghujan)
var seasonCycle = 2 # Variabel penyimpan siklus musim

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$UI/LabelSeason.text = "Musim " + season
	$UI/LabelMoney.text = "Rp" + str(shop.getMoney()) # Menampilkan uang yang dimiliki pemain saat ini
	$UI/PanelShopSettings/LabelFoodPrice.text = "Rp" + str(shop.getFoodPrice()) # Menampilkan harga makanan saat ini
	$UI/PanelShopSettings/LabelLevelProduct.text = "Level " + str(shop.getLevelProduct()) # Menampilkan level kualitas makanan
	$UI/PanelShopSettings/LabelLevelPromotion.text = "Level " + str(shop.getLevelPromotion()) # Menampilkan level promosi
	$UI/PanelShopSettings/LabelLevelPlacement.text = "Level " + str(shop.getLevelPlacement()) # Menampilkan level distribusi
	$UI/PanelShopSettings/LabelFoodStock.text = str(shop.getFoodStock()) # Menampilkan stok makanan
	$UI/PanelShopSettings/LabelFoodStockIncrease.text = "Tambah " + str(foodStockIncrease) # Menampilkan 
	$UI/PanelShopSettings/LabelFoodStockTotalPrice.text = "Rp" + str(foodStockTotalPrice)
	
	# Proses pengaturan frekuensi terjadinya transaksi
	timerTransactionNewTime = timerTransactionBaseTime - (0.1 * shop.getLevelProduct()) - (0.1 * shop.getLevelPromotion()) - (0.1 * shop.getLevelPlacement())
	timerTransactionNewTime = timerTransactionNewTime + (((shop.getFoodPrice() - shop.getFoodStockPrice()) / 50) * 0.1)
	
	# Jika memasuki musim kemarau, frekuensi terjadinya transaksi dikali 0.8 (dipercepat)
	if season == "Kemarau":
		$TimerTransaction.wait_time = timerTransactionNewTime * 0.8 # Atur frekuensi transaksi yang terjadi
	else:
		$TimerTransaction.wait_time = timerTransactionNewTime # Atur frekuensi transaksi yang terjadi
	
	# Nonaktifkan tombol 'ButtonStartDay' jika stok makanan masih kosong atau harga makanan masih 0
	# atau hari sudah mulai
	if shop.getFoodStock() == 0 || shop.getFoodPrice() == 0 || timerStartDayStart == true:
		$UI/ButtonStartDay.disabled = true
	else:
		$UI/ButtonStartDay.disabled = false
	
	# Nonaktifkan tombol 'ButtonFoodStockPurchase' jika tidak ada stok yang dibeli
	# dan uang pemain tidak cukup
	if foodStockIncrease == 0 || shop.getMoney() < foodStockTotalPrice:
		$UI/PanelShopSettings/ButtonFoodStockPurchase.disabled = true
	else:
		$UI/PanelShopSettings/ButtonFoodStockPurchase.disabled = false

# Fungsi perhitungan biaya peningkatan level pada toko
func _setNewlevelUpgradePrice(level, price):
	var newPrice = price + (1000 * level)
	shop.setLevelProductUpgradePrice(newPrice)

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
		
		# Tutup panel 'PanelShopSettings'
		$UI/PanelShopSettings/AnimationPlayer.play_backwards("Popup")
		print($TimerTransaction.wait_time)

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
		$UI/PanelShopSettings/AnimationPlayer.play("Popup")
		
		# Update siklus musim
		seasonCycle -= 1
		
		# Ganti musim jika siklus sudah habis
		if seasonCycle == 0:
			seasonCycle = 2
			if season == "Kemarau":
				season = "Penghujan"
			else:
				season = "Kemarau"

# Fungsi timer timeout 'TimerTransaction' untuk mengatur frekuensi banyaknya transaksi yang terjadi
# ketika 'ButtonStartDay' di klik dan 'TimerStartDay' berjalan
func _on_TimerTransaction_timeout():
	# Ketika timer selesai, akan menambahkan uang pemain jika stok makanan masih tersedia
	# dan mengurangi stok makanan
	if shop.getFoodStock() > 0:
		shop.setMoney(shop.getMoney() + shop.getFoodPrice())
		shop.setFoodStock(shop.getFoodStock() - 1)

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
	# Jika tombol di klik dan uang pemain mencukupi
	if shop.getMoney() >= shop.getLevelProductUpgradePrice():
		# Kurangi uang pemain
		shop.setMoney(shop.getMoney() - shop.getLevelProductUpgradePrice())
		
		# naikkan level kualitas makanan sebesar 1
		shop.setLevelProduct(shop.getLevelProduct() + 1)
		_setNewlevelUpgradePrice(shop.getLevelProduct(), shop.getLevelProductUpgradePrice())

# Fungsi meningkatkan level promosi
func _on_buttonLevelPromotionUpgrade_pressed():
	# Jika tombol di klik dan uang pemain mencukupi
	if shop.getMoney() >= shop.getLevelPromotionUpgradePrice():
		# Kurangi uang pemain
		shop.setMoney(shop.getMoney() - shop.getLevelPromotionUpgradePrice())
		
		# naikkan level promosi sebesar 1
		shop.setLevelPromotion(shop.getLevelPromotion() + 1)
		_setNewlevelUpgradePrice(shop.getLevelPromotion(), shop.getLevelPromotionUpgradePrice())

# Fungsi meningkatkan level distribusi
func _on_buttonLevelPlacementUpgrade_pressed():
	# Jika tombol di klik dan uang pemain mencukupi
	if shop.getMoney() >= shop.getLevelPlacementUpgradePrice():
		# Kurangi uang pemain
		shop.setMoney(shop.getMoney() - shop.getLevelPlacementUpgradePrice())
		
		# naikkan level promosi sebesar 1
		shop.setLevelPlacement(shop.getLevelPlacement() + 1)
		_setNewlevelUpgradePrice(shop.getLevelPlacement(), shop.getLevelPlacementUpgradePrice())

# Fungsi penaik jumlah stok makanan yang ingin ditambah
func _on_buttonFoodStockPlus_pressed():
	# Jika tombol di klik, naikkan penambah stok makanan sebesar 1
	# dan update total harga pembelian stok makanan
	foodStockIncrease += 1
	foodStockTotalPrice = shop.getFoodStockPrice() * foodStockIncrease

# Fungsi penurun jumlah stok makanan yang ingin ditambah
func _on_buttonFoodStockMinus_pressed():
	# Jika tombol di klik dan penambah stok makanan tidak 0, naikkan penambah stok makanan sebesar 1
	# (penambah stok makanan tidak akan bernilai negatif) dan update total harga pembelian stok makanan
	if foodStockIncrease != 0:
		foodStockIncrease -= 1
		foodStockTotalPrice = shop.getFoodStockPrice() * foodStockIncrease
	
	# Nonaktifkan tombol buttonFoodStockPurchase ketika uang pemain tidak cukup
	if shop.getMoney() < foodStockTotalPrice:
		$UI/PanelShopSettings/ButtonFoodStockPurchase.disabled = true
	else:
		$UI/PanelShopSettings/ButtonFoodStockPurchase.disabled = false

# Fungsi membeli stok makanan
func _on_buttonFoodStockPurchase_pressed():
	# Jika penambah stok makanan tidak 0, tambah stok makanan, kurangi uang pemain
	# lalu reset penambah stok makanan dan total harga pembelian stok makanan menjadi 0
	if foodStockIncrease != 0 && shop.getMoney() >= foodStockTotalPrice:
		shop.setFoodStock(shop.getFoodStock() + foodStockIncrease)
		shop.setMoney(shop.getMoney() - foodStockTotalPrice)
		foodStockIncrease = 0
		foodStockTotalPrice = 0
