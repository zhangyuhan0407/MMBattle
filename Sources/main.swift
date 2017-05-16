//zyh


import Foundation
import Kitura
import OCTJSON
import OCTFoundation

#if os(Linux)
    import Glibc
#endif


// All Web apps need a router to define routes
let router = Router()



router.get("/test", middleware: MMTestMiddleware())


//@deprecated
//router.get("/pve/:battleid", middleware: MMPVECheckMissionMiddleware())

router.post("/pve/:battleid/:key", middleware: MMPVEBattleMiddleware())




router.post("/pvp/training", middleware: MMPVPTrainningMiddleware())




router.post("/pvp/match/message", middleware: MMPVPMatchMessageMiddleware())

router.post("/pvp/match", middleware: MMPVPMatchMiddleware())



router.post("/pvp/message", middleware: MMPVPBattleMessageMiddleware())

router.post("/pvp", middleware: MMPVPBattleMiddleware())




//@deprecated
//router.get("/player/:playerkey/:type", middleware: MMCheckPlayerMiddleware())


router.get("battles") { (request, response, next) in
    
    let battles = MMPVPBattleManager.battles.map {
        return $0.key
    }
    
    try response.send(battles.joined(separator: "\n")).end()
}

//router.get("/redir") { _, response, next in
//    try response.redirect("http://www.baidu.com")
//}



//
//KituraRequest.request(Request.Method.get, "http://www.baidu.com").response { (request, response, data, error) in
//    
//    let s = String(bytes: data!, encoding: String.Encoding.utf8)
//    
//    
//    print(s)
//    
//}


//let shell = "pwd"

//let task = Process()
//task.launchPath = "/bin/bash"
//task.arguments = ["-c", "/Users/yorg/Desktop/main.swift aa bb cc dd"]
//
//task.launch()
//
//let params = dump(ProcessInfo.processInfo.arguments)




// Using an implementation for a Logger
//Log.logger = HeliumLogger()


// Add HTTP Server to listen on port 8090
Kitura.addHTTPServer(onPort: 8900, with: router)


// start the framework - the servers added until now will start listening
Kitura.run()







