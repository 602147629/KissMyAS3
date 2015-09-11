package nape.callbacks
{
    import flash.*;
    import nape.space.*;
    import zpp_nape.callbacks.*;
    import zpp_nape.space.*;
    import zpp_nape.util.*;

    public class Listener extends Object
    {
        public var zpp_inner:ZPP_Listener;

        public function Listener() : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            zpp_inner = null;
            if (!ZPP_Listener.internal)
            {
                throw "Error: Cannot instantiate Listener derp!";
            }
            return;
        }// end function

        public function toString() : String
        {
            var _loc_2:* = null as ZPP_BodyListener;
            var _loc_3:* = null as ZPP_ConstraintListener;
            var _loc_4:* = null as ZPP_InteractionListener;
            var _loc_5:* = null as String;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_1:* = ["BEGIN", "END", "WAKE", "SLEEP", "BREAK", "PRE", "ONGOING"][zpp_inner.event];
            if (zpp_inner.type == ZPP_Flags.id_ListenerType_BODY)
            {
                _loc_2 = zpp_inner.body;
                return "BodyListener{" + _loc_1 + "::" + Std.string(_loc_2.outer_zn.zpp_inner_zn.options.outer) + "}";
            }
            else if (zpp_inner.type == ZPP_Flags.id_ListenerType_CONSTRAINT)
            {
                _loc_3 = zpp_inner.constraint;
                return "ConstraintListener{" + _loc_1 + "::" + Std.string(_loc_3.outer_zn.zpp_inner_zn.options.outer) + "}";
            }
            else
            {
                _loc_4 = zpp_inner.interaction;
                _loc_6 = _loc_4.itype;
                _loc_7 = _loc_6;
                if (_loc_7 == ZPP_Flags.id_InteractionType_COLLISION)
                {
                    _loc_5 = "COLLISION";
                }
                else if (_loc_7 == ZPP_Flags.id_InteractionType_SENSOR)
                {
                    _loc_5 = "SENSOR";
                }
                else if (_loc_7 == ZPP_Flags.id_InteractionType_FLUID)
                {
                    _loc_5 = "FLUID";
                }
                else
                {
                    _loc_5 = "ALL";
                }
                return (zpp_inner.type == ZPP_Flags.id_ListenerType_INTERACTION ? ("InteractionListener{" + _loc_1 + "#" + _loc_5 + "::" + Std.string(_loc_4.outer_zni.zpp_inner_zn.options1.outer) + ":" + Std.string(_loc_4.outer_zni.zpp_inner_zn.options2.outer) + "}") : ("PreListener{" + _loc_5 + "::" + Std.string(_loc_4.outer_znp.zpp_inner_zn.options1.outer) + ":" + Std.string(_loc_4.outer_znp.zpp_inner_zn.options2.outer) + "}")) + " precedence=" + zpp_inner.precedence;
            }
        }// end function

        public function set_space(param1:Space) : Space
        {
            var _loc_2:* = null as ListenerList;
            if ((zpp_inner.space == null ? (null) : (zpp_inner.space.outer)) != param1)
            {
                if (zpp_inner.space != null)
                {
                    zpp_inner.space.outer.zpp_inner.wrap_listeners.remove(this);
                }
                if (param1 != null)
                {
                    _loc_2 = param1.zpp_inner.wrap_listeners;
                    if (_loc_2.zpp_inner.reverse_flag)
                    {
                        _loc_2.push(this);
                    }
                    else
                    {
                        _loc_2.unshift(this);
                    }
                }
                else
                {
                    zpp_inner.space = null;
                }
            }
            if (zpp_inner.space == null)
            {
                return null;
            }
            else
            {
                return zpp_inner.space.outer;
            }
        }// end function

        public function set_precedence(param1:int) : int
        {
            if (zpp_inner.precedence != param1)
            {
                zpp_inner.precedence = param1;
                zpp_inner.invalidate_precedence();
            }
            return zpp_inner.precedence;
        }// end function

        public function set_event(event:CbEvent) : CbEvent
        {
            var _loc_2:* = 0;
            if (event == null)
            {
                throw "Error: Cannot set listener event type to null";
            }
            if (ZPP_Listener.events[zpp_inner.event] != event)
            {
                if (ZPP_Flags.CbEvent_BEGIN == null)
                {
                    ZPP_Flags.internal = true;
                    ZPP_Flags.CbEvent_BEGIN = new CbEvent();
                    ZPP_Flags.internal = false;
                }
                if (event == ZPP_Flags.CbEvent_BEGIN)
                {
                    _loc_2 = ZPP_Flags.id_CbEvent_BEGIN;
                }
                else
                {
                    if (ZPP_Flags.CbEvent_ONGOING == null)
                    {
                        ZPP_Flags.internal = true;
                        ZPP_Flags.CbEvent_ONGOING = new CbEvent();
                        ZPP_Flags.internal = false;
                    }
                    if (event == ZPP_Flags.CbEvent_ONGOING)
                    {
                        _loc_2 = ZPP_Flags.id_CbEvent_ONGOING;
                    }
                    else
                    {
                        if (ZPP_Flags.CbEvent_END == null)
                        {
                            ZPP_Flags.internal = true;
                            ZPP_Flags.CbEvent_END = new CbEvent();
                            ZPP_Flags.internal = false;
                        }
                        if (event == ZPP_Flags.CbEvent_END)
                        {
                            _loc_2 = ZPP_Flags.id_CbEvent_END;
                        }
                        else
                        {
                            if (ZPP_Flags.CbEvent_SLEEP == null)
                            {
                                ZPP_Flags.internal = true;
                                ZPP_Flags.CbEvent_SLEEP = new CbEvent();
                                ZPP_Flags.internal = false;
                            }
                            if (event == ZPP_Flags.CbEvent_SLEEP)
                            {
                                _loc_2 = ZPP_Flags.id_CbEvent_SLEEP;
                            }
                            else
                            {
                                if (ZPP_Flags.CbEvent_WAKE == null)
                                {
                                    ZPP_Flags.internal = true;
                                    ZPP_Flags.CbEvent_WAKE = new CbEvent();
                                    ZPP_Flags.internal = false;
                                }
                                if (event == ZPP_Flags.CbEvent_WAKE)
                                {
                                    _loc_2 = ZPP_Flags.id_CbEvent_WAKE;
                                }
                                else
                                {
                                    if (ZPP_Flags.CbEvent_PRE == null)
                                    {
                                        ZPP_Flags.internal = true;
                                        ZPP_Flags.CbEvent_PRE = new CbEvent();
                                        ZPP_Flags.internal = false;
                                    }
                                    if (event == ZPP_Flags.CbEvent_PRE)
                                    {
                                        _loc_2 = ZPP_Flags.id_CbEvent_PRE;
                                    }
                                    else
                                    {
                                        _loc_2 = ZPP_Flags.id_CbEvent_BREAK;
                                    }
                                }
                            }
                        }
                    }
                }
                zpp_inner.swapEvent(_loc_2);
            }
            return ZPP_Listener.events[zpp_inner.event];
        }// end function

        public function get_type() : ListenerType
        {
            return ZPP_Listener.types[zpp_inner.type];
        }// end function

        public function get_space() : Space
        {
            if (zpp_inner.space == null)
            {
                return null;
            }
            else
            {
                return zpp_inner.space.outer;
            }
        }// end function

        public function get_precedence() : int
        {
            return zpp_inner.precedence;
        }// end function

        public function get_event() : CbEvent
        {
            return ZPP_Listener.events[zpp_inner.event];
        }// end function

    }
}
