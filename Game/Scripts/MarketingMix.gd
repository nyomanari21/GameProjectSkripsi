extends Control


var editVariable = 1
var variabelEdited = [false, false, false]
var advertisementNumber = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	# Jalankan tutorial untuk pertama kali
	if ingametutorial.getTutorialMMPlace() == 0:
		_playTutorialPlace()
		ingametutorial.setTutorialMMPlace(1)
	
	# Cek apakah pemain mengatur ulang variabel marketing mix
	# Jika pemain mengatur ulang variabel marketing mix, tampilkan petunjuk
	shop.resetAllVariable()
	transaction.resetAllVariable()
	if shop.getResetVariable() == false:
		$PanelMarketingMix/ControlHint.visible = false
	else:
		$PanelMarketingMix/ControlHint.visible = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Atur tampilan harga kopi yang muncul di layar
	$PanelMarketingMix/ControlPricePromotion/PanelPrice/LabelPrice.text = "Harga Kopi: " + str(shop.getFoodPrice()) + "G"
	
	# Atur tampilan besarnya diskon yang muncul di layar
	$PanelMarketingMix/ControlPricePromotion/PanelDiscount/LabelDiscount.text = "Diskon: " + str(shop.getDiscount())
	
	# Atur tombol 'ButtonNext' agar dinonaktifkan ketika ada variabel yang belum diatur
	if editVariable == 1:
		if variabelEdited[0] == false:
			$PanelMarketingMix/ButtonNext.disabled = true
		else:
			$PanelMarketingMix/ButtonNext.disabled = false
		
		# Atur petunjuk yang muncul ke layar
		if $PanelMarketingMix/ControlHint.visible == true:
			$PanelMarketingMix/ControlHint/PanelHint1.visible = true
			$PanelMarketingMix/ControlHint/PanelHint2.visible = false
			$PanelMarketingMix/ControlHint/PanelHint3.visible = false
	
	if editVariable == 2:
		if variabelEdited[1] == false:
			$PanelMarketingMix/ButtonNext.disabled = true
		else:
			$PanelMarketingMix/ButtonNext.disabled = false
		
		# Atur petunjuk yang muncul ke layar
		if $PanelMarketingMix/ControlHint.visible == true:
			$PanelMarketingMix/ControlHint/PanelHint2.visible = true
			$PanelMarketingMix/ControlHint/PanelHint1.visible = false
			$PanelMarketingMix/ControlHint/PanelHint3.visible = false
	
	if editVariable == 3:
		if variabelEdited[2] == false:
			$PanelMarketingMix/ButtonNext.disabled = true
		else:
			$PanelMarketingMix/ButtonNext.disabled = false
		
		# Atur petunjuk yang muncul ke layar
		if $PanelMarketingMix/ControlHint.visible == true:
			$PanelMarketingMix/ControlHint/PanelHint3.visible = true
			$PanelMarketingMix/ControlHint/PanelHint1.visible = false
			$PanelMarketingMix/ControlHint/PanelHint2.visible = false

# Fungsi-fungsi tombol Selanjutnya dan Kembali untuk berpindah halaman
func _on_buttonNext_pressed():
	$PopSfx.play()
	editVariable += 1
	
	if editVariable == 2:
		$PanelMarketingMix/ControlPlace.visible = false
		$PanelMarketingMix/ControlProduct.visible = true
		
		$PanelMarketingMix/ButtonPrev.disabled = false
		
		if ingametutorial.getTutorialMMProduct() == 0:
			_playTutorialProduct()
			ingametutorial.setTutorialMMProduct(1)
	
	if editVariable == 3:
		$PanelMarketingMix/ControlProduct.visible = false
		$PanelMarketingMix/ControlPricePromotion.visible = true
		
		$PanelMarketingMix/ButtonNext.text = "Mulai Main"
		
		if ingametutorial.getTutorialMMPrice() == 0:
			_playTutorialPrice()
			ingametutorial.setTutorialMMPrice(1)
	
	if editVariable == 4:
		if shop.getPlace() == 1:
			get_tree().change_scene_to_file("res://Scenes/GamePark.tscn")
		elif shop.getPlace() == 2:
			get_tree().change_scene_to_file("res://Scenes/GameDowntown.tscn")
		elif shop.getPlace() == 3:
			get_tree().change_scene_to_file("res://Scenes/GameMall.tscn")

func _on_buttonPrev_pressed():
	$PopSfx.play()
	editVariable -= 1
	
	if editVariable == 2:
		$PanelMarketingMix/ControlPricePromotion.visible = false
		$PanelMarketingMix/ControlProduct.visible = true
		
		$PanelMarketingMix/ButtonNext.text = "Selanjutnya"
	
	if editVariable == 1:
		$PanelMarketingMix/ControlProduct.visible = false
		$PanelMarketingMix/ControlPlace.visible = true
	
	if editVariable == 0:
		get_tree().change_scene_to_file("res://Scenes/Introduction.tscn")

# Fungsi-fungsi pengatur variabel Place (Tempat)
func _on_buttonSelectPark_pressed():
	$PopSfx.play()
	# Set tempat yang dipilih pemain adalah Taman
	$PanelMarketingMix/ControlPlace/PanelPark/ButtonSelectPark.disabled = true
	shop.setPlace(1)
	$PanelMarketingMix/ControlPlace/PanelMall/ButtonSelectMall.disabled = false
	$PanelMarketingMix/ControlPlace/PanelDowntown/ButtonSelectDowntown.disabled = false
	
	variabelEdited[0] = true

func _on_buttonSelectDowntown_pressed():
	$PopSfx.play()
	# Set tempat yang dipilih pemain adalah Pusat Kota
	$PanelMarketingMix/ControlPlace/PanelDowntown/ButtonSelectDowntown.disabled = true
	shop.setPlace(2)
	$PanelMarketingMix/ControlPlace/PanelPark/ButtonSelectPark.disabled = false
	$PanelMarketingMix/ControlPlace/PanelMall/ButtonSelectMall.disabled = false
	
	variabelEdited[0] = true

func _on_buttonSelectMall_pressed():
	$PopSfx.play()
	# Set tempat yang dipilih pemain adalah Mall
	$PanelMarketingMix/ControlPlace/PanelMall/ButtonSelectMall.disabled = true
	shop.setPlace(3)
	$PanelMarketingMix/ControlPlace/PanelPark/ButtonSelectPark.disabled = false
	$PanelMarketingMix/ControlPlace/PanelDowntown/ButtonSelectDowntown.disabled = false
	
	variabelEdited[0] = true

# Fungsi-fungsi pengatur variabel Product (Produk)
func _on_buttonProduct1_pressed():
	$PopSfx.play()
	# Set kualitas kopi yang dipilih adalah Biasa
	$PanelMarketingMix/ControlProduct/PanelProduct1/ButtonProduct1.disabled = true
	shop.setLevelProduct(1)
	shop.setFoodStockPrice(200)
	$PanelMarketingMix/ControlProduct/PanelProduct2/ButtonProduct2.disabled = false
	$PanelMarketingMix/ControlProduct/PanelProduct3/ButtonProduct3.disabled = false
	
	variabelEdited[1] = true

func _on_buttonProduct2_pressed():
	$PopSfx.play()
	# Set kualitas kopi yang dipilih adalah Biasa
	$PanelMarketingMix/ControlProduct/PanelProduct2/ButtonProduct2.disabled = true
	shop.setLevelProduct(2)
	shop.setFoodStockPrice(400)
	$PanelMarketingMix/ControlProduct/PanelProduct1/ButtonProduct1.disabled = false
	$PanelMarketingMix/ControlProduct/PanelProduct3/ButtonProduct3.disabled = false
	
	variabelEdited[1] = true

func _on_buttonProduct3_pressed():
	$PopSfx.play()
	# Set kualitas kopi yang dipilih adalah Biasa
	$PanelMarketingMix/ControlProduct/PanelProduct3/ButtonProduct3.disabled = true
	shop.setLevelProduct(3)
	shop.setFoodStockPrice(600)
	$PanelMarketingMix/ControlProduct/PanelProduct1/ButtonProduct1.disabled = false
	$PanelMarketingMix/ControlProduct/PanelProduct2/ButtonProduct2.disabled = false
	
	variabelEdited[1] = true

# Fungsi-fungsi pengatur variabel Price
func _on_buttonIncPrice_pressed():
	$PopSfx.play()
	# Tambah harga kopi
	shop.setFoodPrice(shop.getFoodPrice() + 50)
	variabelEdited[2] = true

func _on_buttonDecPrice_pressed():
	$PopSfx.play()
	# Kurangi harga kopi
	if shop.getFoodPrice() > 0:
		shop.setFoodPrice(shop.getFoodPrice() - 50)
	
	if shop.getFoodPrice() == 0:
		variabelEdited[2] = false

# Fungsi-fungsi pengatur variabel Promotion
# Fungsi pengatur anggaran iklan
func _on_buttonAdPlus_pressed():
	$PopSfx.play()
	# Tambah anggaran iklan
	#shop.setPromotionBudget(shop.getPromotionBudget() + 500)
	
	if advertisementNumber < 5:
		advertisementNumber += 1
	
	if advertisementNumber == 1:
		$PanelMarketingMix/ControlPricePromotion/PanelAdvertisement/LabelAdvertisement.text = "Anggaran Iklan: Iklan Media Sosial 500G"
		shop.setPromotionBudget(500)
	elif advertisementNumber == 2:
		$PanelMarketingMix/ControlPricePromotion/PanelAdvertisement/LabelAdvertisement.text = "Anggaran Iklan: Iklan Koran 1000G"
		shop.setPromotionBudget(1000)
	elif advertisementNumber == 3:
		$PanelMarketingMix/ControlPricePromotion/PanelAdvertisement/LabelAdvertisement.text = "Anggaran Iklan: Iklan Billboard 1500G"
		shop.setPromotionBudget(1500)
	elif advertisementNumber == 4:
		$PanelMarketingMix/ControlPricePromotion/PanelAdvertisement/LabelAdvertisement.text = "Anggaran Iklan: Iklan Radio 2500G"
		shop.setPromotionBudget(2500)
	elif advertisementNumber == 5:
		$PanelMarketingMix/ControlPricePromotion/PanelAdvertisement/LabelAdvertisement.text = "Anggaran Iklan: Iklan TV 5000G"
		shop.setPromotionBudget(5000)

func _on_buttonAdMin_pressed():
	$PopSfx.play()
	# Kurangi anggaran iklan
	#if shop.getPromotionBudget() > 0:
	#	shop.setPromotionBudget(shop.getPromotionBudget() - 500)
	
	if advertisementNumber > 0:
		advertisementNumber -= 1
	
	if advertisementNumber == 0:
		$PanelMarketingMix/ControlPricePromotion/PanelAdvertisement/LabelAdvertisement.text = "Anggaran Iklan: -"
		shop.setPromotionBudget(0)
	elif advertisementNumber == 1:
		$PanelMarketingMix/ControlPricePromotion/PanelAdvertisement/LabelAdvertisement.text = "Anggaran Iklan: Iklan Media Sosial 500G"
		shop.setPromotionBudget(500)
	elif advertisementNumber == 2:
		$PanelMarketingMix/ControlPricePromotion/PanelAdvertisement/LabelAdvertisement.text = "Anggaran Iklan: Iklan Koran 1000G"
		shop.setPromotionBudget(1000)
	elif advertisementNumber == 3:
		$PanelMarketingMix/ControlPricePromotion/PanelAdvertisement/LabelAdvertisement.text = "Anggaran Iklan: Iklan Billboard 1500G"
		shop.setPromotionBudget(1500)
	elif advertisementNumber == 4:
		$PanelMarketingMix/ControlPricePromotion/PanelAdvertisement/LabelAdvertisement.text = "Anggaran Iklan: Iklan Radio 2500G"
		shop.setPromotionBudget(2500)

# Fungsi pengatur besarnya diskon
func _on_buttonDiscountPlus_pressed():
	if shop.getDiscount() < 100:
		shop.setDiscount(shop.getDiscount() + 5)

func _on_buttonDiscountMin_pressed():
	if shop.getDiscount() > 0:
		shop.setDiscount(shop.getDiscount() - 5)


# Fungsi-fungsi pengatur Tutorial
func _playTutorialPlace():
	$PanelMarketingMix/ControlTutorial.visible = true
	$PanelMarketingMix/ControlTutorial/ControlTutorialPlace.visible = true
	$PanelMarketingMix/ControlTutorial/ControlTutorialPlace/PanelTutorialPlace/AnimationPlayerTutorialPlace.play("popup")

func _on_button_close_tutorial_place_pressed():
	$PanelMarketingMix/ControlTutorial/ControlTutorialPlace/PanelTutorialPlace/AnimationPlayerTutorialPlace.play_backwards("popup")
	$PanelMarketingMix/ControlTutorial.visible = false
	$PanelMarketingMix/ControlTutorial/ControlTutorialPlace.visible = false

func _playTutorialProduct():
	$PanelMarketingMix/ControlTutorial.visible = true
	$PanelMarketingMix/ControlTutorial/ControlTutorialProduct.visible = true
	$PanelMarketingMix/ControlTutorial/ControlTutorialProduct/PanelTutorialProduct/AnimationPlayerTutorialProduct.play("popup")

func _on_button_close_tutorial_product_pressed():
	$PanelMarketingMix/ControlTutorial/ControlTutorialProduct/PanelTutorialProduct/AnimationPlayerTutorialProduct.play_backwards("popup")
	$PanelMarketingMix/ControlTutorial.visible = false
	$PanelMarketingMix/ControlTutorial/ControlTutorialProduct.visible = false

func _playTutorialPrice():
	$PanelMarketingMix/ControlTutorial.visible = true
	$PanelMarketingMix/ControlTutorial/ControlTutorialPricePromotion.visible = true
	$PanelMarketingMix/ControlTutorial/ControlTutorialPricePromotion/PanelTutorialPrice/AnimationPlayerTutorialPrice.play("popup")

func _on_button_close_tutorial_price_pressed():
	$PanelMarketingMix/ControlTutorial/ControlTutorialPricePromotion/PanelTutorialPrice/AnimationPlayerTutorialPrice.play_backwards("popup")
	$PanelMarketingMix/ControlTutorial.visible = false
	$PanelMarketingMix/ControlTutorial/ControlTutorialPricePromotion.visible = false
	
	if ingametutorial.getTutorialMMPromotion() == 0:
			_playTutorialPromotion()
			ingametutorial.setTutorialMMPromotion(1)

func _playTutorialPromotion():
	$PanelMarketingMix/ControlTutorial.visible = true
	$PanelMarketingMix/ControlTutorial/ControlTutorialPricePromotion.visible = true
	$PanelMarketingMix/ControlTutorial/ControlTutorialPricePromotion/PanelTutorialPromotion/AnimationPlayerTutorialPromotion.play("popup")

func _on_button_close_tutorial_promotion_pressed():
	$PanelMarketingMix/ControlTutorial/ControlTutorialPricePromotion/PanelTutorialPromotion/AnimationPlayerTutorialPromotion.play_backwards("popup")
	$PanelMarketingMix/ControlTutorial.visible = false
	$PanelMarketingMix/ControlTutorial/ControlTutorialPricePromotion.visible = false
