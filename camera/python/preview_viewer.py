

from kivy.uix.relativelayout import RelativeLayout
from kivy.graphics.texture import Texture
from kivy.properties import ObjectProperty, AliasProperty
from kivy.lang import Builder





class PreviewViewer(RelativeLayout):

    tex = ObjectProperty(None)

    def get_image_ratio(self):
        tex = self.tex
        if tex:
            return tex.width / float(tex.height)
        return 1.

    image_ratio = AliasProperty(get_image_ratio, bind=('tex',), cache=True)

    def get_norm_image_size(self):
        tex = self.tex
        if not tex:
            return list(self.size)
        ratio = self.image_ratio
        w, h = self.size
        iw = w
        # calculate the appropriate height
        ih = iw / ratio
        # if the height is too higher, take the height of the container
        # and calculate appropriate width. no need to test further. :)
        if ih > h:
            ih = h
            iw = ih * ratio
        return [iw, ih]

    norm_image_size = AliasProperty(get_norm_image_size,
                                    bind=('tex', 'size',
                                        'image_ratio'),
                                    cache=True)

    def get_offset_pos(self):
        w, h = self.size
        tw, th = self.norm_image_size

        offset_x = (w - tw) / 2
        offset_y = (h - th) / 2

        return [self.x + offset_x, self.y + offset_y]

    offset_pos = AliasProperty(get_offset_pos,
                            bind=('norm_image_size','pos'),
                            cache=True
                            )

    def ask_update(self):
        #...
        self.canvas.ask_update()




Builder.load_string("""

<PreviewViewer>:
    tex: app.camera_data.preview_texture
    canvas: 
        Rectangle:
            texture: self.tex
            pos: self.offset_pos
            size: self.norm_image_size

""")