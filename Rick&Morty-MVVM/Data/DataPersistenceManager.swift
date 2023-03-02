//
//  DataPersistenceManager.swift
//  Rick&Morty-MVVM
//
//  Created by Ali Görkem Aksöz on 27.02.2023.
//

import UIKit
import CoreData

final class DataPersistenceManager {
    
    enum DatabaseError: String, Error {
        case failedToSaveData = "There is a error while saving data"
        case failedToFetching = "There is a error while saving datas"
        case failedToDeleting = "There is a error while deleting data"
    }
    
    static let shared = DataPersistenceManager()
    
    func saveCharacter(with model: Results, completion: @escaping (Result<Void, DatabaseError>) -> ()) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let context = appDelegate.persistentContainer.viewContext
        
        let item = CharacterItem(context: context)
        
        item.id = Int64(model.id ?? 0)
        item.name = model.name
        item.status = model.status
        item.species = model.species
        item.type = model.type
        item.gender = model.gender
        item.image = model.image
        item.url = model.url
        
        do {
            try context.save()
            completion(.success(()))
        } catch  {
            completion(.failure(.failedToSaveData))
        }
        
    }
    
    func fetchingCharacterFromDatabase(completion: @escaping (Result<[CharacterItem], DatabaseError>) -> ()) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let context = appDelegate.persistentContainer.viewContext
        
        let request: NSFetchRequest<CharacterItem>
        
        request = CharacterItem.fetchRequest()
        
        do {
           let characters = try context.fetch(request)
            completion(.success(characters))
        } catch  {
            completion(.failure(.failedToFetching))
        }
    }
    
    func deletingCharacter(with model: CharacterItem, completion: @escaping (Result<Void, DatabaseError>) -> ()) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let context = appDelegate.persistentContainer.viewContext
        
        context.delete(model)
        
        do {
            try context.save()
            completion(.success(()))
        } catch  {
            completion(.failure(.failedToDeleting))
        }
    }
}

