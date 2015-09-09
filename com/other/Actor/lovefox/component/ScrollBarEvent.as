package lovefox.component
{
    import flash.events.*;

    public class ScrollBarEvent extends Event
    {
        public var percent:int;
        public var text:String;
        public static const VSCROLL_UPPERCENT:String = "vscroll_uppercent";
        public static const TEXTAREAuiEVENT:String = "textareaevent";

        public function ScrollBarEvent(param1:String, param2:Boolean = false)
        {
            super(param1, param2);
            return;
        }// end function

    }
}
