import Foundation
import UIKit
import MobileCoreServices
import UniformTypeIdentifiers


class FileManagerApi {
    init() {
        InitFileManagerApi_Delegate(delegate: self)
    }
}

extension FileManagerApi: FileManagerApi_Delegate {
    func get_viewcontroller() {
        let types = UTType.types(tag: "json", 
                                tagClass: UTTagClass.filenameExtension, 
                                conformingTo: nil)
        let documentPickerController = UIDocumentPickerViewController(
                forOpeningContentTypes: types)
        documentPickerController.delegate = self
        self.present(documentPickerController, animated: true, completion: nil)
    }
}