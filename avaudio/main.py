import kivy
from kivy.app import App
from kivy.uix.button import Button
from kivy.uix.boxlayout import BoxLayout

from av_media_player import AVPlayerApi

from os import getcwd, listdir

class MediaSwift(App):
    def __init__(self, **kwargs):
        super(MediaSwift, self).__init__(**kwargs)
        self.audio_player: AVPlayerApi = AVPlayerApi(self)


    def build(self):

        self.playbutton = Button(text='Load')
        self.playbutton.bind(on_press=self.play_func)

        self.pausebutton = Button(text='Play/Pause')
        self.pausebutton.bind(on_press=self.pause_play_func)

        self.statusbutton = Button(text='Status')
        self.statusbutton.bind(on_press=self.player_status)

        self.down_ratebutton = Button(text='-')
        self.down_ratebutton.bind(on_press=self.down_rate_button)

        self.rate_resetbutton = Button(text='Reset')
        self.rate_resetbutton.bind(on_press=self.rate_reset_button)
        
        self.up_ratebutton = Button(text='+')
        self.up_ratebutton.bind(on_press=self.up_rate_button)

        self.current_time_button = Button(text='Time')
        self.current_time_button.bind(on_press=self.current_time_func)

        self.duration_button = Button(text='Duration')
        self.duration_button.bind(on_press=self.duration_func)

        sub_box1 = BoxLayout(orientation='horizontal')
        sub_box1.add_widget(self.down_ratebutton)
        sub_box1.add_widget(self.rate_resetbutton)
        sub_box1.add_widget(self.up_ratebutton)

        sub_box2 = BoxLayout(orientation='horizontal')
        sub_box2.add_widget(self.current_time_button)
        sub_box2.add_widget(self.duration_button)

        boxlayout = BoxLayout(orientation='vertical')
        boxlayout.add_widget(self.playbutton)
        boxlayout.add_widget(self.pausebutton)
        boxlayout.add_widget(self.statusbutton)
        boxlayout.add_widget(sub_box1)
        boxlayout.add_widget(sub_box2)
        return boxlayout     

    def play_func(self, instance):
        print(listdir())
        file_dir = getcwd() + '/sound/test.mp3'
        self.audio_player.play(file_dir)

    def pause_play_func(self, instance):
        self.audio_player.play_or_pause()

    def player_status(self, instance):
        print(self.audio_player.player_status())

    def down_rate_button(self, instance):
        self.audio_player.rate_adjustment(-0.1)

    def up_rate_button(self, instance):
        self.audio_player.rate_adjustment(0.1)

    def rate_reset_button(self, instance):
        self.audio_player.rate_reset()

    def current_time_func(self, instance):
        print(self.audio_player.return_currentTime())

    def duration_func(self, instance):
        print(self.audio_player.return_duration())
  

MediaSwift().run()  