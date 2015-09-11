package nape.callbacks
{
    import flash.*;
    import zpp_nape.callbacks.*;

    public class Callback extends Object
    {
        public var zpp_inner:ZPP_Callback;

        public function Callback() : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            zpp_inner = null;
            if (!ZPP_Callback.internal)
            {
                throw "Error: Callback cannot be instantiated derp!";
            }
            return;
        }// end function

        public function toString() : String
        {
            return "";
        }// end function

        public function get_listener() : Listener
        {
            return zpp_inner.listener.outer;
        }// end function

        public function get_event() : CbEvent
        {
            return ZPP_Listener.events[zpp_inner.event];
        }// end function

    }
}
