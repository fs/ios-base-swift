//
//  RoundView.swift
//  Tools
//
//  Created by Marat Galeev on 28.03.2018.
//  Copyright © 2018 Flatstack. All rights reserved.
//

import UIKit

public class RoundView: UIView {

    // MARK: - Initializers

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
    }
}
