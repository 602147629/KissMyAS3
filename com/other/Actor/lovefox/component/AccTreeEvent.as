package lovefox.component
{
    import flash.events.*;

    public class AccTreeEvent extends Event
    {
        public var typeobj:Object;
        public static const TREE_SELECT:String = "tree_select";
        public static const TOGGLE_SELECT:String = "toggle_select";
        public static const ACCORDCONTAIN_OPEN:String = "acc_open";

        public function AccTreeEvent(param1:String, param2:Boolean = false)
        {
            super(param1, param2);
            return;
        }// end function

    }
}
