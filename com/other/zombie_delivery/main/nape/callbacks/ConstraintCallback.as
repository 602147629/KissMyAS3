package nape.callbacks
{
    import flash.*;
    import nape.constraint.*;
    import zpp_nape.util.*;

    final public class ConstraintCallback extends Callback
    {

        public function ConstraintCallback() : void
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
            _loc_1 = _loc_1 + ["WAKE", "SLEEP", "BREAK"][zpp_inner.event - ZPP_Flags.id_CbEvent_WAKE];
            _loc_1 = _loc_1 + (":" + zpp_inner.constraint.outer.toString());
            _loc_1 = _loc_1 + (" : listener: " + Std.string(zpp_inner.listener.outer));
            return _loc_1;
        }// end function

        public function get_constraint() : Constraint
        {
            return zpp_inner.constraint.outer;
        }// end function

    }
}
