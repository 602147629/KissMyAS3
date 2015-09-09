package lovefox.component
{
    import flash.events.*;

    public class SimpleTreeEvent extends Event
    {
        public var id:int;
        public var check:Boolean;
        public static const SELECT_ID:String = "select_id";
        public static const CHECK_ID:String = "check_id";

        public function SimpleTreeEvent(param1:String, param2:Boolean = false)
        {
            super(param1, param2);
            return;
        }// end function

    }
}
