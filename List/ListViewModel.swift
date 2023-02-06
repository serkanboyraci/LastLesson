//
//  ListViewModel.swift
//  LastLesson
//
//  Created by Ali serkan Boyracı  on 14.01.2023.
//

import Foundation

class ListViewModel {
    
    private let model = ListModel()
    
    var onErrorDetected: ((String) -> ())?
    var refreshItems: (([ListCellModel]) -> ())?
    
    init() {
        model.delegate = self
    }
    
    func didViewLoad() {
        model.fetchData() // to learn from VC and fetch data
    }
    
    func itemPressed(_ index: Int) {
        //    TODO:
    }
}

extension ListViewModel: ListModelProtocol { // model inform to VM 
    
    func didLiveDataFetch() {
        let cellModels: [ListCellModel] = model.data.map{ .init(imageURL: $0.image ?? "", name: $0.name ?? "", status: $0.status ?? "", gender: $0.gender ?? "") }
        refreshItems?(cellModels)
    }
    
    func didCacheDataFetch() {
        let cellModels: [ListCellModel] = model.databaseData.map{ .init(imageURL: $0.imageUrl ?? "", name: $0.name ?? "", status: $0.status ?? "", gender: $0.gender ?? "") }
        refreshItems?(cellModels)
    }
    
    func didDataCouldntFetch() {
        onErrorDetected?("Please try again later !")
    }
}

