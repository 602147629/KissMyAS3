package lovefox.gameUI
{
    import flash.events.*;

    public class MailEvent extends Event
    {
        public var data:Object;
        public var arr:Array;
        public static const CHANGE_SELECT:String = "change_select";
        public static const ATTACHMENTS_UP:String = "attachments_up";
        public static const CLOSE_READ:String = "close_read";
        public static const TO_MAIL:String = "tomail";
        public static const TO_MAILLIST:String = "to_maillist";

        public function MailEvent(param1:String, param2:Boolean = false)
        {
            super(param1, param2);
            return;
        }// end function

    }
}
