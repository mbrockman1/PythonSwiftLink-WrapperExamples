//
//  KivyTexture.swift
//


import Foundation

public let texture_cls = pythonImport(from: "kivy.graphics.texture", import_name: "Texture")

public let _blit_buffer = "blit_buffer".pyStringUTF8
public let bgra_str = "bgra".pyStringUTF8
public let ask_update_str = "ask_update".pyStringUTF8
public let _create = "create".pyStringUTF8
public let flip_vertical_str = "flip_vertical".pyStringUTF8
public let flip_horizontal_str = "flip_horizontal".pyStringUTF8




public class KivyTexture {
    public let tex: PythonPointer
    
    @inlinable
    init(w: Int, h: Int) {
        let w = w.python_int
        let h = h.python_int
        let size = [w, h].pythonList
        
        //tex = PyObject_VectorcallMethod(create_str, [texture_cls, size, bgra_str], 3, nil)
        tex = texture_cls(method: _create , args: [size, bgra_str])
        
        size.decref()
        w.decref()
        h.decref()
    }
    
    deinit {
        tex.decref()
    }
    
    @inlinable
    func flip_vertical() {
        //PyObject_CallMethodNoArgs(tex, flip_vertical_str)
        tex(method: flip_vertical_str)
    }
    
    @inlinable
    func flip_horizontal() {
        //PyObject_CallMethodNoArgs(tex, flip_horizontal_str)
        tex(method: flip_horizontal_str)
    }
    
    @inlinable
    func blit_buffer(bytes: PythonPointer) {
        //PyObject_VectorcallMethod(blit_buffer_str, [tex, bytes, PythonNone, bgra_str], 4, nil)
        tex(method: _blit_buffer, args: [bytes, PythonNone, bgra_str])
    }
}
