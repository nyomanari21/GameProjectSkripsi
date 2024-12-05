# Class game utama
extends Control

var rng = RandomNumberGenerator.new()
var baristaCoffeeNumber:int = 0 # Kopi yang dipilih oleh barista (player)
var customerCoffeeNumber:int = 0 # Kopi yang diminta oleh customer
var customerFeedback:int = 0 # Penyimpan perhitungan feedback dari customer (...,-1,0,1,...)
var customerNumber:int # Penyimpan banyaknya customer yang telah datang
var totalDay:int = 3 # Total hari yang akan berjalan setiap kali bermain
var dayNumber:int = 0 # Penanda hari yang sedang berjalan
var timerCustomerStarted = false # Penanda status timer customer
var customerScale1 # Penyimpan ukuran animasi customer 1
var customerScale2 # Penyimpan ukuran animasi customer 2
var customerAnimation # Penyimpan random number untuk load animasi customer
var customerFeedbackPercentage # Penyimpan random number untuk feedback customer

# Called when the node enters the scene tree for the first time.
func _ready():
	if shop.getResetVariable() == true:
		shop.setResetVariable(false)
	customerScale1 = $UI/ControlCharacters/ControlCustomer1/AnimatedSprite2DCustomer1.scale
	customerScale2 = $UI/ControlCharacters/ControlCustomer1/AnimatedSprite2DCustomer1.scale / 2
	transaction.setDailyCustomer(transaction.getDailyCustomer() + (shop.getPromotionBudget() / 500))
	shop.setFoodPrice(shop.getFoodPrice() - (shop.getFoodPrice() * shop.getDiscount() / 100))
	$TimerCustomer.wait_time = 2
	$UI/ControlTimerBar/PanelTimerBar/Line2DTimerBar/TimerTimerBar.wait_time = 0.2
	_startDay()
	_startBackgroundAnimation()
	
	# Mulai tutorial untuk pertama kali main
	if ingametutorial.getTutorialGame() == 0:
		_startTutorial(1)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_keyboardPressed()

# Fungsi untuk loop MainMusic
func _on_main_music_finished():
	$MainMusic.play()

# Fungsi untuk memulai hari
func _startDay():
	print("Customer: " + str(transaction.getDailyCustomer()))
	print("TimerCustomer: " + str($TimerCustomer.wait_time))
	$UI/ControlDayNumber/PanelDayNumber/LabelDayNumber.text = "Hari Ke " + str(dayNumber + 1)
	$UI/ControlCustomerNumber/PanelCustomerNumber/LabelCustomerNumber.text = "Pelanggan Ke 1"
	customerNumber = 0 # Reset jumlah customer yang telah datang
	$UI/ControlCustomerCoffee.visible = false
	_moveCustomer() # Jalankan animasi customer

# Fungsi untuk menjalankan animasi Customer
func _moveCustomer():
	customerAnimation = rng.randi_range(1, 6)
	
	if customerAnimation == 1:
		$UI/ControlCharacters/ControlCustomer1/AnimatedSprite2DCustomer1.scale = customerScale1
		$UI/ControlCharacters/ControlCustomer1/AnimatedSprite2DCustomer1.play("walking 1")
	elif customerAnimation == 2:
		$UI/ControlCharacters/ControlCustomer1/AnimatedSprite2DCustomer1.scale = customerScale2
		$UI/ControlCharacters/ControlCustomer1/AnimatedSprite2DCustomer1.play("walking 2")
	elif customerAnimation == 3:
		$UI/ControlCharacters/ControlCustomer1/AnimatedSprite2DCustomer1.scale = customerScale1
		$UI/ControlCharacters/ControlCustomer1/AnimatedSprite2DCustomer1.play("walking 3")
	elif customerAnimation == 4:
		$UI/ControlCharacters/ControlCustomer1/AnimatedSprite2DCustomer1.scale = customerScale1
		$UI/ControlCharacters/ControlCustomer1/AnimatedSprite2DCustomer1.play("walking 4")
	elif customerAnimation == 5:
		$UI/ControlCharacters/ControlCustomer1/AnimatedSprite2DCustomer1.scale = customerScale1
		$UI/ControlCharacters/ControlCustomer1/AnimatedSprite2DCustomer1.play("walking 5")
	elif customerAnimation == 6:
		$UI/ControlCharacters/ControlCustomer1/AnimatedSprite2DCustomer1.scale = customerScale1
		$UI/ControlCharacters/ControlCustomer1/AnimatedSprite2DCustomer1.play("walking 6")
	$UI/ControlCharacters/ControlCustomer1/AnimationPlayerCustomer1.play("moving")

func _playTimerBar():
	$UI/ControlTimerBar/PanelTimerBar/Line2DTimerBar.points[1].x = 100
	$UI/ControlTimerBar.visible = true
	$UI/ControlTimerBar/PanelTimerBar/Line2DTimerBar/TimerTimerBar.start()

func _stopTimerBar():
	$UI/ControlTimerBar.visible = false
	$UI/ControlTimerBar/PanelTimerBar/Line2DTimerBar/TimerTimerBar.stop()

# Fungsi untuk memunculkan kopi yang diinginkan oleh customer
func _on_animation_player_customer_animation_finished(anim_name):
	$UI/ControlCharacters/ControlCustomer1/AnimatedSprite2DCustomer1.stop()
	customerCoffeeNumber = rng.randi_range(1, 3)
	_loadCustomerCoffee(customerCoffeeNumber)
	_loadBaristaCoffee(shop.getPlace())
	$TimerCustomer.start()
	$TimerCustomerCoffee.start()
	_playTimerBar()
	timerCustomerStarted = true
	
	# Lanjutkan tutorial ketika pertama kali main
	if ingametutorial.getTutorialGame() == 0:
		_startTutorial(2)

func _loadBaristaCoffee(place:int):
	$UI/ControlBaristaCoffee.visible = true
	if shop.getPlace() == 1:
		$UI/ControlBaristaCoffee/AnimationPlayerArrow.play("moving_park")
	elif shop.getPlace() == 2:
		$UI/ControlBaristaCoffee/AnimationPlayerArrow.play("moving_downtown")
	elif shop.getPlace() == 3:
		$UI/ControlBaristaCoffee/AnimationPlayerArrow.play("moving_mall")

# Fungsi kontrol animasi Arrow
func _on_animationPlayerArrowAnimation_finished(anim_name):
	if shop.getPlace() == 1:
		$UI/ControlBaristaCoffee/AnimationPlayerArrow.play("moving_park")
	elif shop.getPlace() == 2:
		$UI/ControlBaristaCoffee/AnimationPlayerArrow.play("moving_downtown")
	elif shop.getPlace() == 3:
		$UI/ControlBaristaCoffee/AnimationPlayerArrow.play("moving_mall")

func _hideBaristaCoffee():
	$UI/ControlBaristaCoffee.visible = false
	$UI/ControlBaristaCoffee/AnimationPlayerArrow.stop()

# Fungsi untuk load gambar kopi
func _loadCustomerCoffee(coffee:int):
	$UI/ControlCustomerCoffee.visible = true
	if coffee == 1:
		$UI/ControlCustomerCoffee/PanelCustomerCoffee/TextureRectCustomerCoffee.texture = ResourceLoader.load("res://Assets/Images/Coffee 1.png")
	elif coffee == 2:
		$UI/ControlCustomerCoffee/PanelCustomerCoffee/TextureRectCustomerCoffee.texture = ResourceLoader.load("res://Assets/Images/Coffee 2.png")
	elif coffee == 3:
		$UI/ControlCustomerCoffee/PanelCustomerCoffee/TextureRectCustomerCoffee.texture = ResourceLoader.load("res://Assets/Images/Coffee 3.png")

# Fungsi untuk menghilangkan kopi customer yang muncul
func _on_timer_customer_coffee_timeout():
	$TimerCustomerCoffee.stop()
	$UI/ControlCustomerCoffee.visible = false

# Fungsi untuk mengecek kesesuaian antara kopi customer dengan kopi yang di klik pemain
func _checkCoffee(customer:int, barista:int):
	_stopTimerBar()
	_hideBaristaCoffee()
	$TimerCustomer.stop()
	timerCustomerStarted = false
	# Jika pemain memilih salah satu dari ketiga kopi
	if barista != 0:
		# Jika kopi yang dipilih benar
		if customer == barista:
			_moneyEarned()
			_customerFeedback()
		# Jika kopi yang dipilih salah
		else:
			_saveCustomerFeedback("negative")
			_loadFeedbackIcon("negative")
	# Jika pemain tidak memilih salah satu dari ketiga kopi
	else:
		_saveCustomerFeedback("negative")
		_loadFeedbackIcon("negative")
	
	customerNumber += 1
	if customerNumber < transaction.getDailyCustomer():
		_nextCustomer()
	else:
		_dayReport()

func _nextCustomer():
	await get_tree().create_timer(1).timeout
	$UI/ControlCustomerNumber/PanelCustomerNumber/LabelCustomerNumber.text = "Pelanggan Ke " + str(customerNumber + 1)
	$UI/ControlCharacters/ControlCustomer1/AnimationPlayerCustomer1.stop()
	_moveCustomer()

# Fungsi kalkulasi feedback customer yang didapatkan pemain
func _customerFeedback():
	# Cek kepuasan customer dengan kualitas kopi
	customerFeedback = shop.getLevelProduct() - shop.getPlace()
	
	# Cek kepuasan customer dengan harga kopi
	# Cek lokasi Park (Taman)
	if shop.getPlace() == 1:
		if shop.getFoodPrice() <= 400:
			customerFeedback += 1
		elif shop.getFoodPrice() > 400 and shop.getFoodPrice() <= 500:
			customerFeedback += 0
		elif shop.getFoodPrice() > 500:
			customerFeedback -= 1
	
	# Cek lokasi Downtown (Pusat Kota)
	if shop.getPlace() == 2:
		if shop.getFoodPrice() <= 800:
			customerFeedback += 1
		elif shop.getFoodPrice() > 800 and shop.getFoodPrice() <= 900:
			customerFeedback += 0
		elif shop.getFoodPrice() > 900:
			customerFeedback -= 1
	
	# Cek lokasi Mall
	if shop.getPlace() == 3:
		if shop.getFoodPrice() <= 1200:
			customerFeedback += 1
		elif shop.getFoodPrice() > 1200 and shop.getFoodPrice() <= 1300:
			customerFeedback += 0
		elif shop.getFoodPrice() > 1300:
			customerFeedback -= 1
	
	customerFeedbackPercentage = rng.randi_range(1, 100)
	# Jika perhitungan feedback customer bernilai positif
	if customerFeedback > 0:
		if customerFeedbackPercentage <= 80:
			_saveCustomerFeedback("positive")
			_loadFeedbackIcon("positive")
		elif customerFeedbackPercentage > 80 and customerFeedbackPercentage <= 90:
			_saveCustomerFeedback("neutral")
			_loadFeedbackIcon("neutral")
		else:
			_saveCustomerFeedback("negative")
			_loadFeedbackIcon("negative")
	# Jika perhitungan feedback customer bernilai 0
	elif customerFeedback == 0:
		if customerFeedbackPercentage <= 40:
			_saveCustomerFeedback("positive")
			_loadFeedbackIcon("positive")
		elif customerFeedbackPercentage > 40 and customerFeedbackPercentage <= 80:
			_saveCustomerFeedback("neutral")
			_loadFeedbackIcon("neutral")
		else:
			_saveCustomerFeedback("negative")
			_loadFeedbackIcon("negative")
	# Jika perhitungan feedback customer bernilai negatif
	elif customerFeedback < 0:
		if customerFeedbackPercentage <= 20:
			_saveCustomerFeedback("positive")
			_loadFeedbackIcon("positive")
		elif customerFeedbackPercentage > 20 and customerFeedbackPercentage <= 30:
			_saveCustomerFeedback("neutral")
			_loadFeedbackIcon("neutral")
		else:
			_saveCustomerFeedback("negative")
			_loadFeedbackIcon("negative")

# Fungsi untuk menyimpan feedback customer
func _saveCustomerFeedback(feedback:String):
	if feedback == "positive":
		transaction.setDailyPositiveFeedback(transaction.getDailyPositiveFeedback() + 1)
	elif feedback == "neutral":
		transaction.setDailyNeutralFeedback(transaction.getDailyNeutralFeedback() + 1)
	elif feedback == "negative":
		transaction.setDailyNegativeFeedback(transaction.getDailyNegativeFeedback() + 1)

# Fungsi memunculkan icon feedback customer
func _loadFeedbackIcon(feedback:String):
	if feedback == "positive":
		$UI/ControlCustomerFeedback/TextureRectCustomerFeedback.texture = ResourceLoader.load("res://Assets/Images/Smile icon.png")
	elif feedback == "neutral":
		$UI/ControlCustomerFeedback/TextureRectCustomerFeedback.texture = ResourceLoader.load("res://Assets/Images/Neutral icon.png")
	elif feedback == "negative":
		$UI/ControlCustomerFeedback/TextureRectCustomerFeedback.texture = ResourceLoader.load("res://Assets/Images/Sad icon.png")
	
	$UI/ControlCustomerFeedback.visible = true
	$UI/ControlCustomerFeedback/AnimationPlayerCustomerFeedback.play("floating")

# Fungsi memunculkan pertambahan uang pemain
func _moneyEarned():
	transaction.setIncome(transaction.getIncome() + shop.getFoodPrice())
	$MoneyRegisterSfx.play()
	$UI/ControlMoneyEarned/LabelMoneyEarned.text = "+" + str(shop.getFoodPrice())
	$UI/ControlMoneyEarned/LabelMoneyEarned.add_theme_color_override("font_color", Color(0, 1, 0, 1.0))
	$UI/ControlMoneyEarned.visible = true
	$UI/ControlMoneyEarned/AnimationPlayerMoneyEarned.play("floating")

# Fungsi untuk menyimpan kopi yang dipilih oleh pemain dan cek kesesuaian kopi
func _selectedCoffee(coffee:int):
	$PopSfx.play()
	if timerCustomerStarted == true:
		baristaCoffeeNumber = coffee
		_checkCoffee(customerCoffeeNumber, baristaCoffeeNumber)

# Memilih Kopi 1
func _on_texture_button_barista_coffee_1_pressed():
	_selectedCoffee(1)

# Memilih Kopi 2
func _on_texture_button_barista_coffee_2_pressed():
	_selectedCoffee(2)

# Memilih Kopi 3
func _on_texture_button_barista_coffee_3_pressed():
	_selectedCoffee(3)

# Memilih dengan Keyboard
func _keyboardPressed():
	if Input.is_action_just_pressed("Kopi 1"):
		_selectedCoffee(1)
	elif Input.is_action_just_pressed("Kopi 2"):
		_selectedCoffee(2)
	elif Input.is_action_just_pressed("Kopi 3"):
		_selectedCoffee(3)

# Fungsi ketika waktu tunggu customer habis
func _on_timer_customer_timeout():
	_checkCoffee(customerCoffeeNumber, 0)

# Fungsi untuk mengurangi progres bar waktu
func _on_timerTimerBar_timeout():
	$UI/ControlTimerBar/PanelTimerBar/Line2DTimerBar.points[1].x -= 10
	$UI/ControlTimerBar/PanelTimerBar/Line2DTimerBar/TimerTimerBar.start()

# Fungsi reset animasi pada MoneyEarned
func _on_animation_player_money_earned_animation_finished(anim_name):
	$UI/ControlMoneyEarned.visible = false
	$UI/ControlMoneyEarned/AnimationPlayerMoneyEarned.stop()

# Fungsi reset animasi pada CustomerFeedback
func _on_animation_player_customer_feedback_animation_finished(anim_name):
	$UI/ControlCustomerFeedback.visible = false
	$UI/ControlCustomerFeedback/AnimationPlayerCustomerFeedback.stop()

# Fungsi untuk memunculkan laporan harian
func _dayReport():
	dayNumber += 1
	
	# Update data transaksi dan toko
	transaction.saveTotalFeedback()
	transaction.saveTotalCustomer()
	shop.setMoney(shop.getMoney() + transaction.getIncome())
	
	# Jika masih ada hari yang belum dilalui, tampilkan report harian
	if dayNumber < totalDay:
		$UI/ControlDayReport/PanelDayReport/LabelCustomer.text = "Pelanggan : " + str(transaction.getDailyCustomer()) + " Orang"
		$UI/ControlDayReport/PanelDayReport/LabelPositiveFeedback.text = ": " + str(transaction.getDailyPositiveFeedback()) + " Orang"
		$UI/ControlDayReport/PanelDayReport/LabelNeutralFeedback.text = ": " + str(transaction.getDailyNeutralFeedback()) + " Orang"
		$UI/ControlDayReport/PanelDayReport/LabelNegativeFeedback.text = ": " + str(transaction.getDailyNegativeFeedback()) + " Orang"
		$UI/ControlDayReport/PanelDayReport/LabelCapital.text = "Biaya Produksi : " + str(shop.getFoodStockPrice() * transaction.getDailyCustomer()) + "G"
		$UI/ControlDayReport/PanelDayReport/LabelEarned.text = "Pendapatan     : " + str(transaction.getIncome()) + "G"
		$UI/ControlDayReport/PanelDayReport/LabelAdBudget.text = "Iklan                : " + str(shop.getPromotionBudget()) + "G"
		$UI/ControlDayReport/PanelDayReport/LabelDifference.text = "Selisih               : " + str(transaction.getIncome() - (shop.getFoodStockPrice() * transaction.getDailyCustomer()) - shop.getPromotionBudget()) + "G"
		$UI/ControlDayReport.visible = true
		$UI/ControlDayReport/AnimationPlayerDayFinished.play("popup")
	# Jika total hari sudah habis, tampilkan report keseluruhan
	else:
		$UI/ControlDayReport/PanelDayReport/LabelCustomer.text = "Pelanggan : " + str(transaction.getTotalCustomer()) + " Orang"
		$UI/ControlDayReport/PanelDayReport/LabelPositiveFeedback.text = ": " + str(transaction.getTotalPositiveFeedback()) + " Orang"
		$UI/ControlDayReport/PanelDayReport/LabelNeutralFeedback.text = ": " + str(transaction.getTotalNeutralFeedback()) + " Orang"
		$UI/ControlDayReport/PanelDayReport/LabelNegativeFeedback.text = ": " + str(transaction.getTotalNegativeFeedback()) + " Orang"
		$UI/ControlDayReport/PanelDayReport/LabelCapital.text = "Biaya Produksi : " + str(shop.getFoodStockPrice() * transaction.getTotalCustomer()) + "G"
		$UI/ControlDayReport/PanelDayReport/LabelEarned.text = "Pendapatan     : " + str(shop.getMoney()) + "G"
		$UI/ControlDayReport/PanelDayReport/LabelAdBudget.text = "Iklan                : " + str(shop.getPromotionBudget() * totalDay) + "G"
		$UI/ControlDayReport/PanelDayReport/LabelDifference.text = "Selisih               : " + str(shop.getMoney() - (shop.getFoodStockPrice() * transaction.getTotalCustomer())) + "G"
		$UI/ControlDayReport/PanelDayReport/LabelReportTitle.text = "Laporan Penjualan Keseluruhan"
		$UI/ControlDayReport/PanelDayReport/ButtonCloseDayFinished.text = "Selanjutnya"
		$UI/ControlDayReport.visible = true
		$UI/ControlDayReport/AnimationPlayerDayFinished.play("popup")
	
	# Reset data transaksi
	transaction.calculateNextDailyCustomer()
	transaction.resetDailyFeedback()
	transaction.resetIncome()

# Fungsi untuk menutup panel PanelDayReport
func _on_button_close_day_finished_pressed():
	# Jika masih ada hari yang belum dilalui, lanjutkan ke hari berikutnya
	if dayNumber < totalDay:
		$UI/ControlDayReport/AnimationPlayerDayFinished.play_backwards("popup")
		$UI/ControlDayReport.visible = false
		
		$TimerCustomer.wait_time -= 0.2
		$TimerCustomerCoffee.wait_time -= 0.15
		$UI/ControlTimerBar/PanelTimerBar/Line2DTimerBar/TimerTimerBar.wait_time = $TimerCustomer.wait_time / 10
		_startDay()
	# Jika total hari sudah habis, munculkan ending
	else:
		if (shop.getMoney() > (shop.getFoodStockPrice() * transaction.getTotalCustomer())) && (transaction.getTotalPositiveFeedback() > transaction.getTotalNegativeFeedback()):
			$UI/ControlEnding/PanelEnding/LabelTitleEnding.text = "SUKSES"
			$UI/ControlEnding/PanelEnding/LabelDescription.text = "Kamu berhasil mendapat keuntungan dan pelanggan menyukai kopimu!"
		elif (shop.getMoney() < (shop.getFoodStockPrice() * transaction.getTotalCustomer())) && (transaction.getTotalPositiveFeedback() > transaction.getTotalNegativeFeedback()):
			$UI/ControlEnding/PanelEnding/LabelTitleEnding.text = "BANGKRUT"
			$UI/ControlEnding/PanelEnding/LabelDescription.text = "Pelanggan menyukai kopimu tetapi kamu kehabisan modal untuk berjualan dan bangkrut!"
		elif (shop.getMoney() > (shop.getFoodStockPrice() * transaction.getTotalCustomer())) && (transaction.getTotalPositiveFeedback() < transaction.getTotalNegativeFeedback()):
			$UI/ControlEnding/PanelEnding/LabelTitleEnding.text = "KEHILANGAN PELANGGAN"
			$UI/ControlEnding/PanelEnding/LabelDescription.text = "Walaupun mendapat keuntungan, tetapi kamu kehilangan pelanggan dan akhirnya usahamu tutup!"
		else:
			$UI/ControlEnding/PanelEnding/LabelTitleEnding.text = "BANGKRUT"
			$UI/ControlEnding/PanelEnding/LabelDescription.text = "Kamu kehabisan modal dan kehilangan pelanggan hingga akhirnya bangkrut!"
		
		$UI/ControlDayReport/AnimationPlayerDayFinished.play_backwards("popup")
		$UI/ControlEnding/AnimationPlayerEnding.play("popup")

func _on_buttonEnding_pressed():
	get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")

# Fungsi 'ButtonResetMarketingMixVariable' untuk mengatur ulang variabel marketing mix
func _on_buttonResetMarketingMixVariable_pressed():
	shop.setResetVariable(true)
	get_tree().change_scene_to_file("res://Scenes/MarketingMix.tscn")

# Fungsi kontrol Background Animation
func _stopBackgroundAnimation():
	$UI/ControlBackgroundAnimation/ControlAnimationPark.visible = false
	$UI/ControlBackgroundAnimation/ControlAnimationPark/AnimationPlayerSwan.stop()
	
	$UI/ControlBackgroundAnimation/ControlAnimationDowntown.visible = false
	$UI/ControlBackgroundAnimation/ControlAnimationDowntown/AnimationPlayerCar1.stop()
	$UI/ControlBackgroundAnimation/ControlAnimationDowntown/AnimationPlayerCar2.stop()

func _startBackgroundAnimation():
	if shop.getPlace() == 1:
		_playAnimtaionPark()
	elif shop.getPlace() == 2:
		_playAnimationDowntown()

# Fungsi-fungsi kontrol Animation Park
func _playAnimtaionPark():
	$UI/ControlBackgroundAnimation/ControlAnimationPark.visible = true
	$UI/ControlBackgroundAnimation/ControlAnimationPark/AnimationPlayerSwan.play("moving")

func _on_animation_player_swan_animation_finished(anim_name):
	$UI/ControlBackgroundAnimation/ControlAnimationPark/AnimationPlayerSwan.play("moving")

# Fungsi-fungsi kontrol Animation Downtown
func _playAnimationDowntown():
	$UI/ControlBackgroundAnimation/ControlAnimationDowntown.visible = true
	$UI/ControlBackgroundAnimation/ControlAnimationDowntown/AnimationPlayerCar1.play("moving")
	$UI/ControlBackgroundAnimation/ControlAnimationDowntown/AnimationPlayerCar2.play("moving")

func _on_animation_player_car_1_animation_finished(anim_name):
	$UI/ControlBackgroundAnimation/ControlAnimationDowntown/AnimationPlayerCar1.play("moving")

func _on_animation_player_car_2_animation_finished(anim_name):
	$UI/ControlBackgroundAnimation/ControlAnimationDowntown/AnimationPlayerCar2.play("moving")


# Fungsi-fungsi kontrol Tutorial
func _startTutorial(n:int):
	if n == 1:
		$UI/ControlTutorial.visible = true
		$UI/ControlTutorial/ControlTutorial1/PanelTutorial1/AnimationPlayerTutorial1.play("popup")
		get_tree().paused = true
	elif n == 2:
		$UI/ControlTutorial.visible = true
		$UI/ControlTutorial/ControlTutorial2/PanelTutorial2/AnimationPlayerTutorial2.play("popup")
		get_tree().paused = true

func _on_button_tutorial_1_pressed():
	$PopSfx.play()
	$UI/ControlTutorial/ControlTutorial1/PanelTutorial1/AnimationPlayerTutorial1.play_backwards("popup")
	$UI/ControlTutorial.visible = false
	get_tree().paused = false

func _on_button_tutorial_2_pressed():
	$PopSfx.play()
	$UI/ControlTutorial/ControlTutorial2/PanelTutorial2/AnimationPlayerTutorial2.play_backwards("popup")
	$UI/ControlTutorial/ControlTutorial3/PanelTutorial3/AnimationPlayerTutorial3.play("popup")

func _on_button_tutorial_3_pressed():
	$PopSfx.play()
	$UI/ControlTutorial/ControlTutorial3/PanelTutorial3/AnimationPlayerTutorial3.play_backwards("popup")
	$UI/ControlTutorial/ControlTutorial4/PanelTutorial4/AnimationPlayerTutorial4.play("popup")

func _on_button_tutorial_4_pressed():
	$PopSfx.play()
	$UI/ControlTutorial/ControlTutorial4/PanelTutorial4/AnimationPlayerTutorial4.play_backwards("popup")
	$UI/ControlTutorial/ControlTutorial5/PanelTutorial5/AnimationPlayerTutorial5.play("popup")

func _on_button_tutorial_5_pressed():
	$PopSfx.play()
	$UI/ControlTutorial/ControlTutorial5/PanelTutorial5/AnimationPlayerTutorial5.play_backwards("popup")
	$UI/ControlTutorial/ControlTutorial6/PanelTutorial6/AnimationPlayerTutorial6.play("popup")

func _on_button_tutorial_6_pressed():
	$PopSfx.play()
	$UI/ControlTutorial/ControlTutorial6/PanelTutorial6/AnimationPlayerTutorial6.play_backwards("popup")
	$UI/ControlTutorial/ControlTutorial7/PanelTutorial7/AnimationPlayerTutorial7.play("popup")

func _on_button_tutorial_7_pressed():
	$PopSfx.play()
	$UI/ControlTutorial/ControlTutorial7/PanelTutorial7/AnimationPlayerTutorial7.play_backwards("popup")
	$UI/ControlTutorial/ControlTutorial8/PanelTutorial8/AnimationPlayerTutorial8.play("popup")

func _on_button_tutorial_8_pressed():
	$PopSfx.play()
	$UI/ControlTutorial/ControlTutorial8/PanelTutorial8/AnimationPlayerTutorial8.play_backwards("popup")
	$UI/ControlTutorial.visible = false
	get_tree().paused = false
	ingametutorial.setTutorialGame(1)
