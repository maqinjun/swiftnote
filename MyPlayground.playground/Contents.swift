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


























































