package nape.callbacks
{
    import flash.*;
    import nape.dynamics.*;
    import nape.phys.*;

    final public class InteractionCallback extends Callback
    {

        public function InteractionCallback() : void
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
            _loc_1 = _loc_1 + ["BEGIN", "END", "", "", "", "", "ONGOING"][zpp_inner.event];
            _loc_1 = _loc_1 + (":" + zpp_inner.int1.outer_i.toString() + "/" + zpp_inner.int2.outer_i.toString());
            _loc_1 = _loc_1 + (" : " + zpp_inner.wrap_arbiters.toString());
            _loc_1 = _loc_1 + (" : listener: " + Std.string(zpp_inner.listener.outer));
            return _loc_1;
        }// end function

        public function get_int2() : Interactor
        {
            return zpp_inner.int2.outer_i;
        }// end function

        public function get_int1() : Interactor
        {
            return zpp_inner.int1.outer_i;
        }// end function

        public function get_arbiters() : ArbiterList
        {
            return zpp_inner.wrap_arbiters;
        }// end function

    }
}
