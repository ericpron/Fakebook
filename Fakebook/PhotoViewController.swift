//
//  PhotoViewController.swift
//  Fakebook
//
//  Created by Eric Eriksson on 11/9/14.
//  Copyright (c) 2014 Eric Eriksson. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var scrollerView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var actionButtonView: UIImageView!
    @IBOutlet weak var doneButton: UIButton!
    
    var image: UIImage!
    var dynamicOpacity: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        imageView.image = image
        
        dynamicOpacity = 1
        
        scrollerView.backgroundColor = UIColor(white: 0, alpha: dynamicOpacity)
        
        scrollerView.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView!) {
        // This method is called as the user scrolls
       
        // stash offset in variable
        var whereIsIt = scrollerView.contentOffset.y;
        
        // assign background alpha to variable
        scrollerView.backgroundColor = UIColor(white: 0, alpha: dynamicOpacity)
        actionButtonView.alpha = dynamicOpacity-0.5
        doneButton.alpha = dynamicOpacity-0.5
        
        // adjust background alpha according to offset
        if whereIsIt > 0 {
            dynamicOpacity = (1 - (whereIsIt / 100)) + 0.3
        } else {
            dynamicOpacity = (1 - (-(whereIsIt / 100))) + 0.3
        }
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView!) {
        
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView!,
        willDecelerate decelerate: Bool) {
            var offset = scrollView.contentOffset.y
            
            // This method is called right as the user lifts their finger
            if offset > 100 {
                dismissViewControllerAnimated(true, completion: nil)
            } else if offset < -100 {
                dismissViewControllerAnimated(true, completion: nil)
            }
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView!) {
        // This method is called when the scrollview finally stops scrolling.
        
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView!) -> UIView! {
        return imageView
    }
    
    @IBAction func onDone(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
