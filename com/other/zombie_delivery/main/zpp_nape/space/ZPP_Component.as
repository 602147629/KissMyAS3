package zpp_nape.space
{
    import flash.*;
    import zpp_nape.constraint.*;
    import zpp_nape.phys.*;

    public class ZPP_Component extends Object
    {
        public var woken:Boolean;
        public var waket:int;
        public var sleeping:Boolean;
        public var rank:int;
        public var parent:ZPP_Component;
        public var next:ZPP_Component;
        public var island:ZPP_Island;
        public var isBody:Boolean;
        public var constraint:ZPP_Constraint;
        public var body:ZPP_Body;
        public static var zpp_pool:ZPP_Component;

        public function ZPP_Component() : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            woken = false;
            waket = 0;
            sleeping = false;
            island = null;
            constraint = null;
            body = null;
            isBody = false;
            rank = 0;
            parent = null;
            next = null;
            sleeping = false;
            island = null;
            parent = this;
            rank = 0;
            woken = false;
            return;
        }// end function

        public function reset() : void
        {
            sleeping = false;
            island = null;
            parent = this;
            rank = 0;
            return;
        }// end function

        public function free() : void
        {
            body = null;
            constraint = null;
            return;
        }// end function

        public function alloc() : void
        {
            return;
        }// end function

    }
}
