//
//  ViewController.swift
//  LastLesson
//
//  Created by Ali serkan Boyracı  on 14.01.2023.
//

import UIKit

class ListViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    //    @IBOutlet private weak var tableView: UITableView!
    
    private let viewModel = ListViewModel() // 1 to reach ViewModel instance
    private var tableHelper: ListViewControllerTableHelper! // 2 to reach tableHelper
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupBindings()
        viewModel.didViewLoad() // to inform VM
    }
}

private extension ListViewController {
    
    private func setupUI() {
        tableHelper = .init(tableView: tableView, viewModel: viewModel) // when we clecked any item, we must inform ViewModel
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
