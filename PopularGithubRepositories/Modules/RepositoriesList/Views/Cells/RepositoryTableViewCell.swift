//
//  RepositoryTableViewCell.swift
//  PopularGithubRepositories
//
//  Created by Ayman Karram on 02.02.20.
//  Copyright © 2020 Ayman Karram. All rights reserved.
//

import UIKit

class RepositoryTableViewCell: UITableViewCell {

    @IBOutlet weak var cellContinerView: UIView!
    @IBOutlet weak var ownerImageView: UIImageView!
    @IBOutlet weak var repoNameLabel: UILabel!
    @IBOutlet weak var repoDescriptionLabel: UILabel!
    @IBOutlet weak var forkNumberLabel: UILabel!

    var viewModel: RepositoryCellViewModel? {
        didSet {
            bindViewModel()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        cellContinerView.layer.cornerRadius = 8
        cellContinerView.layer.masksToBounds = true
        cellContinerView.layer.borderColor = UIColor.white.cgColor
        cellContinerView.layer.borderWidth = 1
        ownerImageView.layer.cornerRadius = 35
        ownerImageView.layer.masksToBounds = true
        ownerImageView.backgroundColor = UIColor.gray
    }

    override func prepareForReuse() {
        self.ownerImageView.image = nil
    }

    private func bindViewModel() {

    }
}
