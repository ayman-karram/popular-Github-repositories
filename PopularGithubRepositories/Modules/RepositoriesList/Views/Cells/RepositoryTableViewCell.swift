//
//  RepositoryTableViewCell.swift
//  PopularGithubRepositories
//
//  Created by Ayman Karram on 02.02.20.
//  Copyright © 2020 Ayman Karram. All rights reserved.
//

import UIKit
import Nuke

class RepositoryTableViewCell: UITableViewCell {

    @IBOutlet weak var ownerImageView: UIImageView!
    @IBOutlet weak var repoNameLabel: UILabel!
    @IBOutlet weak var repoDescriptionLabel: UILabel!

    var viewModel: RepositoryCellViewModel? {
        didSet {
            bindViewModel()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        ownerImageView.layer.cornerRadius = 35
        ownerImageView.layer.masksToBounds = true
        ownerImageView.backgroundColor = UIColor.gray
    }

    override func prepareForReuse() {
        self.ownerImageView.image = nil
    }

    private func bindViewModel() {
        guard let viewModel = viewModel else { return }
        if let imageURL = viewModel.ownerImageURL {
            let options = ImageLoadingOptions(transition: .fadeIn(duration: 0.5))
            Nuke.loadImage(with: imageURL, options: options, into: ownerImageView)
        }
        repoNameLabel.text = viewModel.name
        repoDescriptionLabel.text = viewModel.description
    }
}
