//: A SpriteKit based Playground

import PlaygroundSupport
import SpriteKit

struct emojiJSON: Codable {
    let no : Int
    let code : String
    let emoji : String
    let description : String
    let flagged : Bool
    let keywords : [String]
    
    enum CodingKeys: String, CodingKey {
            case no = "no"
            case code = "code"
            case emoji = "emoji"
            case description = "description"
            case flagged = "flagged"
            case keywords = "keywords"
    }
}

struct emojiList: Codable {
    let emojis: [emojiJSON]
    
    enum CodingKeys: String, CodingKey{
        case emojis = "Smileys & People"
    }
}



class GameScene: SKScene {
    
    private var label : SKLabelNode!
    private var emoji : SKLabelNode!
    private var spinnyNode : SKShapeNode!
    
    var localData : Data?
    
    var emojiFace : emojiList?
    
    
    
    
    override func didMove(to view: SKView) {
        localData = readLocalJSONFile(forName: "full-emoji-list")
        
        if let data = localData{
            if let emojiObj = parse(jsonData: data){
                emojiFace = emojiObj
            }
        }
        
        // Get label node from scene and store it for use later
        label = childNode(withName: "//helloLabel") as? SKLabelNode
        label.text = "Click Anywhere For A Random Emoji"
        label.numberOfLines = 100
        label.fontSize = 60
        label.alpha = 0.0
        let fadeInOut = SKAction.sequence([.fadeIn(withDuration: 2.0),
                                           .fadeOut(withDuration: 2.0)])
        label.run(.repeatForever(fadeInOut))
        
        emoji = childNode(withName: "//emojiLabel") as? SKLabelNode
        emoji.text = ""
        

        /*let fadeAndRemove = SKAction.sequence([.wait(forDuration: 0.5),
                                               .fadeOut(withDuration: 0.5),
                                               .removeFromParent()])
        emoji.run(.repeatForever(.rotate(byAngle: CGFloat(Double.pi), duration: 1)))
        emoji.run(fadeAndRemove)*/
    }
    
    @objc static override var supportsSecureCoding: Bool {
        // SKNode conforms to NSSecureCoding, so any subclass going
        // through the decoding process must support secure coding
        get {
            return true
        }
    }
    
    func touchDown(atPoint pos : CGPoint) {
        let size = emojiFace?.emojis.endIndex ?? 0
        let rand = Int.random(in: 0..<size)
        emoji.text = emojiFace?.emojis[rand].emoji
        emoji.position = pos
    }
    
    func touchMoved(toPoint pos : CGPoint) {
    }
    
    func touchUp(atPoint pos : CGPoint) {
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { touchUp(atPoint: t.location(in: self)) }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
        
    func readLocalJSONFile(forName name: String) -> Data? {
        if let filePath =  Bundle.main.path(forResource: name, ofType: "json") {
            do {
                let fileUrl = URL(fileURLWithPath: filePath)
                let data = try Data(contentsOf: fileUrl)
                return data
            } catch {
            print("error: \(error)")
            }
        }
        return nil
    }

    func parse(jsonData: Data) -> emojiList? {
        do {
            let decodedData = try JSONDecoder().decode(emojiList.self, from: jsonData)

            return decodedData
        } catch {
            print("error: \(error)")
        }
        return nil
    }
}

// Load the SKScene from 'GameScene.sks'
let sceneView = SKView(frame: CGRect(x:0 , y:0, width: 640, height: 480))
if let scene = GameScene(fileNamed: "GameScene") {
    // Set the scale mode to scale to fit the window
    scene.scaleMode = .aspectFill
    
    // Present the scene
    sceneView.presentScene(scene)
}



PlaygroundSupport.PlaygroundPage.current.liveView = sceneView
