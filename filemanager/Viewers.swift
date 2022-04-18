//
//  WebViewer.swift
//  kivy_swifttest
//
//  Created by macdaw on 01/04/2021.
//

import Foundation
import UIKit
import WebKit
import PDFKit
import MobileCoreServices


class WebViewer: UIViewController,WKNavigationDelegate {
    var webview: WKWebView!
    
    override func loadView() {
        webview = WKWebView()
        webview.navigationDelegate = self
        view = webview
    }
    
    func loadURL(path: String) {
        
        let url = URL(string: path)!
        print(url)
        webview.load(URLRequest(url: url))
    }
}


class PDF_Viewer: UIViewController {
    
    let pdfView = PDFView()
    
    override func loadView() {
        //pdfView = PDFView.init()
        self.view = pdfView
    }
    
    func loadPDF(path: String) {
        let filepath = "YourApp/".appending(path)
        print(filepath)
        let url = resourceUrl(forFileName: filepath)!
        let doc = PDFDocument(url: url)
        print(doc as Any)
        self.pdfView.document = doc
        
        
    }
    
    private func resourceUrl(forFileName fileName: String) -> URL? {
        if let resourceUrl = Bundle.main.url(forResource: fileName,
                                             withExtension: "pdf") {
            return resourceUrl
        }
        print("url error")
        return nil
    }
    
}


class KivyUIView: UIView {

    override func willMove(toSuperview newSuperview: UIView?) {
        if newSuperview != nil {
            print("will add View")
            self.alpha = 0
        }
    }
    
    override func didMoveToSuperview() {
        print("didMoveToSuperview")
        UIView.animate(withDuration: 1) {
            self.alpha = 1
        }
    }
    
}



class DocumentPicker: NSObject, UIDocumentPickerDelegate {
    
    let did_pick: ((_ urls: [URL])->Void)?
    let did_cancel: (()->Void)?
    
    let kivy_vc: UIViewController
    
    let picker: UIDocumentPickerViewController
    
    init(types: [CFString], mode: UIDocumentPickerMode, did_pick: @escaping (_ urls: [URL])->Void, did_cancel: @escaping ()->Void) {
        self.did_pick = did_pick
        self.did_cancel = did_cancel
        guard let vc = get_viewcontroller() else {fatalError("No Kivy ViewController found")} //will just return if it cant get kivy viewcontroller
        self.kivy_vc = vc
        let types = types.map{String($0)}
        picker = UIDocumentPickerViewController(documentTypes: types, in: mode )
        super.init()
        picker.delegate = self
        
        
    }
    
    func present(animated: Bool) {
        kivy_vc.present(picker, animated: animated)
    }
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let did_pick = did_pick else {
            return
        }
        did_pick(urls)
    }
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        guard let did_cancel = did_cancel else {
            return
        }
        did_cancel()
    }
}
