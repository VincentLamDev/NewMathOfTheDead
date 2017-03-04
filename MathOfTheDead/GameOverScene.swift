//
//  GameOverScene.swift
//  MathOfTheDead
//
//  Created by Vincent Lam on 2017-03-03.
//  Copyright © 2017 NGU. All rights reserved.
//

import Foundation
import SpriteKit

class GameOverScene: SKScene {
    
    init(size: CGSize, won:Bool) {
        
        super.init(size: size)
        
        
        let bgTexture = SKTexture(imageNamed: "dark-grass")
        let bgDefinition = SKTileDefinition(texture: bgTexture, size: bgTexture.size())
        let bgGroup = SKTileGroup(tileDefinition: bgDefinition)
        let tileSet = SKTileSet(tileGroups: [bgGroup])
        //let bgNode = SKTileMapNode(tileSet: tileSet, columns: 4, rows: 8, tileSize: bgTexture.size())
        
        let bgNode = SKTileMapNode(tileSet: tileSet, columns: 4, rows: 8, tileSize: bgTexture.size(), fillWith: bgGroup)
        
        bgNode.position = CGPoint(x: self.frame.size.width / 2, y: self.frame.size.height / 2)
        bgNode.setScale(1)
        
        self.addChild(bgNode)
        
        
        
        
        
        // 1
        backgroundColor = SKColor.white
        
        // 2
        let message = "GAME OVER"
        
        // 3
        let label = SKLabelNode(fontNamed: "Chalkduster")
        label.text = message
        label.fontSize = 80
        label.fontColor = SKColor.white
        label.position = CGPoint(x: self.frame.midX, y: self.frame.maxY - label.frame.height)
        addChild(label)
        
        let restartBox = SKShapeNode()
        
        let btnWidth = self.frame.width/2
        let btnHeight = self.frame.height/10
        var xPos = self.frame.minX + self.frame.width/4
        var yPos = self.frame.midY
        restartBox.path = UIBezierPath(roundedRect: CGRect(x: xPos,
                                                              y: yPos,
                                                              width: btnWidth,
                                                              height: btnHeight), cornerRadius: 0).cgPath
        
        restartBox.fillColor = UIColor.red
        restartBox.strokeColor = UIColor.black
        restartBox.lineWidth = frame.size.width * 0.01
        addChild(restartBox)
        
        let mainMenuBox = SKShapeNode()
        yPos = self.frame.midY - self.frame.height * 0.25
        mainMenuBox.path = UIBezierPath(roundedRect: CGRect(x: xPos,
                                                           y: yPos,
                                                           width: btnWidth,
                                                           height: btnHeight), cornerRadius: 0).cgPath

        mainMenuBox.fillColor = UIColor.red
        mainMenuBox.strokeColor = UIColor.black
        mainMenuBox.lineWidth = frame.size.width * 0.01
        addChild(mainMenuBox)

//        waveNumberBox.fillColor = UIColor.red
//        waveNumberBox.strokeColor = UIColor.black
//        waveNumberBox.lineWidth = frame.size.width * 0.01
//        waveNumberBox.zPosition = CGFloat(zvalue);
//        addChild(waveNumberBox)
//        
//        waveNumberLabel = SKLabelNode(fontNamed: "Arial")
//        
//        waveNumberLabel.text = "Kills: 0"
//        waveNumberLabel.fontSize = 20
//        
//        // Determine the font scaling factor that should let the label text fit in the given rectangle.
//        scalingFactor = min(waveNumberBox.frame.width / waveNumberLabel.frame.width, waveNumberBox.frame.height / pauseButton.frame.height)
//        
//        // Change the fontSize.
//        waveNumberLabel.fontSize *= scalingFactor
//        
//        // Optionally move the SKLabelNode to the center of the rectangle.
//        waveNumberLabel.position = CGPoint(x: waveNumberBox.frame.midX, y: waveNumberBox.frame.midY - waveNumberLabel.frame.height / 2.0)
//        waveNumberLabel.zPosition = CGFloat(zvalue);
//        addChild(waveNumberLabel)

        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        // 4
        run(SKAction.sequence([
            SKAction.wait(forDuration: 3.0),
            SKAction.run() {
                // 5
                
                let reveal = SKTransition.flipHorizontal(withDuration: 0.5)
                let scene = GameScene(size: size)
                scene.reloadInputViews()
                self.view?.presentScene(scene, transition:reveal)
            }
            ]))
        
    }
    
    // 6
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
