//
//  File.swift
//  MusicDownloader
//
//  Created by Ayaulym Ibrayeva on 4/29/20.
//  Copyright © 2020 kbtu. All rights reserved.
//

import UIKit
import Foundation

let firstUrl:URL = try! FileManager.default.url(for: .documentDirectory,in: .userDomainMask,appropriateFor: nil,create: true)

class Folder: Codable{
    var name: String
    var previewUrl:URL
    var objectList:[String] = []
    var backFolderUrl:URL
    
    enum CodingKeys: String, CodingKey {
        case name
        case  previewUrl
        case objectList
        case backFolderUrl
    }
    
    init(name:String, previewUrl:URL, backFolderUrl:URL) {
        self.name = name
        self.previewUrl = previewUrl
        self.backFolderUrl = backFolderUrl
    }
}

var mainPath:URL = firstUrl


func addToList(folderListUrl:URL, newFolderUrl:URL){
    let data = FileManager.default.contents(atPath: folderListUrl.path)
    let decoder = JSONDecoder()
    let decodedFolder = try! decoder.decode(Folder.self, from: data!)
    print(decodedFolder.name)
    decodedFolder.objectList.append(newFolderUrl.absoluteString)
    
    let encoder = JSONEncoder()
    encoder.dateEncodingStrategy = .iso8601
    let datEn = try? encoder.encode(decodedFolder)
    try! datEn?.write(to: folderListUrl)
    
}

func createFolder1(folderName:String, backFolderUrl:URL){
    let url = backFolderUrl
    
    
    let doc = url.appendingPathComponent(folderName, isDirectory: false)
        do{
            let prevUrl:URL = URL(fileURLWithPath: doc.path)
            let fold = Folder(name:folderName, previewUrl: prevUrl, backFolderUrl: url)
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .iso8601
            let data = try? encoder.encode(fold)
            print(folderName)
            print("data: ", data!)
            if(backFolderUrl != firstUrl){addToList(folderListUrl: backFolderUrl, newFolderUrl: prevUrl)}else{mainPath = prevUrl}
            try data?.write(to: prevUrl, options: .atomic)
        }catch{
            print("Error in createFolder1 for:", folderName)
        }
        
}
func getByUrl(url:URL){
    
    let data = FileManager.default.contents(atPath: url.path)
    let decoder = JSONDecoder()
    let decodedPerson = try! decoder.decode(Folder.self, from: data!)
    print(decodedPerson.objectList)
}


