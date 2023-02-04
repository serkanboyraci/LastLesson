//
//  ListModel.swift
//  LastLesson
//
//  Created by Ali serkan Boyracı  on 14.01.2023.
//

import Foundation
import Alamofire
import CoreData
import UIKit

protocol ListModelProtocol: AnyObject {
    
    func didLiveDataFetch() // to take from web
    func didCacheDataFetch() // to take from CoreData
    func didDataCouldntFetch()
}

class ListModel {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate // to reach appDelegate
    
    private(set) var data: [CharacterData] = []
    private(set) var databaseData: [ListEntity] = []
    
    weak var delegate: ListModelProtocol?
    
    func fetchData() {
        if InternetManager.shared.isInternetActive() { // internt is active do here
            AF.request("https://rickandmortyapi.com/api/character/?page=1").responseDecodable(of: ApiData.self) { (res) in
                guard
                    let response = res.value
                else {
                    self.delegate?.didDataCouldntFetch()
                    return
                }
                self.data = response.results ?? []
                self.delegate?.didLiveDataFetch() // after fetching data, we inform VM that we took the data
                
                for item in self.data { // after informing VM and
                    self.saveToCoreData(item) // to save all data // we should do it background thread. // we will wat 10-15 seconds if ot is 10.000 data
                }
            }
        } else { // internete nonactive do here, call  CoreData funcs
            retrieveFromCoreData()
        }
    }
    
    private func saveToCoreData(_ data: CharacterData) {
        let context = appDelegate.persistentContainer.viewContext
        if let entity = NSEntityDescription.entity(forEntityName: "ListEntity", in: context) { // take from Coredata
            let listObject = NSManagedObject(entity: entity, insertInto: context)
            listObject.setValue(data.gender ?? "", forKey: "gender") //define coreData attributes
            listObject.setValue(data.id ?? 0, forKey: "id")
            listObject.setValue(data.image ?? "", forKey: "imageUrl")
            listObject.setValue(data.name ?? "", forKey: "name")
            listObject.setValue(data.status ?? "", forKey: "status")
            listObject.setValue(data.species ?? "", forKey: "species")
            
            do {
                try context.save() // canbe error , we must do it do-try-catch
            } catch {
                print("ERROR while saving data to CoreData")
            }
        }
    }
    
    private func retrieveFromCoreData() {
        let context = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<ListEntity>(entityName: "ListEntity") // to take data from coreData
        // if you want filer your taken data
        do {
            let result = try context.fetch(request)
            print("\(result.count)")
            self.databaseData = result
            delegate?.didCacheDataFetch()
        } catch {
            print("ERROR while fetching data from CoreData")
            delegate?.didDataCouldntFetch()
        }
    }
}
