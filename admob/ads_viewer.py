from swift_types import *


@wrapper
class AdsViewerExample:
    
    class Callbacks:
        
        def banner_did_load(self, w: float, h: float): ...
    
    def init_ads_class(self): ...
    
    def banner_ad(self, enabled: bool): ...
    
    def static_banner_ad(self, enabled: bool): ...
    
    def fullscreen_ad(self): ...