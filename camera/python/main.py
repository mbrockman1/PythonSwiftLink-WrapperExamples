
from kivy.app import App
from kivy.uix.relativelayout import RelativeLayout
from kivy.graphics.texture import Texture
from kivy.properties import ObjectProperty
from kivy._event import EventDispatcher
from kivy.lang import Builder


from swift_camera import SwiftCamera
from preview_viewer import PreviewViewer

class CameraDataModel(EventDispatcher):

    preview_texture = ObjectProperty(Texture.create(size=[128,128]))

    def dummy(): ...

    # def update_texture_size(self, w: int, h: int) -> Texture:
    #     tex = Texture.create(
    #         size = [w, h],
    #         colorfmt = "bgra",
    #         #callback = print
    #     )
    #     self.preview_texture = tex
    #     print(f"new tex w: {w} - h: {h} - tex: {tex}")
    #     return tex

class CamApp(App):

    previewer: PreviewViewer

    def __init__(self, **kwargs):
        super(CamApp, self).__init__(**kwargs)
        self.camera_data = CameraDataModel()
        self.swift_camera = SwiftCamera(self.camera_data)

    def build(self):
        preview = PreviewViewer()
        self.previewer = preview
        self.swift_camera.start(preview.canvas)
        return preview


if __name__ == '__main__':
    CamApp().run()