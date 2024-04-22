# Class data toko pemain
extends Control


var money:int = 1000: get = getMoney, set = setMoney # Variabel penyimpan uang toko pemain
var foodPrice:int = 0: get = getFoodPrice, set = setFoodPrice # Variabel penyimpan harga makanan

var levelProduct:int = 1: get = getLevelProduct, set = setLevelProduct # Variabel penyimpan level kualitas produk makanan
var levelProductUpgradePrice:int = 1000: get = getLevelProductUpgradePrice, set = setLevelProductUpgradePrice # Variabel penyimpan biaya peningkatan level kualitas produk makanan

var levelPromotion:int = 1: get = getLevelPromotion, set = setLevelPromotion # Variabel penyimpan level promosi
var levelPromotionUpgradePrice:int = 1000: get = getLevelPromotionUpgradePrice, set = setLevelPromotionUpgradePrice # Variabel penyimpan biaya peningkatan level promosi

var levelPlacement:int = 1: get = getLevelPlacement, set = setLevelPlacement # Variabel penyimpan level distribusi
var levelPlacementUpgradePrice:int = 1000: get = getLevelPlacementUpgradePrice, set = setLevelPlacementUpgradePrice # Variabel penyimpan biaya peningkatan level distribusi

var foodStock:int = 0: get = getFoodStock, set = setFoodStock # Variabel penyimpan stok makanan
var foodStockPrice:int = 200: get = getFoodStockPrice, set = setFoodStockPrice # Variabel penyimpan modal stok makanan


# Setter dan Getter uang toko
func setMoney(newMoney):
	money = newMoney

func getMoney():
	return money

# Setter dan Getter harga makanan
func setFoodPrice(newFoodPrice):
	foodPrice = newFoodPrice

func getFoodPrice():
	return foodPrice

# Setter dan Getter level kualitas produk makanan
func setLevelProduct(newLevelProduct):
	levelProduct = newLevelProduct

func getLevelProduct():
	return levelProduct

# Setter dan Getter biaya peningkatan level kualitas produk makanan
func setLevelProductUpgradePrice(newLevelProductUpgradePrice):
	levelProductUpgradePrice = newLevelProductUpgradePrice

func getLevelProductUpgradePrice():
	return levelProductUpgradePrice

# Setter dan Getter level promosi
func setLevelPromotion(newLevelPromotion):
	levelPromotion = newLevelPromotion

func getLevelPromotion():
	return levelPromotion

# Setter dan Getter biaya peningkatan level promosi
func setLevelPromotionUpgradePrice(newLevelPromotionUpgradePrice):
	levelPromotionUpgradePrice = newLevelPromotionUpgradePrice

func getLevelPromotionUpgradePrice():
	return levelPromotionUpgradePrice

# Setter dan Getter level distribusi
func setLevelPlacement(newLevelPlacement):
	levelPlacement = newLevelPlacement

func getLevelPlacement():
	return levelPlacement

# Setter dan Getter biaya peningkatan level distribusi
func setLevelPlacementUpgradePrice(newLevelPlacementUpgradePrice):
	levelPlacementUpgradePrice = newLevelPlacementUpgradePrice

func getLevelPlacementUpgradePrice():
	return levelPlacementUpgradePrice

# Setter dan Getter stok makanan
func setFoodStock(newFoodStock):
	foodStock = newFoodStock

func getFoodStock():
	return foodStock

# Setter dan Getter modal stok makanan
func setFoodStockPrice(newFoodStockPrice):
	foodStockPrice = newFoodStockPrice

func getFoodStockPrice():
	return foodStockPrice
