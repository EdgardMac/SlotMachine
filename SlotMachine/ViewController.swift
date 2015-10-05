//
//  ViewController.swift
//  SlotMachine
//
//  Created by Edgard Maciel on 10/4/15.
//  Copyright © 2015 Edgard Maciel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //Information Labels
    
    var firstContainer: UIView!
    var secondContainer: UIView!
    var thirdContainer: UIView!
    var fourthContainer: UIView!
    
    var tittleLabel: UILabel!
    
    //Buttons in Fourth Container
    
    var resetButton = UIButton()
    var betOneButton = UIButton()
    var betMaxButton = UIButton()
    var spinButton = UIButton()
    
    var slots: [[Slot]] = []
    
    //Stats
    
    var credits = 0
    var currentBet = 0
    var winnings = 0
    
    
    var creditsLabel: UILabel!
    var betLabel: UILabel!
    var winnerPaidLabel: UILabel!
    var creditsTittleLabel: UILabel!
    var betTittleLabel: UILabel!
    var winnerPaidTittleLable: UILabel!
    
    let kMarginForView: CGFloat = 10.0
    let kMarginForSlot: CGFloat = 2.0
    
    let kSixth: CGFloat = 1.0 / 6.0
    let KThird: CGFloat = 1.0 / 3.0
    
    let kHalf: CGFloat = 1.0 / 2.0
    let kEight: CGFloat = 1.0 / 8.0
    
    let kNumberOfContainers = 3
    let kNumerOfSlots = 3

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.setupContainerViews()
        setupFirstContainer(self.firstContainer)
        setupThirdContainer(self.thirdContainer)
        setupFourthContainer(self.fourthContainer)
        hardReset()
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //IBActions
    
    func resetButtonPressed (button: UIButton){
        hardReset()
        print("Reset Button Pressed")
    }
    
    func betOneButtonPressed (button: UIButton){
        
        print(button)
        
        if credits <= 0 {
        
            showAlertWithText("No More Credits", message: "Reset Game")
        } else {
        
            if currentBet < 5 {
                
                currentBet += 1
                credits -= 1
                updateMainView()
            }
            else {
                showAlertWithText(message: "You can only bet 5 credits at a time!")
            }
            
        }
        
        
    }
    
    func betMaxButtonPressed (button: UIButton){
        
        print("Bet Max Button Pressed")
        if credits <= 5 {
            showAlertWithText("Not Enough Credits", message: "Bet Less")
        }
        else {
            if currentBet < 5 {
                var creditsToBetMax = 5 - currentBet
                credits -= creditsToBetMax
                currentBet += creditsToBetMax
                updateMainView()
            }
            else {
                showAlertWithText(message: "You can only bet 5 credits at a time!")
            }
        }
        
    }
    
    func spinButtonPressed (button: UIButton){
        removeSlotImageViews()
        slots = Factory.createSlots()
        setupSecondContainer(self.secondContainer)
    }
    
    
    func setupContainerViews (){
        
        self.firstContainer = UIView(frame: CGRect(x: self.view.bounds.origin.x + kMarginForView, y: self.view.bounds.origin.y, width: self.view.bounds.width - (kMarginForView * 2), height: self.view.bounds.height * kSixth))
        
        self.firstContainer.backgroundColor = UIColor.redColor()
        self.view.addSubview(self.firstContainer)
        
        self.secondContainer = UIView(frame: CGRect(x: self.view.bounds.origin.x + kMarginForView, y: firstContainer.frame.height, width: self.view.bounds.width - (kMarginForView * 2), height: self.view.bounds.height * (3 * kSixth)))
        self.secondContainer.backgroundColor = UIColor.blackColor()
        self.view.addSubview(self.secondContainer)
        
        self.thirdContainer = UIView(frame: CGRect(x: self.view.bounds.origin.x + kMarginForView, y: firstContainer.frame.height + secondContainer.frame.height, width: self.view.bounds.width - (kMarginForView * 2), height: self.view.bounds.height * kSixth))
        self.thirdContainer.backgroundColor = UIColor.lightGrayColor()
        self.view.addSubview(self.thirdContainer)
        
        self.fourthContainer = UIView(frame: CGRect(x: self.view.bounds.origin.x + kMarginForView, y: firstContainer.frame.height + secondContainer.frame.height + thirdContainer.frame.height, width: self.view.bounds.width - (kMarginForView * 2), height: self.view.bounds.height * kSixth))
        self.fourthContainer.backgroundColor = UIColor.blackColor()
        self.view.addSubview(self.fourthContainer)
        
        
    }
    
    func setupFirstContainer(containerView: UIView){
        
        self.tittleLabel = UILabel()
        self.tittleLabel.text = "Super Slots"
        self.tittleLabel.textColor = UIColor.yellowColor()
        self.tittleLabel.font = UIFont(name: "MarkerFelt-Wide", size: 40)
        self.tittleLabel.sizeToFit()
        self.tittleLabel.center = containerView.center
        containerView.addSubview(self.tittleLabel)
        
    }
    
    func setupSecondContainer(containerView: UIView){
        
        for var containerNumber = 0; containerNumber < kNumberOfContainers; ++containerNumber {
            
            for var slotNumber = 0; slotNumber < kNumerOfSlots; ++slotNumber {
                
                var slot:Slot
                var slotImageView = UIImageView()
                
                if slots.count != 0 {
                    let slotContainer = slots[containerNumber] //ArraySlot Number 1, 2 or 3
                    slot = slotContainer[slotNumber] // ArraySlot SubIndex: 1, 2 or 3
                    slotImageView.image = slot.image // Se asigna la imagen del slot al Image View
                }
                else {
                    slotImageView.image = UIImage(named: "Ace")
                }
                
                slotImageView.backgroundColor = UIColor.yellowColor()
                slotImageView.frame = CGRect(x: containerView.bounds.origin.x + (containerView.bounds.size.width * CGFloat(containerNumber) * KThird), y: containerView.bounds.origin.y + (containerView.bounds.size.height * CGFloat(slotNumber) * KThird), width: containerView.bounds.width * KThird - kMarginForSlot, height: containerView.bounds.height * KThird - kMarginForSlot)
                containerView.addSubview(slotImageView)
    
            }
        }
    }
    
    func setupThirdContainer(containerView: UIView){
        
        self.creditsLabel = UILabel()
        self.creditsLabel.text = "000000"
        self.creditsLabel.textColor = UIColor.redColor()
        self.creditsLabel.font = UIFont(name: "Menlo-Bold", size: 16)
        self.creditsLabel.sizeToFit()
        self.creditsLabel.center = CGPoint(x: containerView.frame.width * kSixth, y: containerView.frame.height * KThird)
        self.creditsLabel.textAlignment = NSTextAlignment.Center
        self.creditsLabel.backgroundColor = UIColor.darkGrayColor()
        containerView.addSubview(self.creditsLabel)
        
        self.betLabel = UILabel()
        self.betLabel.text = "0000"
        self.betLabel.textColor = UIColor.redColor()
        self.betLabel.font = UIFont(name: "Menlo-Bold", size: 16)
        self.betLabel.sizeToFit()
        self.betLabel.center = CGPoint(x: containerView.frame.width * kSixth * 3, y: containerView.frame.height * KThird)
        self.betLabel.textAlignment = NSTextAlignment.Center
        self.betLabel.backgroundColor = UIColor.darkGrayColor()
        containerView.addSubview(self.betLabel)
        
        self.winnerPaidLabel = UILabel()
        self.winnerPaidLabel.text = "000000"
        self.winnerPaidLabel.textColor = UIColor.redColor()
        self.winnerPaidLabel.font = UIFont(name: "Menlo-Bold", size: 15)
        self.winnerPaidLabel.sizeToFit()
        self.winnerPaidLabel.center = CGPoint(x: containerView.frame.width * kSixth * 5, y: containerView.frame.height * KThird)
        self.winnerPaidLabel.textAlignment = NSTextAlignment.Center
        self.winnerPaidLabel.backgroundColor = UIColor.darkGrayColor()
        containerView.addSubview(self.winnerPaidLabel)
        
        self.creditsTittleLabel = UILabel()
        self.creditsTittleLabel.text = "Credits"
        self.creditsTittleLabel.textColor = UIColor.blackColor()
        self.creditsTittleLabel.font = UIFont(name: "AmericanTypeWriter", size: 14)
        self.creditsTittleLabel.sizeToFit()
        self.creditsTittleLabel.center = CGPoint(x: containerView.frame.width *  kSixth, y: containerView.frame.height * KThird * 2)
        containerView.addSubview(self.creditsTittleLabel)
        
        self.betTittleLabel = UILabel()
        self.betTittleLabel.text = "Bet"
        self.betTittleLabel.textColor = UIColor.blackColor()
        self.betTittleLabel.font = UIFont(name: "AmericanTypeWriter", size: 14)
        self.betTittleLabel.sizeToFit()
        self.betTittleLabel.center = CGPoint(x: containerView.frame.width * kSixth * 3, y: containerView.frame.height * KThird * 2)
        containerView.addSubview(self.betTittleLabel)
        
        self.winnerPaidTittleLable = UILabel()
        self.winnerPaidTittleLable.text = "Winner Paid"
        self.winnerPaidTittleLable.textColor = UIColor.blackColor()
        self.winnerPaidTittleLable.font = UIFont(name: "AmericanTypeWriter", size: 14)
        self.winnerPaidTittleLable.sizeToFit()
        self.winnerPaidTittleLable.center = CGPoint(x: containerView.frame.width * 5 * kSixth, y: containerView.frame.height * 2 * KThird)
        containerView.addSubview(self.winnerPaidTittleLable)
    
    }
    
    func setupFourthContainer(containerView: UIView){
        
        self.resetButton.setTitle("Reset", forState: UIControlState.Normal)
            self.resetButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        self.resetButton.titleLabel?.font = UIFont(name: "Superclarendon-Bold", size: 12)
        self.resetButton.backgroundColor = UIColor.lightGrayColor()
        self.resetButton.sizeToFit()
        self.resetButton.center = CGPoint(x: containerView.frame.width * kEight, y: containerView.frame.height * kHalf)
        self.resetButton.addTarget(self, action: "resetButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        containerView.addSubview(self.resetButton)
        
        self.betOneButton.setTitle("Bet One", forState: UIControlState.Normal)
        self.betOneButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        self.betOneButton.titleLabel?.font = UIFont(name: "Superclarendon-Bold", size: 12)
        self.betOneButton.backgroundColor = UIColor.greenColor()
        self.betOneButton.sizeToFit()
        self.betOneButton.center = CGPoint(x: containerView.frame.width * 3 * kEight , y: containerView.frame.height * kHalf)
        self.betOneButton.addTarget(self, action: "betOneButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        containerView.addSubview(self.betOneButton)
        
        self.betMaxButton.setTitle("Bet Max", forState: UIControlState.Normal)
        self.betMaxButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        self.betMaxButton.titleLabel?.font = UIFont(name: "Superclarendon-Bold", size: 12)
        self.betMaxButton.backgroundColor = UIColor.redColor()
        self.betMaxButton.sizeToFit()
        self.betMaxButton.center = CGPoint(x: containerView.frame.width * 5 * kEight, y: containerView.frame.height * kHalf)
        self.betMaxButton.addTarget(self, action: "betMaxButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        containerView.addSubview(self.betMaxButton)
        
        self.spinButton.setTitle("Spin", forState: UIControlState.Normal)
        self.spinButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        self.spinButton.titleLabel?.font = UIFont(name: "Superclarendon-Bold", size: 12)
        self.spinButton.backgroundColor = UIColor.greenColor()
        self.spinButton.sizeToFit()
        self.spinButton.center = CGPoint(x: containerView.frame.width * 7 * kEight, y: containerView.frame.height * kHalf)
        self.spinButton.addTarget(self, action: "spinButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        containerView.addSubview(self.spinButton)
    }
    
    func removeSlotImageViews () {
        if self.secondContainer != nil {
            let container: UIView? = self.secondContainer
            let subViews:Array? = container!.subviews
            for view in subViews! {
                view.removeFromSuperview()
            }
        }
    }
    
    func hardReset() {
        removeSlotImageViews()
        slots.removeAll(keepCapacity: true)
        self.setupSecondContainer(self.secondContainer)
        credits = 50
        winnings = 0
        currentBet = 0
        updateMainView()
    }
    
    func updateMainView () {
        self.creditsLabel.text = "\(credits)"
        self.betLabel.text = "\(currentBet)"
        self.winnerPaidLabel.text = "\(winnings)"
    }
    
    func showAlertWithText (header : String = "Warning", message : String) {
        var alert = UIAlertController(title: header, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
}

