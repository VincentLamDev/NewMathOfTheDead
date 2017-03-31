//
//  HomeScene.swift
//  MathOfTheDead
//
//  Created by Vincent Lam on 2017-03-06.
//  Copyright © 2017 NGU. All rights reserved.
//

import Foundation
import SpriteKit

class HomeScene: SKScene {
    var gl:CAGradientLayer!

    var logo: SKNode!
    var gradientLayer: CAGradientLayer!
    var startBox: SKShapeNode!
    var startLabel: SKLabelNode!
    var leaderboardBox: SKShapeNode!
    var leaderboardLabel: SKLabelNode!
    var settingsBox: SKShapeNode!
    var settingsLabel: SKLabelNode!
    var size1: CGSize!

    var backgroundMusic: SKAudioNode!
    
    override init(size: CGSize) {
        
        super.init(size: size)
        self.size1 = size
        
        if let musicURL = Bundle.main.url(forResource: "MichaelMyers", withExtension: "mp3") {
            backgroundMusic = SKAudioNode(url: musicURL)
            addChild(backgroundMusic)
        }
        
        //background grass tile map
        let bgTexture = SKTexture(imageNamed: "dark-grass")
        let bgDefinition = SKTileDefinition(texture: bgTexture, size: bgTexture.size())
        let bgGroup = SKTileGroup(tileDefinition: bgDefinition)
        let tileSet = SKTileSet(tileGroups: [bgGroup])
        //let bgNode = SKTileMapNode(tileSet: tileSet, columns: 4, rows: 8, tileSize: bgTexture.size())
        
        let bgNode = SKTileMapNode(tileSet: tileSet, columns: 4, rows: 8, tileSize: bgTexture.size(), fillWith: bgGroup)
        
        bgNode.position = CGPoint(x: self.frame.size.width / 2, y: self.frame.size.height / 2)
        bgNode.setScale(1)
        self.addChild(bgNode)
        

        
        gradientLayer = CAGradientLayer()
        
        gradientLayer.frame.size.width = size.width
        gradientLayer.frame.size.height = size.height
        
        gradientLayer.colors = [UIColor.black.cgColor, UIColor.clear]
        gradientLayer.locations = [0.0, 0.40]
        view?.layer.addSublayer(gradientLayer)
        
        
//        let view = UIView(frame: CGRect(x: 100, y: 100, width: size.width, height: size.height))
//
//        let layer = CAGradientLayer()
//        layer.frame = CGRect(x: 100, y: 100, width: size.width, height: size.height)
//        layer.colors = [UIColor.blue.cgColor, UIColor.yellow.cgColor]
//        layer.zPosition = 2.0
//        view.layer.addSublayer(layer)
        

        
        
        //Game over label
        let label1 = SKLabelNode(fontNamed: "Nosifer-Regular")
        label1.text = "MATH OF"
        label1.fontSize = 80
        label1.fontColor = SKColor.red
        var scalingFactor = min(self.frame.width * 0.7 / label1.frame.width, self.frame.height * 0.15 / label1.frame.height)
        label1.fontSize *= scalingFactor
        label1.position = CGPoint(x: self.frame.midX, y: self.frame.maxY - label1.frame.height * 1.10)
        addChild(label1)
        
        let label2 = SKLabelNode(fontNamed: "Nosifer-Regular")
        label2.text = "THE DEAD"
        label2.fontSize = 80
        label2.fontColor = SKColor.red
        scalingFactor = min(self.frame.width * 0.7 / label2.frame.width, self.frame.height * 0.15 / label2.frame.height)
        label2.fontSize *= scalingFactor
        label2.position = CGPoint(x: self.frame.midX, y: self.frame.maxY - label1.frame.height * 2 )
        addChild(label2)
    
        
        
        //Start game button
        startBox = SKShapeNode()
        let btnWidth = self.frame.width/2
        let btnHeight = self.frame.height/10
        let xPos = self.frame.minX + self.frame.width/4
        var yPos = self.frame.maxY * 0.6
        startBox.path = UIBezierPath(roundedRect: CGRect(x: xPos,
                                                         y: yPos,
                                                         width: btnWidth,
                                                         height: btnHeight), cornerRadius: 0).cgPath
        startBox.fillColor = UIColor.red
        startBox.strokeColor = UIColor.black
        startBox.lineWidth = frame.size.width * 0.01
        startBox.name = "start"
        addChild(startBox)
        
        
        //Start button label
        startLabel = SKLabelNode(fontNamed: "Arial")
        startLabel.text = "Start"
        startLabel.fontSize = 20
        scalingFactor = min(startBox.frame.width / startLabel.frame.width, startBox.frame.height / startLabel.frame.height)
        startLabel.fontSize *= (scalingFactor * 0.4)
        startLabel.position = CGPoint(x: startBox.frame.midX, y: startBox.frame.midY - startLabel.frame.height / 2.0)
        startLabel.name = "start"
        addChild(startLabel)
        
        // add logo
        
        let zombies = SKSpriteNode(imageNamed: "shaneszombies")
        var zombiesScalingFactor = min(self.frame.width / zombies.frame.width, self.frame.height / zombies.frame.height)
        zombies.position = CGPoint(x: self.frame.midX, y: self.frame.midY - zombies.frame.height / 2.0)
        addChild(zombies)
        
        
//        //Leaderboard button
//        leaderboardBox = SKShapeNode()
//        yPos = self.frame.maxY * 0.4
//        leaderboardBox.path = UIBezierPath(roundedRect: CGRect(x: xPos,
//                                                               y: yPos,
//                                                               width: btnWidth,
//                                                               height: btnHeight), cornerRadius: 0).cgPath
//        leaderboardBox.fillColor = UIColor.red
//        leaderboardBox.strokeColor = UIColor.black
//        leaderboardBox.lineWidth = frame.size.width * 0.01
//        addChild(leaderboardBox)
//        
//        
//        //Leaderboard button label
//        leaderboardLabel = SKLabelNode(fontNamed: "Arial")
//        leaderboardLabel.text = "High Scores"
//        leaderboardLabel.fontSize = 20
//        scalingFactor = min(leaderboardBox.frame.width / leaderboardLabel.frame.width, leaderboardBox.frame.height / leaderboardLabel.frame.height)
//        leaderboardLabel.fontSize *= (scalingFactor * 0.7)
//        leaderboardLabel.position = CGPoint(x: leaderboardBox.frame.midX, y: leaderboardBox.frame.midY - leaderboardLabel.frame.height / 2.0)
//        addChild(leaderboardLabel)
//        
//        
//        //Setting button
//        settingsBox = SKShapeNode()
//        yPos = self.frame.maxY * 0.2
//        settingsBox.path = UIBezierPath(roundedRect: CGRect(x: xPos,
//                                                            y: yPos,
//                                                            width: btnWidth,
//                                                            height: btnHeight), cornerRadius: 0).cgPath
//        settingsBox.fillColor = UIColor.red
//        settingsBox.strokeColor = UIColor.black
//        settingsBox.lineWidth = frame.size.width * 0.01
//        addChild(settingsBox)
//        
//        
//        //Settings button label
//        settingsLabel = SKLabelNode(fontNamed: "Arial")
//        settingsLabel.text = "Settings"
//        settingsLabel.fontSize = 20
//        scalingFactor = min(settingsBox.frame.width / settingsLabel.frame.width, settingsBox.frame.height / settingsLabel.frame.height)
//        settingsLabel.fontSize *= (scalingFactor * 0.7)
//        settingsLabel.position = CGPoint(x: leaderboardBox.frame.midX, y: settingsBox.frame.midY - settingsLabel.frame.height / 2.0)
//        addChild(settingsLabel)
//        
        
        
        //self.createGradientLayer()

    }
    
    // 6
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createGradientLayer() {
        gradientLayer = CAGradientLayer()
        
        gradientLayer.frame = (self.view?.frame)!
        
        gradientLayer.colors = [UIColor.black.cgColor, UIColor.clear]
        gradientLayer.locations = [0.0, 0.40]
        self.view?.layer.addSublayer(gradientLayer)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch:UITouch = touches.first!
        let positionInScene = touch.location(in: self)
        let touchedNode = self.atPoint(positionInScene)
        
        if let name = touchedNode.name
        {
            if name == "start" {
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
                        let scene = GameScene(size: self.size1)
                        scene.reloadInputViews()
                        self.view?.presentScene(scene, transition:reveal)
                    }
                    ]))
            }
        }
    }

}
