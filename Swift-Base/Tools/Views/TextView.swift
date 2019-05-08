//
//  TextView.swift
//  Tools
//
//  Created by Oleg Gorelov on 30/05/2018.
//  Copyright © 2018 Flatstack. All rights reserved.
//

import UIKit

@IBDesignable public class TextView: UITextView {

    // MARK: - Instance Properties

    @IBInspectable public var bottomOutset: CGFloat {
        get {
            return self.touchEdgeOutset.bottom
        }

        set {
            self.touchEdgeOutset.bottom = newValue
        }
    }

    @IBInspectable public var leftOutset: CGFloat {
        get {
            return self.touchEdgeOutset.left
        }

        set {
            self.touchEdgeOutset.left = newValue
        }
    }

    @IBInspectable public var rightOutset: CGFloat {
        get {
            return self.touchEdgeOutset.right
        }

        set {
            self.touchEdgeOutset.right = newValue
        }
    }

    @IBInspectable public var topOutset: CGFloat {
        get {
            return self.touchEdgeOutset.top
        }

        set {
            self.touchEdgeOutset.top = newValue
        }
    }

    public var touchEdgeOutset: UIEdgeInsets = UIEdgeInsets.zero

    // MARK: - UIControl

    public override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let rect = CGRect(x: self.bounds.origin.x - self.touchEdgeOutset.left,
                          y: self.bounds.origin.y - self.touchEdgeOutset.top,
                          width: self.bounds.width + self.touchEdgeOutset.left + self.touchEdgeOutset.right,
                          height: self.bounds.height + self.touchEdgeOutset.top + self.touchEdgeOutset.bottom)

        return rect.contains(point)
    }
}
