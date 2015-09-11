package zpp_nape.callbacks
{
    import flash.*;
    import nape.callbacks.*;
    import zpp_nape.space.*;
    import zpp_nape.util.*;

    public class ZPP_BodyListener extends ZPP_Listener
    {
        public var outer_zn:BodyListener;
        public var options:ZPP_OptionType;
        public var handler:Function;

        public function ZPP_BodyListener(param1:OptionType = undefined, param2:int = 0, param3:Function = undefined) : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            handler = null;
            options = null;
            outer_zn = null;
            event = param2;
            handler = param3;
            body = this;
            type = ZPP_Flags.id_ListenerType_BODY;
            options = param1.zpp_inner;
            return;
        }// end function

        override public function swapEvent(param1:int) : void
        {
            if (param1 != ZPP_Flags.id_CbEvent_WAKE)
            {
            }
            if (param1 != ZPP_Flags.id_CbEvent_SLEEP)
            {
                throw "Error: BodyListener event must be either WAKE or SLEEP only";
            }
            removedFromSpace();
            event = param1;
            addedToSpace();
            return;
        }// end function

        override public function removedFromSpace() : void
        {
            var _loc_2:* = null as ZPP_CbType;
            var _loc_3:* = null as ZNPNode_ZPP_CbSet;
            var _loc_4:* = null as ZPP_CbSet;
            var _loc_1:* = options.includes.head;
            while (_loc_1 != null)
            {
                
                _loc_2 = _loc_1.elt;
                _loc_2.bodylisteners.remove(this);
                _loc_3 = _loc_2.cbsets.head;
                while (_loc_3 != null)
                {
                    
                    _loc_4 = _loc_3.elt;
                    _loc_4.zip_bodylisteners = true;
                    _loc_3 = _loc_3.next;
                }
                _loc_1 = _loc_1.next;
            }
            options.handler = null;
            return;
        }// end function

        override public function invalidate_precedence() : void
        {
            if (space != null)
            {
                removedFromSpace();
                addedToSpace();
            }
            return;
        }// end function

        public function immutable_options() : void
        {
            if (space != null)
            {
            }
            if (space.midstep)
            {
                throw "Error: Cannot change listener type options during space.step()";
            }
            return;
        }// end function

        public function cbtype_change(param1:ZPP_CbType, param2:Boolean, param3:Boolean) : void
        {
            var _loc_5:* = null as ZNPNode_ZPP_CbType;
            var _loc_6:* = null as ZNPNode_ZPP_CbType;
            var _loc_7:* = null as ZPP_CbType;
            var _loc_8:* = null as ZNPList_ZPP_CbType;
            var _loc_9:* = null as ZNPNode_ZPP_CbType;
            var _loc_10:* = false;
            removedFromSpace();
            var _loc_4:* = options;
            if (param2)
            {
                if (param3)
                {
                    _loc_5 = null;
                    _loc_6 = _loc_4.includes.head;
                    while (_loc_6 != null)
                    {
                        
                        _loc_7 = _loc_6.elt;
                        if (param1.id < _loc_7.id)
                        {
                            break;
                        }
                        _loc_5 = _loc_6;
                        _loc_6 = _loc_6.next;
                    }
                    _loc_8 = _loc_4.includes;
                    if (ZNPNode_ZPP_CbType.zpp_pool == null)
                    {
                        _loc_9 = new ZNPNode_ZPP_CbType();
                    }
                    else
                    {
                        _loc_9 = ZNPNode_ZPP_CbType.zpp_pool;
                        ZNPNode_ZPP_CbType.zpp_pool = _loc_9.next;
                        _loc_9.next = null;
                    }
                    _loc_9.elt = param1;
                    _loc_6 = _loc_9;
                    if (_loc_5 == null)
                    {
                        _loc_6.next = _loc_8.head;
                        _loc_8.head = _loc_6;
                    }
                    else
                    {
                        _loc_6.next = _loc_5.next;
                        _loc_5.next = _loc_6;
                    }
                    _loc_10 = true;
                    _loc_8.modified = _loc_10;
                    _loc_8.pushmod = _loc_10;
                    (_loc_8.length + 1);
                }
                else
                {
                    _loc_4.includes.remove(param1);
                }
            }
            else if (param3)
            {
                _loc_5 = null;
                _loc_6 = _loc_4.excludes.head;
                while (_loc_6 != null)
                {
                    
                    _loc_7 = _loc_6.elt;
                    if (param1.id < _loc_7.id)
                    {
                        break;
                    }
                    _loc_5 = _loc_6;
                    _loc_6 = _loc_6.next;
                }
                _loc_8 = _loc_4.excludes;
                if (ZNPNode_ZPP_CbType.zpp_pool == null)
                {
                    _loc_9 = new ZNPNode_ZPP_CbType();
                }
                else
                {
                    _loc_9 = ZNPNode_ZPP_CbType.zpp_pool;
                    ZNPNode_ZPP_CbType.zpp_pool = _loc_9.next;
                    _loc_9.next = null;
                }
                _loc_9.elt = param1;
                _loc_6 = _loc_9;
                if (_loc_5 == null)
                {
                    _loc_6.next = _loc_8.head;
                    _loc_8.head = _loc_6;
                }
                else
                {
                    _loc_6.next = _loc_5.next;
                    _loc_5.next = _loc_6;
                }
                _loc_10 = true;
                _loc_8.modified = _loc_10;
                _loc_8.pushmod = _loc_10;
                (_loc_8.length + 1);
            }
            else
            {
                _loc_4.excludes.remove(param1);
            }
            addedToSpace();
            return;
        }// end function

        override public function addedToSpace() : void
        {
            var _loc_2:* = null as ZPP_CbType;
            var _loc_3:* = null as ZNPNode_ZPP_BodyListener;
            var _loc_4:* = null as ZNPNode_ZPP_BodyListener;
            var _loc_5:* = null as ZPP_BodyListener;
            var _loc_6:* = null as ZNPList_ZPP_BodyListener;
            var _loc_7:* = null as ZNPNode_ZPP_BodyListener;
            var _loc_8:* = false;
            var _loc_9:* = null as ZNPNode_ZPP_CbSet;
            var _loc_10:* = null as ZPP_CbSet;
            options.handler = cbtype_change;
            var _loc_1:* = options.includes.head;
            while (_loc_1 != null)
            {
                
                _loc_2 = _loc_1.elt;
                _loc_3 = null;
                _loc_4 = _loc_2.bodylisteners.head;
                while (_loc_4 != null)
                {
                    
                    _loc_5 = _loc_4.elt;
                    if (precedence <= _loc_5.precedence)
                    {
                        if (precedence == _loc_5.precedence)
                        {
                        }
                    }
                    if (id > _loc_5.id)
                    {
                        break;
                    }
                    _loc_3 = _loc_4;
                    _loc_4 = _loc_4.next;
                }
                _loc_6 = _loc_2.bodylisteners;
                if (ZNPNode_ZPP_BodyListener.zpp_pool == null)
                {
                    _loc_7 = new ZNPNode_ZPP_BodyListener();
                }
                else
                {
                    _loc_7 = ZNPNode_ZPP_BodyListener.zpp_pool;
                    ZNPNode_ZPP_BodyListener.zpp_pool = _loc_7.next;
                    _loc_7.next = null;
                }
                _loc_7.elt = this;
                _loc_4 = _loc_7;
                if (_loc_3 == null)
                {
                    _loc_4.next = _loc_6.head;
                    _loc_6.head = _loc_4;
                }
                else
                {
                    _loc_4.next = _loc_3.next;
                    _loc_3.next = _loc_4;
                }
                _loc_8 = true;
                _loc_6.modified = _loc_8;
                _loc_6.pushmod = _loc_8;
                (_loc_6.length + 1);
                _loc_9 = _loc_2.cbsets.head;
                while (_loc_9 != null)
                {
                    
                    _loc_10 = _loc_9.elt;
                    _loc_10.zip_bodylisteners = true;
                    _loc_9 = _loc_9.next;
                }
                _loc_1 = _loc_1.next;
            }
            return;
        }// end function

    }
}
