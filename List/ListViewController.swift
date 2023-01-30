//
//  ViewController.swift
//  LastLesson
//
//  Created by Ali serkan Boyracı  on 14.01.2023.
//

import UIKit

class ListViewController: UIViewController {
    
//    @IBOutlet private weak var tableView: UITableView!
    
    private let viewModel = ListViewModel()
    private var tableHelper: ListViewControllerTableHelper!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupBindings()
        viewModel.didViewLoad()
    }
}

private extension ListViewController {
    
    private func setupUI() {
        tableHelper = .init(tableView: tableView, viewModel: viewModel)
    }
    
    func setupBindings() {
        viewModel.onErrorDetected = { [weak self] message in
            let alertController = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
            alertController.addAction(.init(title: "Ok", style: .default))
            self?.present(alertController, animated: true)
        }
        
        viewModel.refreshItems = { [weak self] items in
            self?.tableHelper.setItems(items)
        }
    }
}
