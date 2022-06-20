//
//  DocumentPickerHandler.swift
//  alphatest
//
//  Created by MusicMaker on 11/04/2022.
//

import Foundation
import UIKit
import MobileCoreServices



class FileManagerExample {
    
    var py: FileManagerExamplePyCallback!
    
    init() {
        InitFileManagerExample_Delegate(delegate: self)
    }
}

extension FileManagerExample: FileManagerExample_Delegate {
    
    
    func set_FileManagerExample_Callback(callback: FileManagerExamplePyCallback) {
        py = callback
    }
    
    func get_document() {
        
        let docPicker = DocumentPicker(
            types: [kUTTypeText, kUTTypeContent, kUTTypeItem, kUTTypeData],
            mode: .import) { urls in
                //executed when pick
                self.py.did_pick_document(files: urls.map{$0.path})
                
            } did_cancel: {
                //executed when cancel
                self.py.did_cancel_pick()
            }

    }
    
    
}
