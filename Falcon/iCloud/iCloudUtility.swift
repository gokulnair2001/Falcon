//
//  iCloudUtility.swift
//  Falcon
//
//  Created by Gokul Nair on 05/01/22.
//

import CloudKit

class iCloudUtilityModel: ObservableObject {
    
    @Published var ClusterTitle:String = ""
    @Published var ClusterList:[String] = []
    @Published var isDuplicateCluster: Bool = false
    @Published var isClusterSaved: Bool = false
    
    let CKDefaultContainer = CKContainer.default()
    
    private var returnedTitles: [String] = []

    func addButtonPressed() {
        guard !ClusterTitle.isEmpty else {return}
        let modifiedTitle = ClusterTitle.trimmingCharacters(in: .whitespaces)
        verifyClusterTitle(title: modifiedTitle)
    }
    
    private func verifyClusterTitle(title: String) {
        
        let modifiedArray = returnedTitles.map{$0.lowercased()}
        if !modifiedArray.contains(title.lowercased()) {
            addCluster(title: title)
            isDuplicateCluster = false
        }else {
            isDuplicateCluster = true
            DispatchQueue.main.async {
                self.ClusterTitle = ""
            }
        }
    }
    
    private func addCluster(title: String) {
        let cluster = CKRecord(recordType: "Clusters")
        cluster["title"] = title
        saveCluster(record: cluster)
    }
    
    private func saveCluster(record: CKRecord) {
        CKDefaultContainer.privateCloudDatabase.save(record) { [weak self] returnedRecord, returnedError in
//            print(returnedRecord)
//            print(returnedError?.localizedDescription)
            
            DispatchQueue.main.async {
                self?.ClusterTitle = ""
                self?.isClusterSaved = true
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.fetchClusters()
        }
    }
    
    func fetchClusters() {
        
        print("FETCHED")
        
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "Clusters", predicate: predicate)
        let queryOperation = CKQueryOperation(query: query)
        
        self.returnedTitles.removeAll()
        
        queryOperation.recordMatchedBlock = { (returnedRecordID, returnedResult) in
            switch returnedResult {
            case .success(let record):
                guard let titles = record["title"] as? String else {return}
                self.returnedTitles.append(titles)
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        queryOperation.queryResultBlock = { returnedResult in
            DispatchQueue.main.async {
                self.ClusterList = self.returnedTitles
                print(self.ClusterList)
            }
        }
        
        addQueryOperation(operation: queryOperation)
    }
    
    func addQueryOperation(operation: CKDatabaseOperation) {
        CKDefaultContainer.privateCloudDatabase.add(operation)
    }
}
