import SwiftyGPIO
import Foundation
import WS281x

class LED {

private let lamp: WS281x
private let numberOfLeds = 120
private(set) var isOn: Bool = false

init() {

let pwms = SwiftyGPIO.hardwarePWMs(for: .RaspberryPiPlusZero)!
let pwm = (pwms[0]?[.P18])!

let w = WS281x(pwm,
               type: .WS2812B,
               numElements: numberOfLeds)

self.lamp = w
}

private(set) var color: UInt32 = 0xFFFFFF

func turnOff() {
    lamp.setLeds([UInt32](repeating: 0x0, count: numberOfLeds))
    isOn = false
    lamp.start()
    lamp.wait()
}

func turnOn() {
    lamp.setLeds([UInt32](repeating: color, count: numberOfLeds))
    isOn = true
    lamp.start()
    lamp.wait()
}

func set(_ newColor: HSV) {
    self.color = newColor.rbgUInt
    lamp.setLeds([UInt32](repeating: self.color, count: numberOfLeds))
    lamp.start()
    lamp.wait()
}

}
