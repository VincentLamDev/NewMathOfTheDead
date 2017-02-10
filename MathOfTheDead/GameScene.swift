//
//  GameScene.swift
//  MathoftheDead
//
//  Created by Rachel Shellborn on 2017-01-27.
//  Copyright © 2017 Rachel Shellborn. All rights reserved.
//
import SpriteKit

class GameScene: SKScene {
    
    // 1
    //let gunbar = SKSpriteNode(imageNamed: "redLine")
    var gradientLayer: CAGradientLayer!

    var plusGun:SKSpriteNode!
    var diviGun:SKSpriteNode!
    var minusGun:SKSpriteNode!
    var multiGun:SKSpriteNode!
    
    var EndOfGameLine:SKShapeNode!
    
    override func didMove(to view: SKView) {
        
        addingGuns()
        createGradientLayer()
        addingGameOverLine()
        
        //gunbar.position = CGPoint(x: size.width * 0.5, y: size.height * 1)
        // 4
        //addChild(gunbar)
        
        run(SKAction.repeatForever(
            SKAction.sequence([
                SKAction.run(addMonster),
                SKAction.wait(forDuration: 4.0)
                ])
        ))
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
    
    func addingGuns(){
        plusGun = SKSpriteNode(imageNamed: "plusGun")
        let width = frame.width/4
        let aspectRatio = plusGun.size.width/plusGun.size.height
        plusGun.size = CGSize(width: width, height: width/aspectRatio)
        var xPos = (-1 * (frame.width/2)) + plusGun.size.width/2
        let yPos = (-1 * (frame.height/2)) + plusGun.size.height/2
        plusGun.position = CGPoint(x: xPos, y: yPos)
        addChild(plusGun)
        
        minusGun = SKSpriteNode(imageNamed: "subGun")
        minusGun.size = CGSize(width: width, height: width/aspectRatio)
        xPos = xPos + plusGun.size.width
        minusGun.position = CGPoint(x: xPos, y: yPos)
        addChild(minusGun)
        
        multiGun = SKSpriteNode(imageNamed: "multiGun")
        multiGun.size = CGSize(width: width, height: width/aspectRatio)
        xPos = xPos + plusGun.size.width
        multiGun.position = CGPoint(x: xPos, y: yPos)
        addChild(multiGun)
        
        diviGun = SKSpriteNode(imageNamed: "diviGun")
        diviGun.size = CGSize(width: width, height: width/aspectRatio)
        xPos = xPos + plusGun.size.width
        diviGun.position = CGPoint(x: xPos, y: yPos)
        addChild(diviGun)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //let touch = touches.first!

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
    
    func addMonster() {
        
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
        
    }
    
}

