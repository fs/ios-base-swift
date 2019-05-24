//
//  DefaultImageLoader.swift
//  Tools
//
//  Created by Timur Shafigullin on 03/03/2019.
//  Copyright © 2019 Flatstack. All rights reserved.
//

import Foundation
import Kingfisher

class DefaultImageLoader: ImageLoader {

    // MARK: - Instance Methods

    func loadImage(for url: URL, in imageView: UIImageView, placeholder: UIImage? = nil) {
        imageView.kf.setImage(with: url, placeholder: placeholder)
    }

    func cancelLoading(in imageView: UIImageView) {
        imageView.kf.cancelDownloadTask()
    }
}
