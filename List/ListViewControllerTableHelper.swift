//
//  ListViewControllerTableHelper.swift
//  LastLesson
//
//  Created by Ali serkan Boyracı  on 30.01.2023.
//

import UIKit

class ListViewControllerTableHelper: NSObject { // to self any class ypu must use NSObject
    
    typealias RowItem = ListCellModel
    
    private let cellIdentifier = "ListCell"
    
    private var tableView: UITableView?
    private weak var viewModel: ListViewModel?
    
    private var items: [RowItem] = []
    
    init(tableView: UITableView, viewModel: ListViewModel) {
        self.tableView = tableView
        self.viewModel = viewModel
        super.init() // you must use this to use NSObject
        
        setupTableView()
    }
    
    private func setupTableView() {
        tableView?.register(.init(nibName: "ListCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        tableView?.delegate = self
        tableView?.dataSource = self
    }
    
    func setItems(_ items: [RowItem]) {
        self.items = items
        tableView?.reloadData()
    }
}

extension ListViewControllerTableHelper: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.itemPressed(indexPath.row) // we inform VM that item pressed
    }
}

extension ListViewControllerTableHelper: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! ListCell
        cell.configure(with: items[indexPath.row])
        return cell
    }
}
