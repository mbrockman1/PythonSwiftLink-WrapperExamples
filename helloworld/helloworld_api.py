from swift_types import *


@wrapper
class HelloWorld:
    
    def get_string(self)  -> str:
        """
        Receive a str from swift.
        """

    def send_string(self, sent_string: str):
        """
        Sends a str to swift.
        """