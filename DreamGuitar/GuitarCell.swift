//
//  GuitarCell.swift
//  DreamGuitar
//
//  Created by Robin Farmer on 20/08/2017.
//  Copyright © 2017 Maddisys Limited. All rights reserved.
//

import UIKit

@IBDesignable
class GuitarCell: UICollectionViewCell {
    @IBOutlet weak var optionImageView: UIImageView!
    @IBInspectable public var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
}
