//
//  ImageDismissedAnimator.swift
//  Pinterest
//
//  Created by Oka Yuya on 2016/09/24.
//  Copyright © 2016年 nnsnodnb.moe. All rights reserved.
//

class ImageDismissedAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.3
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        guard let sourceVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)
            as? ImageDistinationTransitionType else {
                return
        }
        
        guard let distinationVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)
            as? ImageSourceTransitionType else {
                return
        }
        
        guard let containerView = transitionContext.containerView() else {
            return
        }
        
        let animationDuration = transitionDuration(transitionContext)
        
        let snapshot = sourceVC.imageView.snapshotViewAfterScreenUpdates(false)
        snapshot.frame = containerView.convertRect(sourceVC.imageView.frame,
                                                   toView: sourceVC.imageView.superview)
        snapshot.autoresizingMask = [.FlexibleHeight,.FlexibleWidth,.FlexibleTopMargin,.FlexibleBottomMargin]
        sourceVC.imageView.alpha = 0.0
        
        guard let selectedIndexPath = distinationVC.collectionView.indexPathsForSelectedItems()?.first else {
            return
        }
        
        let selectedCell = distinationVC.collectionView.cellForItemAtIndexPath(selectedIndexPath) as! ImageCollectionViewCellType
        selectedCell.imageView.alpha = 0.0
        selectedCell.imageView.transform =  CGAffineTransformMakeScale(1.1, 1.1)
        
        distinationVC.baseView.frame = transitionContext.finalFrameForViewController(distinationVC as! UIViewController)
        containerView.insertSubview(distinationVC.baseView, belowSubview: sourceVC.baseView)
        
        let imageWrapperView = UIView.init(frame: containerView.convertRect(sourceVC.imageView.frame,
            toView: sourceVC.imageView.superview))
        imageWrapperView.clipsToBounds = true
        imageWrapperView.addSubview(snapshot)
        containerView.addSubview(imageWrapperView)
        
        let whiteBackgroundView = UIView.init(frame: sourceVC.baseView.frame)
        whiteBackgroundView.backgroundColor = UIColor.whiteColor()
        containerView.insertSubview(whiteBackgroundView, belowSubview: imageWrapperView)
        
        UIView.animateKeyframesWithDuration(animationDuration,
                                            delay: 0.0,
                                            options: UIViewKeyframeAnimationOptions.CalculationModeLinear,
                                            animations: {
                                                
                                                UIView .addKeyframeWithRelativeStartTime(0.0,
                                                    relativeDuration: 1.0,
                                                    animations: {
                                                        
                                                        sourceVC.baseView.alpha = 0.0
                                                        imageWrapperView.frame = containerView.convertRect(selectedCell.imageView.frame,
                                                            fromView: selectedCell.imageView.superview)
                                                        whiteBackgroundView.alpha = 0.0
                                                        selectedCell.imageView.alpha = 1.0
                                                })
                                                
                                                UIView .addKeyframeWithRelativeStartTime(0.95,
                                                    relativeDuration: 0.05,
                                                    animations: {
                                                        selectedCell.imageView.transform = CGAffineTransformIdentity
                                                        snapshot.alpha = 0.0
                                                })
                                                
        }) { (finished) in
            
            whiteBackgroundView.removeFromSuperview()
            snapshot.removeFromSuperview()
            imageWrapperView.removeFromSuperview()
            sourceVC.imageView.hidden = false
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
        }
    }
}