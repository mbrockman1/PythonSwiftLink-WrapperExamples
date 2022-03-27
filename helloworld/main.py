import kivy
from kivy.app import App
from kivy.uix.button import Button
from kivy.uix.boxlayout import BoxLayout

from helloworld_api import HelloWorld
from pprint import pprint

class HelloSwift(App):
    def __init__(self, **kwargs):
        super(HelloSwift, self).__init__(**kwargs)
        self.apple_api: HelloWorld = HelloWorld(self)

    def build(self):

        self.sendhellobutton = Button(text='Send: Hello World',
                size_hint=(.2, .2),
                pos_hint={'center_x': .5, 'center_y': .5})
          
        self.sendhellobutton.bind(on_press=self.send_press_func)

        self.receivehellobutton = Button(text='Receive: Hello World',
        size_hint=(.2, .2),
        pos_hint={'center_x': .5, 'center_y': .5})

        self.receivehellobutton.bind(on_press=self.receive_press_func)

        boxlayout = BoxLayout()
        boxlayout.add_widget(self.sendhellobutton)
        boxlayout.add_widget(self.receivehellobutton)
        return boxlayout     

    def send_press_func(self, instance):
        self.apple_api.send_string("Hello from Python")


    def receive_press_func(self, instance):
        print(self.apple_api.get_string())

HelloSwift().run()  