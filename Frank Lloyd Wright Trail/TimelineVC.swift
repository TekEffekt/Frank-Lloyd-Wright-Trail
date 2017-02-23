//
//  TimelineVC.swift
//  Frank Lloyd Wright Trail
//
//  Created by Alex on 11/17/16.
//  Copyright © 2016 App Factory. All rights reserved.
//

import UIKit

class TimelineVC: UIViewController {

    
    var scrollView: UIScrollView!
    var timeline:   TimelineView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        scrollView = UIScrollView(frame: view.bounds)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        view.addConstraints([
            NSLayoutConstraint(item: scrollView, attribute: .Left, relatedBy: .Equal, toItem: view, attribute: .Left, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: scrollView, attribute: .Top, relatedBy: .Equal, toItem: view, attribute: .Top, multiplier: 1.0, constant: 29),
            NSLayoutConstraint(item: scrollView, attribute: .Right, relatedBy: .Equal, toItem: view, attribute: .Right, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: scrollView, attribute: .Bottom, relatedBy: .Equal, toItem: view, attribute: .Bottom, multiplier: 1.0, constant: 0)
            ])
        
        timeline = TimelineView(bulletType: .Circle, timeFrames: [
            TimeFrame(text: "New Year's Day", date: "January 1", image: UIImage(named: "meetinghouse")),
            TimeFrame(text: "The month of love!", date: "February 14", image: UIImage(named: "meetinghouse")),
            TimeFrame(text: "Comes like a lion, leaves like a lamb", date: "March",  image: nil),
            TimeFrame(text: "Dumb stupid pranks.", date: "April 1", image: UIImage(named: "meetinghouse")),
            TimeFrame(text: "That's right. No image is necessary!", date: "No image?", image: nil),
            TimeFrame(text: "This control can stretch. It doesn't matter how long or short the text is, or how many times you wiggle your nose and make a wish. The control always fits the content, and even extends a while at the end so the scroll view it is put into, even when pulled pretty far down, does not show the end of the scroll view.", date: "Long text", image: nil),
            TimeFrame(text: "Hope this helps someone!", date: "That's it!", image: nil)
            ])
        scrollView.addSubview(timeline)
        scrollView.addConstraints([
            NSLayoutConstraint(item: timeline, attribute: .Left, relatedBy: .Equal, toItem: scrollView, attribute: .Left, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: timeline, attribute: .Bottom, relatedBy: .LessThanOrEqual, toItem: scrollView, attribute: .Bottom, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: timeline, attribute: .Top, relatedBy: .Equal, toItem: scrollView, attribute: .Top, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: timeline, attribute: .Right, relatedBy: .Equal, toItem: scrollView, attribute: .Right, multiplier: 1.0, constant: 0),
            
            NSLayoutConstraint(item: timeline, attribute: .Width, relatedBy: .Equal, toItem: scrollView, attribute: .Width, multiplier: 1.0, constant: 0)
            ])
        
        view.sendSubviewToBack(scrollView)
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationItem.title = "Suggested Trip"
        let button = UIBarButtonItem(title: "Next", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(doneSelected))
        
        self.navigationItem.rightBarButtonItem = button
    }
    
    func doneSelected(sender: UIBarButtonItem){
        performSegueWithIdentifier("signup", sender: nil)
    }
    

    override func prefersStatusBarHidden() -> Bool {
        return true
    }


}
