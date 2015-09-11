package zpp_nape.geom
{
    import flash.*;
    import zpp_nape.dynamics.*;
    import zpp_nape.shape.*;

    public class ZPP_ToiEvent extends Object
    {
        public var toi:Number;
        public var slipped:Boolean;
        public var s2:ZPP_Shape;
        public var s1:ZPP_Shape;
        public var next:ZPP_ToiEvent;
        public var kinematic:Boolean;
        public var frozen2:Boolean;
        public var frozen1:Boolean;
        public var failed:Boolean;
        public var c2:ZPP_Vec2;
        public var c1:ZPP_Vec2;
        public var axis:ZPP_Vec2;
        public var arbiter:ZPP_ColArbiter;
        public static var zpp_pool:ZPP_ToiEvent;

        public function ZPP_ToiEvent() : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            kinematic = false;
            failed = false;
            slipped = false;
            axis = null;
            c2 = null;
            c1 = null;
            frozen2 = false;
            frozen1 = false;
            arbiter = null;
            s2 = null;
            s1 = null;
            toi = 0;
            next = null;
            c1 = new ZPP_Vec2();
            c2 = new ZPP_Vec2();
            axis = new ZPP_Vec2();
            return;
        }// end function

        public function free() : void
        {
            return;
        }// end function

        public function alloc() : void
        {
            failed = false;
            var _loc_1:* = null;
            s2 = null;
            s1 = _loc_1;
            arbiter = null;
            return;
        }// end function

    }
}
