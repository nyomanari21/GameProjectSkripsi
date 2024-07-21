# Class game engine, penyimpan semua fungsi game
extends Control


@onready var shop = get_node("Shop") # Variabel penyimpan class Shop
var timerStartDayStart = false # Variabel penyimpan status 'TimerStartDay'
var timerTransactionStart = false # Variabel penyimpan status 'TimerTransaction'
var timerTransactionBaseTime = 4 # Variabel penyimpan frekuensi dasar transaksi
var timerTransactionNewTime = 0 # Variabel penyimpan frekuensi baru transaksi
var panelShopSettingsOpened = true # Variabel penyimpan status 'PanelShopSettings' (opened/closed)
var foodStockIncrease = 0 # Variabel penyimpan jumlah penambahan stok makanan
var foodStockTotalPrice = 0 # Variabel penyimpan total harga stok makanan
var season = "Kemarau" # Variabel penyimpan musim dalam permainan (kemarau dan penghujan)
var seasonCycle = 1 # Variabel penyimpan siklus musim
var dailyFee = 0 # Variabel penyimpan biaya harian untuk memulai berjualan
var placeChanged = true # Variabel penanda perubahan tempat berjualan
var panelPauseMenuOpened = false # Variabel penyimpan status 'PanelPauseMenu' (opened/closed)
var globalAnimationRunning = false # Variabel penyimpan status fungsi '_globalAnimationControl' (running/not running)
var gameOver = false # Variabel penyimpan status game over
var goalsStatus = [false, false] # Variabel penyimpan status target apakah sudah tercapai atau belum

# Called when the node enters the scene tree for the first time.
func _ready():
	$UI/PanelShopSettings/AnimationPlayerPanelShopSettings.play("Popup")
	$UI/LabelMoneyChanged.visible = false
	_globalAnimationStop()
	#_playTutorial()

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
			$UI/CenterContainerBackground/TextureRectBackground.texture = ResourceLoader.load("res://Assets/Images/Coffee stall - Downtown 2.png")
			$UI/CenterContainerBackground/BackgroundRain.stream = ResourceLoader.load("res://Assets/Videos/Coffee stall - Downtown rain.ogv")
			
		# Cek apakah musim kemarau atau penghujan untuk penentuan background
		if season == "Kemarau":
			$UI/CenterContainerBackground/TextureRectBackground.visible = true
			$UI/CenterContainerBackground/BackgroundRain.stop()
		else:
			$UI/CenterContainerBackground/TextureRectBackground.visible = false
			$UI/CenterContainerBackground/BackgroundRain.play()
		
		if shop.getPlace() == 2 and season == "Kemarau":
			$UI/Sprite2DCoffeeStallCampus.visible = true
			$UI/Sprite2DBaristaCampus.visible = true
		else:
			$UI/Sprite2DCoffeeStallCampus.visible = false
			$UI/Sprite2DBaristaCampus.visible = false
	
	# Proses menjalankan animasi pada permainan
	if globalAnimationRunning == false && season == "Kemarau":
		_globalAnimationStop()
		globalAnimationRunning = true
		_globalAnimationPlay(shop.getPlace())
	
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
	
	# Proses pengecekan jika game over
	if shop.getMoney() < shop.getFoodStockPrice() && shop.getFoodStock() == 0 && gameOver == false:
		gameOver = true
		_gameOver()

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
		
		# Kurangi uang pemain jika ada biaya harian
		if dailyFee > 0:
			$MoneySpendSfx.play()
			shop.setMoney(shop.getMoney() - dailyFee)
			_moneyChangedAnimation("decreased", dailyFee)
		
		# Tutup panel 'PanelShopSettings'
		$UI/PanelShopSettings/AnimationPlayerPanelShopSettings.play_backwards("Popup")
			
		# Proses pengaturan frekuensi terjadinya transaksi
		timerTransactionNewTime = timerTransactionBaseTime - (0.1 * shop.getLevelProduct()) - (0.2 * shop.getPlace()) - ((shop.getPromotionBudget() / 1000) * 0.1)
		timerTransactionNewTime = timerTransactionNewTime + (((shop.getFoodPrice() - shop.getFoodStockPrice()) / 50) * 0.1)
		print(timerTransactionNewTime)
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
			_globalAnimationStop()
			seasonCycle = 2
			if season == "Kemarau":
				# Ganti ke musim hujan, lalu ganti background
				season = "Penghujan"
				$UI/CenterContainerBackground/TextureRectBackground.visible = false
				$UI/CenterContainerBackground/BackgroundRain.play()
				$RainSfx.play()
			else:
				# Ganti ke musim kemarau, lalu ganti background
				season = "Kemarau"
				$UI/CenterContainerBackground/TextureRectBackground.visible = true
				$UI/CenterContainerBackground/BackgroundRain.stop()
				$RainSfx.stop()
		
		# Cek apakah ada target yang berhasil dicapai oleh pemain
		_checkGoals()

# Fungsi timer timeout 'TimerTransaction' untuk mengatur frekuensi banyaknya transaksi yang terjadi
# ketika 'ButtonStartDay' di klik dan 'TimerStartDay' berjalan
func _on_TimerTransaction_timeout():
	# Ketika timer selesai, akan menambahkan uang pemain jika stok makanan masih tersedia
	# dan mengurangi stok makanan
	if shop.getFoodStock() > 0:
		shop.setMoney(shop.getMoney() + shop.getFoodPrice())
		shop.setFoodStock(shop.getFoodStock() - 1)
		
		# Munculkan animasi jumlah uang yang bertambah
		_moneyChangedAnimation("increased", shop.getFoodPrice())

# Fungsi loop video 'BackgroundRain'
func _on_BackgroundRain_finished():
	$UI/CenterContainerBackground/BackgroundRain.play()

# Fungsi loop audio 'RainSfx'
func _on_rainSfx_finished():
	$RainSfx.play()

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
		
		# Munculkan animasi perubahan uang pemain
		_moneyChangedAnimation("decreased", shop.getLevelProductUpgradePrice())
		
		# Naikkan level kualitas makanan sebesar 1
		shop.setLevelProduct(shop.getLevelProduct() + 1)
		_setNewlevelUpgradePrice(shop.getLevelProduct(), shop.getLevelProductUpgradePrice())
		
		# Naikkan modal stok makanan sebesar 200
		shop.setFoodStockPrice(shop.getFoodStockPrice() + 200)

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
		globalAnimationRunning = false # Tandai bahwa animasi tidak berjalan

func _on_buttonPlacePrev_pressed():
	$ButtonPopSfx.play()
	# Jika tombol di klik, ganti tempat berjualan
	if shop.getPlace() > 1:
		shop.setPlace(shop.getPlace() - 1)
		placeChanged = true # Tandai bahwa tempat diganti oleh pemain
		globalAnimationRunning = false # Tandai bahwa animasi tidak berjalan

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
	# Jika penambah stok makanan tidak 0, tambah stok makanan, kurangi uang pemain
	# lalu reset penambah stok makanan dan total harga pembelian stok makanan menjadi 0
	if foodStockIncrease != 0 && shop.getMoney() >= foodStockTotalPrice:
		# Munculkan animasi jumlah uang yang dikeluarkan
		_moneyChangedAnimation("decreased", foodStockTotalPrice)
		
		shop.setFoodStock(shop.getFoodStock() + foodStockIncrease)
		shop.setMoney(shop.getMoney() - foodStockTotalPrice)
		foodStockIncrease = 0
		foodStockTotalPrice = 0

# Fungsi untuk menjalankan animasi pada label 'LabelMoneyChanged'
func _moneyChangedAnimation(status:String, moneyChanged:int):
	# Munculkan animasi jumlah uang yang dikeluarkan
	if status == "decreased":
		$MoneySpendSfx.play()
		$UI/LabelMoneyChanged.text = "-" + str(moneyChanged)
		$UI/LabelMoneyChanged.add_theme_color_override("font_color", Color(1, 0, 0, 1.0))
		$UI/LabelMoneyChanged.visible = true
		$UI/AnimationPlayerLabelMoneyChanged.play("FlyIn")
	elif status == "increased":
		$MoneyRegisterSfx.play()
		$UI/LabelMoneyChanged.text = "+" + str(moneyChanged)
		$UI/LabelMoneyChanged.add_theme_color_override("font_color", Color(0, 1, 0, 1.0))
		$UI/LabelMoneyChanged.visible = true
		$UI/AnimationPlayerLabelMoneyChanged.play("FlyIn")

# Fungsi pengatur animasi pada label "LabelMoneyChanged"
func _on_AnimationPlayerLabelMoneyChanged_animation_finished(anim_name):
	$UI/LabelMoneyChanged.visible = false
	$UI/AnimationPlayerLabelMoneyChanged.stop()

# Fungsi untuk menjalankan animasi pada game
func _globalAnimationPlay(place):
	if place == 1:
		_parkAnimationControl()
	elif place == 2:
		_campusAnimationControl()
	elif place == 3:
		_downtownAnimationControl()

# Fungsi untuk memberhentikan animasi pada game
func _globalAnimationStop():
	$UI/ControlAnimationDowntown/ControlCar1/Sprite2DCar1.visible = false
	$UI/ControlAnimationDowntown/ControlCar1/AnimationPlayerCar1.stop()
	$UI/ControlAnimationDowntown/ControlCar2/Sprite2DCar2.visible = false
	$UI/ControlAnimationDowntown/ControlCar2/AnimationPlayerCar2.stop()
	
	$UI/ControlAnimationCampus/ControlCar3/Sprite2DCar3.visible = false
	$UI/ControlAnimationCampus/ControlCar3/AnimationPlayerCar3.stop()
	$UI/ControlAnimationCampus/ControlCar4/Sprite2DCar4.visible = false
	$UI/ControlAnimationCampus/ControlCar4/AnimationPlayerCar4.stop()
	
	$UI/ControlAnimationPark/ControlSwan1/Sprite2DSwan1.visible = false
	$UI/ControlAnimationPark/ControlSwan1/AnimationPlayerSwan1.stop()

# Fungsi pengatur animasi pada tempat 'Downtown'
func _downtownAnimationControl():
	$UI/ControlAnimationDowntown/ControlCar1/Sprite2DCar1.visible = true
	$UI/ControlAnimationDowntown/ControlCar1/AnimationPlayerCar1.play("moving")
	$UI/ControlAnimationDowntown/ControlCar2/Sprite2DCar2.visible = true
	$UI/ControlAnimationDowntown/ControlCar2/AnimationPlayerCar2.play("moving")
	await get_tree().create_timer(6).timeout

# Fungsi pengatur animasi 'AnimationPlayerCar1' pada 'Downtown'
func _on_animationPlayerCar1Animation_finished(anim_name):
	$UI/ControlAnimationDowntown/ControlCar1/AnimationPlayerCar1.play("moving")

# Fungsi pengatur animasi 'AnimationPlayerCar2' pada 'Downtown'
func _on_animationPlayerCar2Animation_finished(anim_name):
	$UI/ControlAnimationDowntown/ControlCar2/AnimationPlayerCar2.play("moving")

# Fungsi pengatur animasi pada tempat 'Campus'
func _campusAnimationControl():
	$UI/ControlAnimationCampus/ControlCar4/Sprite2DCar4.visible = true
	$UI/ControlAnimationCampus/ControlCar4/AnimationPlayerCar4.play("moving")
	$UI/ControlAnimationCampus/ControlCar3/Sprite2DCar3.visible = true
	$UI/ControlAnimationCampus/ControlCar3/AnimationPlayerCar3.play("moving")
	await get_tree().create_timer(6).timeout

# Fungsi pengatur animasi 'AnimationPlayerCar3' pada 'Campus'
func _on_animationPlayerCar3Animation_finished(anim_name):
	$UI/ControlAnimationCampus/ControlCar3/AnimationPlayerCar3.play("moving")

# Fungsi pengatur animasi 'AnimationPlayerCar4' pada 'Campus'
func _on_animationPlayerCar4Animation_finished(anim_name):
	$UI/ControlAnimationCampus/ControlCar4/AnimationPlayerCar4.play("moving")

# Fungsi Pengatur animasi pada tempat 'Park'
func _parkAnimationControl():
	$UI/ControlAnimationPark/ControlSwan1/Sprite2DSwan1.visible = true
	$UI/ControlAnimationPark/ControlSwan1/AnimationPlayerSwan1.play("moving")

# Fungsi pengatur animasi 'AnimationPlayerSwan' pada 'Park'
func _on_animationPlayerSwan1Animation_finished(anim_name):
	$UI/ControlAnimationPark/ControlSwan1/AnimationPlayerSwan1.play("moving")

# Fungsi jika permainan berakhir
func _gameOver():
	$UI/ControlGameOver.visible = true
	$UI/ControlGameOver/PanelGameOver/AnimationPlayerGameOver.play("popup")
	$UI/ControlGameOver.top_level = true

# Fungsi pengatur tombol 'ButtonGameOver'
func _on_buttonGameOver_pressed():
	# Jika di klik, kembali ke halaman utama
	get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")

# Fungsi untuk memulai tutorial
func _playTutorial():
	$UI/ControlTutorial.visible = true
	$UI/ControlTutorial.top_level = true
	$UI/ControlTutorial/PanelTutorial1/AnimationPlayerTutorial1.play("popup")

# Fungsi button "Tutorial" ketika di klik akan menjalankan tutorial
func _on_buttonTutorial_pressed():
	$ButtonPopSfx.play()
	_playTutorial()

func _on_buttonNextTutorial1_pressed():
	$ButtonPopSfx.play()
	$UI/ControlTutorial/PanelTutorial1/AnimationPlayerTutorial1.play_backwards("popup")
	await get_tree().create_timer(0.1).timeout
	$UI/ControlTutorial/PanelTutorial2/AnimationPlayerTutorial2.play("popup")

func _on_buttonNextTutorial2_pressed():
	$ButtonPopSfx.play()
	$UI/ControlTutorial/PanelTutorial2/AnimationPlayerTutorial2.play_backwards("popup")
	await get_tree().create_timer(0.1).timeout
	$UI/ControlTutorial/PanelTutorial3/AnimationPlayerTutorial3.play("popup")

func _on_buttonNextTutorial3_pressed():
	$ButtonPopSfx.play()
	$UI/ControlTutorial/PanelTutorial3/AnimationPlayerTutorial3.play_backwards("popup")
	await get_tree().create_timer(0.1).timeout
	$UI/ControlTutorial/PanelTutorial4/AnimationPlayerTutorial4.play("popup")

func _on_buttonNextTutorial4_pressed():
	$ButtonPopSfx.play()
	$UI/ControlTutorial/PanelTutorial4/AnimationPlayerTutorial4.play_backwards("popup")
	await get_tree().create_timer(0.1).timeout
	$UI/ControlTutorial/PanelTutorial5/AnimationPlayerTutorial5.play("popup")

func _on_buttonNextTutorial5_pressed():
	$ButtonPopSfx.play()
	$UI/ControlTutorial/PanelTutorial5/AnimationPlayerTutorial5.play_backwards("popup")
	await get_tree().create_timer(0.1).timeout
	$UI/ControlTutorial/PanelTutorial6/AnimationPlayerTutorial6.play("popup")

func _on_buttonNextTutorial6_pressed():
	$ButtonPopSfx.play()
	$UI/ControlTutorial/PanelTutorial6/AnimationPlayerTutorial6.play_backwards("popup")
	await get_tree().create_timer(0.1).timeout
	$UI/ControlTutorial/PanelTutorial7/AnimationPlayerTutorial7.play("popup")

func _on_buttonNextTutorial7_pressed():
	$ButtonPopSfx.play()
	$UI/ControlTutorial/PanelTutorial7/AnimationPlayerTutorial7.play_backwards("popup")
	await get_tree().create_timer(0.1).timeout
	$UI/ControlTutorial/PanelTutorial8/AnimationPlayerTutorial8.play("popup")

func _on_buttonNextTutorial8_pressed():
	$ButtonPopSfx.play()
	$UI/ControlTutorial/PanelTutorial8/AnimationPlayerTutorial8.play_backwards("popup")
	await get_tree().create_timer(0.1).timeout
	$UI/ControlTutorial/PanelTutorial9/AnimationPlayerTutorial9.play("popup")

func _on_buttonNextTutorial9_pressed():
	$ButtonPopSfx.play()
	$UI/ControlTutorial/PanelTutorial9/AnimationPlayerTutorial9.play_backwards("popup")
	await get_tree().create_timer(0.1).timeout
	$UI/ControlTutorial/PanelTutorial10/AnimationPlayerTutorial10.play("popup")

func _on_buttonNextTutorial10_pressed():
	$ButtonPopSfx.play()
	$UI/ControlTutorial/PanelTutorial10/AnimationPlayerTutorial10.play_backwards("popup")
	await get_tree().create_timer(0.1).timeout
	$UI/ControlTutorial/PanelTutorial11/AnimationPlayerTutorial11.play("popup")

func _on_buttonNextTutorial11_pressed():
	$ButtonPopSfx.play()
	$UI/ControlTutorial/PanelTutorial11/AnimationPlayerTutorial11.play_backwards("popup")
	await get_tree().create_timer(0.1).timeout
	$UI/ControlTutorial/PanelTutorial12/AnimationPlayerTutorial12.play("popup")

func _on_buttonNextTutorial12_pressed():
	$ButtonPopSfx.play()
	$UI/ControlTutorial/PanelTutorial12/AnimationPlayerTutorial12.play_backwards("popup")
	await get_tree().create_timer(0.1).timeout
	$UI/ControlTutorial/PanelTutorial13/AnimationPlayerTutorial13.play("popup")

func _on_buttonNextTutorial13_pressed():
	$ButtonPopSfx.play()
	$UI/ControlTutorial/PanelTutorial13/AnimationPlayerTutorial13.play_backwards("popup")
	await get_tree().create_timer(0.1).timeout
	$UI/ControlTutorial/PanelTutorial14/AnimationPlayerTutorial14.play("popup")

func _on_buttonNextTutorial14_pressed():
	$ButtonPopSfx.play()
	$UI/ControlTutorial/PanelTutorial14/AnimationPlayerTutorial14.play_backwards("popup")
	await get_tree().create_timer(0.1).timeout
	$UI/ControlTutorial/PanelTutorial15/AnimationPlayerTutorial15.play("popup")

func _on_buttonNextTutorial15_pressed():
	$ButtonPopSfx.play()
	$UI/ControlTutorial/PanelTutorial15/AnimationPlayerTutorial15.play_backwards("popup")
	await get_tree().create_timer(0.1).timeout
	$UI/ControlTutorial/PanelTutorial16/AnimationPlayerTutorial16.play("popup")

func _on_buttonEndTutorial16_pressed():
	$ButtonPopSfx.play()
	$UI/ControlTutorial/PanelTutorial16/AnimationPlayerTutorial16.play_backwards("popup")
	$UI/ControlTutorial.top_level = false
	$UI/ControlTutorial.visible = false

# Fungsi untuk mengecek target pemain
func _checkGoals():
	# Cek target pertama
	if shop.getMoney() > 20000 and goalsStatus[0] == false:
		# Jika target terpenuhi, beri pemain uang sebesar 5000, lalu tandai bahwa target telah tercapai
		$AchievementSfx.play()
		$UI/PanelGoals/VBoxContainerGoalsList/LabelGoals1.modulate = Color(1, 1, 1, 0.5)
		shop.setMoney(shop.getMoney() + 5000)
		_moneyChangedAnimation("increased", 5000)
		goalsStatus[0] = true
	
	# Cek target kedua
	if shop.getPlace() == 2 and goalsStatus[1] == false:
		# Jika target terpenuhi, beri pemain stok kopi sebanyak 10 buah, lalu tandai bahwa target telah tercapai
		$AchievementSfx.play()
		$UI/PanelGoals/VBoxContainerGoalsList/LabelGoals2.modulate = Color(1, 1, 1, 0.5)
		shop.setFoodStock(shop.getFoodStock() + 10)
		goalsStatus[1] = true

# Fungsi untuk loop audio 'MainMusic'
func _on_mainMusic_finished():
	$MainMusic.play()
