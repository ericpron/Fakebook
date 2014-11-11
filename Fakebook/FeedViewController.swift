//
//  FeedViewController.swift
//  Fakebook
//
//  Created by Eric Eriksson on 10/16/14.
//  Copyright (c) 2014 Eric Eriksson. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController, UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning {
    
    var isPresenting: Bool = true
    
    @IBOutlet weak var feedScrollView: UIScrollView!
    @IBOutlet weak var homeFeedContent: UIImageView!
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    @IBOutlet weak var wedding1: UIImageView!
    @IBOutlet weak var wedding2: UIImageView!
    @IBOutlet weak var wedding3: UIImageView!
    @IBOutlet weak var wedding4: UIImageView!
    @IBOutlet weak var wedding5: UIImageView!
    
    var selectedImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.homeFeedContent.alpha = 0
        self.wedding1.alpha = 0
        self.wedding2.alpha = 0
        self.wedding3.alpha = 0
        self.wedding4.alpha = 0
        self.wedding5.alpha = 0
        
        // Do any additional setup after loading the view.
        feedScrollView.contentSize = CGSize(width: 320, height: homeFeedContent.frame.size.height)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func alphaHome() {
        UIView.animateWithDuration(0.4, animations: { () -> Void in
            self.homeFeedContent.alpha = 1
            self.wedding1.alpha = 1
            self.wedding2.alpha = 1
            self.wedding3.alpha = 1
            self.wedding4.alpha = 1
            self.wedding5.alpha = 1
        })
    }
    
    override func viewDidAppear(animated:Bool) {
        delay(2, { () -> () in
            self.alphaHome()
            self.loadingView.stopAnimating()
        })
    }
    
    func animationControllerForPresentedController(presented: UIViewController!, presentingController presenting: UIViewController!, sourceController source: UIViewController!) -> UIViewControllerAnimatedTransitioning! {
        isPresenting = true
        return self
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController!) -> UIViewControllerAnimatedTransitioning! {
        isPresenting = false
        return self
    }
    
    @IBAction func onImageTap(sender: UITapGestureRecognizer) {
        var tappedImageView = sender.view as UIImageView
        selectedImageView = tappedImageView
        
        performSegueWithIdentifier("photoSegue", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        var destinationViewController = segue.destinationViewController as PhotoViewController
        destinationViewController.modalPresentationStyle = UIModalPresentationStyle.Custom
        destinationViewController.transitioningDelegate = self
        
        destinationViewController.image = self.selectedImageView.image
        
    }
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        // The value here should be the duration of the animations scheduled in the animationTransition method
        return 0.3
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        var containerView = transitionContext.containerView()
        var toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        var fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        
        var movingImage = UIImageView(image: selectedImageView.image)
        movingImage.contentMode = selectedImageView.contentMode
        movingImage.clipsToBounds = selectedImageView.clipsToBounds
        var window = UIApplication.sharedApplication().keyWindow!
        window.addSubview(movingImage)
        
        if (isPresenting) {
            var photoViewController = toViewController as PhotoViewController
            photoViewController.imageView.hidden = true
            
            movingImage.frame = selectedImageView.frame
            
            selectedImageView.hidden = true
            
            containerView.addSubview(toViewController.view)
            toViewController.view.alpha = 0
            
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                toViewController.view.alpha = 1
                movingImage.frame = photoViewController.imageView.frame
                movingImage.contentMode = photoViewController.imageView.contentMode
                }) { (finished: Bool) -> Void in
                    transitionContext.completeTransition(true)
                    movingImage.removeFromSuperview()
                    photoViewController.imageView.hidden = false
            }
        } else {
            var photoViewController = fromViewController as PhotoViewController
            photoViewController.imageView.hidden = true
            
            movingImage.frame = photoViewController.imageView.frame
            movingImage.contentMode = photoViewController.imageView.contentMode
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                fromViewController.view.alpha = 0
                movingImage.frame = self.selectedImageView.frame
                }) { (finished: Bool) -> Void in
                    transitionContext.completeTransition(true)
                    fromViewController.view.removeFromSuperview()
                    self.selectedImageView.hidden = false
                    movingImage.removeFromSuperview()
            }
        }
    }
}
