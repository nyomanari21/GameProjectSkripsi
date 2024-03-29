# Class data toko pemain
extends Control


var money:int = 10000: get = getMoney, set = setMoney # Variabel penyimpan uang toko pemain
var foodPrice:int = 0: get = getFoodPrice, set = setFoodPrice # Variabel penyimpan harga makanan
var levelProduct:int = 1: get = getLevelProduct, set = setLevelProduct # Variabel penyimpan level kualitas produk makanan
var levelPromotion:int = 1: get = getLevelPromotion, set = setLevelPromotion # Variabel penyimpan level promosi
var levelPlacement:int = 1: get = getLevelPlacement, set = setLevelPlacement # Variabel penyimpan level distribusi
var foodStock:int = 0: get = getFoodStock, set = setFoodStock # Variabel penyimpan stok makanan


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

# Setter dan Getter level promosi
func setLevelPromotion(newLevelPromotion):
	levelPromotion = newLevelPromotion

func getLevelPromotion():
	return levelPromotion

# Setter dan Getter level distribusi
func setLevelPlacement(newLevelPlacement):
	levelPlacement = newLevelPlacement

func getLevelPlacement():
	return levelPlacement

# Setter dan Getter stok makanan
func setFoodStock(newFoodStock):
	foodStock = newFoodStock

func getFoodStock():
	return foodStock
