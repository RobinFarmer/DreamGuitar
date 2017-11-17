//
//  ViewController.swift
//  DreamGuitar
//
//  Created by Robin Farmer on 04/08/2017.
//  Copyright © 2017 Maddisys Limited. All rights reserved.
//

import UIKit


class ViewController: UIViewController, DataSentDelegate {
    
    @IBOutlet weak var rightCurtain: UIImageView!
    @IBOutlet weak var leftCurtain: UIImageView!
    
    @IBOutlet weak var sharedView: UIView!
    @IBAction func unwindToThisVC(segue:UIStoryboardSegue) {
        
    }
    
    @IBAction func saveBtnPressed(_ sender: UIButton) {
        saveThisImage.isHidden = false
        let img = takeSnapshotOfView(view: sharedView)
        let activityVC = UIActivityViewController(activityItems: [img!], applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view
        self.present(activityVC, animated: true, completion: nil)
        saveThisImage.isHidden = true
    }
    
    
    func takeSnapshotOfView(view:UIView) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(view.frame.size, view.isOpaque, 0.0)
        view.drawHierarchy(in: CGRect(x: 0.0, y: 0.0, width: view.frame.size.width, height: view.frame.size.height), afterScreenUpdates: true)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    @IBOutlet weak var saveThisImage: UIImageView!
    
    
    @IBAction func resetBtnPressed(_ sender: UIButton) {
        // reset head
        imageNumber = 0
        headDetailView.image = UIImage(named: "head1")!
        headImageView.image = UIImage(named: "background0")
        let headMaskImage = UIImage(named: "head1mask")!
        headBackGround.mask = UIImageView(image: headMaskImage)

        

        // reset neck
        neckNumber = 0
        neckDetailView.image = neckDetail
        neckImageView.image = UIImage(named: "background0")
        neckBackGround.mask = UIImageView(image: neckMaskImage)

        
        // reset body
        bodyNumber = 0
        bodyDetailView.image = bodyDetail
        bodyImageView.image = UIImage(named: "background0")
        bodyBackGround.mask = UIImageView(image: bodyMaskImage)

        
        headBackGround.layer.mask?.frame = CGRect(x: 0, y: 0, width: headImageView.frame.size.width, height: headImageView.frame.size.height)
        bodyBackGround.layer.mask?.frame = CGRect(x: 0, y: 0, width: bodyImageView.frame.size.width, height: bodyImageView.frame.size.height)
        neckBackGround.layer.mask?.frame = CGRect(x: 0, y: 0, width: neckImageView.frame.size.width, height: neckImageView.frame.size.height)
    }
    

    @IBOutlet weak var headHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var headImageHeight: NSLayoutConstraint!
    @IBOutlet weak var bodyHeight: NSLayoutConstraint!
    @IBOutlet weak var bodyHeightMultiplier: NSLayoutConstraint!
    

    func headImageSelected(image: String, newMaskImage: String) {
        headDetailView.image = UIImage(named: image)
        let newMaskImage = UIImage(named: newMaskImage)
        headBackGround.mask = UIImageView(image: newMaskImage)
    }
    
    func bodyImageSelected(bodyImage: String, newBodyMask: String) {
        bodyDetailView.image = UIImage(named: bodyImage)
        let newMaskImage = UIImage(named: newBodyMask)
        bodyBackGround.mask = UIImageView(image: newMaskImage)
    }
    
    func neckImageSelected(neckImage: String, newNeckMask: String) {
        neckDetailView.image = UIImage(named: neckImage)
        let newNeckImage = UIImage(named: newNeckMask)
        neckBackGround.mask = UIImageView(image: newNeckImage)
    }
    
    func headBackGroundImage(image: UIImage) {
        headImageView.image = image
    }
    
    func bodyBackGroundImage(image: UIImage) {
        bodyImageView.image = image
    }
    func neckBackGroundImage(image: UIImage) {
        neckImageView.image = image
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        getBackgrounds()
        saveThisImage.isHidden = true
        let screenSize: CGRect = UIScreen.main.bounds
        if screenSize.height > 700 {
            headHeightConstraint.constant = 135
            headImageHeight.constant = 135
            bodyHeight = bodyHeight.setMultiplier(multiplier: 2.25)
            bodyHeightMultiplier = bodyHeightMultiplier.setMultiplier(multiplier: 2.25)
            leftCurtainWidth.constant = 207
            rightCurtainWidth.constant = 207
        } else if 600 ... 700 ~= screenSize.height {
            headHeightConstraint.constant = 120
            headImageHeight.constant = 120
            leftCurtainWidth.constant = 187.5
            rightCurtainWidth.constant = 187.5
        } else {
            leftCurtainWidth.constant = 160
            rightCurtainWidth.constant = 160
        }
        if headDetailView.image == nil {
            headDetailView.image = headDetail
            headBackGround.mask = UIImageView(image: maskImage)
        }
        if bodyDetailView.image == nil {
            bodyDetailView.image = bodyDetail
            bodyBackGround.mask = UIImageView(image: bodyMaskImage)
        }
        if neckDetailView.image == nil {
            neckDetailView.image = neckDetail
            neckBackGround.mask = UIImageView(image: neckMaskImage)
        }
    }
    
    @IBOutlet weak var rightCurtainConstraint: NSLayoutConstraint!
    @IBOutlet weak var leftCurtainConstraint: NSLayoutConstraint!
    @IBOutlet weak var leftCurtainWidth: NSLayoutConstraint!
    @IBOutlet weak var rightCurtainWidth: NSLayoutConstraint!
    

    
    let screenSize: CGRect = UIScreen.main.bounds
    
    override func viewDidAppear(_ animated: Bool) {

        headBackGround.layer.mask?.frame = CGRect(x: 0, y: 0, width: headImageView.frame.size.width, height: headImageView.frame.size.height)
        bodyBackGround.layer.mask?.frame = CGRect(x: 0, y: 0, width: bodyImageView.frame.size.width, height: bodyImageView.frame.size.height)
        neckBackGround.layer.mask?.frame = CGRect(x: 0, y: 0, width: neckImageView.frame.size.width, height: neckImageView.frame.size.height)

        if screenSize.height > 700 {
            rightCurtainConstraint.constant = -207
            leftCurtainConstraint.constant = -207
            UIView.animate(withDuration: 0.5, animations: {
                self.view.layoutIfNeeded()
            })
        } else if 600 ... 700 ~= screenSize.height {
            self.rightCurtainConstraint.constant = -187.5
            self.leftCurtainConstraint.constant = -187.5
            UIView.animate(withDuration: 0.5, animations: {
                self.view.layoutIfNeeded()
            })

        } else {
            self.rightCurtainConstraint.constant = -160
            self.leftCurtainConstraint.constant = -160
            UIView.animate(withDuration: 0.5, animations: {
                self.view.layoutIfNeeded()
            })
        }

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "imageTapped" {
            let imageTapped: CollectionView = segue.destination as! CollectionView
            imageTapped.headTapped = headPressed
            imageTapped.bodyTapped = bodyPressed
            imageTapped.neckTapped = neckPressed
            imageTapped.delegate = self
        }

    }
    
    
    //MARK: NECK
    
    @IBOutlet weak var neckBackGround: UIView!
    @IBOutlet weak var neckImageView: UIImageView!
    @IBOutlet weak var neckDetailView: UIImageView!
    var neckNumber: Int = 0
    var neckPressed: Bool = false
    var neckMaskImage: UIImage = UIImage(named: "neck1mask")!
    var neckDetail: UIImage = UIImage(named: "neck1")!
    
    
    @IBAction func neckImageTapped(_ sender: UITapGestureRecognizer) {
        headPressed = false
        bodyPressed = false
        neckPressed = true
        rightCurtainConstraint.constant = 0
        leftCurtainConstraint.constant = 0
        UIView.animate(withDuration: 0.5, animations: {
            self.view.layoutIfNeeded()
        }, completion: {finished in
            self.performSegue(withIdentifier: "imageTapped", sender: self)
        })
    }
    
    @IBAction func neckViewSwipedRight(_ sender: UISwipeGestureRecognizer) {
        if neckNumber == backgroundArray.count-1 {
            neckNumber = 0
        } else {
            neckNumber += 1
        }
        let newNeckBackground = UIImage(named: "background\(neckNumber)")
        UIView.transition(with: neckImageView,
                          duration: 0.2,
                          options: .transitionCrossDissolve,
                          animations: {self.neckImageView.image = newNeckBackground},
                          completion: nil)

    }
    
    @IBAction func neckViewSwipedLeft(_ sender: UISwipeGestureRecognizer) {
        if neckNumber == 0 {
            neckNumber = backgroundArray.count-1
        } else {
            neckNumber -= 1
        }
        let newNeckBackground = UIImage(named: "background\(neckNumber)")
        UIView.transition(with: neckImageView,
                          duration: 0.2,
                          options: .transitionCrossDissolve,
                          animations: {self.neckImageView.image = newNeckBackground},
                          completion: nil)

    }
    
    //MARK: Body
    
    @IBOutlet weak var bodyBackGround: UIView!
    @IBOutlet weak var bodyImageView: UIImageView!
    @IBOutlet weak var bodyDetailView: UIImageView!
    var bodyNumber: Int = 0
    var bodyPressed: Bool = false
    var bodyMaskImage: UIImage = UIImage(named: "body1mask")!
    var bodyDetail: UIImage = UIImage(named: "body1")!

    @IBAction func bodyImageTapped(_ sender: UITapGestureRecognizer) {
        headPressed = false
        bodyPressed =  true
        neckPressed = false
        rightCurtainConstraint.constant = 0
        leftCurtainConstraint.constant = 0
        UIView.animate(withDuration: 0.5, animations: {
            self.view.layoutIfNeeded()
        }, completion: {finished in
            self.performSegue(withIdentifier: "imageTapped", sender: self)
        })

    }

    @IBAction func bodyViewSwipedRight(_ sender: UISwipeGestureRecognizer) {
        if bodyNumber == backgroundArray.count-1 {
            bodyNumber = 0
        } else {
            bodyNumber += 1
        }
        let newBodyBackground = UIImage(named: "background\(bodyNumber)")
        UIView.transition(with: bodyImageView,
                          duration: 0.2,
                          options: .transitionCrossDissolve,
                          animations: {self.bodyImageView.image = newBodyBackground},
                          completion: nil)

    }

    @IBAction func bodyViewSwipedLeft(_ sender: UISwipeGestureRecognizer) {
        if bodyNumber == 0 {
            bodyNumber = backgroundArray.count-1
        } else {
            bodyNumber -= 1
        }
        let newBodyBackground = UIImage(named: "background\(bodyNumber)")
        UIView.transition(with: bodyImageView,
                          duration: 0.2,
                          options: .transitionCrossDissolve,
                          animations: {self.bodyImageView.image = newBodyBackground},
                          completion: nil)

    }
    
    //MARK: Head

    @IBOutlet weak var headBackGround: UIView!
    @IBOutlet weak var headImageView: UIImageView!
    @IBOutlet weak var headDetailView: UIImageView!
    
    var imageNumber: Int = 0
    var headPressed: Bool = false
    var maskImage: UIImage = UIImage(named: "head1mask")!
    var headDetail: UIImage = UIImage(named: "head1")!
    
    @IBAction func headImageTapped(_ sender: UITapGestureRecognizer) {
        headPressed = true
        bodyPressed = false
        neckPressed = false
        rightCurtainConstraint.constant = 0
        leftCurtainConstraint.constant = 0
        UIView.animate(withDuration: 0.5, animations: {
            self.view.layoutIfNeeded()
        }, completion: {finished in
            self.performSegue(withIdentifier: "imageTapped", sender: self)
        })
        
    }
    

    @IBAction func headViewSwipedRight(_ sender: UISwipeGestureRecognizer) {
        if imageNumber == backgroundArray.count-1 {
            imageNumber = 0
        } else {
            imageNumber += 1
        }
        let newBackGround = UIImage(named: "background\(imageNumber)")
        UIView.transition(with: headImageView,
                          duration: 0.2,
                          options: .transitionCrossDissolve,
                          animations: {self.headImageView.image = newBackGround},
                          completion: nil)

    }
    @IBAction func headViewSwipedLeft(_ sender: UISwipeGestureRecognizer) {
        if imageNumber == 0 {
            imageNumber = backgroundArray.count-1
        } else {
            imageNumber -= 1
        }
        let newBackGround = UIImage(named: "background\(imageNumber)")
        UIView.transition(with: headImageView,
                          duration: 0.2,
                          options: .transitionCrossDissolve,
                          animations: {self.headImageView.image = newBackGround},
                          completion: nil)

    }
    
    var backgroundArray = [String]()
    
    
    func getBackgrounds() {
    
        do {
            if let path = Bundle.main.path(forResource: "backgrounds", ofType: "txt"){
                let data = try String(contentsOfFile:path, encoding: String.Encoding.utf8)
                backgroundArray = data.components(separatedBy: "\n")
                _ = backgroundArray.removeLast()
            }
        } catch let err as NSError {
            // do something with Error
            print(err)
        }
    }

}


extension NSLayoutConstraint {
    func setMultiplier(multiplier:CGFloat) -> NSLayoutConstraint {
        NSLayoutConstraint.deactivate([self])
        let newConstraint = NSLayoutConstraint(
            item: firstItem as Any,
            attribute: firstAttribute,
            relatedBy: relation,
            toItem: secondItem,
            attribute: secondAttribute,
            multiplier: multiplier,
            constant: constant)
        newConstraint.priority = priority
        newConstraint.shouldBeArchived = self.shouldBeArchived
        newConstraint.identifier = self.identifier
        NSLayoutConstraint.activate([newConstraint])
        return newConstraint
    }
}
