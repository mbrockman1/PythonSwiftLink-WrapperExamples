//
//  MainCamera.swift
//  camera_test
//
//  Created by MusicMaker on 09/06/2022.
//

import Foundation
import CoreImage


class MainCamera {
    
    let camera = CameraHandler()
    var py_cb: SwiftCameraPyCallback!
    
    var camera_data: PythonPointer?
    //private var previewTexture: PythonPointer = nil
    private var previewTexture: KivyTexture?
    private var preview_canvas: PythonPointer = nil
    
    private var previewBufferSize: Int = 0
    
    init() {
        InitSwiftCamera_Delegate(delegate: self)
        Task {
            await handleCameraPreviews()
        }
    }
    
    
    
    func handleCameraPreviews() async {
            let pixelStream = camera.previewStream
            for await pixels in pixelStream {
                
                await handleBufferSize(pixels: pixels)
                await sendPreviewToPython(pixels: pixels)

            }
        }
    
    func handleBufferSize(pixels: CVPixelBuffer) async {
        let newSize = CVPixelBufferGetDataSize(pixels)
        if newSize != previewBufferSize {
            let w = CVPixelBufferGetBytesPerRow(pixels) / 4
            let h = CVPixelBufferGetHeight(pixels)
            
            await newPreviewTexture(h: h, w: w, buf_size: newSize)
        }
    }
    
    @MainActor
    func newPreviewTexture(h: Int, w: Int, buf_size: Int) async {
        previewBufferSize = buf_size

        withGIL { [unowned self] in

            let new_tex = KivyTexture(w: w, h: h)
            new_tex.flip_vertical()
            new_tex.flip_horizontal()

            previewTexture = new_tex
            camera_data?.set(key: "preview_texture", value: new_tex.tex)
        }
    }
    
    
    @MainActor
    func sendPreviewToPython(pixels: CVPixelBuffer) async {
        withGIL {
            pixels.withMemoryView { [self] mem_view in
                previewTexture?.blit_buffer(bytes: mem_view)
                preview_canvas.ask_update()
            }
        }
    }
    
    
}

extension MainCamera: SwiftCamera_Delegate {
    func set_SwiftCamera_Callback(callback: SwiftCameraPyCallback) {
        self.py_cb = callback
        //fetching the python class used as callback, and assigning it to self.camera_data
        self.camera_data = py_cb.pycall.ptr
    }
    
    func start(ask_update: PythonPointer) {
        preview_canvas = ask_update
        Task {
            await camera.start()
            camera.switchCaptureDevice()
        }
    }
    
    func stop() {
        camera.stop()
    }
    
    
    
}


extension PythonPointer {
    
    fileprivate func ask_update() {
        PyObject_CallMethodNoArgs(self, ask_update_str)
    }
    
}
