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
var dailyFee = 0 # Variabel penyimpan biaya harian untuk memulai berjualan
var placeChanged = true # Variabel penanda perubahan tempat berjualan

# Called when the node enters the scene tree for the first time.
func _ready():
	$UI/PanelShopSettings/AnimationPlayerPanelShopSettings.play("Popup")
	$UI/LabelMoneyChanged.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$UI/LabelSeason.text = "Musim " + season
	$UI/LabelMoney.text = "Rp" + str(shop.getMoney()) # Menampilkan uang yang dimiliki pemain saat ini
	$UI/PanelShopSettings/LabelFoodPrice.text = "Rp" + str(shop.getFoodPrice()) # Menampilkan harga makanan saat ini
	$UI/PanelShopSettings/LabelLevelProduct.text = "Level " + str(shop.getLevelProduct()) # Menampilkan level kualitas makanan
	$UI/PanelShopSettings/LabelPromotionBudget.text = "Rp" + str(shop.getPromotionBudget()) # Menampilkan biaya promosi
	$UI/PanelShopSettings/LabelFoodStock.text = str(shop.getFoodStock()) # Menampilkan stok makanan
	$UI/PanelShopSettings/LabelFoodStockIncrease.text = "Tambah " + str(foodStockIncrease) # Menampilkan jumlah stok makanan yang ingin ditambah
	$UI/PanelShopSettings/LabelFoodStockTotalPrice.text = "Rp" + str(foodStockTotalPrice) # Menampilkan biaya untuk membeli stok makanan
	$UI/PanelShopSettings/LabelDailyFee.text = "Rp" + str(dailyFee) # Menampilkan biaya harian untuk memulai berjualan
	$UI/PanelShopSettings/LabelLevelProductUpgradePrice.text = "Rp" + str(shop.getLevelProductUpgradePrice())
	
	# Proses penentuan tempat berjualan
	if placeChanged == true:
		# Lalu tandai bahwa tempat telah diganti
		placeChanged = false
		if shop.getPlace() == 1:
			$UI/PanelShopSettings/LabelPlace.text = "Taman" # Menampilkan tempat berjualan
			$UI/CenterContainerBackground/TextureRectBackground.texture = ResourceLoader.load("res://Assets/Images/Coffee stall - Park.png")
			$UI/CenterContainerBackground/BackgroundRain.stream = ResourceLoader.load("res://Assets/Videos/Coffee stall - Park rain.ogv")
		elif shop.getPlace() == 2:
			$UI/PanelShopSettings/LabelPlace.text = "Kampus" # Menampilkan tempat berjualan
			$UI/CenterContainerBackground/TextureRectBackground.texture = ResourceLoader.load("res://Assets/Images/Coffee stall - Campus.png")
			$UI/CenterContainerBackground/BackgroundRain.stream = ResourceLoader.load("res://Assets/Videos/Coffee stall - Campus rain.ogv")
		elif shop.getPlace() == 3:
			$UI/PanelShopSettings/LabelPlace.text = "Pusat Kota" # Menampilkan tempat berjualan
			$UI/CenterContainerBackground/TextureRectBackground.texture = ResourceLoader.load("res://Assets/Images/Coffee stall - Downtown.png")
			$UI/CenterContainerBackground/BackgroundRain.stream = ResourceLoader.load("res://Assets/Videos/Coffee stall - Downtown rain.ogv")
			
		# Cek apakah musim kemarau atau penghujan untuk penentuan background
		if season == "Kemarau":
			$UI/CenterContainerBackground/TextureRectBackground.visible = true
			$UI/CenterContainerBackground/BackgroundRain.stop()
		else:
			$UI/CenterContainerBackground/TextureRectBackground.visible = false
			$UI/CenterContainerBackground/BackgroundRain.play()
	
	# Proses menghitung biaya harian
	dailyFee = shop.getPromotionBudget() + ((shop.getPlace() - 1) * 2000)
	
	# Nonaktifkan tombol 'ButtonStartDay' jika stok makanan masih kosong, harga makanan masih 0,
	# uang pemain tidak mencukupi biaya harian, atau hari sudah mulai
	if shop.getFoodStock() == 0 || shop.getFoodPrice() == 0 || shop.getMoney() < dailyFee || timerStartDayStart == true:
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
	$ButtonPopSfx.play()
	# Jika tombol di klik, jalankan timer 'TimerStartDay' dan 'TimerTransaction'
	# lalu nonaktifkan tombol 'ButtonStartDay' dan 'ButtonShopSettings'
	if timerStartDayStart == false and timerTransactionStart == false:
		timerStartDayStart = true
		timerTransactionStart = true
		$TimerStartDay.start()
		$TimerTransaction.start()
		$UI/ButtonStartDay.disabled = true
		
		# Tutup panel 'PanelShopSettings'
		$UI/PanelShopSettings/AnimationPlayerPanelShopSettings.play_backwards("Popup")
			
		# Proses pengaturan frekuensi terjadinya transaksi
		timerTransactionNewTime = timerTransactionBaseTime - (0.1 * shop.getLevelProduct()) - (0.2 * shop.getPlace()) - ((shop.getPromotionBudget() / 1000) * 0.1)
		timerTransactionNewTime = timerTransactionNewTime + (((shop.getFoodPrice() - shop.getFoodStockPrice()) / 50) * 0.1)
		
		# Jika memasuki musim penghujan, frekuensi terjadinya transaksi dikali 0.8 (dipercepat 20%)
		if season == "Penghujan":
			$TimerTransaction.wait_time = timerTransactionNewTime * 0.8 # Atur frekuensi transaksi yang terjadi
		else:
			$TimerTransaction.wait_time = timerTransactionNewTime # Atur frekuensi transaksi yang terjadi

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
		$UI/PanelShopSettings/AnimationPlayerPanelShopSettings.play("Popup")

		# Update siklus musim
		seasonCycle -= 1
		
		# Ganti musim jika siklus sudah habis
		if seasonCycle == 0:
			seasonCycle = 2
			if season == "Kemarau":
				# Ganti ke musim hujan, lalu ganti background
				season = "Penghujan"
				$UI/CenterContainerBackground/TextureRectBackground.visible = false
				$UI/CenterContainerBackground/BackgroundRain.play()
			else:
				# Ganti ke musim kemarau, lalu ganti background
				season = "Kemarau"
				$UI/CenterContainerBackground/TextureRectBackground.visible = true
				$UI/CenterContainerBackground/BackgroundRain.stop()

# Fungsi timer timeout 'TimerTransaction' untuk mengatur frekuensi banyaknya transaksi yang terjadi
# ketika 'ButtonStartDay' di klik dan 'TimerStartDay' berjalan
func _on_TimerTransaction_timeout():
	# Ketika timer selesai, akan menambahkan uang pemain jika stok makanan masih tersedia
	# dan mengurangi stok makanan
	if shop.getFoodStock() > 0:
		$MoneyRegisterSfx.play()
		shop.setMoney(shop.getMoney() + shop.getFoodPrice())
		shop.setFoodStock(shop.getFoodStock() - 1)
		
		# Munculkan animasi jumlah uang yang bertambah
		$UI/LabelMoneyChanged.text = "+" + str(shop.getFoodPrice())
		$UI/LabelMoneyChanged.add_theme_color_override("font_color", Color(0, 1, 0, 1.0))
		$UI/LabelMoneyChanged.visible = true
		$UI/AnimationPlayerLabelMoneyChanged.play("FlyIn")

# Fungsi loop video 'BackgroundRain'
func _on_BackgroundRain_finished():
	$UI/CenterContainerBackground/BackgroundRain.play()

# Fungsi penaik harga makanan
func _on_ButtonFoodPricePlus_pressed():
	$ButtonPopSfx.play()
	# Jika tombol di klik, naikkan harga makanan sebesar 50
	shop.setFoodPrice(shop.getFoodPrice() + 50)

# Fungsi penurun harga makanan
func _on_ButtonFoodPriceMin_pressed():
	$ButtonPopSfx.play()
	# Jika tombol di klik dan harga makanan tidak 0, naikkan harga makanan sebesar 50
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

# Fungsi meningkatkan anggaran promosi
func _on_buttonPromotionBudgetPlus_pressed():
	$ButtonPopSfx.play()
	# Jika tombol di klik dan anggaran promosi tidak lebih dari 10000, naikkan anggaran promosi sebesar 1000
	if shop.getPromotionBudget() < 10000:
		shop.setPromotionBudget(shop.getPromotionBudget() + 1000)

# Fungsi menurunkan anggaran promosi
func _on_buttonPromotionBudgetMin_pressed():
	$ButtonPopSfx.play()
	# Jika tombol di klik dan anggaran promosi tidak 0, turunkan anggaran promosi sebesar 1000
	# (anggaran promosi tidak akan bernilai negatif)
	if shop.getPromotionBudget() > 0:
		shop.setPromotionBudget(shop.getPromotionBudget() - 1000)

# Fungsi mengganti tempat berjualan
func _on_buttonPlaceNext_pressed():
	$ButtonPopSfx.play()
	# Jika tombol di klik, ganti tempat berjualan
	if shop.getPlace() < 3:
		shop.setPlace(shop.getPlace() + 1)
		placeChanged = true # Tandai bahwa tempat diganti oleh pemain

func _on_buttonPlacePrev_pressed():
	$ButtonPopSfx.play()
	# Jika tombol di klik, ganti tempat berjualan
	if shop.getPlace() > 1:
		shop.setPlace(shop.getPlace() - 1)
		placeChanged = true # Tandai bahwa tempat diganti oleh pemain

# Fungsi penaik jumlah stok makanan yang ingin ditambah
func _on_buttonFoodStockPlus_pressed():
	$ButtonPopSfx.play()
	# Jika tombol di klik, naikkan penambah stok makanan sebesar 1
	# dan update total harga pembelian stok makanan
	foodStockIncrease += 1
	foodStockTotalPrice = shop.getFoodStockPrice() * foodStockIncrease

# Fungsi penurun jumlah stok makanan yang ingin ditambah
func _on_buttonFoodStockMinus_pressed():
	$ButtonPopSfx.play()
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
	$MoneySpendSfx.play()
	# Jika penambah stok makanan tidak 0, tambah stok makanan, kurangi uang pemain
	# lalu reset penambah stok makanan dan total harga pembelian stok makanan menjadi 0
	if foodStockIncrease != 0 && shop.getMoney() >= foodStockTotalPrice:
		shop.setFoodStock(shop.getFoodStock() + foodStockIncrease)
		shop.setMoney(shop.getMoney() - foodStockTotalPrice)
		foodStockIncrease = 0
		foodStockTotalPrice = 0
		
		# Munculkan animasi jumlah uang yang dikeluarkan
		$UI/LabelMoneyChanged.text = "-" + str(foodStockTotalPrice)
		$UI/LabelMoneyChanged.add_theme_color_override("font_color", Color(1, 0, 0, 1.0))
		$UI/LabelMoneyChanged.visible = true
		$UI/AnimationPlayerLabelMoneyChanged.play("FlyIn")

# Fungsi pengatur animasi pada label "LabelMoneyChanged"
func _on_AnimationPlayerLabelMoneyChanged_animation_finished(anim_name):
	$UI/LabelMoneyChanged.visible = false
	$UI/AnimationPlayerLabelMoneyChanged.stop()
