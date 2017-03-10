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
    var bQueue: BulletQueue!
    
    //all zombies
    var zombies: [SKSpriteNode]!
    
    var kills: Int = 0
    
    //score
    var score: Int = 0
    
    var currentGun : String! = "plus"
    
    var gradientLayer: CAGradientLayer!
    
    var zombieHealth : SKLabelNode!
    
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
    
    var bulletQueueBoxes: [SKShapeNode] = [SKShapeNode]()
    var bulletQueueLabels: [SKLabelNode] = [SKLabelNode]()

    
    var EndOfGameLine:SKShapeNode!
    
    var walkFrames: [SKTexture]!
    var zombieAnimation: SKAction!
    
    
    
    
    override func didMove(to view: SKView) {
        
        let bgTexture = SKTexture(imageNamed: "dark-grass")
        let bgDefinition = SKTileDefinition(texture: bgTexture, size: bgTexture.size())
        let bgGroup = SKTileGroup(tileDefinition: bgDefinition)
        let tileSet = SKTileSet(tileGroups: [bgGroup])
        //let bgNode = SKTileMapNode(tileSet: tileSet, columns: 4, rows: 8, tileSize: bgTexture.size())
        
        let bgNode = SKTileMapNode(tileSet: tileSet, columns: 4, rows: 8, tileSize: bgTexture.size(), fillWith: bgGroup)
        
        bgNode.position = CGPoint(x: self.frame.size.width / 2, y: self.frame.size.height / 2)
        bgNode.setScale(1)
        bgNode.zPosition = CGFloat(1.0)

        self.addChild(bgNode)

        bQueue = BulletQueue.init()
        addingGuns(zvalue: 2.0)
        addingGameOverLine(zvalue: 2.0)
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
        pauseButtonBox.name = "pause"
        
        
        pauseButton = SKLabelNode(fontNamed: "Arial")

        pauseButton.text = "||"
        pauseButton.fontSize = 3
        
        // Determine the font scaling factor that should let the label text fit in the given rectangle.
        var scalingFactor = min(pauseButtonBox.frame.width / pauseButton.frame.width, pauseButtonBox.frame.height / pauseButton.frame.height)
        
        // Change the fontSize.
        pauseButton.fontSize *= scalingFactor
        
        // Optionally move the SKLabelNode to the center of the rectangle.
        var gap = (pauseButtonBox.frame.height - pauseButton.frame.height)/2
        pauseButton.position = CGPoint(x: pauseButtonBox.frame.midX, y: (pauseButtonBox.frame.maxY - pauseButtonBox.frame.height/2) - gap/2)
        pauseButton.zPosition = CGFloat(zvalue)
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

        waveNumberLabel = SKLabelNode(fontNamed: "Arial")
        
        waveNumberLabel.text = "Kills: 0"
        waveNumberLabel.fontSize = 20
        
        // Determine the font scaling factor that should let the label text fit in the given rectangle.
        scalingFactor = min(waveNumberBox.frame.width / waveNumberLabel.frame.width, waveNumberBox.frame.height / pauseButton.frame.height)
        
        // Change the fontSize.
        waveNumberLabel.fontSize *= scalingFactor
        
        // Optionally move the SKLabelNode to the center of the rectangle.
        waveNumberLabel.position = CGPoint(x: waveNumberBox.frame.midX, y: waveNumberBox.frame.midY - waveNumberLabel.frame.height / 2.0)
        waveNumberLabel.zPosition = CGFloat(zvalue);
        addChild(waveNumberLabel)
        
        
        
        
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
        
        
        
        
        scoreDisplayLabel = SKLabelNode(fontNamed: "Arial")
        
        scoreDisplayLabel.text = "Score: 0"
        scoreDisplayLabel.fontSize = 20
        
        // Determine the font scaling factor that should let the label text fit in the given rectangle.
        scalingFactor = min(scoreDisplayBox.frame.width / scoreDisplayLabel.frame.width, scoreDisplayBox.frame.height / pauseButton.frame.height)
        
        // Change the fontSize.
        scoreDisplayLabel.fontSize *= scalingFactor
        
        // Optionally move the SKLabelNode to the center of the rectangle.
        scoreDisplayLabel.position = CGPoint(x: scoreDisplayBox.frame.midX, y: scoreDisplayBox.frame.midY - scoreDisplayLabel.frame.height / 2.0)
        scoreDisplayLabel.zPosition = CGFloat(zvalue);
        addChild(scoreDisplayLabel)

        
        
    }
    
    func addBulletQueue(zvalue: Double){
        
        //////////Bullet 1/////////////
        
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
        
        //////////Bullet 1/////////////
        
        //////////Bullet 2/////////////
        
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
        
        
        //////////Bullet 2/////////////
        
        //////////Bullet 3/////////////
        
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
        
        
        //////////Bullet 3/////////////
        
        //////////Bullet 4/////////////
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
        
        
        
        //////////Bullet 4/////////////
        
        //////////Bullet 5/////////////
        
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
        
        //giving current bullet a name
        bullet4.name = "currentBullet"
        //////////Bullet 5/////////////
        
        bulletQueueBoxes.append(bullQueue0Box)
        bulletQueueBoxes.append(bullQueue1Box)
        bulletQueueBoxes.append(bullQueue2Box)
        bulletQueueBoxes.append(bullQueue3Box)
        bulletQueueBoxes.append(bullQueue4Box)
        
        bullQueue0Label = SKLabelNode(fontNamed: "Arial")
        bullQueue1Label = SKLabelNode(fontNamed: "Arial")
        bullQueue2Label = SKLabelNode(fontNamed: "Arial")
        bullQueue3Label = SKLabelNode(fontNamed: "Arial")
        bullQueue4Label = SKLabelNode(fontNamed: "Arial")
        
        bullQueue0Label.name = "currentBullet"
        bullQueue0Box.name = "currentBullet"
        
        bulletQueueLabels.append(bullQueue0Label)
        bulletQueueLabels.append(bullQueue1Label)
        bulletQueueLabels.append(bullQueue2Label)
        bulletQueueLabels.append(bullQueue3Label)
        bulletQueueLabels.append(bullQueue4Label)
        
        refreshBullets()
    }
    
    
    func refreshBullets() {
        let zvalue = 2.0
        
        for i in 0 ..< 5 {
            let bulletQueueBox    = bulletQueueBoxes[i]
            let bulletQueueLabel = bulletQueueLabels[i]
            let num       = String(bQueue.queue.getValue(4 - i))
            
            bulletQueueLabel.text = num
            bulletQueueLabel.fontSize = 2
            bulletQueueLabel.zPosition = CGFloat(zvalue + 2)
            
            let scalingFactorB4 = min(bulletQueueBox.frame.width / bulletQueueLabel.frame.width, bulletQueueBox.frame.height / bulletQueueLabel.frame.height)
            
            bulletQueueLabel.fontSize *= scalingFactorB4
            
            // Optionally move the SKLabelNode to the center of the rectangle.
            bulletQueueLabel.position = CGPoint(x: bulletQueueBox.frame.midX - 25, y: bulletQueueBox.frame.midY - bulletQueueLabel.frame.height / 2.0)
            bulletQueueLabel.zPosition = CGFloat(zvalue + 2);
            addChild(bulletQueueLabel)
        }
    }
    
    func clearBulletLabels() {
        for i in 0 ..< 5 {
            bulletQueueLabels[i].removeFromParent()
        }
    }
    
    
    func addingGuns(zvalue: Double){
        plusGun = SKSpriteNode(imageNamed: "plusGun")
        let width = frame.width/4
        let aspectRatio = plusGun.size.width/plusGun.size.height
        plusGun.size = CGSize(width: width, height: width/aspectRatio)
        var xPos = (frame.minX + plusGun.size.width/2)
        let yPos = (frame.minY + plusGun.size.height/2)
        plusGun.position = CGPoint(x: xPos, y: yPos)
        plusGun.zPosition = CGFloat(zvalue);
        addChild(plusGun)
        
        plusGunBox = SKShapeNode()
        plusGunBox.path = UIBezierPath(roundedRect: CGRect(x: xPos - plusGun.size.width/2,
                                                           y: yPos - plusGun.size.height/2,
                                                           width: plusGun.size.width,
                                                           height: plusGun.size.width), cornerRadius: 0).cgPath
        plusGunBox.fillColor = UIColor.red
        plusGunBox.strokeColor = UIColor.black
        plusGunBox.lineWidth = frame.size.width * 0.01
        plusGunBox.zPosition = CGFloat(zvalue);
        addChild(plusGunBox)
        plusGunBox.name = "plusGun"
        
        
        minusGun = SKSpriteNode(imageNamed: "subGun")
        minusGun.size = CGSize(width: width, height: width/aspectRatio)
        xPos = xPos + plusGun.size.width
        minusGun.position = CGPoint(x: xPos, y: yPos)
        minusGun.zPosition = CGFloat(zvalue);
        addChild(minusGun)
        
        minusGunBox = SKShapeNode()
        minusGunBox.path = UIBezierPath(roundedRect: CGRect(x: xPos - minusGun.size.width/2,
                                                            y: yPos - minusGun.size.height/2,
                                                            width: minusGun.size.width,
                                                            height: minusGun.size.width), cornerRadius: 0).cgPath
        minusGunBox.fillColor = UIColor.red
        minusGunBox.strokeColor = UIColor.black
        minusGunBox.lineWidth = frame.size.width * 0.01
        minusGunBox.zPosition = CGFloat(zvalue);
        addChild(minusGunBox)
        minusGunBox.name = "minusGun"
        
        
        multiGun = SKSpriteNode(imageNamed: "multiGun")
        multiGun.size = CGSize(width: width, height: width/aspectRatio)
        xPos = xPos + plusGun.size.width
        multiGun.position = CGPoint(x: xPos, y: yPos)
        multiGun.zPosition = CGFloat(zvalue);
        addChild(multiGun)
        
        
        multiGunBox = SKShapeNode()
        multiGunBox.path = UIBezierPath(roundedRect: CGRect(x: xPos - multiGun.size.width/2,
                                                            y: yPos - multiGun.size.height/2,
                                                            width: multiGun.size.width,
                                                            height: multiGun.size.width), cornerRadius: 0).cgPath
        multiGunBox.fillColor = UIColor.red
        multiGunBox.strokeColor = UIColor.black
        multiGunBox.lineWidth = frame.size.width * 0.01
        multiGunBox.zPosition = CGFloat(zvalue);
        addChild(multiGunBox)
        multiGunBox.name = "multiGun"
        
        
        diviGun = SKSpriteNode(imageNamed: "diviGun")
        diviGun.size = CGSize(width: width, height: width/aspectRatio)
        xPos = xPos + plusGun.size.width
        diviGun.position = CGPoint(x: xPos, y: yPos)
        diviGun.zPosition = CGFloat(zvalue);
        addChild(diviGun)
        
        diviGunBox = SKShapeNode()
        diviGunBox.path = UIBezierPath(roundedRect: CGRect(x: xPos - diviGun.size.width/2,
                                                           y: yPos - diviGun.size.height/2,
                                                           width: diviGun.size.width,
                                                           height: diviGun.size.width), cornerRadius: 0).cgPath
        diviGunBox.fillColor = UIColor.red
        diviGunBox.strokeColor = UIColor.black
        diviGunBox.lineWidth = frame.size.width * 0.01
        diviGunBox.zPosition = CGFloat(zvalue);
        addChild(diviGunBox)
        diviGunBox.name = "diviGun"
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
    
    
    func addingGameOverLine(zvalue: Double){
        
        //let y = frame.midY - (frame.height * 0.15)
        let y = frame.minY + plusGun.size.height + plusGun.size.height * 0.25
        
        let bezierPath = UIBezierPath()
        let startPoint = CGPoint(x:(frame.minX), y: y)
        let endPoint = CGPoint(x:frame.maxX, y: y)
        bezierPath.move(to: startPoint)
        bezierPath.addLine(to: endPoint)
        
        let pattern : [CGFloat] = [10.0, 10.0]
        let dashed = CGPath(__byDashing: bezierPath.cgPath, transform: nil, phase: 0, lengths: pattern, count: 2)
        
        EndOfGameLine = SKShapeNode.init(path: dashed!)
        //EndOfGameLine.position = CGPoint(x:frame.midX, y: (frame.minY * 0.65))
        EndOfGameLine.lineWidth = 10;
        EndOfGameLine.zPosition = CGFloat(zvalue)
        //physicsBody = SKPhysicsBody(edgeFrom: startPoint, to: endPoint)
        //physicsBody?.restitution = 0.3
        addChild(EndOfGameLine)
    }
    
    func plusOperation(_ healthNode: SKLabelNode) {
        var health = Int(healthNode.text!)!
        print(bQueue.queue.front)
        health += bQueue.queue.front
        healthNode.text = String(health)
    }
    
    func minusOperation(_ healthNode: SKLabelNode) {
        var health = Int(healthNode.text!)!
        print(bQueue.queue.front)
        health -= bQueue.queue.front
        healthNode.text = String(health)
    }
    
    func multiOperation(_ healthNode: SKLabelNode) {
        var health = Int(healthNode.text!)!
        print(bQueue.queue.front)
        health *= bQueue.queue.front
        healthNode.text = String(health)
    }
    
    func diviOperation(_ healthNode: SKLabelNode) {
        var health = Int(healthNode.text!)!
        if(bQueue.queue.front == 0) {
            health /= 1
        }
        print(bQueue.queue.front)
        health /= bQueue.queue.front
        healthNode.text = String(health)
    }
    
    func shootZombie(_ zombie: SKSpriteNode, _ healthNode: SKLabelNode) {
        var killed : Bool = false
        
        switch currentGun {
        case "plus":
            plusOperation(healthNode)
        case "minus":
            minusOperation(healthNode)
        case "multi":
            multiOperation(healthNode)
        case "divi":
            diviOperation(healthNode)
        default:
            print("error")
        }
        
        if(Int(healthNode.text!)! == 0) {
            //KILL ZOMBIE
            //add to score
            score += 5
            scoreDisplayLabel.text = "Score: " + String(score)
            
            kills += 1
            waveNumberLabel.text = "Kills: " + String(kills)
            //remove from scene
            zombie.removeFromParent()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch:UITouch = touches.first!
        let positionInScene = touch.location(in: self)
        let touchedNode = self.atPoint(positionInScene)
        
        if let name = touchedNode.name
        {
            //if its paused, unpause
            if self.view?.isPaused == true {
                if name == "pause" {
                    self.view?.isPaused = false
                    print("pause")
                }
            } else {
                if name == "zombie" {
                    //get health of zombie
                    let healthNode = touchedNode.childNode(withName: "health") as! SKLabelNode
                    
                    shootZombie(touchedNode as! SKSpriteNode, healthNode)
                    
                    bQueue.generateNewBullet()
                    print(bQueue.queue)
                    clearBulletLabels()
                    refreshBullets()
                    
                    print("Score: \(score)")
                } else if name == "plusGun" {
                    currentGun = "plus"
                    print("plus")
                } else if name == "minusGun" {
                    currentGun = "minus"
                    print("minus")
                } else if  name == "multiGun" {
                    currentGun = "multi"
                    print("multi")
                } else if  name == "diviGun" {
                    currentGun = "divi"
                    print("divi")
                
                } else if name == "pause" {
                    self.view?.isPaused = true
                    print("pause")
                } else if name == "currentBullet" {
                    //remove first bullet and generate another one
                    bQueue.generateNewBullet()
                    print(bQueue.queue)
                    clearBulletLabels()
                    refreshBullets()
                }
            }
        }
    }
    // Generates a random number between -10 and 10 to represent zombie health
//    func randomZombieHealth(){
//        let health = Int(arc4random_uniform(11) + 1)
//    }
    func addZombie() {
        // NOTE: GRID SYSTEM USES 0,0 AS THE CENTER OF THE SCREEN!!!
        
        // Create sprite
        let zombie = SKSpriteNode(imageNamed: "zombie")
        let aspectRatio = zombie.size.width/zombie.size.height
        let zombieWidth = frame.width/4
        zombie.size = CGSize(width: zombieWidth, height: zombieWidth/aspectRatio)
        
        // Create zombie health
        let healthNum = Int(arc4random_uniform(11) + 1)
        
        //display health to the screen
        zombieHealth = SKLabelNode(fontNamed: "Arial")
        zombieHealth.fontSize = 50
        zombieHealth.text = String(healthNum)
        
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
        zombieHealth.position.y =  zombie.size.height/1.25 * -1
        // Add the monster to the scene
        addChild(zombie)
        zombie.addChild(zombieHealth)
        
        // Determine speed of the monster
        //    let actualDuration = random(min: CGFloat(2.0), max: CGFloat(4.0))
        let actualDuration = CGFloat(15.0)
        
        // Create the actions
        let gameOverLine = frame.minY + plusGun.size.height + plusGun.size.height * 0.25 + zombie.size.height/2
        
        let actionMove = SKAction.move(to: CGPoint(x: actualX, y: gameOverLine), duration: TimeInterval(actualDuration))
        let actionMoveDone = SKAction.removeFromParent()

        let loseAction = SKAction.run() {
            let reveal = SKTransition.flipVertical(withDuration: 0.5)
            let gameOverScene = GameOverScene(size: self.size, won: false)
            self.view?.presentScene(gameOverScene, transition: reveal)
        }

        
        zombie.run(SKAction.sequence([actionMove, loseAction, actionMoveDone]))
        

        //animate zombie walking
        zombie.run(SKAction.repeatForever(zombieAnimation))
        
        //setting name for tap detection
        zombie.name = "zombie"
        zombieHealth.name = "health"
    }
    
}

