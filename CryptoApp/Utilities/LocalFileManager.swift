//
//  LocalFileManager.swift
//  CryptoApp
//
//  Created by Muktar Hussein on 10/12/2023.
//

import Foundation
import SwiftUI

class LocalFileManager {
    
    // making it a singleton
    static let instance = LocalFileManager()
    
    private init() { }
    
    func saveImage(image: UIImage, imageName:String, folderName: String) {
        // create folder
        createFolderIfNeeded(folderName: folderName)
        
        // get path for image
        guard
        let data = image.pngData(),
        let url = getURLForImage(imageName: imageName, folderName: folderName) else { return }
        
        do {
            try data.write(to: url)
        } catch let error {
            print("Error saving image: \(imageName).Error \(error)")
        }
    }
    
    func getImage(imageName: String, folderName: String) -> UIImage? {
        guard
            let url = getURLForImage(imageName: imageName, folderName: folderName),
            FileManager.default.fileExists(atPath: url.path) else {
            return nil
        }
        return UIImage(contentsOfFile: url.path)
    }
    
    
    // create folder to save the image if it does not exist
    private func createFolderIfNeeded(folderName: String) {
        guard let url = getURLFolder(folderName: folderName) else { return }
        if !FileManager.default.fileExists(atPath: url.path) {
            
            
            do {
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true)
            } catch let error {
                print("Error creating needed folder: \(folderName). Error: \(error)")
            }
        }
    }
    
    // getting the url
    private func getURLFolder(folderName: String) -> URL? {
        guard let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {
            return nil
        }
        return url.appendingPathComponent(folderName)
    }
    
    //
    private func getURLForImage(imageName: String, folderName: String) -> URL? {
        guard let folderURL = getURLFolder(folderName: folderName) else { return nil }
    
        return folderURL.appendingPathComponent(imageName + ".png")
    }
}
