package notice
{
    import message.*;

    public class LocalNoticeInfo extends Object
    {
        private var _type:int;
        public static const LOCAL_NOTICE_EMPEROR_FACILITY_CANCEL:int = 1;

        public function LocalNoticeInfo(param1:int)
        {
            this._type = param1;
            return;
        }// end function

        public function get type() : int
        {
            return this._type;
        }// end function

        public function getMessage() : String
        {
            if (this._type == LOCAL_NOTICE_EMPEROR_FACILITY_CANCEL)
            {
                return MessageManager.getInstance().getMessage(MessageId.HOME_EMPEROR_SELECT_AFTER_MESSAGE);
            }
            return "";
        }// end function

    }
}
