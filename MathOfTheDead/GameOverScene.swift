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
    var size1: CGSize!
    
    init(size: CGSize, won:Bool, score: Int, wave: Int) {
        
        super.init(size: size)
        self.size1 = size
        
        let bgTexture = SKTexture(imageNamed: "dark-grass")
        let bgDefinition = SKTileDefinition(texture: bgTexture, size: bgTexture.size())
        let bgGroup = SKTileGroup(tileDefinition: bgDefinition)
        let tileSet = SKTileSet(tileGroups: [bgGroup])
        
        let bgNode = SKTileMapNode(tileSet: tileSet, columns: 4, rows: 8, tileSize: bgTexture.size(), fillWith: bgGroup)
        
        bgNode.position = CGPoint(x: self.frame.size.width / 2, y: self.frame.size.height / 2)
        bgNode.setScale(1)
        
        self.addChild(bgNode)
        
        run(SKAction.playSoundFileNamed("playerDie.mp3",waitForCompletion:false))
        
        //Game over label
        let message = "YOU"
        let label = SKLabelNode(fontNamed: "Nosifer-Regular")
        label.text = message
        label.fontSize = 80
        label.fontColor = SKColor.red
        var scalefactor = min((self.frame.width * 0.85) / label.frame.width, (self.frame.height * 0.10) / label.frame.height)
        label.fontSize *= scalefactor
        label.position = CGPoint(x: self.frame.midX, y: self.frame.maxY - label.frame.height)
        addChild(label)
        
        let message2 = "DIED"
        let label2 = SKLabelNode(fontNamed: "Nosifer-Regular")
        label2.text = message2
        label2.fontSize = label.fontSize
        label2.fontColor = SKColor.red
        label2.position = CGPoint(x: self.frame.midX, y: self.frame.maxY - label.frame.height * 2)
        addChild(label2)
        
      
        //Displaying player score
        let scorelabel = SKLabelNode(fontNamed: "Nosifer-Regular")
        scorelabel.text = "Score: " + String(score)
        scorelabel.fontSize = 20
        scalefactor = min((self.frame.width * 0.6) / scorelabel.frame.width, (self.frame.height * 0.15) / scorelabel.frame.height)
        scorelabel.fontSize *= scalefactor
        scorelabel.position = CGPoint(x: self.frame.midX, y: self.frame.maxY * 0.65)
        addChild(scorelabel)
        
        //Displaying player kills
        let killslabel = SKLabelNode(fontNamed: "Nosifer-Regular")
        killslabel.text = "Kills: " + String(wave)
        killslabel.fontSize = scorelabel.fontSize
        killslabel.position = CGPoint(x: self.frame.midX, y: self.frame.maxY * 0.55)
        addChild(killslabel)
        
  
        
        
        //Restart game button
        restartBox = SKShapeNode()
        let btnWidth = self.frame.width/2
        let btnHeight = self.frame.height/10
        let xPos = self.frame.minX + self.frame.width/4
        var yPos = self.frame.maxY * 0.35
        restartBox.path = UIBezierPath(roundedRect: CGRect(x: xPos,
                                                              y: yPos,
                                                              width: btnWidth,
                                                              height: btnHeight), cornerRadius: 0).cgPath
        restartBox.fillColor = UIColor.red
        restartBox.strokeColor = UIColor.black
        restartBox.lineWidth = frame.size.width * 0.01
        addChild(restartBox)
        
        
        //Restart button label
        restartLabel = SKLabelNode(fontNamed: "Arial-Bold")
        restartLabel.text = "Restart"
        restartLabel.fontSize = 20
        var scalingFactor = min(restartBox.frame.width / restartLabel.frame.width, restartBox.frame.height / restartLabel.frame.height)
        restartLabel.fontSize *= (scalingFactor * 0.5)
        restartLabel.position = CGPoint(x: restartBox.frame.midX, y: restartBox.frame.midY - restartLabel.frame.height / 2.0)
        restartLabel.name = "restart"
        addChild(restartLabel)
        
        
        //Return to main menu button
        mainMenuBox = SKShapeNode()
        yPos = self.frame.maxY * 0.15
        mainMenuBox.path = UIBezierPath(roundedRect: CGRect(x: xPos,
                                                           y: yPos,
                                                           width: btnWidth,
                                                           height: btnHeight), cornerRadius: 0).cgPath
        mainMenuBox.fillColor = UIColor.red
        mainMenuBox.strokeColor = UIColor.black
        mainMenuBox.lineWidth = frame.size.width * 0.01
        mainMenuBox.name = "menu"
        addChild(mainMenuBox)
        
        
        //Main menu button label
        mainMenuLabel = SKLabelNode(fontNamed: "Arial-Bold")
        mainMenuLabel.text = "Main Menu"
        mainMenuLabel.fontSize = 20
        scalingFactor = min(mainMenuBox.frame.width / mainMenuLabel.frame.width, mainMenuBox.frame.height / mainMenuLabel.frame.height)
        mainMenuLabel.fontSize *= (scalingFactor * 0.7)
        mainMenuLabel.position = CGPoint(x: mainMenuBox.frame.midX, y: mainMenuBox.frame.midY - mainMenuLabel.frame.height / 2.0)
        addChild(mainMenuLabel)
    
        
    }
    
    // 6
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch:UITouch = touches.first!
        let positionInScene = touch.location(in: self)
        let touchedNode = self.atPoint(positionInScene)
        
        if let name = touchedNode.name
        {
            if name == "restart" {
                run(SKAction.sequence([
                    SKAction.wait(forDuration: 0.0),
                    SKAction.run() {
                        // 5
                        
                        let reveal = SKTransition.flipHorizontal(withDuration: 0.5)
                        let scene = GameScene(size: self.size1)
                        scene.reloadInputViews()
                        self.view?.presentScene(scene, transition:reveal)
                    }
                    ]))
            }
            if name == "menu" {
                run(SKAction.sequence([
                    SKAction.wait(forDuration: 0.0),
                    SKAction.run() {
                        // 5
                        
                        let reveal = SKTransition.flipHorizontal(withDuration: 0.5)
                        let scene = HomeScene(size: self.size1)
                        scene.reloadInputViews()
                        self.view?.presentScene(scene, transition:reveal)
                    }
                    ]))
            }
        }
    }

}
