# Class data toko pemain
extends Control


var money:int = 0 setget setMoney, getMoney # Variabel penyimpan uang toko pemain
var foodPrice:int = 0 setget setFoodPrice, getFoodPrice # Variabel penyimpan harga makanan

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
