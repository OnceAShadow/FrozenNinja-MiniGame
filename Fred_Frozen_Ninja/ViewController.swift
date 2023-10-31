//  ViewController.swift
//  Fred_Frozen_Ninja
//
//  Created by Fred Sevillano 3/24/16.
//  Copyright © 2016 Fred Sevillano All rights reserved.
//  This was originally written in swift 2

import UIKit

class ViewController: UIViewController {

    var snowSpawn = Timer()
    var snowFall = Timer()
    var walkTimer = Timer()
    var snowmanSpawn = Timer()
    var timeScoreTimer = Timer()
    
    var hp = CGFloat()
    var maxHp = Int()
    var hpBar = UIButton()
    var inAir = Bool()
    var dblJump = Bool()
    var groundLevel = CGFloat()
    var levelTimer = Int()
    var spawnTimer = TimeInterval()
    var startCount = Int()
    var miniBossCount = Int()
    var sbOneChange = CGFloat()
    var sbTwoChange = CFloat()
    var attWeapon = Int()
    
    var spawnAmount = Int()
    var difCounter = Int()
    var points = Int()
    var animType = Int()
    var animCounter = Int()
    var snowmenSpeed = Int()
    var fallAngle = CGFloat()
    var snowFlakes = [UIImageView]()
    var snowMen = [UIImageView]()
    var gameFloor = UIImageView()
    var gameFloor2 = UIImageView()
    var pointBoard = UILabel()
    var spawnlb = UILabel()
    
    var spikes1 = UIImageView()
    var spikes2 = UIImageView()
    var spikes3 = UIImageView()
    var spikes4 = UIImageView()
    var spikes5 = UIImageView()
    
    var toon = UIImageView()
    var toonWalk1 = UIImage.init(named: "toon001")
    var toonWalk2 = UIImage.init(named: "toon002")
    var toonWalk3 = UIImage.init(named: "toon003")
    var toonJump1 = UIImage.init(named: "toon005")
    var toonJump2 = UIImage.init(named: "toon006")
    var toonShoot = UIImage.init(named: "toon007")
    
    var shot = UIImageView()
    var shot1 = UIImage.init(named: "shot04")
    var shot2 = UIImage.init(named: "shot002")
    
    var iceSpike = UIImage.init(named: "iceSpike")
    
    var attackTypeButton = UIButton()
    var attOneIcon = UIImage.init(named: "shot04")
    var attTwoIcon = UIImage.init(named: "shot05")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hp = 100.00
        hpBar.frame = CGRect(x:self.view.frame.size.width - 120, y:25, width:hp, height:10)
        hpBar.backgroundColor = .red
        hpBar.layer.cornerRadius = 5
        view.addSubview(hpBar)
        
        fallAngle = 0.80
        animType = 1
        animCounter = 1
        points = 0
        difCounter = 0
        spawnAmount = 0
        inAir = false
        dblJump = false
        levelTimer = 0
        miniBossCount = 0
        attWeapon = 0
        startCount = 3
        
        attackTypeButton = UIButton.init(frame: CGRect(x:view.frame.size.width - 60, y:70, width:50, height:50))
        //attackTypeButton.backgroundColor = UIColor.init(colorLiteralRed: 0.0, green: 0.0, blue: 1.0, alpha: 0.95)
        attackTypeButton.layer.cornerRadius = 16
        attackTypeButton.setImage(attOneIcon, for: [])
        attackTypeButton.addTarget(self, action: #selector(switchAttacks), for: UIControlEvents.touchUpInside)
    
        view.addSubview(attackTypeButton)
        
        snowSpawn = Timer.scheduledTimer(timeInterval: 0.05,
                                         target: self,
                                         selector: #selector(ViewController.snowSpawner),
                                         userInfo: nil,
                                         repeats: true)
        
        snowFall = Timer.scheduledTimer(timeInterval:0.015,
                                        target: self,
                                        selector: #selector(ViewController.snowFaller),
                                        userInfo: nil,
                                        repeats: true)
        
        walkTimer = Timer.scheduledTimer(timeInterval:0.1,
                                         target: self,
                                         selector: #selector(ViewController.walkChanger),
                                         userInfo: nil,
                                         repeats: true)
        
        snowmanSpawn = Timer.scheduledTimer(timeInterval:2.0,
                                            target: self,
                                            selector: #selector(ViewController.snowmanSpawner),
                                            userInfo: nil,
                                            repeats: true)

        timeScoreTimer = Timer.scheduledTimer(timeInterval:1.0,
                                              target: self,
                                              selector: #selector(ViewController.timeScore),
                                              userInfo: nil,
                                              repeats: true)
        
        view.backgroundColor = UIColor.init(red: 0.75, green: 0.96, blue: 1.0, alpha: 0.95)
        
        gameFloor = UIImageView.init(frame: CGRect(x:0, 
                                                   y:self.view.frame.size.height - 40,
                                                   width:self.view.frame.size.width * 2,
                                                   height:200))
        
        gameFloor.image = UIImage.init(named: "ice001")
        gameFloor.layer.zPosition = 100
        view.addSubview(gameFloor)
        
        gameFloor2 = UIImageView.init(frame: CGRect(x:self.view.frame.size.width * 2,
                                                    y:self.view.frame.size.height - 40,
                                                    width:self.view.frame.size.width * 2,
                                                    height:200))
        
        gameFloor2.image = UIImage.init(named: "ice001")
        gameFloor2.layer.zPosition = 100
        view.addSubview(gameFloor2)
        
        toon = UIImageView.init(frame: CGRect(x:100, y:self.view.frame.size.height - 90, width:50, height:50))
        toon.image = toonWalk1
        view.addSubview(toon)
        
        groundLevel = toon.frame.origin.y
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.upSwipe))
        swipeUp.direction = UISwipeGestureRecognizerDirection.up
        view.addGestureRecognizer(swipeUp)
        
        let dTap = UITapGestureRecognizer.init(target: self, action: #selector(ViewController.doubleTap))
        dTap.numberOfTapsRequired = 2
        view.addGestureRecognizer(dTap)
        
        pointBoard = UILabel.init(frame: CGRect(x:10, y:20, width:400, height:30))
        pointBoard.text = String(points)
        pointBoard.font = UIFont(name: pointBoard.font.fontName, size: 35)
        pointBoard.textColor = UIColor.init(red: 1.0, green: 0.47, blue: 0.0, alpha: 0.95)
        view.addSubview(pointBoard)

        spikes1 = UIImageView.init(frame: CGRect(x:0, y:-4, width:200, height:42))
        spikes1.image = UIImage.init(named: "icespike")
        view.addSubview(spikes1)
        
        spikes2 = UIImageView.init(frame: CGRect(x:200, y:-4, width:200, height:42))
        spikes2.image = UIImage.init(named: "icespike")
        view.addSubview(spikes2)

        spikes3 = UIImageView.init(frame: CGRect(x:400, y:-4, width:200, height:42))
        spikes3.image = UIImage.init(named: "icespike")
        view.addSubview(spikes3)
        
        spikes4 = UIImageView.init(frame: CGRect(x:600, y:-4, width:200, height:42))
        spikes4.image = UIImage.init(named: "icespike")
        view.addSubview(spikes4)

        spikes5 = UIImageView.init(frame: CGRect(x:800, y:-4, width:200, height:42))
        spikes5.image = UIImage.init(named: "icespike")
        view.addSubview(spikes5)
    }
    
    @objc func snowSpawner() {
        var flakeSize = arc4random() % 25
        if flakeSize < 5 {
            flakeSize = 5
        }
        let aSnowFlake = UIImageView.init(frame: CGRect(x:CGFloat(Int(arc4random()) % Int(self.view.frame.size.width)) + 60,
                                                        y:-25, 
                                                        width:CGFloat(flakeSize),
                                                        height:CGFloat(flakeSize)))
        
        aSnowFlake.image = UIImage.init(named: "snow001")
        aSnowFlake.alpha = 0.82
        view.isOpaque = false
        
        snowFlakes.append(aSnowFlake)
        view.addSubview(aSnowFlake)
    }
    
    @objc func snowFaller() {
        
        for (index, _) in snowMen.enumerated().reversed() {
            if hp > 0 {
                snowMen[index].frame.origin.x -= 1.5
                
                if view.subviews.contains(shot) && snowMen[index].frame.origin.x < shot.frame.origin.x && toon.frame.origin.x + toon.frame.size.width < snowMen[index].frame.origin.x {
                    
                    if shot.frame.origin.y + shot.frame.size.height > snowMen[index].frame.origin.y {
                        shot.removeFromSuperview()
                        snowMen[index].removeFromSuperview()
                        snowMen.remove(at: index)
                    
                        points += 100
                    
                        continue
                    }
                }
                
                if snowMen[index].frame.origin.x < toon.frame.origin.x + toon.frame.size.width/2 {
                    if toon.frame.origin.y + (toon.frame.size.width/3)  > snowMen[index].frame.origin.y {
                        snowMen[index].removeFromSuperview()
                        snowMen.remove(at: index)
                        hp -= 20
                        
                        if hp <= 0 {
                            print("dead!")
                            hpBar.frame = CGRect(x:self.view.frame.size.width - 120, y:30, width:hp, height:10)
                            toon.frame = CGRect(x:0 - 100, y:30, width:hp, height:10)
                        }
                        
                        if hp >= 0 {
                            hpBar.frame = CGRect(x:self.view.frame.size.width - 120, y:30, width:hp, height:10)
                        }
                        
                        print("damage")
                        continue
                    }
                
                }
                
                if snowMen[index].frame.origin.x < -40 {
                    snowMen[index].removeFromSuperview()
                    snowMen.remove(at: index)
                    
                    continue
                }
            }
        }
        
        pointBoard.text = String(points)
        
        shot.frame.origin.x += 15
        
        if shot.frame.origin.x > self.view.frame.size.width + 40 {
            shot.removeFromSuperview()
        }
        
        gameFloor.frame.origin.x -= 4
        gameFloor2.frame.origin.x -= 4
        
        if gameFloor.frame.origin.x < (self.view.frame.size.width * 2) * -1 {
            gameFloor.frame.origin.x = self.view.frame.size.width * 2
        } else if gameFloor2.frame.origin.x < (self.view.frame.size.width * 2) * -1 {
            gameFloor2.frame.origin.x = self.view.frame.size.width * 2
        }

        for (index,flake) in snowFlakes.enumerated() {
            flake.frame.origin.x -= fallAngle
            flake.frame.origin.y += 2
            
            if flake.frame.origin.x < 0 || flake.frame.origin.y > view.frame.size.height + 20 {
                flake.removeFromSuperview()
                snowFlakes.remove(at: index)
            }
        }
    }
    
    @objc func walkChanger() {
        if animType == 1 {
            if animCounter == 3 {
                toon.image = toonWalk1
                animCounter = 1
            } else if animCounter == 2 {
                toon.image = toonWalk2
                animCounter = 3
            } else {
                toon.image = toonWalk3
                animCounter = 2
            }
        } else if animType == 2 {
            if animCounter == 1  || animCounter == 2 {
                toon.image = toonShoot
                animCounter += 1
            }else{
                animType = 1
                animCounter = 1
            }
        } else if animType == 3 || animType == 4 {
            if animType == 3 {
                if animCounter < 7 {
                    animCounter += 1
                    if dblJump == true {
                        if animCounter == 6 {
                            toon.frame.origin.y -= 5
                        } else {
                            toon.frame.origin.y -= 32
                        }
                    } else {
                        toon.frame.origin.y -= 25
                    }
                    
                    if animCounter == 4 {
                        toon.image = toonJump2
                    }
                } else {
                    if dblJump == true {
                        toon.frame.origin.y += 23
                    } else {
                        toon.frame.origin.y += 27
                    }
                    
                    if toon.frame.origin.y + toon.frame.size.width > groundLevel {
                        toon.frame.origin.y = groundLevel
                        animType = 1
                        animCounter = 0
                        dblJump = false
                    }
                    animCounter += 1
                }
            } else {
                toon.image = toonShoot
                animType = 3
                animCounter += 1
            }
        }
    }
    
    @objc func doubleTap() {
        if view.subviews.contains(shot) {
            
        } else {
            if animType == 3 {
                animType = 4
            } else {
                animType = 2
                animCounter = 1
            }
            shot = UIImageView.init(frame: CGRect(x:toon.center.x, y:toon.center.y - 10, width:15, height:15))
            
            shot.image = shot1
            view.addSubview(shot)
            toon.image = toonShoot
        }
    }
    
    @objc func upSwipe() {
        if dblJump == false {
            if animType == 3 {
                animType = 4
                animCounter = 1
                dblJump = true
                toon.image = toonJump1
            } else {
                animType = 3
                animCounter = 1
                toon.image = toonJump1
            }
        }
    }
    
    @objc func snowmanSpawner() {
        //spawnTimer = spawnTimer - (spawnTimer * 0.0015)
        //snowmanSpawn = NSTimer.scheduledTimer(spawnTimer, target: self, selector: #selector(ViewController.snowmanSpawner), userInfo: nil, repeats: true)
        //spawnlb.text = String(spawnTimer)
        
        startCount += 1
        if startCount < 4 {
            
        } else {
        
            var random = Int(arc4random_uniform(3))
            
            spawnAmount += 1
            
            if spawnAmount < 5 {
            
                if random == 1 {
                    let sMan = UIImageView.init(frame: CGRect(x:view.frame.size.width + 100, y:view.frame.size.height - 75, width:40 , height:40))
                    sMan.image = UIImage.init(named: "snowman001")
                    view.addSubview(sMan)
                    snowMen.append(sMan)
                } else if random == 2 || random == 0 {
                    random = Int(arc4random_uniform(100))
                    
                    if random <= 45 {
                        let sMan = UIImageView.init(frame: CGRect(x:view.frame.size.width + 100, y:view.frame.size.height - 75, width:40, height:40))
                        sMan.image = UIImage.init(named: "snowman001")
                        view.addSubview(sMan)
                        snowMen.append(sMan)
                    } else if random <= 75 {
                        let sMan = UIImageView.init(frame: CGRect(x:view.frame.size.width + 100, y:view.frame.size.height - 75, width:40, height:40))
                        sMan.image = UIImage.init(named: "snowman001")
                        view.addSubview(sMan)
                        snowMen.append(sMan)
                        
                        let sMan2 = UIImageView.init(frame: CGRect(x:view.frame.size.width + 147, y:view.frame.size.height - 75, width:40, height:40))
                        sMan2.image = UIImage.init(named: "snowman001")
                        view.addSubview(sMan2)
                        snowMen.append(sMan2)
                    } else {
                        let sMan = UIImageView.init(frame: CGRect(x:view.frame.size.width + 100, y:view.frame.size.height - 75, width:40, height:40))
                        sMan.image = UIImage.init(named: "snowman001")
                        view.addSubview(sMan)
                        snowMen.append(sMan)
                        
                        let sMan2 = UIImageView.init(frame: CGRect(x:view.frame.size.width + 147, y:view.frame.size.height - 90, width:55, height:55))
                        sMan2.image = UIImage.init(named: "snowman001")
                        view.addSubview(sMan2)
                        snowMen.append(sMan2)
                        
                        let sMan3 = UIImageView.init(frame: CGRect(x:view.frame.size.width + 203, y:view.frame.size.height - 75, width:40, height:40))
                        sMan3.image = UIImage.init(named: "snowman001")
                        view.addSubview(sMan3)
                        snowMen.append(sMan3)
                    }
                }
            } else {
                spawnAmount = 0
                miniBossCount += 1
                
                if miniBossCount == 1 {
                    
                    let sMan = UIImageView.init(frame: CGRect(x:view.frame.size.width + 100, y:view.frame.size.height - 75, width:40, height:40))
                    sMan.image = UIImage.init(named: "snowman001")
                    view.addSubview(sMan)
                    snowMen.append(sMan)
                    
                    let sMan2 = UIImageView.init(frame: CGRect(x:view.frame.size.width + 128, y:view.frame.size.height - 75, width:40, height:40))
                    sMan2.image = UIImage.init(named: "snowman001")
                    view.addSubview(sMan2)
                    snowMen.append(sMan2)
                    
                    let sMan3 = UIImageView.init(frame: CGRect(x:view.frame.size.width + 170, y:view.frame.size.height - 95, width:60, height:60))
                    sMan3.image = UIImage.init(named: "snowman001")
                    view.addSubview(sMan3)
                    snowMen.append(sMan3)
                    
                    let sMan4 = UIImageView.init(frame: CGRect(x:view.frame.size.width + 220, y:view.frame.size.height - 75, width:40, height:40))
                    sMan4.image = UIImage.init(named: "snowman001")
                    view.addSubview(sMan4)
                    snowMen.append(sMan4)
                    
                    let sMan5 = UIImageView.init(frame: CGRect(x:view.frame.size.width + 245, y:view.frame.size.height - 85, width:50, height:50))
                    sMan5.image = UIImage.init(named: "snowman001")
                    view.addSubview(sMan5)
                    snowMen.append(sMan5)
                    
                } else if  miniBossCount == 2 {
                
                    let sMan3 = UIImageView.init(frame: CGRect(x:view.frame.size.width + 245, y:view.frame.size.height - 135, width:100, height:100))
                    sMan3.image = UIImage.init(named: "snowmansad01")
                    view.addSubview(sMan3)
                    snowMen.append(sMan3)
                    
                } else if miniBossCount == 3 {
                    miniBossCount = 0
                    let sMan3 = UIImageView.init(frame: CGRect(x:view.frame.size.width + 245, y:50, width:50, height:50))
                    sMan3.image = UIImage.init(named: "snowman001")
                    view.addSubview(sMan3)
                    snowMen.append(sMan3)
                }
            }
        }
    }

    @objc func timeScore() {
        points += 1;
        levelTimer += 1;
    }
    
    @objc func switchAttacks() {
        if attWeapon == 0 {
            attWeapon = 1
            attackTypeButton.setImage(attTwoIcon, for: [])
        } else {
            attWeapon = 0
            attackTypeButton.setImage(attOneIcon, for: [])
        }
        print("Hello----")
    }
}
