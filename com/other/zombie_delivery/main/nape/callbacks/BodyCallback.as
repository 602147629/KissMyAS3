package nape.callbacks
{
    import flash.*;
    import nape.phys.*;
    import zpp_nape.util.*;

    final public class BodyCallback extends Callback
    {

        public function BodyCallback() : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            return;
        }// end function

        override public function toString() : String
        {
            var _loc_1:* = "Cb:";
            _loc_1 = _loc_1 + ["WAKE", "SLEEP"][zpp_inner.event - ZPP_Flags.id_CbEvent_WAKE];
            _loc_1 = _loc_1 + (":" + zpp_inner.body.outer.toString());
            _loc_1 = _loc_1 + (" : listener: " + Std.string(zpp_inner.listener.outer));
            return _loc_1;
        }// end function

        public function get_body() : Body
        {
            return zpp_inner.body.outer;
        }// end function

    }
}
