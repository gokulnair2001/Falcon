//
//  iCloudClusterModel.swift
//  Falcon
//
//  Created by Gokul Nair on 07/01/22.
//

import CloudKit

class iCloudClusterModel: ObservableObject {
 
    @Published var routeTitle:String = ""
    @Published var routeURL:String = ""
    @Published var routeType:RequestType = .GET
    @Published var isRoutesSaved:Bool = false
    @Published var fetchRoutes:[clusterSchema] = []
    
    var clusterName:String = ""
    
    let CKDefaultContainer = CKContainer.default()
    
    func addRouteButtonPressed() {
        guard !routeTitle.isEmpty, !routeURL.isEmpty, !clusterName.isEmpty else {return}
        addRoute(cluster: clusterName, routeTitle: routeTitle, routeURL: routeURL, routeType: routeType)
    }
    
    private func addRoute(cluster: String, routeTitle: String, routeURL: String, routeType: RequestType) {
        let cluster = CKRecord(recordType: cluster)
        cluster["title"] = routeTitle
        cluster["url"] = routeURL
        cluster["type"] = routeType.rawValue
        
        saveCluster(record: cluster)
    }
    
    private func saveCluster(record: CKRecord) {
        CKDefaultContainer.privateCloudDatabase.save(record) { [weak self] returnedRecord, returnedError in
//            print(returnedRecord)
//            print(returnedError?.localizedDescription)
            
            DispatchQueue.main.async {
                self?.isRoutesSaved = true
                self?.routeTitle = ""
                self?.routeURL = ""
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.fetchRoutes(cluster: self.clusterName)
        }
    }
    
    func fetchRoutes(cluster: String) {
        
        print("FETCHED Routes: \(cluster)")
        
        let predicate = NSPredicate(value: true)
        
        let query = CKQuery(recordType: cluster, predicate: predicate)
        let queryOperation = CKQueryOperation(query: query)
        
        var returnedTitles:[String] = []
        var returnedUrls:[String] = []
        var returnedTypes:[String] = []
        var fetchedData:[clusterSchema] = []
        
        queryOperation.recordMatchedBlock = { (returnedRecordID, returnedResult) in
            switch returnedResult {
            case .success(let record):
                guard let title = record["title"] as? String, let url = record["url"] as? String, let type = record["type"] as? String else {return}
                print("🚀\(title)")
                print("🚀🚀\(url)")
                print("🚀🚀🚀\(type)")
                
                returnedTitles.append(title)
                returnedUrls.append(url)
                returnedTypes.append(type)
                fetchedData.append(clusterSchema(title: title, url: url, type: type))
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        queryOperation.queryResultBlock = { returnedResult in
            DispatchQueue.main.async {
                self.fetchRoutes = fetchedData
            }
        }
        
        addQueryOperation(operation: queryOperation)
    }
    
    func addQueryOperation(operation: CKDatabaseOperation) {
        CKDefaultContainer.privateCloudDatabase.add(operation)
    }
}
