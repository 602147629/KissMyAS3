package lovefox.socket
{
    import flash.events.*;
    import flash.utils.*;

    public class SocketEvent extends Event
    {
        public var data:ByteArray;

        public function SocketEvent(param1:String, param2:ByteArray)
        {
            super(param1, false, false);
            this.data = param2;
            return;
        }// end function

    }
}
