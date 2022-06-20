


from kivy.app import App
from kivy.uix.widget import Widget
from kivy.uix.boxlayout import BoxLayout
from kivy.lang.builder import Builder
from ads_viewer import AdsViewerExample


Builder.load_string("""
<AdMobTestPanel>:
    ToggleButton:
        text: "floating banner"
        on_state: app.adsview.banner_ad(self.state == "down")
    ToggleButton:
        text: "static banner"
        on_state: on_state: app.adsview.static_banner_ad(self.state == "down")
    Button:
        text: "Full screen Ads"
        on_release: app.adsview.fullscreen_ad()
"""
)


class AdMobTestPanel(BoxLayout):
    pass


class AdMobApp(App):

    def build(self):

        self.adsview = AdsViewerExample(self)

        #static ad logic
        box = BoxLayout(orientation='vertical')
        spacer = Widget(size_hint_y=None, height=0)
        self.ad_spacer = spacer
        ads = AdMobTestPanel()
        box.add_widget(spacer)
        box.add_widget(ads)

        return box

    def banner_did_load(self, w: float, h: float): 
        self.ad_spacer.height = h


if __name__ == '__main__':
    AdMobApp().run()

