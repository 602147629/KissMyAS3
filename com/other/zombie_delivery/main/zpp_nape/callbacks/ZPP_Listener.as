package zpp_nape.callbacks
{
    import flash.*;
    import nape.callbacks.*;
    import zpp_nape.*;
    import zpp_nape.space.*;

    public class ZPP_Listener extends Object
    {
        public var type:int;
        public var space:ZPP_Space;
        public var precedence:int;
        public var outer:Listener;
        public var interaction:ZPP_InteractionListener;
        public var id:int;
        public var event:int;
        public var constraint:ZPP_ConstraintListener;
        public var body:ZPP_BodyListener;
        public static var init__:Boolean;
        public static var internal:Boolean;
        public static var types:Array;
        public static var events:Array;

        public function ZPP_Listener() : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            space = null;
            interaction = null;
            constraint = null;
            body = null;
            precedence = 0;
            event = 0;
            type = 0;
            id = 0;
            outer = null;
            id = ZPP_ID.Listener();
            return;
        }// end function

        public function swapEvent(param1:int) : void
        {
            return;
        }// end function

        public function removedFromSpace() : void
        {
            return;
        }// end function

        public function invalidate_precedence() : void
        {
            return;
        }// end function

        public function addedToSpace() : void
        {
            return;
        }// end function

        public static function setlt(param1:ZPP_Listener, param2:ZPP_Listener) : Boolean
        {
            if (param1.precedence <= param2.precedence)
            {
                if (param1.precedence == param2.precedence)
                {
                }
            }
            return param1.id > param2.id;
        }// end function

    }
}
