//
//  ImageLoader.swift
//  Tools
//
//  Created by Timur Shafigullin on 19/04/2019.
//  Copyright © 2019 Flatstack. All rights reserved.
//

import UIKit

protocol ImageLoader {

    // MARK: - Instance Methods

    func loadImage(for url: URL, in imageView: UIImageView, placeholder: UIImage?)

    func cancelLoading(in imageView: UIImageView)
}

// MARK: -

extension ImageLoader {

    // MARK: - Instance Methods

    func loadImage(for url: URL, in imageView: UIImageView, placeholder: UIImage? = nil) {
        return self.loadImage(for: url, in: imageView, placeholder: placeholder)
    }
}
