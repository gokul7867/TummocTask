//
//  CoreDataManager.swift
//  TummocTask
//
//  Created by gokul on 07/08/24.
//

import Foundation
import CoreData

class CoreDataManager : ObservableObject {
    static let share = CoreDataManager()
    let persistentContainer : NSPersistentContainer
    // MARK: - Initializer
    init() {
        persistentContainer = NSPersistentContainer(name: "CoreDataModel")
        persistentContainer.loadPersistentStores { storeDescription, error in
        }
    }
    func categoryEntityExists(id: String) -> Bool {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "ProdectEntity")
        fetchRequest.predicate = NSPredicate(format: "id = %@", id)
        var results: [NSManagedObject] = []
        do {
            results = try persistentContainer.viewContext.fetch(fetchRequest)
        }
        catch {
            print("error executing fetch request: \(error)")
        }
        return results.count > 0
    }
    func SaveCategoryProdect(arrCategory : [St_CategoryModel]){
        arrCategory.forEach { (data) in
            if(categoryEntityExists(id: String(data.id))){
                print("Already have category")
            }else{
                let entity = ProdectEntity(context: self.persistentContainer.viewContext)
                entity.id = Int64(data.id)
                entity.name = data.name
                SaveItems(catId: String(data.id),arrItems: data.items)
            }
        }
        do{
            try persistentContainer.viewContext.save()
        }
        catch {
            print(error.localizedDescription)
        }
        
    }
    func itemsEntityExists(catId: String,id: String) -> Bool {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "ItemsEntity")
        fetchRequest.predicate = NSPredicate(format: "catId = %@ AND subCatId = %@", catId,id)
        var results: [NSManagedObject] = []
        do {
            results = try persistentContainer.viewContext.fetch(fetchRequest)
        }
        catch {
            print("error executing fetch request: \(error)")
        }
        return results.count > 0
    }
    func SaveItems(catId: String,arrItems : [St_items]){
        arrItems.forEach { (data) in
            if(itemsEntityExists(catId: String(catId),id: String(data.id))){
                print("Already have Items")
            }else{
                let entity = ItemsEntity(context: self.persistentContainer.viewContext)
                entity.catId = Int64(catId) ?? 0
                entity.subCatId = Int64(data.id)
                entity.name = data.name
                entity.icon = data.icon
                entity.prise = data.price
                entity.isFav = false
                entity.isCart = false
            }
        }
        do{
            try persistentContainer.viewContext.save()
        }
        catch {
            print(error.localizedDescription)
        }
        
    }
    func getAllCategory() -> [ProdectEntity] {
        let fetchRequest: NSFetchRequest<ProdectEntity> = ProdectEntity.fetchRequest()
        do {
            return try persistentContainer.viewContext.fetch(fetchRequest)
        } catch {
            return[]
        }
    }
    func getAllItems(catId: Int64) -> [ItemsEntity] {
        let fetchRequest: NSFetchRequest<ItemsEntity> = ItemsEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "catId = %d",catId)
        do {
            return try persistentContainer.viewContext.fetch(fetchRequest)
        } catch {
            return[]
        }
    }
    func getAllFavItems() -> [ItemsEntity] {
        let fetchRequest: NSFetchRequest<ItemsEntity> = ItemsEntity.fetchRequest()
        do {
            return try persistentContainer.viewContext.fetch(fetchRequest)
        } catch {
            return[]
        }
    }
    func getAllCartItems() -> [ItemsEntity] {
        let fetchRequest: NSFetchRequest<ItemsEntity> = ItemsEntity.fetchRequest()
        do {
            return try persistentContainer.viewContext.fetch(fetchRequest)
        } catch {
            return[]
        }
    }
    func isFavUpdate(selectedItem : ItemsEntity){
            selectedItem.isFav = true
        do {
            try persistentContainer.viewContext.save()
        } catch {
            persistentContainer.viewContext.rollback()
        }
        
    }
    func isCartUpdate(selectedItem : ItemsEntity){
            selectedItem.isCart = true
        do {
            try persistentContainer.viewContext.save()
        } catch {
            persistentContainer.viewContext.rollback()
        }
        
    }
    func isUnCartUpdate(selectedItem : ItemsEntity){
            selectedItem.isCart = false
        do {
            try persistentContainer.viewContext.save()
        } catch {
            persistentContainer.viewContext.rollback()
        }
        
    }
    func isUnFavUpdate(selectedItem : ItemsEntity){
          selectedItem.isFav = false
        do {
            try persistentContainer.viewContext.save()
        } catch {
            persistentContainer.viewContext.rollback()
        }
        
    }
    
}
