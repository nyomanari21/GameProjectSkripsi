extends Node

var tutorialMMPlace:int = 0: get = getTutorialMMPlace, set = setTutorialMMPlace
var tutorialMMProduct:int = 0: get = getTutorialMMProduct, set = setTutorialMMProduct
var tutorialMMPrice:int = 0: get = getTutorialMMPrice, set = setTutorialMMPrice
var tutorialMMPromotion:int = 0: get = getTutorialMMPromotion, set = setTutorialMMPromotion
var tutorialGame:int = 0: get = getTutorialGame, set = setTutorialGame

# Setter dan Getter tutorial marketing mix place
func setTutorialMMPlace(newTutorialMMPlace):
	tutorialMMPlace = newTutorialMMPlace
	
func getTutorialMMPlace():
	return tutorialMMPlace

# Setter dan Getter tutorial marketing mix product
func setTutorialMMProduct(newTutorialMMProduct):
	tutorialMMProduct = newTutorialMMProduct
	
func getTutorialMMProduct():
	return tutorialMMProduct

# Setter dan Getter tutorial marketing mix price
func setTutorialMMPrice(newTutorialMMPrice):
	tutorialMMPrice = newTutorialMMPrice
	
func getTutorialMMPrice():
	return tutorialMMPrice

# Setter dan Getter tutorial marketing mix promotion
func setTutorialMMPromotion(newTutorialMMPromotion):
	tutorialMMPromotion = newTutorialMMPromotion
	
func getTutorialMMPromotion():
	return tutorialMMPromotion

# Setter dan Getter tutorial game
func setTutorialGame(newTutorialGame):
	tutorialGame = newTutorialGame

func getTutorialGame():
	return tutorialGame
