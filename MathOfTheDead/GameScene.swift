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
    let gunbar = SKSpriteNode(imageNamed: "redLine")
    var gradientLayer: CAGradientLayer!

    
    override func didMove(to view: SKView) {
        

        // 2
        //backgroundColor = SKColor.white
        // 3
        createGradientLayer()

        print(self.view!.bounds.size.width)
        print(self.view!.bounds.size.height)
        
        print(frame.width)
        print(frame.height)

        
        gunbar.position = CGPoint(x: size.width * 0.5, y: size.height * 1)
        // 4
        //addChild(gunbar)
        
        run(SKAction.repeatForever(
            SKAction.sequence([
                SKAction.run(addMonster),
                SKAction.wait(forDuration: 5.0)
                ])
        ))
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
        
        // Create sprite
        let zombie = SKSpriteNode(imageNamed: "zombie")
        let aspectRatio = zombie.size.width/zombie.size.height
        zombie.size = CGSize(width: 100, height: 100/aspectRatio)
        // Determine where to spawn the monster along the Y axis
        var actualX = random(min: (zombie.size.width/2) * -1, max: size.width - zombie.size.width/2)
        actualX = 375
        print(actualX)
        
        // Position the monster slightly off-screen along the right edge,
        // and along a random position along the Y axis as calculated above
        zombie.position = CGPoint(x: actualX, y: size.height + zombie.size.height/2)
        
        // Add the monster to the scene
        addChild(zombie)
        
        // Determine speed of the monster
        //    let actualDuration = random(min: CGFloat(2.0), max: CGFloat(4.0))
        let actualDuration = CGFloat(15.0)
        
        // Create the actions
        
        let actionMove = SKAction.move(to: CGPoint(x: actualX, y:  -zombie.size.width/2), duration: TimeInterval(actualDuration))
        let actionMoveDone = SKAction.removeFromParent()
        zombie.run(SKAction.sequence([actionMove, actionMoveDone]))
        
    }
    
}

