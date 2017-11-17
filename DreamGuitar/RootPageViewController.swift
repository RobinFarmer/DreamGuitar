//
//  RootPageViewController.swift
//  DreamGuitar
//
//  Created by Robin Farmer on 07/09/2017.
//  Copyright © 2017 Maddisys Limited. All rights reserved.
//

import UIKit

class RootPageViewController: UIPageViewController, UIPageViewControllerDataSource {
    
    lazy var viewControllerList:[UIViewController] = {
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc1 = sb.instantiateViewController(withIdentifier: "onboardingVC1")
        let vc2 = sb.instantiateViewController(withIdentifier: "onboardingVC2")
        let vc3 = sb.instantiateViewController(withIdentifier: "onboardingVC3")
        return [vc1, vc2, vc3]
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        self.dataSource = self
        
        
        
        if let firstViewController = viewControllerList.first {
            self.setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let vcIndex = viewControllerList.index(of: viewController) else { return nil}
        
        let previousIndex = vcIndex - 1
        
        guard previousIndex >= 0 else {return nil}
        
        guard viewControllerList.count > previousIndex else { return nil}
        
        return viewControllerList[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let vcIndex = viewControllerList.index(of: viewController) else {return nil}
        
        let nextIndex = vcIndex + 1
        
        guard viewControllerList.count != nextIndex else {return nil}
        
        guard viewControllerList.count > nextIndex else {return nil}
        
        return viewControllerList[nextIndex]
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return viewControllerList.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }



}
