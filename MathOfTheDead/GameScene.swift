//
//  GameScene.swift
//  MathoftheDead
//
//  Created by Rachel Shellborn on 2017-01-27.
//  Copyright © 2017 Rachel Shellborn. All rights reserved.
//
import SpriteKit

class GameScene: SKScene {
    //bullet queue numbers
    
    
    var gradientLayer: CAGradientLayer!
    
    var plusGun:SKSpriteNode!
    var diviGun:SKSpriteNode!
    var minusGun:SKSpriteNode!
    var multiGun:SKSpriteNode!
    
    var plusGunBox: SKShapeNode!
    var minusGunBox: SKShapeNode!
    var diviGunBox: SKShapeNode!
    var multiGunBox: SKShapeNode!
    
    
    var pauseButton:SKLabelNode!
    var pauseButtonBox:SKShapeNode!
    
    var waveNumberBox:SKShapeNode!
    var waveNumberLabel:SKLabelNode!
    
    var scoreDisplayBox:SKShapeNode!
    var scoreDisplayLabel:SKLabelNode!
    
    
    
    var bullQueue0Box:SKShapeNode!
    var bullQueue0Label:SKLabelNode!
    
    var bullQueue1Box:SKShapeNode!
    var bullQueue1Label:SKLabelNode!
    
    var bullQueue2Box:SKShapeNode!
    var bullQueue2Label:SKLabelNode!
    
    var bullQueue3Box:SKShapeNode!
    var bullQueue3Label:SKLabelNode!
    
    var bullQueue4Box:SKShapeNode!
    var bullQueue4Label:SKLabelNode!
    
    
    
    var EndOfGameLine:SKShapeNode!
    
    var walkFrames: [SKTexture]!
    var zombieAnimation: SKAction!
    
    override func didMove(to view: SKView) {
        
        addingGuns()
        addingGameOverLine()
        addingTopMenuBar(zvalue: 2.0)
        addBulletQueue(zvalue: 2.0)
        
        walkFrames = [SKTexture]()
        
        walkFrames.append(SKTexture(imageNamed: "zombie"))
        walkFrames.append(SKTexture(imageNamed: "zombie2"))
        
        zombieAnimation = SKAction.animate(with: walkFrames,
                                               timePerFrame: 0.6)
        
        run(SKAction.repeatForever(
            SKAction.sequence([
                SKAction.run(addZombie),
                SKAction.wait(forDuration: 4.0)
                ])
        ))
    }
    
    func addingTopMenuBar(zvalue : Double){
        let menuWidth = frame.width/3
        let menuHeight = frame.height/16
        
        var xPos = frame.minX
        var yPos = frame.maxY - menuHeight
        pauseButtonBox = SKShapeNode()
        pauseButtonBox.path = UIBezierPath(roundedRect: CGRect(x: xPos,
                                                               y: yPos,
                                                               width: menuWidth,
                                                               height: menuHeight), cornerRadius: 0).cgPath
        pauseButtonBox.fillColor = UIColor.red
        pauseButtonBox.strokeColor = UIColor.black
        pauseButtonBox.lineWidth = frame.size.width * 0.01
        pauseButtonBox.zPosition = CGFloat(zvalue);
        addChild(pauseButtonBox)
        
        
        pauseButton = SKLabelNode(fontNamed: "Arial")
        pauseButton.text = "PAUSE"
        pauseButton.fontSize = 20
        
        // Determine the font scaling factor that should let the label text fit in the given rectangle.
        let scalingFactor = min(pauseButtonBox.frame.width / pauseButton.frame.width, pauseButtonBox.frame.height / pauseButton.frame.height)
        
        // Change the fontSize.
        pauseButton.fontSize *= scalingFactor
        
        // Optionally move the SKLabelNode to the center of the rectangle.
        pauseButton.position = CGPoint(x: pauseButtonBox.frame.midX, y: pauseButtonBox.frame.midY - pauseButton.frame.height / 2.0)
        pauseButton.zPosition = CGFloat(zvalue);
        addChild(pauseButton)
        
        xPos = xPos + menuWidth
        yPos = frame.maxY - menuHeight
        waveNumberBox = SKShapeNode()
        waveNumberBox.path = UIBezierPath(roundedRect: CGRect(x: xPos,
                                                              y: yPos,
                                                              width: menuWidth,
                                                              height: menuHeight), cornerRadius: 0).cgPath
        waveNumberBox.fillColor = UIColor.red
        waveNumberBox.strokeColor = UIColor.black
        waveNumberBox.lineWidth = frame.size.width * 0.01
        waveNumberBox.zPosition = CGFloat(zvalue);
        addChild(waveNumberBox)
        
        
        xPos = xPos + menuWidth
        yPos = frame.maxY - menuHeight
        scoreDisplayBox = SKShapeNode()
        scoreDisplayBox.path = UIBezierPath(roundedRect: CGRect(x: xPos,
                                                                y: yPos,
                                                                width: menuWidth,
                                                                height: menuHeight), cornerRadius: 0).cgPath
        scoreDisplayBox.fillColor = UIColor.red
        scoreDisplayBox.strokeColor = UIColor.black
        scoreDisplayBox.lineWidth = frame.size.width * 0.01
        scoreDisplayBox.zPosition = CGFloat(zvalue);
        addChild(scoreDisplayBox)
        
    }
    
    func addBulletQueue(zvalue: Double){
        let queueWidth = frame.width * 0.1875
        let queueHeight = frame.height/16
        
        
        var xPos = frame.minX
        var yPos = frame.maxY - queueHeight*2
        bullQueue0Box = SKShapeNode()
        bullQueue0Box.path = UIBezierPath(roundedRect: CGRect(x: xPos,
                                                              y: yPos,
                                                              width: queueWidth,
                                                              height: queueHeight), cornerRadius: 0).cgPath
        bullQueue0Box.fillColor = UIColor.gray
        bullQueue0Box.strokeColor = UIColor.black
        bullQueue0Box.lineWidth = frame.size.width * 0.01
        bullQueue0Box.zPosition = CGFloat(zvalue);
        addChild(bullQueue0Box)
        
        var bullet0 = SKSpriteNode(imageNamed: "bullet");
        var aspectRatio = bullet0.size.width/bullet0.size.height
        bullet0.size = CGSize(width: bullQueue0Box.frame.width, height: bullQueue0Box.frame.width/aspectRatio)
        
        bullet0.position = CGPoint(x: bullQueue0Box.frame.midX, y: bullQueue0Box.frame.midY)
        bullet0.zPosition = CGFloat(zvalue);
        addChild(bullet0)
        
        
        xPos = frame.minX + queueWidth
        yPos = frame.maxY - queueHeight*2
        bullQueue1Box = SKShapeNode()
        bullQueue1Box.path = UIBezierPath(roundedRect: CGRect(x: xPos,
                                                              y: yPos,
                                                              width: queueWidth,
                                                              height: queueHeight), cornerRadius: 0).cgPath
        bullQueue1Box.fillColor = UIColor.gray
        bullQueue1Box.strokeColor = UIColor.black
        bullQueue1Box.lineWidth = frame.size.width * 0.01
        bullQueue1Box.zPosition = CGFloat(zvalue);
        addChild(bullQueue1Box)
        
        var bullet1 = SKSpriteNode(imageNamed: "bullet");
        aspectRatio = bullet1.size.width/bullet1.size.height
        bullet1.size = CGSize(width: bullQueue1Box.frame.width, height: bullQueue0Box.frame.width/aspectRatio)
        
        bullet1.position = CGPoint(x: bullQueue1Box.frame.midX, y: bullQueue1Box.frame.midY)
        bullet1.zPosition = CGFloat(zvalue);
        addChild(bullet1)
        
        xPos = xPos + queueWidth
        bullQueue2Box = SKShapeNode()
        bullQueue2Box.path = UIBezierPath(roundedRect: CGRect(x: xPos,
                                                              y: yPos,
                                                              width: queueWidth,
                                                              height: queueHeight), cornerRadius: 0).cgPath
        bullQueue2Box.fillColor = UIColor.gray
        bullQueue2Box.strokeColor = UIColor.black
        bullQueue2Box.lineWidth = frame.size.width * 0.01
        bullQueue2Box.zPosition = CGFloat(zvalue);
        addChild(bullQueue2Box)
        
        var bullet2 = SKSpriteNode(imageNamed: "bullet");
        aspectRatio = bullet2.size.width/bullet2.size.height
        bullet2.size = CGSize(width: bullQueue2Box.frame.width, height: bullQueue2Box.frame.width/aspectRatio)
        
        bullet2.position = CGPoint(x: bullQueue2Box.frame.midX, y: bullQueue2Box.frame.midY)
        bullet2.zPosition = CGFloat(zvalue);
        addChild(bullet2)
        
        
        xPos = xPos + queueWidth
        bullQueue3Box = SKShapeNode()
        bullQueue3Box.path = UIBezierPath(roundedRect: CGRect(x: xPos,
                                                              y: yPos,
                                                              width: queueWidth,
                                                              height: queueHeight), cornerRadius: 0).cgPath
        bullQueue3Box.fillColor = UIColor.gray
        bullQueue3Box.strokeColor = UIColor.black
        bullQueue3Box.lineWidth = frame.size.width * 0.01
        bullQueue3Box.zPosition = CGFloat(zvalue);
        addChild(bullQueue3Box)
        
        var bullet3 = SKSpriteNode(imageNamed: "bullet");
        aspectRatio = bullet3.size.width/bullet3.size.height
        bullet3.size = CGSize(width: bullQueue3Box.frame.width, height: bullQueue3Box.frame.width/aspectRatio)
        
        bullet3.position = CGPoint(x: bullQueue3Box.frame.midX, y: bullQueue3Box.frame.midY)
        bullet3.zPosition = CGFloat(zvalue);
        addChild(bullet3)
        
        
        xPos = xPos + queueWidth
        yPos = yPos - (queueHeight * 0.5)
        bullQueue4Box = SKShapeNode()
        bullQueue4Box.path = UIBezierPath(roundedRect: CGRect(x: xPos,
                                                              y: yPos,
                                                              width: frame.width * 0.25,
                                                              height: queueHeight * 1.5), cornerRadius: 0).cgPath
        bullQueue4Box.fillColor = UIColor.gray
        bullQueue4Box.strokeColor = UIColor.black
        bullQueue4Box.lineWidth = frame.size.width * 0.01
        bullQueue4Box.zPosition = CGFloat(zvalue);
        addChild(bullQueue4Box)
        
        var bullet4 = SKSpriteNode(imageNamed: "bullet");
        aspectRatio = bullet4.size.width/bullet4.size.height
        bullet4.size = CGSize(width: bullQueue4Box.frame.width, height: bullQueue4Box.frame.width/aspectRatio)
        
        bullet4.position = CGPoint(x: bullQueue4Box.frame.midX, y: bullQueue4Box.frame.midY)
        bullet4.zPosition = CGFloat(zvalue);
        addChild(bullet4)
        
    }
    
    
    func addingGuns(){
        plusGun = SKSpriteNode(imageNamed: "plusGun")
        let width = frame.width/4
        let aspectRatio = plusGun.size.width/plusGun.size.height
        plusGun.size = CGSize(width: width, height: width/aspectRatio)
        var xPos = (-1 * (frame.width/2)) + plusGun.size.width/2
        let yPos = (-1 * (frame.height/2)) + plusGun.size.height/2
        plusGun.position = CGPoint(x: xPos, y: yPos)
        addChild(plusGun)
        
        plusGunBox = SKShapeNode()
        plusGunBox.path = UIBezierPath(roundedRect: CGRect(x: xPos - plusGun.size.width/2,
                                                           y: yPos - plusGun.size.height/2,
                                                           width: plusGun.size.width,
                                                           height: plusGun.size.width), cornerRadius: 0).cgPath
        plusGunBox.position = CGPoint(x: 0, y: 0)
        plusGunBox.fillColor = UIColor.red
        plusGunBox.strokeColor = UIColor.black
        plusGunBox.lineWidth = frame.size.width * 0.01
        addChild(plusGunBox)
        
        
        minusGun = SKSpriteNode(imageNamed: "subGun")
        minusGun.size = CGSize(width: width, height: width/aspectRatio)
        xPos = xPos + plusGun.size.width
        minusGun.position = CGPoint(x: xPos, y: yPos)
        addChild(minusGun)
        
        minusGunBox = SKShapeNode()
        minusGunBox.path = UIBezierPath(roundedRect: CGRect(x: xPos - minusGun.size.width/2,
                                                            y: yPos - minusGun.size.height/2,
                                                            width: minusGun.size.width,
                                                            height: minusGun.size.width), cornerRadius: 0).cgPath
        minusGunBox.position = CGPoint(x: 0, y: 0)
        minusGunBox.fillColor = UIColor.red
        minusGunBox.strokeColor = UIColor.black
        minusGunBox.lineWidth = frame.size.width * 0.01
        addChild(minusGunBox)
        
        
        multiGun = SKSpriteNode(imageNamed: "multiGun")
        multiGun.size = CGSize(width: width, height: width/aspectRatio)
        xPos = xPos + plusGun.size.width
        multiGun.position = CGPoint(x: xPos, y: yPos)
        addChild(multiGun)
        
        
        multiGunBox = SKShapeNode()
        multiGunBox.path = UIBezierPath(roundedRect: CGRect(x: xPos - multiGun.size.width/2,
                                                            y: yPos - multiGun.size.height/2,
                                                            width: multiGun.size.width,
                                                            height: multiGun.size.width), cornerRadius: 0).cgPath
        multiGunBox.position = CGPoint(x: 0, y: 0)
        multiGunBox.fillColor = UIColor.red
        multiGunBox.strokeColor = UIColor.black
        multiGunBox.lineWidth = frame.size.width * 0.01
        addChild(multiGunBox)
        
        
        diviGun = SKSpriteNode(imageNamed: "diviGun")
        diviGun.size = CGSize(width: width, height: width/aspectRatio)
        xPos = xPos + plusGun.size.width
        diviGun.position = CGPoint(x: xPos, y: yPos)
        addChild(diviGun)
        
        diviGunBox = SKShapeNode()
        diviGunBox.path = UIBezierPath(roundedRect: CGRect(x: xPos - diviGun.size.width/2,
                                                           y: yPos - diviGun.size.height/2,
                                                           width: diviGun.size.width,
                                                           height: diviGun.size.width), cornerRadius: 0).cgPath
        diviGunBox.position = CGPoint(x: 0, y: 0)
        diviGunBox.fillColor = UIColor.red
        diviGunBox.strokeColor = UIColor.black
        diviGunBox.lineWidth = frame.size.width * 0.01
        addChild(diviGunBox)
    }
    
    func createGradientLayer() {
        gradientLayer = CAGradientLayer()
        
        gradientLayer.frame = (self.view?.bounds)!
        
        gradientLayer.colors = [UIColor.black.cgColor, UIColor.clear]
        gradientLayer.locations = [0.0, 0.40]
        self.view?.layer.addSublayer(gradientLayer)
    }
    
    func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    
    func random(min: CGFloat, max: CGFloat) -> CGFloat {
        return random() * (max - min) + min
    }
    
    
    func addingGameOverLine(){
        
        let bezierPath = UIBezierPath()
        let startPoint = CGPoint(x:(frame.minX), y:frame.midY)
        let endPoint = CGPoint(x:frame.maxX, y:frame.midY)
        bezierPath.move(to: startPoint)
        bezierPath.addLine(to: endPoint)
        
        let pattern : [CGFloat] = [10.0, 10.0]
        let dashed = CGPath(__byDashing: bezierPath.cgPath, transform: nil, phase: 0, lengths: pattern, count: 2)
        
        EndOfGameLine = SKShapeNode.init(path: dashed!)
        EndOfGameLine.position = CGPoint(x:frame.midX, y: (frame.minY * 0.65))
        EndOfGameLine.lineWidth = 10;
        //physicsBody = SKPhysicsBody(edgeFrom: startPoint, to: endPoint)
        //physicsBody?.restitution = 0.3
        addChild(EndOfGameLine)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch:UITouch = touches.first!
        let positionInScene = touch.location(in: self)
        let touchedNode = self.atPoint(positionInScene)
        
        //testing queue
        var queue = Queue<Int>()
        queue.enqueue(5)
        print(queue.front)
    
        if let name = touchedNode.name
        {
            if name == "zombie"
            {
                touchedNode.removeFromParent()
            }
        }
    }
    func addZombie() {
        // NOTE: GRID SYSTEM USES 0,0 AS THE CENTER OF THE SCREEN!!!
        
        // Create sprite
        let zombie = SKSpriteNode(imageNamed: "zombie")
        let aspectRatio = zombie.size.width/zombie.size.height
        let zombieWidth = frame.width/4
        zombie.size = CGSize(width: zombieWidth, height: zombieWidth/aspectRatio)
        // Determine where to spawn the monster along the Y axis
        
        // Determining min x value to spawn zombie
        let minX = frame.minX + (zombie.size.width/2)

        // Determining max x value to spawn zombie
        let maxX = frame.maxX - (zombie.size.width/2)
        let actualX = random(min: minX, max: maxX)

        // Position the monster slightly off-screen along the right edge,
        // and along a random position along the Y axis as calculated above
        zombie.position = CGPoint(x: actualX, y: frame.maxY + zombie.size.height)
        zombie.zPosition = CGFloat(1.0);
        // Add the monster to the scene
        addChild(zombie)
        
        // Determine speed of the monster
        //    let actualDuration = random(min: CGFloat(2.0), max: CGFloat(4.0))
        let actualDuration = CGFloat(15.0)
        
        // Create the actions
        let gameOverLine = (frame.minY * 0.65) + zombie.size.height/2
        
        let actionMove = SKAction.move(to: CGPoint(x: actualX, y: gameOverLine), duration: TimeInterval(actualDuration))
        let actionMoveDone = SKAction.removeFromParent()
        zombie.run(SKAction.sequence([actionMove, actionMoveDone]))
        
        //animate zombie walking
        zombie.run(SKAction.repeatForever(zombieAnimation))
        
        //setting name for tap detection
        zombie.name = "zombie"
    }
    
}

