import Kitura
import Foundation

let router = Router()
let ledStrip = LED()
var currentHue: Float = 360
var currentSaturation: Float = 0
var currentBrightness: Float = 1

router.get("color/:hue/:saturation/:brightness") { request, response, next in
    currentHue = Float(request.parameters["hue"]!)!
    currentSaturation = Float(request.parameters["saturation"]!)! / 100
    currentBrightness = Float(request.parameters["brightness"]!)! / 100
    ledStrip.set(HSV(h: currentHue, s: currentSaturation, v: currentBrightness))

    next()
}


router.get("led/on") { request, response, next in
    response.send("on")
    ledStrip.turnOn()
    next()
}

router.get("led/off") { request, response, next in
    response.send("Off")
    ledStrip.turnOff()
    next()
}

router.get("led/status") { request, response, next in
    let state = ledStrip.isOn ? "1" : "0"
    response.send(state)
    next()
}

router.get("led/hue/:hue") { request, response, next in
    let hue = Float(request.parameters["hue"]!)!
    currentHue = hue
    ledStrip.set(HSV(h: hue, s: currentSaturation, v: currentBrightness))
    response.send("\(hue)")
    next()
}

router.get("led/hue/current/status") { request, response, next in
    response.send("\(Int(currentHue))")
    next()
}

router.get("led/saturation/set/:saturation") { request, response, next in
    currentSaturation = Float(request.parameters["saturation"]!)! / 100
    response.send("New Saturation")
    ledStrip.set(HSV(h: currentHue, s: currentSaturation, v: currentBrightness))
    next()
}

router.get("led/saturation/get") { request, response, next in
    response.send("\(currentSaturation * 100)")
    next()
}

router.get("led/brightness/set/:brightness") { request, response, next in
   currentBrightness = Float(request.parameters["brightness"]!)! / 100
   response.send("new brightness")
   ledStrip.set(HSV(h: currentHue, s: currentSaturation, v: currentBrightness))
   next()
}

router.get("led/brightness/get") { request, response, next in
   response.send("\(currentBrightness * 100)")
   next()
}

Kitura.addHTTPServer(onPort: 8080, with: router)
Kitura.run()
