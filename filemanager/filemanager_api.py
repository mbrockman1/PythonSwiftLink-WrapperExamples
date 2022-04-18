from swift_types import *



@wrapper
class FileManagerExample:
    
    class Callbacks:
        
        def did_pick_document(self, files: list[str]): ...
        
        # def did_cancel_pick(self): ...
        
    
    def get_document(self): ...
    
    