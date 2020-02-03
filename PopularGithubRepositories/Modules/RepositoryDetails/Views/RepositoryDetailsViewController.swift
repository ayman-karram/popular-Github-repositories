//
//  RepositoryDetailsViewController.swift
//  PopularGithubRepositories
//
//  Created by Ayman Karram on 03.02.20.
//  Copyright © 2020 Ayman Karram. All rights reserved.
//

import UIKit
import Nuke

class RepositoryDetailsViewController: UIViewController {

    //MARK:- IBOutlet
    @IBOutlet weak var ownerImageView: UIImageView!
    @IBOutlet weak var repoNameLabel: UILabel!
    @IBOutlet weak var repoDescriptionLabel: UILabel!
    @IBOutlet weak var forksCountLabel: UILabel!
    @IBOutlet weak var starCountsLabel: UILabel!

    //MARK:- Variables
    var viewModel: RepositoryDetailsViewModel?

    //MARK:- View Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        bindViewModel()
    }

    init(viewModel: RepositoryDetailsViewModel) {
        super.init(nibName: String(describing: RepositoryDetailsViewController.self),
                   bundle: nil)
        self.viewModel = viewModel
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK:- Helpers
    func setupView(){
        ownerImageView.layer.cornerRadius = 35
        ownerImageView.layer.masksToBounds = true
        ownerImageView.backgroundColor = UIColor.gray
    }

    private func bindViewModel() {
        viewModel?.repository.bindAndFire { [weak self] repository in
            DispatchQueue.main.async {
                if let imageURL = repository?.owner.avatarUrl,
                    let url = URL(string: imageURL),
                    let imageView = self?.ownerImageView {
                    let options = ImageLoadingOptions(transition: .fadeIn(duration: 0.5))
                    Nuke.loadImage(with: url, options: options, into: imageView)
                }
                self?.repoNameLabel.text = repository?.name
                self?.repoDescriptionLabel.text = repository?.description
                self?.starCountsLabel.text = "\(repository?.stargazersCount ?? 0)"
                self?.forksCountLabel.text = "\(repository?.forksCount ?? 0)"
            }
        }
    }
}
