//: Playground - noun: a place where people can play

import UIKit

let threeDoubles = [Double](count:3, repeatedValue: 0.0)
let anotherDoubles = [Double](count: 3, repeatedValue: 3)
var sixDoubles = threeDoubles+anotherDoubles
//print((sixDoubles+" "+threeDoubles.count+" "+anotherDoubles.capacity)
print("\(sixDoubles)  \(threeDoubles.count)   \(threeDoubles.capacity)")

sixDoubles.insert(4, atIndex: 1)
sixDoubles.removeAtIndex(1)

if #available(iOS 9, OSX 10, *){
    print("iOS 9")
}

func paramtest(inout a: Int,inout _ b: Int){
    a = 1
    b = 2
    print("a+ b = \(a+b)")
}

var a = 10
var b = 20

paramtest(&a,  &b)

print("a = \(a)")

let paramtesttype: (inout Int,inout Int)->Void = paramtest

paramtesttype(&a, &b)

a>b

threeDoubles.sort{$0>$1}

func closurestest(@noescape isok: (Int)->Bool){
    if isok(3) {
        print("is ok!")
    }else{
        print("is not ok!")
    }
}

closurestest{$0>0}
closurestest(){$0>0}
closurestest({(p: Int)->Bool in
        return p > 0
    })

let mapThree = threeDoubles.map { (d: Double) -> Double in
    return d
}

let reduceThree = threeDoubles.reduce(0) { (d, Double) -> Double in
    return d*3
}


/*
  enum.
 */
enum CompassPoint {
    case North
    case South
    case East
    case West
}

var directionToHead = CompassPoint.South
print("direction \(directionToHead)")

enum Planet {
    case Mercury, Venus, Earth, Mars, Jupiter, Saturn, Uranus, Neptune
}

directionToHead = .West

switch directionToHead{
case .North:
    print("Lots of planets hae a north")
case .South:
    print("Watch out for penguins")
//case .East:
//    print("Where the sun rises")
case .West, .East:
    print("Where the skies are blue")
}

let somePlanet = Planet.Neptune
print("Some planet \(somePlanet)")

switch somePlanet{
case .Earth:
    print("Mostly harmless")
default:
    print("Not a safe place for humans")
}

enum Barcode {
    case UPCA(Int, Int, Int, Int)
    case QRCode(String)
}

var productBarcode = Barcode.UPCA(8, 1, 4, 2)
print("Product barcode: \(productBarcode)")

productBarcode = .QRCode("ABCDEFGHIJKLMNOPQ")

switch productBarcode{
case .UPCA(let numberSystem, let manufacturer, let product, let check):
    print("UPC-A: \(numberSystem)")
case .QRCode(let productCode):
    print("QR code: \(productCode)")
}

switch productBarcode{
case let .UPCA(numberSystem, manufacturer, product, check):
    print("UPC-A: \(manufacturer)")
case let .QRCode(productCode):
    print("QR code: \(productCode)")
}


enum ASCIICoutrolCharacter: Character {
    case Tab = "\t"
    case LineFeed = "\n"
    case CarriageReturn = "\r"
}

enum PlanetInt: Int{
    case Mercury = 1, Venus, Earth, Mars, Jupiter, Saturn, Uranus, Neptune
}

let planetInt = PlanetInt.Mars
print("planetInt: \(planetInt)")
planetInt.rawValue

enum CompassPointStr: String {
    case North, South, East, West
}

let earthsOrder = PlanetInt.Earth.rawValue
print("earthsOrder: \(earthsOrder)")

let sunsetDirection = CompassPointStr.West.rawValue
print("sunsetDirection: \(sunsetDirection)")

let possiblePlanet = PlanetInt(rawValue: 2)

let pot = 22
if let somPot = PlanetInt(rawValue: pot){
    switch somPot{
    case .Earth:
        print("Mostly harmless")
    default:
        print("Not a safe place for humans--->")
    }
}else{
    print("There isn't a planet at position \(pot)")
}


//enum ArithmeticExpression {
//    case Number(Int)
//    indirect case Addition(ArithmeticExpression, ArithmeticExpression)
//    indirect case Multiplication(ArithmeticExpression, ArithmeticExpression)
//}

indirect enum ArithmeticExpression{
    case Number(Int)
    case Addition(ArithmeticExpression, ArithmeticExpression)
    case Multiplication(ArithmeticExpression, ArithmeticExpression)
}

let five = ArithmeticExpression.Number(3)
let four = ArithmeticExpression.Number(8)
let sum = ArithmeticExpression.Addition(five, four)
let product = ArithmeticExpression.Multiplication(sum, ArithmeticExpression.Number(2))
print("sum: \(sum) \nproduct: \(product)")

func evaluate(expression: ArithmeticExpression) -> Int {
    switch expression {
    case let .Number(value):
        return value
        
    case let .Addition(left, right):
        return evaluate(left) + evaluate(right)
        
    case let .Multiplication(left, right):
        return evaluate(left) * evaluate(right)
    }
}

print(evaluate(product))




/*
 Class and Structure
 */
struct Resolution{
    var width = 0
    var height = 0
}

class VideoMode {
    var resolutoin = Resolution()
    var interlaced = false
    var frameRate = 0.0
    var name: String?
}

let videoMode: VideoMode = VideoMode()
videoMode.resolutoin.width = 34
videoMode.resolutoin.height
videoMode.frameRate = 2.3
videoMode.interlaced = true

var resolution: Resolution = Resolution(width: 2, height: 3)

resolution.width = 12
resolution.height = 23
print("resolution= \(resolution)")
var rstTest = resolution
rstTest.width = 40
print("rstTest= \(rstTest), resolution= \(resolution)")

var currentDirection = CompassPoint.West
let rememberedDirection = currentDirection
currentDirection = .East
if rememberedDirection == .West{
    print("The remembered direction is still .West")
}

let tenEighty = VideoMode()
tenEighty.resolutoin = resolution
tenEighty.interlaced = true
tenEighty.name = "1080i"
tenEighty.frameRate = 29.0
let alsoTenEighty = tenEighty
alsoTenEighty.frameRate = 40.0
print("The frameRate property of tenEighty is now \(tenEighty.frameRate)")

if tenEighty === alsoTenEighty{
    print("tenEighty and alsoTenEighty refer to the same VideoMode instance.")
}

struct FixedLengthRange {
    var firstValue: Int
    let length: Int
}

var rangeOfThreeItems = FixedLengthRange(firstValue: 0, length: 4)
rangeOfThreeItems.firstValue = 9


class DataImporter{
    var fileName = "data.txt"
}

class DataManager{
    lazy var importer = DataImporter()
    var data = [String]()
}

let manager = DataManager()
manager.data.append("Some data")
manager.data.append("Some more data")
print(manager.importer.fileName)

class StepCounter{
    var totalSteps:Int = 0{
//        willSet(newTotalSteps){
//            print("About to set totalSteps to \(newTotalSteps)")
        willSet{
          print("About to set totalSteps to \(newValue)")
        }
        
        didSet{
            if totalSteps > oldValue {
                print("Added \(totalSteps - oldValue)")
            }
        }
    }
}

let stepCounter = StepCounter()
stepCounter.totalSteps = 200
stepCounter.totalSteps = 360
stepCounter.totalSteps = 896

struct SomeStructure {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int{
        return 1
    }
}

enum SomeEnumeration {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int{
        return 6
    }
}

class SomeClass {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int{
        return 27
    }
    
    class var overrideableComputeTypeProperty: Int {
        return 107
    }
}

print(SomeStructure.storedTypeProperty)

SomeStructure.storedTypeProperty = "Another value."
print(SomeStructure.storedTypeProperty)

print(SomeEnumeration.computedTypeProperty)
print(SomeClass.computedTypeProperty)


struct AudioChannel {
    static let thresholdLevel = 10
    static var maxInputLevelForAllChannels = 0
    
    var currentLevel:Int = 0{
        didSet{
            if currentLevel > AudioChannel.thresholdLevel {
                currentLevel = AudioChannel.thresholdLevel
            }
            
            if currentLevel > AudioChannel.maxInputLevelForAllChannels {
                AudioChannel.maxInputLevelForAllChannels = currentLevel
            }
        }
    }
    
}

var leftChannel = AudioChannel()
var rightChannel = AudioChannel()
leftChannel.currentLevel = 7
print(leftChannel.currentLevel)
print(AudioChannel.maxInputLevelForAllChannels)

rightChannel.currentLevel = 11
print(rightChannel.currentLevel)
print(AudioChannel.maxInputLevelForAllChannels)

class Counter {
    var count = 0
    
    func increment() {
        count += 1
    }
    
    func incrementBy(amount: Int) {
        count += amount
    }
    
    func incrementBy(amount: Int, times numberOfTimes: Int) {
        count += amount * numberOfTimes
    }
    
    func reset(){
        count = 0
    }
}

let counter = Counter()
counter.increment()
counter.incrementBy(5)
counter.reset()
counter.incrementBy(4, times: 12)

print(counter.count)

struct Point{
    var x = 0.0, y = 0.0
    func isToTheRightOfX(x: Double) -> Bool {
        return self.x > x
    }
    
    mutating func moveByX(deltaX: Double, y deltaY: Double){
//        x += deltaX
//        y += deltaY
        self = Point(x: x + deltaX, y: y + deltaY)
    }
}

var somePoint = Point(x: 4.0, y: 5.0)
if somePoint.isToTheRightOfX(1.0){
    print("This point is to the right of the line where x == 1.0")
}
somePoint.moveByX(2.0, y: 4.0)
print("The point is now at (\(somePoint.x), \(somePoint.y))")


enum TriStateSwitch{
    case Off, Low, High
    
    mutating func next(){
        switch self {
        case .Off:
            self = Low
        case .Low:
            self = High
        case .High:
            self = Off
        }
        
        print("value = \(self)")
    }
}

var ovenLight = TriStateSwitch.Low
ovenLight.next()
ovenLight.next()
ovenLight.next()

class SomeClassTest{
    class func someTypeMethod() {
        print("SomeClassTest.someTypeMethod")
    }
}

class SomeClassTestSub: SomeClassTest{
    override class func someTypeMethod(){
        print("SomeClassTestSub.someTypeMethod")
    }
}

SomeClassTest.someTypeMethod()
let someClass = SomeClassTest()
//someClass.someTypeMethod()
UIColor.blueColor()


struct LevelTracker {
    static var highestUnlockedLevel = 1
    
    static func unlockLevel(level: Int){
        if level > highestUnlockedLevel {
            highestUnlockedLevel = level
        }
    }
    
    static func levelIsUnlocked(level: Int) -> Bool{
        return level <= highestUnlockedLevel
    }
    
    var currntLevel = 1
    
    mutating func advanceToLevel(level: Int) -> Bool{
        if LevelTracker.levelIsUnlocked(level) {
            currntLevel = level
            return true
        }else{
            return false
        }
    }
}

class Player{
    var tracker = LevelTracker()
    let playerName: String
    func completedLevel(level: Int){
        LevelTracker.unlockLevel(level + 1)
        tracker.advanceToLevel(level + 1)
    }
    
    subscript(index: Int) -> Int{
        get{
            return 12
        }
        
        set(newValue){
            print("subscript set")
        }
    }
    
    init(name: String){
        playerName = name
    }
}

var player = Player(name: "Argyrios")
player.completedLevel(1)
print("highest unlocked level is now \(LevelTracker.highestUnlockedLevel)")

player = Player(name: "Beto")
if player.tracker.advanceToLevel(6){
    print("player is now on level 6.")
}else{
    print("level 6 has not yet been unlocked.")
}

print("\(player[3])")


var numberOfLegs = ["spider":8];
//public subscript (key: Key) -> Value?
numberOfLegs["bird"]


struct Matrix {
    let rows: Int, columns: Int
    var grid: [Double]
    
    init(rows: Int, columns: Int){
        self.rows = rows
        self.columns = columns
        grid = Array(count: rows * columns, repeatedValue: 0.0)
    }
    
    func indexIsValidForRow(row: Int, column: Int) -> Bool {
        return row >= 0 && row < rows && column < columns && column >= 0
    }
    
    subscript(row: Int, column: Int) -> Double{
        get{
            assert(indexIsValidForRow(row, column: column), "Index out of range")
            return grid[(row*columns) + column]
        }
        
        set {
            assert(indexIsValidForRow(row, column: column), "Index out of range")
            grid[(row * columns) + column] = newValue
        }
    }
}

var matrix = Matrix(rows: 2, columns: 2)
matrix[0, 1] = 1.5
matrix[1, 0] = 3.2


class Vehicle{
    var currentSpeed = 0.0
    var description: String{
        return "traveling at \(currentSpeed) miles perhour"
    }
    
    func makeNoise() {
        print("Vehicle.makeNoise()")
    }
}

class Car: Vehicle {
    var gear = 1
    override var description: String{
        return super.description + " in gear \(gear)"
    }
    
    override func makeNoise() {
        print("Choo Choo")
    }
}

let car = Car()
car.currentSpeed = 24.0
car.gear = 3
print("Car: \(car.description)")
car.makeNoise()

class AutomaticCar: Car{
    override var currentSpeed: Double{
        didSet{
            gear = Int(currentSpeed/10.0) + 1
        }
    }
}

let automatic = AutomaticCar()
automatic.currentSpeed = 45.0
print("AutomaticCar: \(automatic.description)")


/*
  Initialization.
 */

struct Fahrenheit{
    var temperature: Double
    
    init(){
        temperature = 43.0
    }
}

var f = Fahrenheit()
print("The default temperature is \(f.temperature) Fahrenheit")


struct Celsius {
    var temperatureInCelsius: Double
    
    init(fromFahrenheit fahrenheit: Double){
        temperatureInCelsius = (fahrenheit - 32.0)/1.8
    }
    
    init(fromKelvin kelvin: Double){
        temperatureInCelsius = kelvin - 273.15
    }
    
    init(_ celsius: Double){
        temperatureInCelsius = celsius
    }
}

let boilingPointOfWater = Celsius(fromFahrenheit: 212.0)
let freezingPointOfWater = Celsius(fromKelvin: 273.15)
let bodyTemperature = Celsius(34)

class SurveyQuestion {
    var text: String
    var response: String?
    init(text: String){
        self.text = text
    }
    
    func ask() {
        print(text)
    }
}

struct Size {
    var width = 0.0, height = 0.0
}

struct Rect {
    var origin = Point()
    var size = Size()
    init(){}
    init(origin: Point, size: Size){
        self.origin = origin
        self.size = size
    }
    
    init(center: Point, size: Size){
        let originX = center.x - size.width/2
        let originY = center.y - size.height/2
        self.init(origin: Point(x: originX, y: originY), size: size)
    }
}

let basicRect = Rect()

class Food{
    var name: String
    init(name: String){
        self.name = name
    }
    
    convenience init(){
        self.init(name: "[Unnamed]")
    }
}

class RecipeIngredient: Food {
    var quantity: Int
    init(name: String, quantity: Int){
        self.quantity = quantity
        super.init(name: name)
    }
    
    override convenience init(name: String) {
        self.init(name: name, quantity: 1)
    }
}

let oneMysteryItem = RecipeIngredient()
let oneBacon = RecipeIngredient(name: "Bacon")
let sixEggs = RecipeIngredient(name: "Eggs", quantity: 6)

class ShoppingListItem: RecipeIngredient {
    var purchased = false
    var description: String{
        var output = "\(quantity) x \(name)"
        output += purchased ? " ✔":" ✘"
        return output
    }
    
}

var breakfastList = [ShoppingListItem(), ShoppingListItem(name: "Bacon"), ShoppingListItem(name: "Eggs", quantity: 8)]
breakfastList[0].name = "Orange juice"
breakfastList[0].purchased = true
for item in breakfastList{
    print(item.description)
}


struct Chessboard{
    let boardColors: [Bool] = {
        var temporaryBoard = [Bool]()
        var isBlack = false
        
        for i in 1...8{
            for j in 1...8{
                temporaryBoard.append(isBlack)
                isBlack = !isBlack
            }
            
            isBlack = !isBlack
        }
        
        return temporaryBoard
    }()
    
    func squareIsBlackAtRow(row: Int, column: Int) -> Bool {
        return boardColors[(row * 8) + column]
    }
}

let board = Chessboard()
print(board.squareIsBlackAtRow(0, column: 1))
print(board.squareIsBlackAtRow(7, column: 7))


class Bank{
    static var coinsInBank = 10_000
    static func vendCoins(numberOfCoinsRequested: Int) -> Int{
        let numberOfCoinsToVend = min(numberOfCoinsRequested, coinsInBank)
        coinsInBank -= numberOfCoinsToVend
        return numberOfCoinsToVend
    }
    
    static func receiveCoins(coins: Int){
        coinsInBank += coins
    }
}


class PlayerCoins{
    var coinsInPurse: Int
    
    init(coins: Int){
        coinsInPurse = Bank.vendCoins(coins)
    }
    
    func winCoins(coins: Int){
        coinsInPurse += Bank.vendCoins(coins)
    }
    
    deinit{
        Bank.receiveCoins(coinsInPurse)
    }
}

var playerOne: PlayerCoins? = PlayerCoins(coins: 100)
print("A new player has joined the game with \(playerOne!.coinsInPurse) coins")
print("There are now \(Bank.coinsInBank) coins left in the bank")

playerOne!.winCoins(2_000)
print("PlaerOne won 2000 coins & now has \(playerOne!.coinsInPurse) coins")
print("The bank now only has \(Bank.coinsInBank) coins left")

playerOne = nil
print("PlayerOne has left the game")
print("The bank now has \(Bank.coinsInBank) coins")

class Apartment{
    let unit: String
    init(unit: String){ self.unit = unit}
    deinit{ print("Apartment \(unit) is being deinitialized")}
    weak var tenant: Person?
}

class Person{
    let name: String
    init(name: String){
        self.name = name
        print("\(name) is being initialized")
    }
    deinit{
        print("\(name) is being deinitialized")
    }
    
    var apartment: Apartment?
}

var john: Person?
var unit4A: Apartment?

john = Person(name: "John Appleseed")
unit4A = Apartment(unit: "4A")
john!.apartment = unit4A
unit4A!.tenant = john
john = nil
unit4A = nil


class Customer{
    let name: String
    var card: CreditCard?
    init(name: String){ self.name = name}
    deinit{ print("\(name) is being deinitialized")}
}

class CreditCard{
    let number: UInt64
    unowned let customer: Customer
    init(number: UInt64, customer: Customer){
        self.number = number
        self.customer = customer
    }
    deinit{ print("Card #\(number) is being deinitialized")}
}

var customer: Customer? = Customer(name: "John Appleseed")
customer!.card = CreditCard(number: 1234_5678_9012_3456, customer: customer!)


enum VendingMachineError: ErrorType {
    case InvalidSelection
    case InsufficientFounds(coinsNeeded: Int)
    case OutOfStock
}

struct Item {
    var price: Int
    var count: Int
}

class VendingMachine{
    var inventory = [
        "Candy Bar": Item(price: 12, count: 7),
        "Chips": Item(price: 10, count: 4),
        "Pretzels": Item(price: 7, count: 11)
    ]
    
    var coinsDeposited = 0
    
    func dispenseSnack(snack: String) {
        print("Dispensing \(snack)")
    }
    
    func vend(itemNamed name: String) throws -> Void {
        guard let item = inventory[name] else{
            throw VendingMachineError.InsufficientFounds(coinsNeeded: 5)
        }
        
        guard item.count > 0 else {
            throw VendingMachineError.OutOfStock
        }
        
        guard item.price <= coinsDeposited else{
            throw VendingMachineError.InsufficientFounds(coinsNeeded: item.price - coinsDeposited)
        }
        
        coinsDeposited -= item.price
        
        var newItem = item
        newItem.count -= 1
        inventory[name] = newItem
        
        dispenseSnack(name)
    }
    
    let favoriteSnacks = [
        "Alice": "Chips",
        "Bob": "Licorice",
        "Eve": "Pretzels"
    ]
    
    func buyFavoriteSnack(person: String, vendingMachine: VendingMachine)throws -> Void {
        let snackName = favoriteSnacks[person] ?? "Candy Bar"
        try vendingMachine.vend(itemNamed: snackName)
    }
}

struct PurchasedSnack {
    let name: String
    init(name: String, vendingMachine: VendingMachine) throws{
        try vendingMachine.vend(itemNamed: name)
        self.name = name
    }
}

var vendingMachine = VendingMachine()
vendingMachine.coinsDeposited = 8

do{
    try PurchasedSnack(name: "Alice", vendingMachine: vendingMachine)
}catch VendingMachineError.InvalidSelection{
    print("Invalid Selection.")
}catch VendingMachineError.OutOfStock{
    print("Out of Stock.")
}catch VendingMachineError.InsufficientFounds(let coinsNeed){
    print("Insufficient funds. Please insert an additional \(coinsNeed) coins.")
}


func someThrowingFunction() throws -> Int {
    print("some throwing function")
    throw VendingMachineError.OutOfStock
}

let x = try? someThrowingFunction()
let y: Int?

do{
    y = try someThrowingFunction()
}catch{
    y = nil
}




















































