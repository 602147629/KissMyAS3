package zpp_nape.callbacks
{
    import flash.*;
    import nape.callbacks.*;
    import nape.constraint.*;
    import nape.phys.*;
    import zpp_nape.*;
    import zpp_nape.constraint.*;
    import zpp_nape.phys.*;
    import zpp_nape.util.*;

    public class ZPP_CbType extends Object
    {
        public var wrap_interactors:InteractorList;
        public var wrap_constraints:ConstraintList;
        public var userData:Object;
        public var outer:CbType;
        public var listeners:ZNPList_ZPP_InteractionListener;
        public var interactors:ZNPList_ZPP_Interactor;
        public var id:int;
        public var constraints:ZNPList_ZPP_Constraint;
        public var conlisteners:ZNPList_ZPP_ConstraintListener;
        public var cbsets:ZNPList_ZPP_CbSet;
        public var bodylisteners:ZNPList_ZPP_BodyListener;
        public static var init__:Boolean;
        public static var ANY_SHAPE:CbType;
        public static var ANY_BODY:CbType;
        public static var ANY_COMPOUND:CbType;
        public static var ANY_CONSTRAINT:CbType;

        public function ZPP_CbType() : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            conlisteners = null;
            bodylisteners = null;
            listeners = null;
            cbsets = null;
            id = 0;
            userData = null;
            outer = null;
            id = ZPP_ID.CbType();
            listeners = new ZNPList_ZPP_InteractionListener();
            bodylisteners = new ZNPList_ZPP_BodyListener();
            conlisteners = new ZNPList_ZPP_ConstraintListener();
            constraints = new ZNPList_ZPP_Constraint();
            interactors = new ZNPList_ZPP_Interactor();
            cbsets = new ZNPList_ZPP_CbSet();
            return;
        }// end function

        public function removeint(param1:ZPP_InteractionListener) : void
        {
            var _loc_3:* = null as ZPP_CbSet;
            listeners.remove(param1);
            var _loc_2:* = cbsets.head;
            while (_loc_2 != null)
            {
                
                _loc_3 = _loc_2.elt;
                _loc_3.zip_listeners = true;
                _loc_3.invalidate_pairs();
                _loc_2 = _loc_2.next;
            }
            return;
        }// end function

        public function removeconstraint(param1:ZPP_ConstraintListener) : void
        {
            var _loc_3:* = null as ZPP_CbSet;
            conlisteners.remove(param1);
            var _loc_2:* = cbsets.head;
            while (_loc_2 != null)
            {
                
                _loc_3 = _loc_2.elt;
                _loc_3.zip_conlisteners = true;
                _loc_2 = _loc_2.next;
            }
            return;
        }// end function

        public function removebody(param1:ZPP_BodyListener) : void
        {
            var _loc_3:* = null as ZPP_CbSet;
            bodylisteners.remove(param1);
            var _loc_2:* = cbsets.head;
            while (_loc_2 != null)
            {
                
                _loc_3 = _loc_2.elt;
                _loc_3.zip_bodylisteners = true;
                _loc_2 = _loc_2.next;
            }
            return;
        }// end function

        public function remInteractor(param1:ZPP_Interactor) : void
        {
            interactors.remove(param1);
            return;
        }// end function

        public function remConstraint(param1:ZPP_Constraint) : void
        {
            constraints.remove(param1);
            return;
        }// end function

        public function invalidateint() : void
        {
            var _loc_2:* = null as ZPP_CbSet;
            var _loc_1:* = cbsets.head;
            while (_loc_1 != null)
            {
                
                _loc_2 = _loc_1.elt;
                _loc_2.zip_listeners = true;
                _loc_2.invalidate_pairs();
                _loc_1 = _loc_1.next;
            }
            return;
        }// end function

        public function invalidateconstraint() : void
        {
            var _loc_2:* = null as ZPP_CbSet;
            var _loc_1:* = cbsets.head;
            while (_loc_1 != null)
            {
                
                _loc_2 = _loc_1.elt;
                _loc_2.zip_conlisteners = true;
                _loc_1 = _loc_1.next;
            }
            return;
        }// end function

        public function invalidatebody() : void
        {
            var _loc_2:* = null as ZPP_CbSet;
            var _loc_1:* = cbsets.head;
            while (_loc_1 != null)
            {
                
                _loc_2 = _loc_1.elt;
                _loc_2.zip_bodylisteners = true;
                _loc_1 = _loc_1.next;
            }
            return;
        }// end function

        public function addint(param1:ZPP_InteractionListener) : void
        {
            var _loc_4:* = null as ZPP_InteractionListener;
            var _loc_6:* = null as ZNPNode_ZPP_InteractionListener;
            var _loc_9:* = null as ZPP_CbSet;
            var _loc_2:* = null;
            var _loc_3:* = listeners.head;
            while (_loc_3 != null)
            {
                
                _loc_4 = _loc_3.elt;
                if (param1.precedence <= _loc_4.precedence)
                {
                    if (param1.precedence == _loc_4.precedence)
                    {
                    }
                }
                if (param1.id > _loc_4.id)
                {
                    break;
                }
                _loc_2 = _loc_3;
                _loc_3 = _loc_3.next;
            }
            var _loc_5:* = listeners;
            if (ZNPNode_ZPP_InteractionListener.zpp_pool == null)
            {
                _loc_6 = new ZNPNode_ZPP_InteractionListener();
            }
            else
            {
                _loc_6 = ZNPNode_ZPP_InteractionListener.zpp_pool;
                ZNPNode_ZPP_InteractionListener.zpp_pool = _loc_6.next;
                _loc_6.next = null;
            }
            _loc_6.elt = param1;
            _loc_3 = _loc_6;
            if (_loc_2 == null)
            {
                _loc_3.next = _loc_5.head;
                _loc_5.head = _loc_3;
            }
            else
            {
                _loc_3.next = _loc_2.next;
                _loc_2.next = _loc_3;
            }
            var _loc_7:* = true;
            _loc_5.modified = true;
            _loc_5.pushmod = _loc_7;
            (_loc_5.length + 1);
            var _loc_8:* = cbsets.head;
            while (_loc_8 != null)
            {
                
                _loc_9 = _loc_8.elt;
                _loc_9.zip_listeners = true;
                _loc_9.invalidate_pairs();
                _loc_8 = _loc_8.next;
            }
            return;
        }// end function

        public function addconstraint(param1:ZPP_ConstraintListener) : void
        {
            var _loc_4:* = null as ZPP_ConstraintListener;
            var _loc_6:* = null as ZNPNode_ZPP_ConstraintListener;
            var _loc_9:* = null as ZPP_CbSet;
            var _loc_2:* = null;
            var _loc_3:* = conlisteners.head;
            while (_loc_3 != null)
            {
                
                _loc_4 = _loc_3.elt;
                if (param1.precedence <= _loc_4.precedence)
                {
                    if (param1.precedence == _loc_4.precedence)
                    {
                    }
                }
                if (param1.id > _loc_4.id)
                {
                    break;
                }
                _loc_2 = _loc_3;
                _loc_3 = _loc_3.next;
            }
            var _loc_5:* = conlisteners;
            if (ZNPNode_ZPP_ConstraintListener.zpp_pool == null)
            {
                _loc_6 = new ZNPNode_ZPP_ConstraintListener();
            }
            else
            {
                _loc_6 = ZNPNode_ZPP_ConstraintListener.zpp_pool;
                ZNPNode_ZPP_ConstraintListener.zpp_pool = _loc_6.next;
                _loc_6.next = null;
            }
            _loc_6.elt = param1;
            _loc_3 = _loc_6;
            if (_loc_2 == null)
            {
                _loc_3.next = _loc_5.head;
                _loc_5.head = _loc_3;
            }
            else
            {
                _loc_3.next = _loc_2.next;
                _loc_2.next = _loc_3;
            }
            var _loc_7:* = true;
            _loc_5.modified = true;
            _loc_5.pushmod = _loc_7;
            (_loc_5.length + 1);
            var _loc_8:* = cbsets.head;
            while (_loc_8 != null)
            {
                
                _loc_9 = _loc_8.elt;
                _loc_9.zip_conlisteners = true;
                _loc_8 = _loc_8.next;
            }
            return;
        }// end function

        public function addbody(param1:ZPP_BodyListener) : void
        {
            var _loc_4:* = null as ZPP_BodyListener;
            var _loc_6:* = null as ZNPNode_ZPP_BodyListener;
            var _loc_9:* = null as ZPP_CbSet;
            var _loc_2:* = null;
            var _loc_3:* = bodylisteners.head;
            while (_loc_3 != null)
            {
                
                _loc_4 = _loc_3.elt;
                if (param1.precedence <= _loc_4.precedence)
                {
                    if (param1.precedence == _loc_4.precedence)
                    {
                    }
                }
                if (param1.id > _loc_4.id)
                {
                    break;
                }
                _loc_2 = _loc_3;
                _loc_3 = _loc_3.next;
            }
            var _loc_5:* = bodylisteners;
            if (ZNPNode_ZPP_BodyListener.zpp_pool == null)
            {
                _loc_6 = new ZNPNode_ZPP_BodyListener();
            }
            else
            {
                _loc_6 = ZNPNode_ZPP_BodyListener.zpp_pool;
                ZNPNode_ZPP_BodyListener.zpp_pool = _loc_6.next;
                _loc_6.next = null;
            }
            _loc_6.elt = param1;
            _loc_3 = _loc_6;
            if (_loc_2 == null)
            {
                _loc_3.next = _loc_5.head;
                _loc_5.head = _loc_3;
            }
            else
            {
                _loc_3.next = _loc_2.next;
                _loc_2.next = _loc_3;
            }
            var _loc_7:* = true;
            _loc_5.modified = true;
            _loc_5.pushmod = _loc_7;
            (_loc_5.length + 1);
            var _loc_8:* = cbsets.head;
            while (_loc_8 != null)
            {
                
                _loc_9 = _loc_8.elt;
                _loc_9.zip_bodylisteners = true;
                _loc_8 = _loc_8.next;
            }
            return;
        }// end function

        public function addInteractor(param1:ZPP_Interactor) : void
        {
            interactors.add(param1);
            return;
        }// end function

        public function addConstraint(param1:ZPP_Constraint) : void
        {
            constraints.add(param1);
            return;
        }// end function

        public static function setlt(param1:ZPP_CbType, param2:ZPP_CbType) : Boolean
        {
            return param1.id < param2.id;
        }// end function

    }
}
