//: Playground - noun: a place where people can play

import UIKit


/*
  Nested Types.
 */

struct BlackjackCard {
    enum Suit: Character {
        case Spades = "♠", Hearts = "♡", Diamonds = "♢", Clubs = "♣"
    }
    
    enum Rank: Int {
        case Tow = 2, Three, Four, Five, Six, Seven, Eight, Nine
        case Jack, Queen, King, Ace
        
        struct Values {
            let first: Int, second: Int?
        }
        
        var values: Values{
            switch self {
            case .Ace:
                return Values(first: 1, second: 11)
            
            case .Jack, .Queen, .King:
                return Values(first: 10, second: nil)
                
            default:
                return Values(first: self.rawValue, second: nil)
            }
        }
    }
    
    let rank: Rank, suit: Suit
    
    var description: String {
        var output = "suit is \(suit.rawValue),"
        output += " value is \(rank.values.first)"
        
        if let second = rank.values.second {
            output += " or \(second)"
        }
        return output
    }
}

let theAceOfSpades = BlackjackCard(rank: .Ace, suit: .Spades)
print("theAceOfSpades: \(theAceOfSpades.description)")

let heartsSymbol = BlackjackCard.Suit.Hearts.rawValue



/*
 Extensions.
 */

//extension ExtRank: Suit, Rank{
//    
//}

extension BlackjackCard{
    
}

extension Double{
    var km: Double{ return self * 1_000.0 }
    var m: Double{ return self }
    var cm: Double{ return self / 100.0 }
    var mm: Double{ return self / 1_000.0 }
    var ft: Double{ return self / 3.28084 }
}

let oneInch = 24.5.mm

print("One inch is \(oneInch)")

let threeFeet = 3.ft
print("Three feet is\(threeFeet) meters")

let aMarathon = 42.km + 195.m
print("A marathon is \(aMarathon) meters long")


struct Size {
    var width = 0.0, height = 0.0
}

struct Point {
    var x = 0.0, y = 0.0
}

struct Rect {
    var origin = Point()
    var size = Size()
}


let defaultRect = Rect()

let memberwiseRect = Rect(origin: Point(x: 2.0, y: 2.0), size: Size(width: 5.0, height: 5.0))

extension Rect{
    init(center: Point, size: Size){
        let originX = center.x - (size.width/2)
        let originY = center.y - (size.height/2)
        self.init(origin: Point(x: originX, y: originY), size: size)
    }
}

let centerRect = Rect(center: Point(x: 4.0, y: 4.0), size: Size(width: 3.0, height: 3.0))

extension Int{
    func repetitions(task:() -> Void) {
        for _ in 0..<self {
            task()
        }
    }
}

3.repetitions { 
    print("Hello!")
}

4.repetitions { 
    print("Goodbye!")
}

print("test")



extension Int{
    mutating func square(){
        self = self * self
    }
}

var someInt = 3
someInt.square()

extension Int{
    subscript(digitIndex: Int) -> Int{
        var decimalBase = 1
        for _ in 0..<digitIndex{
            decimalBase *= 10
        }
        return (self / decimalBase) % 10
    }
}

3234[0]
3234[1]

extension Int{
    enum Kind{
        case Negative, Zero, Positive
    }
    
    var kind: Kind{
        switch self {
        case 0:
            return .Zero
        case let x where x > 0:
            return .Positive
        default:
            return .Negative
        }
    }
}

func printIntegerKinds(numbers: [Int]) {
    for number in numbers{
        switch number.kind {
        case .Negative:
            print("- ", terminator: "")
        case .Zero:
            print("0 ", terminator: "")
        case .Positive:
            print("+ ", terminator: "")
        }
    }
    
    print("")
}

printIntegerKinds([3, 19, -27, 0, -6, 0, 7])


/*
 Protocols.
 */

protocol SomeProtocol {
    var mustBeSettable: Int { get set }
    var doesNotNeedToBeSettable: Int { get }
    init(someParameter: Int)
}

protocol AnotherProtocol {
    static var someTypeProperty: Int{ get set }
}

protocol FullyNamed {
    var fullName: String { get }
}

struct Person: FullyNamed {
    var fullName: String
}

let john = Person(fullName: "John Appleseed")

class Starship: FullyNamed {
    var prefix: String?
    var name: String
    init(name: String, prefix: String? = nil){
        self.name = name
        self.prefix = prefix
    }
    
    var fullName: String{
        return (prefix != nil ? prefix! + " ":"") + name
    }
}

var ncc1701 = Starship(name: "Enterprise", prefix: "USS")
print(ncc1701.fullName)

protocol RandomNumberGenerator {
    func random() -> Double
}

class LinearCongruentialGenerator: RandomNumberGenerator {
    var lastRandom = 42.0
    let m = 139968.0
    let a = 3877.0
    let c = 29573.0
    
    func random() -> Double {
        lastRandom = ((lastRandom * a + c) % m)
        return lastRandom / m
    }
}

let generator = LinearCongruentialGenerator()
print("Here's a random number: \(generator.random())")
print("And another one: \(generator.random())")

protocol Togglable{
    mutating func toggle()
}

enum OnOffSwitch: Togglable {
    case Off, On
    
    mutating func toggle() {
        switch self {
        case .Off:
            self = On
        case .On:
            self = Off
        }
    }
}

var lightSwitch = OnOffSwitch.Off
lightSwitch.toggle()

class SomeClass: SomeProtocol {
    var mustBeSettable: Int
    var doesNotNeedToBeSettable: Int
    required init(someParameter: Int) {
        mustBeSettable = 0
        doesNotNeedToBeSettable = 0
    }
}

//class SomeSubClass:SomeClass, Togglable {
//
//    required override init(someParameter: Int) {
//        
//    }
//}

class Dice{
    let sides: Int
    let generator: RandomNumberGenerator
    init(sides: Int, generator: RandomNumberGenerator){
        self.sides = sides
        self.generator = generator
    }
    
    func roll() -> Int {
        return Int(generator.random() * Double(sides)) + 1
    }
}

var d6 = Dice(sides: 6, generator: LinearCongruentialGenerator())

for _ in 1...5{
    print("Random dice roll is \(d6.roll())")
}

protocol DiceGame {
    var dice: Dice{ get }
    func play()
}

protocol DiceGameDelegate {
    func gameDidStart(game: DiceGame)
    func game(game: DiceGame, didstartNewTurnWithDiceRoll diceRoll: Int)
    func gameDidEnd(game: DiceGame)
}

class SnakesAndLadders: DiceGame {
    let finalSquare = 25
    let dice = Dice(sides: 6, generator: LinearCongruentialGenerator())
    var square = 0
    var board: [Int]
    
    init(){
        board = [Int](count: finalSquare+1, repeatedValue: 0)
        board[03] = +08
        board[06] = +11
        board[09] = +09
        board[10] = +02
        
        board[14] = -10
        board[19] = -11
        board[22] = -02
        board[24] = -08
    }
    
    var delegate: DiceGameDelegate?
    
    func play() {
        square = 0
        delegate?.gameDidStart(self)
        gameLoop: while square != finalSquare{
            let diceRoll = dice.roll()
            delegate?.game(self, didstartNewTurnWithDiceRoll: diceRoll)
            
            switch square + diceRoll {
            case finalSquare:
                break gameLoop
            case let newSquare where newSquare > finalSquare:
                continue gameLoop
            default:
                square += diceRoll
                square += board[square]
            }
        }
        
        delegate?.gameDidEnd(self)
    }
}

class DiceGameTracker: DiceGameDelegate{
    var numberOfTurns = 0
    func gameDidStart(game: DiceGame) {
        numberOfTurns = 0
        if game is SnakesAndLadders {
            print("Started a new game of Snackes and Ladders")
        }
        
        print("The game is using a\(game.dice.sides)- sided dice")
    }
    
    func game(game: DiceGame, didstartNewTurnWithDiceRoll diceRoll: Int) {
        numberOfTurns += 1
        print("Rolled a \(diceRoll)")
    }
    
    func gameDidEnd(game: DiceGame) {
        print("The game lasted for \(numberOfTurns) turns")
    }
}

let tracker = DiceGameTracker()
let game = SnakesAndLadders()

game.delegate = tracker
game.play()



/*
 Adding Protocol Conformance with an Extension.
 */

protocol TextRepresentable {
    var textualDescription: String { get }
}

extension Dice: TextRepresentable{
    var  textualDescription: String{
        return "A \(sides)-sides dice"
    }
    
}


let d12 = Dice(sides: 12, generator: LinearCongruentialGenerator())
print(d12.textualDescription)

extension SnakesAndLadders: TextRepresentable{
    var textualDescription: String{
        return "A game of Snakes and Ladders with \(finalSquare) squares"
    }
}

print(game.textualDescription)


struct Hamster {
    var name: String
    var textualDescription: String{
        return "A hamster named \(name)"
    }
}

extension Hamster: TextRepresentable{}

let simonTheHamster = Hamster(name: "Simon")
let somethingTextRepresentable: TextRepresentable = simonTheHamster
print(somethingTextRepresentable.textualDescription)

let things: [TextRepresentable] = [game, d12, simonTheHamster]

for thing in things{
    print(thing.textualDescription)
}



/*
 Protocol Inheritance.
 */

protocol PrettyTextRepresentable: TextRepresentable {
    var prettyTextualDescription: String { get }
}

extension SnakesAndLadders: PrettyTextRepresentable{
    var prettyTextualDescription: String{
        
        var output = textualDescription + ":\n"
        
        for index in 1...finalSquare {
            switch board[index] {
            case let ladder where ladder > 0:
                output += "▲ "
            case let snake where snake < 0:
                output += "▼ "
            default:
                output += "○ "
            }
        }
        return output
    }
}

print(game.prettyTextualDescription)


/*
 Class-Only Protocols.
 */
protocol SomeClassOnlyProtocol: class, TextRepresentable {
    
}

protocol Named {
    var name: String { get }
}

protocol Aged{
    var age: Int { get }
}

struct FullPerson: Named, Aged {
    var name: String
    var age: Int
}

func wishHappyBirthday(celebrator: protocol<Named, Aged>){
    print("Happy birthday \(celebrator.name) - you're \(celebrator.age)!")
}

let birthdayPerson = FullPerson(name: "Malcolm", age: 21)
wishHappyBirthday(birthdayPerson)


/*
 Checking for Protocol Conformance.
 */

protocol HasArea {
    var area: Double{ get }
}

class Circle: HasArea {
    let pi = 3.1415927
    var radius: Double
    var area: Double { return pi * radius * radius }
    init(radius: Double){ self.radius = radius }
}

class Country: HasArea{
    var area: Double
    init(area: Double){ self.area = area }
}


class Animal {
    var legs: Int
    init(legs: Int){ self.legs = legs }
}


let objects: [AnyObject] = [
    Circle(radius: 2.0),
    Country(area: 243_610),
    Animal(legs: 4)
]

for object in objects{
    if let objectWithArea = object as? HasArea{
        print("Area is \(objectWithArea.area)")
    }else{
        print("Something that doesn't have an area")
    }
}

@objc protocol CounterDataSource{
    optional func incrementForCount(count: Int) -> Int
    optional var fixedIncrement: Int { get }
}

class Counter {
    var count = 0
    var dataSource: CounterDataSource?
    func increment(){
        if let amount = dataSource?.incrementForCount?(count){
            count += amount
        }else if let amount = dataSource?.fixedIncrement{
            count += amount
        }
    }
}

class ThreeSource: NSObject, CounterDataSource {
    let fixedIncrement: Int = 3
}

var counter = Counter()
counter.dataSource = ThreeSource()

for _ in 1...4{
    counter.increment()
    print(counter.count)
}


@objc class TowardsZeroSource: NSObject, CounterDataSource{
    func incrementForCount(count: Int) -> Int {
        if count == 0{
            return 0
        }else if count < 0{
            return 1
        }else {
            return -1
        }
    }
}

counter.count = -4
counter.dataSource = TowardsZeroSource()

for _ in 1...5{
    counter.increment()
    print(counter.count)
}

extension RandomNumberGenerator{
    func randomBool() -> Bool{
        return random() > 0.5
    }
}

let generators = LinearCongruentialGenerator()
print("Here's a random number: \(generators.random())")
print("And here's a random Boolean: \(generators.randomBool())")

extension PrettyTextRepresentable{
    var prettyTextualDescription: String{
        return textualDescription
    }
}

extension CollectionType where Generator.Element: TextRepresentable{
    var textualDescription: String{
        let itemsAsText = self.map { $0.textualDescription }
        return "[" + itemsAsText.joinWithSeparator(",") + "]"
    }
}

let murrayTheHamster = Hamster(name: "Murray")
let morganTheHamster = Hamster(name: "Morgan")
let mauriceTheHamster = Hamster(name: "Maurice")
let hamsters = [murrayTheHamster, morganTheHamster, mauriceTheHamster]

print(hamsters.textualDescription)




/*
 Generics.
 */

func swapTwoInts(inout a: Int, inout _ b: Int) {
    let temporaryA = a
    a = b
    b = temporaryA
}

var someInteger = 3
var anotherInteger = 107
swapTwoInts(&someInt, &anotherInteger)
print("someInt is now \(someInteger), and anotherInt is now \(anotherInteger)")

func swapTwoStrings(inout a: String, inout _ b: String) {
    let temporaryA = a
    a = b
    b = temporaryA
}

func swapTwoDoubles(inout a: Double, inout _ b: Double) {
    let temporaryA = a
    a = b
    b = temporaryA
}

func swapTwoValues<T>(inout a: T, inout _ b: T) {
    let temporaryA = a
    a = b
    b = temporaryA
}

swapTwoValues(&someInteger, &anotherInteger)

var someString = "hello"
var anotherString = "world"

swapTwoValues(&someString, &anotherString)


struct Stack<Element> {
    var items = [Element]()
    mutating func push(item: Element){
        items.append(item)
    }
    mutating func pop() -> Element{
        return items.removeLast()
    }
}

var stackOfStrings = Stack<String>()

stackOfStrings.push("uno")
stackOfStrings.push("dos")
stackOfStrings.push("tres")
stackOfStrings.push("cuatro")

let fromTheTop = stackOfStrings.pop()

extension Stack{
    var topItem: Element?{
        return items.isEmpty ? nil : items[items.count-1]
    }
}

if let topItem = stackOfStrings.topItem{
    print("The top item on the stack is \(topItem).")
}

func someFunction<T: SomeClass, U: SomeProtocol>(someT: T, domeU: U){
    
}

func findStringIndex(array: [String], _ valueToFind: String) -> Int?{
    for (index, value) in array.enumerate() {
        if value == valueToFind {
            return index
        }
    }
    
    return nil
}

let strings = ["cat", "dog", "llama", "parakeet", "terrapin"]
if let foundIndex = findStringIndex(strings, "llama"){
    print("The index of llama is \(foundIndex)")
}

func findIndex<T>(array: [T], _ valueToFind: T) -> Int?{
    for (index, value) in array.enumerate() {
//        let thisValue = value
//        if thisValue == valueToFind {
//            return index
//        }
        
        print("\(index) = \(value)")
    }
    
    return nil
}

findIndex(strings, "llama")

func findIndex<T: Equatable>(array: [T], _ valueToFind: T) -> Int?{
    for (index, value) in array.enumerate(){
        if value == valueToFind{
            return index
        }
    }
    
    return nil
}

let doubleIndex = findIndex([3.14159, 0.1, 0.25], 9.3)

let stringIndex = findIndex(["Mike", "Malcolm", "Andrea"], "Andrea");

protocol Container {
    associatedtype ItemType
    mutating func append(item: ItemType)
    var count: Int { get }
    var fuckingTest: String { get }
    subscript(i: Int) -> ItemType{ get }
}

struct IntStack: Container {
    var items = [Int]()
    
    mutating func push(item: Int){
        items.append(item)
    }
    
    mutating func pop() -> Int{
        return items.removeLast()
    }
    
    typealias ItemType = Int
    
    mutating func append(item: ItemType) {
        self.push(item)
    }
    
    var count: Int{
        return items.count
    }
    
    subscript(i: Int) -> Int{
        return items[i]
    }
    
    var fuckingTest: String{
    
        return "test1..."
    }
}


struct StackItemType<Element>: Container {
    var items = [Element]()
    
    mutating func push(item: Element){
        items.append(item)
    }
    
    mutating func pop() -> Element{
        return items.removeLast()
    }
    
    typealias ItemType = Element
    
    mutating func append(item: ItemType) {
        self.push(item)
    }
    
    var count: Int{
        return items.count
    }
    
    subscript(i: Int) -> Element{
        return items[i]
    }
    
    var fuckingTest: String{
        
        return "test2..."
    }
}


extension Array: Container{
    var fuckingTest: String{
        
        return "test..."
    }
}

var arrs = Array(count:2 , repeatedValue: 0)

arrs.append(3)

print(arrs.fuckingTest)


func allItemsMatch<C1: Container, C2: Container where C1.ItemType == C2.ItemType, C1.ItemType: Equatable>(someContainer: C1, _ anotherContainer: C2) -> Bool{
    if someContainer.count != anotherContainer.count {
        return false
    }
    
    for i in 0 ..<  someContainer.count{
        if someContainer[i] != anotherContainer[i] {
            return false
        }
    }
    
    return true
}

var stackOfStringss = Stack<String>()
stackOfStringss.push("uno")
stackOfStringss.push("dos")
stackOfStringss.push("tres")

var arrayOfStrings = ["uno", "dos", "tres"];
//if allItemsMatch(stackOfStringss, arrayOfStrings){
//    print("All items match.")
//}else {
//    print("Not all items match.")
//}

public struct TrackedString{
    public private(set) var numberOfEdits = 0
    public var value: String = "" {
        didSet{
            numberOfEdits += 1
        }
    }
    
    public init(){}
}


var stringToEdit = TrackedString()
stringToEdit.value = "This string will be tracked."
stringToEdit.value += " This edit will increment numberOfEdits."
stringToEdit.value += " So will this one."
print("The number of edits is \(stringToEdit.numberOfEdits)")
print(stringToEdit.value)














































































