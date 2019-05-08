//
//  RoundImageView.swift
//  Tools
//
//  Created by Almaz Ibragimov on 22.03.2018.
//  Copyright © 2018 Flatstack. All rights reserved.
//

import UIKit

public class RoundImageView: UIImageView {

    // MARK: - Initializers

    public override init(image: UIImage?, highlightedImage: UIImage?) {
        super.init(image: image, highlightedImage: highlightedImage)

        self.layer.masksToBounds = true
    }

    public override init(image: UIImage?) {
        super.init(image: image)

        self.layer.masksToBounds = true
    }

    public override init(frame: CGRect = CGRect.zero) {
        super.init(frame: frame)

        self.layer.masksToBounds = true
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        self.layer.masksToBounds = true
    }

    // MARK: - Instance Methods

    public override func layoutSubviews() {
        super.layoutSubviews()

        self.layer.cornerRadius = min(self.frame.width, self.frame.height) * 0.5
        self.layer.shadowOpacity = 0.2
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowRadius = 5
    }
}
