//
//  RepositoriesListViewController.swift
//  PopularGithubRepositories
//
//  Created by Ayman Karram on 02.02.20.
//  Copyright © 2020 Ayman Karram. All rights reserved.
//

import UIKit

class RepositoriesListViewController: UIViewController {
    
    //MARK:- IBOutlet
    @IBOutlet weak var repositoriesTableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    //MARK:- Variables
    private var viewModel: RepositoriesListViewModel?
    private let githubIcon = UIImage(named: "GithubIcon")

    init(viewModel: RepositoriesListViewModel) {
        super.init(nibName: String(describing: RepositoriesListViewController.self), bundle: nil)
        self.viewModel = viewModel
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }

    //MARK:- View Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        bindViewModel()
        viewModel?.fetchPopularRepositories()
    }
    
    //MARK:- Helpers
    private func setupView(){
        navigationItem.titleView = UIImageView(image: githubIcon)
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.prefersLargeTitles = false
        setUpTableView()
    }
    
    private func bindViewModel() {
        viewModel?.repositoriesCellsViewModels.bind { [weak self] _ in
            DispatchQueue.main.async {
                self?.repositoriesTableView?.reloadData()
            }
        }
        viewModel?.state.bind({[weak self] state in
            switch state {
            case .loading:
                self?.show(loading: true)
            case .finishedLoading:
                self?.show(loading: false)
            case .error(_):
                self?.show(loading: false)
                self?.showAlertWith()
            }
        })
    }
    
    private func show(loading: Bool) {
        DispatchQueue.main.async {
            self.repositoriesTableView.isHidden = loading
            self.activityIndicator.isHidden = !loading
            loading == true ? self.activityIndicator.startAnimating() : self.activityIndicator.stopAnimating()
        }
    }
    
    private func setUpTableView() {
        repositoriesTableView.register(UINib(nibName: RepositoryCellViewModel.cellIdentifier, bundle: nil),
                                       forCellReuseIdentifier: RepositoryCellViewModel.cellIdentifier)
        repositoriesTableView.dataSource = self
        repositoriesTableView.delegate = self
        repositoriesTableView.estimatedRowHeight = UITableView.automaticDimension
        repositoriesTableView.tableFooterView = UIView()
    }

    private func showAlertWith(){
        let alert = SingleButtonAlert(
            title: "Could not connect to server, Check your Internet connection and try again later.",
            message: "",
            action: AlertAction(buttonTitle: "OK", handler: {})
        )
        self.presentSingleButtonDialog(alert: alert)
    }
}

//MARK:- UITableViewDelegate, UITableViewDataSource
extension RepositoriesListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.repositoriesCellsViewModels.value.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RepositoryCellViewModel.cellIdentifier) as? RepositoryTableViewCell else {
            return UITableViewCell()
        }
        cell.viewModel = viewModel?.repositoriesCellsViewModels.value[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.didSelectItemAt(index: indexPath.row)
    }
}
