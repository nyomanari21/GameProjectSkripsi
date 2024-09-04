# Class data toko pemain
extends Control


var money:int = 0: get = getMoney, set = setMoney # Variabel penyimpan uang toko pemain
var foodPrice:int = 0: get = getFoodPrice, set = setFoodPrice # Variabel penyimpan harga makanan

var levelProduct:int = 1: get = getLevelProduct, set = setLevelProduct # Variabel penyimpan level kualitas produk makanan
var levelProductUpgradePrice:int = 1000: get = getLevelProductUpgradePrice, set = setLevelProductUpgradePrice # Variabel penyimpan biaya peningkatan level kualitas produk makanan

var promotionBudget:int = 0: get = getPromotionBudget, set = setPromotionBudget # Variabel penyimpan anggaran promosi

var place:int = 1: get = getPlace, set = setPlace # Variabel penyimpan tempat berjualan

var foodStock:int = 0: get = getFoodStock, set = setFoodStock # Variabel penyimpan stok makanan
var foodStockPrice:int = 200: get = getFoodStockPrice, set = setFoodStockPrice # Variabel penyimpan modal stok makanan

var discount:int = 0: get = getDiscount, set = setDiscount # Variabel penyimpan besarnya diskon produk

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

# Setter dan Getter anggaran promosi
func setPromotionBudget(newPromotionBudget):
	promotionBudget = newPromotionBudget

func getPromotionBudget():
	return promotionBudget

# Setter dan Getter tempat berjualan
func setPlace(newPlace):
	place = newPlace

func getPlace():
	return place

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

# Setter dan Getter diskon produk
func setDiscount(newDiscount):
	discount = newDiscount

func getDiscount():
	return discount

# Fungsi untuk reset semua variabel
func resetAllVariable():
	money = 0
	foodPrice = 0
	levelProduct = 1
	levelProductUpgradePrice = 1000
	promotionBudget = 0
	place = 1
	foodStock = 0
	foodStockPrice = 200
	discount = 0
