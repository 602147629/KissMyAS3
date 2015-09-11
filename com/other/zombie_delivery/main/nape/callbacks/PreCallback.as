package nape.callbacks
{
    import flash.*;
    import nape.dynamics.*;
    import nape.phys.*;

    final public class PreCallback extends Callback
    {

        public function PreCallback() : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            return;
        }// end function

        override public function toString() : String
        {
            var _loc_1:* = "Cb:PRE:";
            _loc_1 = _loc_1 + (":" + zpp_inner.int1.outer_i.toString() + "/" + zpp_inner.int2.outer_i.toString());
            _loc_1 = _loc_1 + (" : " + zpp_inner.pre_arbiter.wrapper().toString());
            _loc_1 = _loc_1 + (" : listnener: " + Std.string(zpp_inner.listener.outer));
            return _loc_1;
        }// end function

        public function get_swapped() : Boolean
        {
            return zpp_inner.pre_swapped;
        }// end function

        public function get_int2() : Interactor
        {
            return zpp_inner.int2.outer_i;
        }// end function

        public function get_int1() : Interactor
        {
            return zpp_inner.int1.outer_i;
        }// end function

        public function get_arbiter() : Arbiter
        {
            return zpp_inner.pre_arbiter.wrapper();
        }// end function

    }
}
