package lovefox.gameUI
{
    import flash.events.*;

    public class FriendEvent extends Event
    {
        public var data:Object;
        public var inum:int;
        public var sendname:String;
        public static const DEL_FRIEND:String = "del_friend";
        public static const ADD_BLACK:String = "add_black";
        public static const DEL_BLACK:String = "del_black";

        public function FriendEvent(param1:String, param2:Boolean = false)
        {
            super(param1, param2);
            return;
        }// end function

    }
}
