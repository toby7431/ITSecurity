
#
from kivy.uix.screenmanager import Screen
from kivymd.utils import platform
from kivymd.uix.button import MDRectangleFlatButton
from kivymd.uix.label import MDLabel

#
class AdaptiveScreen(Screen):
    def __init__(self, **kwargs):
        super().__init__(**kwargs)
