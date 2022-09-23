from kivy.app import App
from kivy.uix.boxlayout import BoxLayout
from kivy.core.window import Window

from kivy.uix.textinput import TextInput
from kivy.uix.label import Label
from kivy.uix.button import Button
from kivy.uix.checkbox import CheckBox

from random import randint

try:
    from notification_wrapper import NotificationApi
except(ModuleNotFoundError):
    print("Debug system, dont forget to import wrapper lib")


class NotificationWidget(BoxLayout):
    def __init__(self):
        super(NotificationWidget, self).__init__()
        try:
            self.apple_api = NotificationApi(self)
            print('Successfully Wrapped')
        except(NameError):
            print("Debug system, dont forget to import wrapper lib")
        self.orientation = "vertical"
        self.secondary_boxlayout_build()
        self.add_widget(self.secondary_boxlayout)
        self.primary_boxlayout_build()

        self.notification_id = str(randint(0, 99999999999))


        self.padding=[0, 0, 0, Window.size[1] / 2.]

        self.notification_dict={
            'title': self.notification_title.text,
            'message': self.notification_text.text,
            'timing': int(self.timing_text.text),
            'repeat': self.repeat_text.active
        }


    def remove_notifications(self):
        self.apple_api.remove_notifications(self.notification_id)

    def do_notify(self, instance):
        self.notification_dict={
            'title': self.notification_title.text,
            'message': self.notification_text.text,
            'timing': int(self.timing_text.text),
            'id': self.notification_id,
            'repeat': self.repeat_text.active
        }

        print(self.notification_dict)

        self.apple_api.do_notify(
            self.notification_dict['title'],
            self.notification_dict['message'],
            self.notification_dict['timing'],
            self.notification_dict['id'],
            bool(self.notification_dict['repeat'])
        )

    def primary_boxlayout_build(self):
        self.simple_notification = Button(
            text = 'Simple Notification',
            size_hint=(1,None),
        )
        self.simple_notification.bind(on_press=self.do_notify)

        self.remove_notifications = Button(
            text='Remove Notification',
            size_hint=(1, None),
        )
        self.remove_notifications.bind(on_press=self.remove_notifications)
        self.add_widget(self.simple_notification)
        self.add_widget(self.remove_notifications)

    def secondary_boxlayout_build(self):
        self.secondary_boxlayout = BoxLayout(
            orientation='horizontal',
            size_hint=(1, None)
        )
        self.notification_title = TextInput(
            text = 'Title',
            size_hint = (1, None)
        )
        self.notification_text = TextInput(
            text = 'Message',
            size_hint = (1, None)
        )
        self.timing_text = TextInput(
            text='5',
            size_hint=(1,None),
            input_filter='int'
        )
        self.repeat_label = Label(
            text = 'Repeat:',
        )
        self.repeat_text = CheckBox(
            size_hint = (1, None),
        )

        self.repeat_text.bind(active=self.on_checkbox_active)

        self.secondary_boxlayout.add_widget(self.notification_title)
        self.secondary_boxlayout.add_widget(self.notification_text)
        self.secondary_boxlayout.add_widget(self.timing_text)
        self.secondary_boxlayout.add_widget(self.repeat_label)
        self.secondary_boxlayout.add_widget(self.repeat_text)

    def on_checkbox_active(self, checkbox, value):
        pass

class NotificationDemoApp(App):
    def build(self):
        return NotificationWidget()

    def on_pause(self):
        return True


if __name__ == '__main__':
    NotificationDemoApp().run()