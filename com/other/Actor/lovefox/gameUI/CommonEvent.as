package lovefox.gameUI
{
    import flash.events.*;

    public class CommonEvent extends Event
    {
        public var sendobj:Object;
        public static const MESSAGE_FUC:String = "messgae_fuc";
        public static const MESSAGE_CANCEL:String = "message_cancel";

        public function CommonEvent(param1:String, param2:Boolean = false)
        {
            super(param1, param2);
            return;
        }// end function

    }
}
