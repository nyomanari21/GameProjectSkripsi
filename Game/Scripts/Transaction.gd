# Class data Customer
extends Node


var dailyPositiveFeedback:int = 0: get = getDailyPositiveFeedback, set = setDailyPositiveFeedback # Jumlah feedback positif harian dari customer
var totalPositiveFeedback:int = 0: get = getTotalPositiveFeedback, set = setTotalPositiveFeedback # Jumlah feedback positif total dari customer

var dailyNeutralFeedback:int = 0: get = getDailyNeutralFeedback, set = setDailyNeutralFeedback # Jumlah feedback positif harian dari customer
var totalNeutralFeedback:int = 0: get = getTotalNeutralFeedback, set = setTotalNeutralFeedback # Jumlah feedback netral total dari customer

var dailyNegativeFeedback:int = 0: get = getDailyNegativeFeedback, set = setDailyNegativeFeedback # Jumlah feedback positif harian dari customer
var totalNegativeFeedback:int = 0: get = getTotalNegativeFeedback, set = setTotalNegativeFeedback # Jumlah feedback negatif total dari customer

var dailyCustomer:int = 5: get = getDailyCustomer, set = setDailyCustomer # Jumlah customer yang datang per hari
var totalCustomer:int = 0: get = getTotalCustomer, set = setTotalCustomer # Jumlah total customer yang datang dari semua hari

var income:int = 0: get = getIncome, set = setIncome # Jumlah pendapatan harian

# Setter dan Getter dailyPositiveFeedback
func setDailyPositiveFeedback(newDailyPositiveFeedback):
	dailyPositiveFeedback = newDailyPositiveFeedback

func getDailyPositiveFeedback():
	return dailyPositiveFeedback

# Setter dan Getter totalPositiveFeedback
func setTotalPositiveFeedback(newPositiveFeedback):
	totalPositiveFeedback = newPositiveFeedback

func getTotalPositiveFeedback():
	return totalPositiveFeedback

# Setter dan Getter dailyNeutralFeedback
func setDailyNeutralFeedback(newDailyNeutralFeedback):
	dailyNeutralFeedback = newDailyNeutralFeedback

func getDailyNeutralFeedback():
	return dailyNeutralFeedback

# Setter dan Getter totalNeutralFeedback
func setTotalNeutralFeedback(newNeutralFeedback):
	totalNeutralFeedback = newNeutralFeedback

func getTotalNeutralFeedback():
	return totalNeutralFeedback

# Setter dan Getter dailyNegativeFeedback
func setDailyNegativeFeedback(newDailyNegativeFeedback):
	dailyNegativeFeedback = newDailyNegativeFeedback

func getDailyNegativeFeedback():
	return dailyNegativeFeedback

# Setter dan Getter totalNegativeFeedback
func setTotalNegativeFeedback(newNegativeFeedback):
	totalNegativeFeedback = newNegativeFeedback

func getTotalNegativeFeedback():
	return totalNegativeFeedback

# Setter dan Getter totalCustomer
func setTotalCustomer(newTotalCustomer):
	totalCustomer = newTotalCustomer

func getTotalCustomer():
	return totalCustomer

# Setter dan Getter dailyCustomer
func setDailyCustomer(newDailyCustomer):
	dailyCustomer = newDailyCustomer

func getDailyCustomer():
	return dailyCustomer

# Setter dan Getter income
func setIncome(newIncome):
	income = newIncome

func getIncome():
	return income

# Fungsi untuk reset income
func resetIncome():
	income = 0

# Fungsi untuk menyimpan daily feedback customer ke total feedback customer
func saveTotalFeedback():
	# Feedback positive
	setTotalPositiveFeedback(getTotalPositiveFeedback() + getDailyPositiveFeedback())
	
	# Feedback neutral
	setTotalNeutralFeedback(getTotalNeutralFeedback() + getDailyNeutralFeedback())
	
	# Feedback negative
	setTotalNegativeFeedback(getTotalNegativeFeedback() + getDailyNegativeFeedback())

# Fungsi untuk reset jumlah daily feedback customer
func resetDailyFeedback():
	# Feedback positif
	setDailyPositiveFeedback(0)
	
	# Feedback neutra
	setDailyNeutralFeedback(0)
	
	# Feedback negatif
	setDailyNegativeFeedback(0)

# Fungsi untuk menyimpan total jumlah customer yang datang
func saveTotalCustomer():
	setTotalCustomer(getTotalCustomer() + getDailyCustomer())

# Fungsi untuk menentukan jumlah customer pada hari berikutnya
func calculateNextDailyCustomer():
	var difference = 0
	difference = getDailyPositiveFeedback() - getDailyNegativeFeedback()
	
	# Jika feedback positif lebih banyak, tambah customer sebanyak 2
	if difference > 0:
		setDailyCustomer(getDailyCustomer() + 1)
	# Jika feedback negatif lebih banyak, kurangi customer sebanyak 2
	elif difference < 0:
		setDailyCustomer(getDailyCustomer() - 1)
	# Jika feedback netral (positif dan negatif sama banyak), jumlah customer selanjutnya sama dengan hari sebelumnya
	elif difference == 0:
		setDailyCustomer(getDailyCustomer())

func resetAllVariable():
	dailyPositiveFeedback = 0
	totalPositiveFeedback = 0
	dailyNeutralFeedback = 0
	totalNeutralFeedback = 0
	dailyNegativeFeedback = 0
	totalNegativeFeedback = 0
	dailyCustomer = 5
	totalCustomer = 0
	income = 0
