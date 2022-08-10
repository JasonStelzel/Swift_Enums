import Foundation

// An Exploration of Swift Enums:

// Definitions:
//
// 1) A Swift enum has traditional "cases"
// 2) A case can have additional "associated data" (numberOfPatties, size, ounces)
// 3) The type of the associated data can be another enum (FryOrderSize)
// 4) A case can also have "unlabeled associated data" (a String value representing a drink's brand)
// 5) When later capturing (retrieving) the associated data within the switch statement, you can use any variable name you like -- it need not be the name used in the original enum declaration for the associated data's label. In fact, in the case of the unlabeled String value for the drink, there IS no label to copy so you MUST supply your own label for this value to represent the brand of drink if it is important to your calculation.
// 6) Another case type can simply be a function which then switches on "self" (isIncludedInSpecialOrder(number: Int) -> Bool { switch self { ... } }) to allow for performing a calculation that takes an argument, in this case, the menu's "burger special" number and performs a calculation and returns a Bool to determine if the matched item(s) of the switch statement is/are included in the special.
// 7) Yet another case type can just be a computed var (calories: Int { switch self { ... } }) which again switches on self but of course does not take any arguments.
// 8) Stored vars are not allowed
// See examples of all of this below.

var lastBurgerSpecial = 6 // burger specials are #1 - #6

enum FastFoodMenuItem {
    case hamburger(numberOfPatties: Int)
    case fries (size: FryOrderSize)
    case drink (String, ounces: Int)
    case cookie
    func isIncludedInSpecialOrder(number: Int) -> Bool {
        switch self {
            case .hamburger(let pattyCount): return pattyCount <= 3 && number <= lastBurgerSpecial
            case .fries, .cookie: return true
            case .drink (_, let oz): return oz == 16 // any drink is valid so we don't care which brand, we only care what size it is and the special only includes a 16 oz beverage.
        }
    }
    var calories: Int {
        switch self {
            case .hamburger(let numberOfPatties): return numberOfPatties * 1000
            case .fries (let size): return size == .small ? 300 : 700
            case .drink (let brand, let ounces):
                let caloriesPerOunce = brand.lowercased().contains("diet") ? 0 : 14
                return ounces * caloriesPerOunce
            case .cookie: return 500
        }
    }
}

enum FryOrderSize {
    case small
    case large
}

func printMenuItem (_ item: FastFoodMenuItem) {
    switch item {
        case .hamburger(let pattyCount): print("burger w/ \(pattyCount) patties!")
        case .fries(let size): print("a \(size) order of fries!")
        case .drink(let brand, let ounces): print("a \(ounces)oz \(brand)")
        case .cookie: print("a cookie")
    }
}


// Very crude usage
var menuItem = FastFoodMenuItem.hamburger(numberOfPatties: 3)
var menuItem2 = FastFoodMenuItem.fries(size: .large)
var menuItem3 = FastFoodMenuItem.drink("Coke", ounces: 16)

var totalCalories: Int = 0
printMenuItem(menuItem)
let addedCost = menuItem.isIncludedInSpecialOrder(number: 7) ? "included in special" : "extra cost"
print (addedCost) //? (try different values for the ounces of Coke, either 16 or 32)
let cals = menuItem.calories //? (add the word "diet" to the drink)
totalCalories += cals
print ("\(cals) Calories")
print()

printMenuItem(menuItem2)
let addedCost2 = menuItem2.isIncludedInSpecialOrder(number: 7) ? "included in special" : "extra cost"
print (addedCost2) //? (checking if the triple burger is part of special #7
let cals2 = menuItem2.calories
totalCalories += cals2
print ("\(cals2) Calories")
print()

printMenuItem(menuItem3)
let addedCost3 = menuItem3.isIncludedInSpecialOrder(number: 7) ? "included in special" : "extra cost"
print (addedCost3) //? (checking if the triple burger is part of special #7
let cals3 = menuItem3.calories
totalCalories += cals3
print ("\(cals3) Calories")
print()
let prompt = totalCalories > 2000 ? "!!!" : ""
print ("Total meal calories = \(totalCalories)"+prompt)


