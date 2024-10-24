//
//  ImageUploader.swift
//  LocalTennisApp
//
//  Created by Ansh Gupta on 8/8/24.
//

import Foundation
import Firebase
import UIKit
import FirebaseStorage

struct ImageUploader{
    
    static func uploadImage(image: UIImage, completition: @escaping(String) -> Void){
        guard let imageData = image.jpegData(compressionQuality: 0.5) else {return}
        
        let filename = NSUUID().uuidString
        let ref = Storage.storage().reference(withPath: "/profile_image/\(filename)")
        
        ref.putData(imageData, metadata: nil) { _, error in
            if let error = error{
                print("DEBUG: failed to upload image with error: \(error.localizedDescription)")
                return
            }
            
            ref.downloadURL { imageUrl, _ in
                guard let imageUrl = imageUrl?.absoluteString else {return}
                completition(imageUrl)
            }
        }
    }
}

