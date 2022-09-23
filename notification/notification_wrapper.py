from swift_types import *


@wrapper
class NotificationApi:
    
    def do_notify(
        self,
        title: str,
        message: str,
        timing: int,
        notification_id: str,
        should_repeat: bool): ...

    def remove_notifications(
        self,
        notification_id: str
    ): ...