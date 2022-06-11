from swift_types import *

@wrapper
class SwiftCamera:

	class Callbacks:

		def update_texture_size(self, w: int, h: int) -> object: ...
		
		#def preview_pixels(self, h: object, w: object, pixels: object ): ...
	
	
	def start(self, ask_update: object): ...
	
	def stop(self): ...
	
	
	