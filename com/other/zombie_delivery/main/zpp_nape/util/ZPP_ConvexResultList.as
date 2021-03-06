﻿package zpp_nape.util
{
    import flash.*;
    import nape.geom.*;

    public class ZPP_ConvexResultList extends Object
    {
        public var zip_length:Boolean;
        public var user_length:int;
        public var subber:Function;
        public var reverse_flag:Boolean;
        public var push_ite:ZNPNode_ConvexResult;
        public var post_adder:Function;
        public var outer:ConvexResultList;
        public var inner:ZNPList_ConvexResult;
        public var immutable:Boolean;
        public var dontremove:Boolean;
        public var at_ite:ZNPNode_ConvexResult;
        public var at_index:int;
        public var adder:Function;
        public var _validate:Function;
        public var _modifiable:Function;
        public var _invalidated:Boolean;
        public var _invalidate:Function;
        public static var internal:Boolean;

        public function ZPP_ConvexResultList() : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            user_length = 0;
            zip_length = false;
            push_ite = null;
            at_ite = null;
            at_index = 0;
            reverse_flag = false;
            dontremove = false;
            subber = null;
            post_adder = null;
            adder = null;
            _modifiable = null;
            _validate = null;
            _invalidate = null;
            _invalidated = false;
            immutable = false;
            inner = null;
            outer = null;
            inner = new ZNPList_ConvexResult();
            _invalidated = true;
            return;
        }// end function

        public function valmod() : void
        {
            validate();
            if (inner.modified)
            {
                if (inner.pushmod)
                {
                    push_ite = null;
                }
                at_ite = null;
                inner.modified = false;
                inner.pushmod = false;
                zip_length = true;
            }
            return;
        }// end function

        public function validate() : void
        {
            if (_invalidated)
            {
                _invalidated = false;
                if (_validate != null)
                {
                    _validate();
                }
            }
            return;
        }// end function

        public function modify_test() : void
        {
            if (_modifiable != null)
            {
                _modifiable();
            }
            return;
        }// end function

        public function modified() : void
        {
            zip_length = true;
            at_ite = null;
            push_ite = null;
            return;
        }// end function

        public function invalidate() : void
        {
            _invalidated = true;
            if (_invalidate != null)
            {
                _invalidate(this);
            }
            return;
        }// end function

        public static function get(param1:ZNPList_ConvexResult, param2:Boolean = false) : ConvexResultList
        {
            var _loc_3:* = new ConvexResultList();
            _loc_3.zpp_inner.inner = param1;
            if (param2)
            {
                _loc_3.zpp_inner.immutable = true;
            }
            _loc_3.zpp_inner.zip_length = true;
            return _loc_3;
        }// end function

    }
}
