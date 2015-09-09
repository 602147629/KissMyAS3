package lovefox.component
{
    import flash.events.*;

    public class DataGridEvent extends Event
    {
        public var selectIndex:int;
        public var rowobj:Object;
        public static const ROW_SELECT:String = "row_select";
        public static const CLOMN_SORT:String = "clomn_sort";
        public static const ROW_ROLLOVER:String = "row_rollover";
        public static const ROW_ROLLOUT:String = "row_rollout";

        public function DataGridEvent(param1:String, param2:Boolean = false)
        {
            super(param1, param2);
            return;
        }// end function

    }
}
