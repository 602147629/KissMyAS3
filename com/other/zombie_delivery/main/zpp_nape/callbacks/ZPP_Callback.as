package zpp_nape.callbacks
{
    import flash.*;
    import nape.callbacks.*;
    import nape.dynamics.*;
    import zpp_nape.constraint.*;
    import zpp_nape.dynamics.*;
    import zpp_nape.phys.*;
    import zpp_nape.space.*;
    import zpp_nape.util.*;

    public class ZPP_Callback extends Object
    {
        public var wrap_arbiters:ArbiterList;
        public var space:ZPP_Space;
        public var set:ZPP_CallbackSet;
        public var prev:ZPP_Callback;
        public var pre_swapped:Boolean;
        public var pre_arbiter:ZPP_Arbiter;
        public var outer_int:InteractionCallback;
        public var outer_con:ConstraintCallback;
        public var outer_body:BodyCallback;
        public var next:ZPP_Callback;
        public var listener:ZPP_Listener;
        public var length:int;
        public var int2:ZPP_Interactor;
        public var int1:ZPP_Interactor;
        public var index:int;
        public var event:int;
        public var constraint:ZPP_Constraint;
        public var body:ZPP_Body;
        public static var internal:Boolean;
        public static var zpp_pool:ZPP_Callback;

        public function ZPP_Callback() : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            constraint = null;
            body = null;
            pre_swapped = false;
            pre_arbiter = null;
            wrap_arbiters = null;
            set = null;
            int2 = null;
            int1 = null;
            length = 0;
            prev = null;
            next = null;
            index = 0;
            space = null;
            listener = null;
            event = 0;
            outer_int = null;
            outer_con = null;
            outer_body = null;
            length = 0;
            return;
        }// end function

        public function wrapper_int() : InteractionCallback
        {
            if (outer_int == null)
            {
                ZPP_Callback.internal = true;
                outer_int = new InteractionCallback();
                ZPP_Callback.internal = false;
                outer_int.zpp_inner = this;
            }
            if (wrap_arbiters == null)
            {
                wrap_arbiters = ZPP_ArbiterList.get(set.arbiters, true);
            }
            else
            {
                wrap_arbiters.zpp_inner.inner = set.arbiters;
            }
            wrap_arbiters.zpp_inner.zip_length = true;
            wrap_arbiters.zpp_inner.at_ite = null;
            return outer_int;
        }// end function

        public function wrapper_con() : ConstraintCallback
        {
            if (outer_con == null)
            {
                ZPP_Callback.internal = true;
                outer_con = new ConstraintCallback();
                ZPP_Callback.internal = false;
                outer_con.zpp_inner = this;
            }
            return outer_con;
        }// end function

        public function wrapper_body() : BodyCallback
        {
            if (outer_body == null)
            {
                ZPP_Callback.internal = true;
                outer_body = new BodyCallback();
                ZPP_Callback.internal = false;
                outer_body.zpp_inner = this;
            }
            return outer_body;
        }// end function

        public function splice(param1:ZPP_Callback) : ZPP_Callback
        {
            var _loc_2:* = param1.next;
            if (param1.prev == null)
            {
                next = param1.next;
                if (next != null)
                {
                    next.prev = null;
                }
                else
                {
                    prev = null;
                }
            }
            else
            {
                param1.prev.next = param1.next;
                if (param1.next != null)
                {
                    param1.next.prev = param1.prev;
                }
                else
                {
                    prev = param1.prev;
                }
            }
            (length - 1);
            return _loc_2;
        }// end function

        public function rotateR() : void
        {
            push_rev(pop_rev());
            return;
        }// end function

        public function rotateL() : void
        {
            push(pop());
            return;
        }// end function

        public function rev_at(param1:int) : ZPP_Callback
        {
            var _loc_2:* = prev;
            do
            {
                
                _loc_2 = _loc_2.prev;
                param1--;
            }while (param1 != 0)
            return _loc_2;
        }// end function

        public function push_rev(param1:ZPP_Callback) : void
        {
            if (next != null)
            {
                next.prev = param1;
            }
            else
            {
                prev = param1;
            }
            param1.next = next;
            param1.prev = null;
            next = param1;
            (length + 1);
            return;
        }// end function

        public function push(param1:ZPP_Callback) : void
        {
            if (prev != null)
            {
                prev.next = param1;
            }
            else
            {
                next = param1;
            }
            param1.prev = prev;
            param1.next = null;
            prev = param1;
            (length + 1);
            return;
        }// end function

        public function pop_rev() : ZPP_Callback
        {
            var _loc_1:* = prev;
            prev = _loc_1.prev;
            if (prev == null)
            {
                next = null;
            }
            else
            {
                prev.next = null;
            }
            (length - 1);
            return _loc_1;
        }// end function

        public function pop() : ZPP_Callback
        {
            var _loc_1:* = next;
            next = _loc_1.next;
            if (next == null)
            {
                prev = null;
            }
            else
            {
                next.prev = null;
            }
            (length - 1);
            return _loc_1;
        }// end function

        public function genarbs() : void
        {
            if (wrap_arbiters == null)
            {
                wrap_arbiters = ZPP_ArbiterList.get(set.arbiters, true);
            }
            else
            {
                wrap_arbiters.zpp_inner.inner = set.arbiters;
            }
            wrap_arbiters.zpp_inner.zip_length = true;
            wrap_arbiters.zpp_inner.at_ite = null;
            return;
        }// end function

        public function free() : void
        {
            var _loc_1:* = null;
            int2 = null;
            int1 = _loc_1;
            body = null;
            constraint = null;
            listener = null;
            if (wrap_arbiters != null)
            {
                wrap_arbiters.zpp_inner.inner = null;
            }
            set = null;
            return;
        }// end function

        public function empty() : Boolean
        {
            return next == null;
        }// end function

        public function cyclePrev(param1:ZPP_Callback) : ZPP_Callback
        {
            if (param1.prev == null)
            {
                return prev;
            }
            else
            {
                return param1.prev;
            }
        }// end function

        public function cycleNext(param1:ZPP_Callback) : ZPP_Callback
        {
            if (param1.next == null)
            {
                return next;
            }
            else
            {
                return param1.next;
            }
        }// end function

        public function clear() : void
        {
            while (!empty())
            {
                
                pop();
            }
            return;
        }// end function

        public function at(param1:int) : ZPP_Callback
        {
            var _loc_2:* = next;
            do
            {
                
                _loc_2 = _loc_2.next;
                param1--;
            }while (param1 != 0)
            return _loc_2;
        }// end function

        public function alloc() : void
        {
            return;
        }// end function

    }
}
