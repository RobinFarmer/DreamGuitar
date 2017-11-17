//
//  CollectionView.swift
//  DreamGuitar
//
//  Created by Robin Farmer on 20/08/2017.
//  Copyright © 2017 Maddisys Limited. All rights reserved.
//

import UIKit


protocol DataSentDelegate {
    func headImageSelected(image: String, newMaskImage: String)
    func bodyImageSelected(bodyImage: String, newBodyMask: String)
    func neckImageSelected(neckImage: String, newNeckMask: String)
    func headBackGroundImage(image: UIImage)
    func bodyBackGroundImage(image: UIImage)
    func neckBackGroundImage(image: UIImage)
}


class CollectionView: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate  {
    
    var delegate: DataSentDelegate? = nil
    
    @IBOutlet weak var topCollectionView: UICollectionView!

    @IBOutlet weak var rightCurtainWidth: NSLayoutConstraint!
    @IBOutlet weak var rightCurtain: UIImageView!
    @IBOutlet weak var leftCurtainWidth: NSLayoutConstraint!
    @IBOutlet weak var leftCurtain: UIImageView!

    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()


        getHeads()
        getNecks()
        getBodys()
        let screenSize: CGRect = UIScreen.main.bounds
        
        if screenSize.height > 700 {
            let itemSize = topCollectionView.bounds.width/3 - 4
            let layout = UICollectionViewFlowLayout()
            layout.itemSize = CGSize(width: itemSize, height: itemSize)
            layout.minimumInteritemSpacing = 4
            layout.minimumLineSpacing = 4
            topCollectionView.collectionViewLayout = layout
            leftCurtainWidth.constant = 207
            rightCurtainWidth.constant = 207
        } else if 600 ... 700 ~= screenSize.height {
            let itemSize = topCollectionView.bounds.width/4 - 4
            let layout = UICollectionViewFlowLayout()
            layout.itemSize = CGSize(width: itemSize, height: itemSize)
            layout.minimumInteritemSpacing = 4
            layout.minimumLineSpacing = 4
            topCollectionView.collectionViewLayout = layout
            leftCurtainWidth.constant = 187.5
            rightCurtainWidth.constant = 187.5
        } else {
            let itemSize = topCollectionView.bounds.width/5 - 4
            let layout = UICollectionViewFlowLayout()
            layout.itemSize = CGSize(width: itemSize, height: itemSize)
            layout.minimumInteritemSpacing = 4
            layout.minimumLineSpacing = 4
            topCollectionView.collectionViewLayout = layout
            leftCurtainWidth.constant = 160
            rightCurtainWidth.constant = 160
        }
    }

    @IBAction func goBackBtn(_ sender: UIButton) {
        self.rightCurtainConstraint.constant = 0
        self.leftCurtainConstraint.constant = 0
        UIView.animate(withDuration: 0.5, animations: {
            self.view.layoutIfNeeded()
        }, completion: {finished in
            self.dismiss(animated: false, completion: nil)
        })
    }

    
    // Number of views in CollectionView
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var returnedInt = 0
        if headTapped {
            returnedInt =  headMaskArray.count
        } else if bodyTapped {
            returnedInt = bodyMaskArray.count
        } else if neckTapped {
            returnedInt = neckMaskArray.count
        }
        
        return returnedInt
    }
    @IBOutlet weak var rightCurtainConstraint: NSLayoutConstraint!
    @IBOutlet weak var leftCurtainConstraint: NSLayoutConstraint!
    
    let screenSize: CGRect = UIScreen.main.bounds
    override func viewDidAppear(_ animated: Bool) {
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
    
    // Populate Views
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var returnedCell: UICollectionViewCell?
        if headTapped {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! GuitarCell
            cell.optionImageView.image = UIImage(named: headMaskArray[indexPath.row] + ".png")
            returnedCell = cell
        } else if bodyTapped {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! GuitarCell
            cell.optionImageView.image = UIImage(named: bodyMaskArray[indexPath.row] + ".png")
            returnedCell = cell
        } else if neckTapped {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! GuitarCell
            cell.optionImageView.image = UIImage(named: neckDetailArray[indexPath.row] + ".png")
            returnedCell = cell
        }
        
        return returnedCell!
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if headTapped {
            if delegate != nil {
                let newHeadDetail: String = headDetailArray[indexPath.row]
                let newHeadMask: String = headMaskArray[indexPath.row]
                delegate?.headImageSelected(image: newHeadDetail, newMaskImage: newHeadMask)
                self.rightCurtainConstraint.constant = 0
                self.leftCurtainConstraint.constant = 0
                UIView.animate(withDuration: 0.5, animations: {
                    self.view.layoutIfNeeded()
                }, completion: {finished in
                    self.dismiss(animated: false, completion: nil)
                })
                
            }
        } else if bodyTapped {
            if delegate != nil {
                let newBodyDetail: String = bodyDetailArray[indexPath.row]
                let newBodyMask: String = bodyMaskArray[indexPath.row]
                delegate?.bodyImageSelected(bodyImage: newBodyDetail, newBodyMask: newBodyMask)
                rightCurtainConstraint.constant = 0
                leftCurtainConstraint.constant = 0
                UIView.animate(withDuration: 0.5, animations: {
                    self.view.layoutIfNeeded()
                }, completion: {finished in
                    self.dismiss(animated: false, completion: nil)
                })
            }
        } else if neckTapped {
            if delegate != nil {
                let newNeckDetail: String = neckDetailArray[indexPath.row]
                let newNeckMask: String = neckMaskArray[indexPath.row]
                delegate?.neckImageSelected(neckImage: newNeckDetail, newNeckMask: newNeckMask)
                rightCurtainConstraint.constant = 0
                leftCurtainConstraint.constant = 0
                UIView.animate(withDuration: 0.5, animations: {
                    self.view.layoutIfNeeded()
                }, completion: {finished in
                    self.dismiss(animated: false, completion: nil)
                })
            }
        }
    }
    @IBAction func importImage(_ sender: UIButton) {
        let alert = UIAlertController(title: "Choose how to import an image", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.openCamera()
        }))
        
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
            self.openGallaray()
        }))
        
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    lazy var pickerController: UIImagePickerController = {
        let controller = UIImagePickerController()
        controller.delegate = self
        controller.allowsEditing = true
        return controller
    }()
    
    func openCamera() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
            pickerController.sourceType = UIImagePickerControllerSourceType.camera
            pickerController.allowsEditing = false
        }
        present(pickerController, animated: true, completion: nil)
        
    }
    func openGallaray() {
        let imagePickerController = UIImagePickerController()
        
        imagePickerController.allowsEditing = false
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {

            if headTapped {
                if delegate != nil {
                    delegate?.headBackGroundImage(image: image)
                }
            } else if bodyTapped {
                if delegate != nil {
                    delegate?.bodyBackGroundImage(image: image)
                }
            } else if neckTapped {
                if delegate != nil {
                    delegate?.neckBackGroundImage(image: image)
                }
            }
        }
        rightCurtainConstraint.constant = 0
        leftCurtainConstraint.constant = 0
        UIView.animate(withDuration: 0.5, animations: {
            self.view.layoutIfNeeded()
        }, completion: {finished in
            self.performSegue(withIdentifier: "unwindSegue", sender: self)
        })
    }
    
    // MARK: Head
    
    var headMaskArray = [String]()
    var headDetailArray = [String]()
    var headTapped: Bool = false

    
    // MARK: Body
    var bodyMaskArray = [String]()
    var bodyDetailArray = [String]()
    var bodyTapped: Bool = false
        
    //MARK: Neck
    var neckMaskArray = [String]()
    var neckDetailArray = [String]()
    var neckTapped: Bool = false
    
    
    var mainHeadArray = [String]()
    var mainNeckArray = [String]()
    var mainBodyArray = [String]()



    func getHeads() {
        var headNumber = 0
        do {
            if let path = Bundle.main.path(forResource: "heads", ofType: "txt"){
                let data = try String(contentsOfFile:path, encoding: String.Encoding.utf8)
                mainHeadArray = data.components(separatedBy: "\n")
                _ = mainHeadArray.removeLast()
            }
        } catch let err as NSError {
            // do something with Error
            print(err)
        }
        for _ in mainHeadArray {
            
            let item = mainHeadArray[headNumber]
            if item.contains("mask") {
                headMaskArray.append(item)
            } else {
                headDetailArray.append(item)
            }
            headNumber += 1
        }
    }
    func getNecks() {
        var neckNumber = 0
        do {
            if let path = Bundle.main.path(forResource: "necks", ofType: "txt"){
                let data = try String(contentsOfFile:path, encoding: String.Encoding.utf8)
                mainNeckArray = data.components(separatedBy: "\n")
                _ = mainNeckArray.removeLast()
            }
        } catch let err as NSError {
            // do something with Error
            print(err)
        }
        for _ in mainNeckArray {
            
            let item = mainNeckArray[neckNumber]
            if item.contains("mask") {
                neckMaskArray.append(item)
            } else {
                neckDetailArray.append(item)
            }
            neckNumber += 1
        }
    }

    func getBodys() {
    var bodyNumber = 0
        do {
            if let path = Bundle.main.path(forResource: "bodys", ofType: "txt"){
                let data = try String(contentsOfFile:path, encoding: String.Encoding.utf8)
                mainBodyArray = data.components(separatedBy: "\n")
                _ = mainBodyArray.removeLast()
            }
        } catch let err as NSError {
            // do something with Error
            print(err)
        }
        for _ in mainBodyArray {
            
            let item = mainBodyArray[bodyNumber]
            if item.contains("mask") {
                bodyMaskArray.append(item)
            } else {
                bodyDetailArray.append(item)
            }
            bodyNumber += 1
        }
    }

}
