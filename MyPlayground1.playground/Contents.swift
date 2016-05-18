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



















































