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
    
    
    var restartBox: SKShapeNode!
    var restartLabel: SKLabelNode!
    var mainMenuBox: SKShapeNode!
    var mainMenuLabel: SKLabelNode!
    
    
    init(size: CGSize, won:Bool, score: Int, wave: Int) {
        
        super.init(size: size)
        
        //background grass tile map
        let bgTexture = SKTexture(imageNamed: "dark-grass")
        let bgDefinition = SKTileDefinition(texture: bgTexture, size: bgTexture.size())
        let bgGroup = SKTileGroup(tileDefinition: bgDefinition)
        let tileSet = SKTileSet(tileGroups: [bgGroup])
        let bgNode = SKTileMapNode(tileSet: tileSet, columns: 4, rows: 8, tileSize: bgTexture.size(), fillWith: bgGroup)
        bgNode.position = CGPoint(x: self.frame.size.width / 2, y: self.frame.size.height / 2)
        bgNode.setScale(1)
        self.addChild(bgNode)
        
        
        
        //Game over label
        let message = "GAME OVER"
        let label = SKLabelNode(fontNamed: "Chalkduster")
        label.text = message
        label.fontSize = 80
        label.fontColor = SKColor.white
        label.position = CGPoint(x: self.frame.midX, y: self.frame.maxY - label.frame.height)
        addChild(label)
        
        
        
        //Displaying player score
        let scorelabel = SKLabelNode(fontNamed: "Arial")
        scorelabel.text = "Score: " + String(score)
        scorelabel.fontSize = 20
        let scoreLabelScaleFactor = min((self.frame.width * 0.7) / scorelabel.frame.width, (self.frame.height * 0.15) / scorelabel.frame.height)
        scorelabel.fontSize *= scoreLabelScaleFactor
        scorelabel.position = CGPoint(x: self.frame.midX, y: self.frame.maxY * 0.75)
        addChild(scorelabel)

        //Displaying player kills
        let killslabel = SKLabelNode(fontNamed: "Arial")
        killslabel.text = "Kills: " + String(wave)
        killslabel.fontSize = 20
        let killLabelScaleFactor = min((self.frame.width * 0.55) / killslabel.frame.width, (self.frame.height * 0.15) / killslabel.frame.height)
        killslabel.fontSize *= killLabelScaleFactor
        killslabel.position = CGPoint(x: self.frame.midX, y: self.frame.maxY * 0.6)
        addChild(killslabel)

        
        
        //Restart game button
        restartBox = SKShapeNode()
        let btnWidth = self.frame.width/2
        let btnHeight = self.frame.height/10
        let xPos = self.frame.minX + self.frame.width/4
        var yPos = self.frame.maxY * 0.4
        restartBox.path = UIBezierPath(roundedRect: CGRect(x: xPos,
                                                              y: yPos,
                                                              width: btnWidth,
                                                              height: btnHeight), cornerRadius: 0).cgPath
        restartBox.fillColor = UIColor.red
        restartBox.strokeColor = UIColor.black
        restartBox.lineWidth = frame.size.width * 0.01
        addChild(restartBox)
        
        
        //Restart button label
        restartLabel = SKLabelNode(fontNamed: "Arial")
        restartLabel.text = "Restart"
        restartLabel.fontSize = 20
        var scalingFactor = min(restartBox.frame.width / restartLabel.frame.width, restartBox.frame.height / restartLabel.frame.height)
        restartLabel.fontSize *= (scalingFactor * 0.5)
        restartLabel.position = CGPoint(x: restartBox.frame.midX, y: restartBox.frame.midY - restartLabel.frame.height / 2.0)
        addChild(restartLabel)
        
        
        //Return to main menu button
        mainMenuBox = SKShapeNode()
        yPos = self.frame.maxY * 0.2
        mainMenuBox.path = UIBezierPath(roundedRect: CGRect(x: xPos,
                                                           y: yPos,
                                                           width: btnWidth,
                                                           height: btnHeight), cornerRadius: 0).cgPath
        mainMenuBox.fillColor = UIColor.red
        mainMenuBox.strokeColor = UIColor.black
        mainMenuBox.lineWidth = frame.size.width * 0.01
        addChild(mainMenuBox)
        
        
        //Main menu button label
        mainMenuLabel = SKLabelNode(fontNamed: "Arial")
        mainMenuLabel.text = "Main Menu"
        mainMenuLabel.fontSize = 20
        scalingFactor = min(mainMenuBox.frame.width / mainMenuLabel.frame.width, mainMenuBox.frame.height / mainMenuLabel.frame.height)
        mainMenuLabel.fontSize *= (scalingFactor * 0.7)
        mainMenuLabel.position = CGPoint(x: mainMenuBox.frame.midX, y: mainMenuBox.frame.midY - mainMenuLabel.frame.height / 2.0)
        addChild(mainMenuLabel)
        

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
