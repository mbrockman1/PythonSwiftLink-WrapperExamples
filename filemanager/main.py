import kivy
from kivy.app import App
from kivy.uix.button import Button
from kivy.uix.boxlayout import BoxLayout

from filemanager_api import FileManagerExample

class FileManagerSwift(App):
    def __init__(self, **kwargs):
        super(FileManagerSwift, self).__init__(**kwargs)
        print(FileManagerExample)
        self.apple_api: FileManagerExample = FileManagerExample(self)


    def build(self):

        self.file_button = Button(text='File Manager',
                size_hint=(.2, .2),
                pos_hint={'center_x': .5, 'center_y': .5})
          
        self.file_button.bind(on_press=self.file_func)
    

        boxlayout = BoxLayout()
        boxlayout.add_widget(self.file_button)
        return boxlayout     

    def file_func(self, instance):
        a = self.apple_api.get_document()
        print(a)

    def did_pick_document(self, instance):
        print("Success")


FileManagerSwift().run()  