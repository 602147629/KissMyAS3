package lovefox.component
{
    import flash.events.*;

    public class AdvanceTreeeEvent extends Event
    {
        public var id:int;
        public var check:Boolean;
        public static const SELECT_ID:String = "select_id";
        public static const CHECK_ID:String = "check_id";
        public static const DCHECK_ID:String = "dcheck_id";
        public static const ROLL_OUT_ID:String = "roll_out_id";
        public static const ROLL_OVER_ID:String = "roll_over_id";

        public function AdvanceTreeeEvent(param1:String, param2:Boolean = false)
        {
            super(param1, param2);
            return;
        }// end function

    }
}
