package nape.callbacks
{
    import flash.*;
    import zpp_nape.callbacks.*;
    import zpp_nape.util.*;

    final public class InteractionListener extends Listener
    {
        public var zpp_inner_zn:ZPP_InteractionListener;

        public function InteractionListener(event:CbEvent = undefined, param2:InteractionType = undefined, param3 = undefined, param4 = undefined, param5:Function = undefined, param6:int = 0) : void
        {
            var _loc_8:* = 0;
            if (Boot.skip_constructor)
            {
                return;
            }
            zpp_inner_zn = null;
            ZPP_Listener.internal = true;
            ZPP_Listener.internal = false;
            if (param5 == null)
            {
                throw "Error: InteractionListener::handler cannot be null";
            }
            if (event == null)
            {
                throw "Error: CbEvent cannot be null for InteractionListener";
            }
            var _loc_7:* = -1;
            if (ZPP_Flags.CbEvent_BEGIN == null)
            {
                ZPP_Flags.internal = true;
                ZPP_Flags.CbEvent_BEGIN = new CbEvent();
                ZPP_Flags.internal = false;
            }
            if (event == ZPP_Flags.CbEvent_BEGIN)
            {
                _loc_7 = ZPP_Flags.id_CbEvent_BEGIN;
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
                    _loc_7 = ZPP_Flags.id_CbEvent_END;
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
                        _loc_7 = ZPP_Flags.id_CbEvent_ONGOING;
                    }
                    else
                    {
                        throw "Error: CbEvent \'" + event.toString() + "\' is not a valid event type for InteractionListener";
                    }
                }
            }
            zpp_inner_zn = new ZPP_InteractionListener(ZPP_OptionType.argument(param3), ZPP_OptionType.argument(param4), _loc_7, ZPP_Flags.id_ListenerType_INTERACTION);
            zpp_inner = zpp_inner_zn;
            zpp_inner.outer = this;
            zpp_inner_zn.outer_zni = this;
            zpp_inner.precedence = param6;
            zpp_inner_zn.handleri = param5;
            if (param2 == null)
            {
                throw "Error: Cannot set listener interaction type to null";
            }
            _loc_8 = zpp_inner_zn.itype;
            if (ZPP_Flags.InteractionType_COLLISION == null)
            {
            }
            if (ZPP_Flags.InteractionType_SENSOR == null)
            {
            }
            if (ZPP_Flags.InteractionType_FLUID == null)
            {
            }
            if (ZPP_Flags.InteractionType_ANY == null)
            {
            }
            if ((_loc_8 == ZPP_Flags.id_InteractionType_COLLISION ? (if (!(ZPP_Flags.InteractionType_COLLISION == null)) goto 463, ZPP_Flags.internal = true, ZPP_Flags.InteractionType_COLLISION = new InteractionType(), ZPP_Flags.internal = false, ZPP_Flags.InteractionType_COLLISION) : (_loc_8 == ZPP_Flags.id_InteractionType_SENSOR ? (if (!(ZPP_Flags.InteractionType_SENSOR == null)) goto 526, ZPP_Flags.internal = true, ZPP_Flags.InteractionType_SENSOR = new InteractionType(), ZPP_Flags.internal = false, ZPP_Flags.InteractionType_SENSOR) : (_loc_8 == ZPP_Flags.id_InteractionType_FLUID ? (if (!(ZPP_Flags.InteractionType_FLUID == null)) goto 589, ZPP_Flags.internal = true, ZPP_Flags.InteractionType_FLUID = new InteractionType(), ZPP_Flags.internal = false, ZPP_Flags.InteractionType_FLUID) : (_loc_8 == ZPP_Flags.id_InteractionType_ANY ? (if (!(ZPP_Flags.InteractionType_ANY == null)) goto 652, ZPP_Flags.internal = true, ZPP_Flags.InteractionType_ANY = new InteractionType(), ZPP_Flags.internal = false, ZPP_Flags.InteractionType_ANY) : (null))))) != param2)
            {
                if (ZPP_Flags.InteractionType_COLLISION == null)
                {
                    ZPP_Flags.internal = true;
                    ZPP_Flags.InteractionType_COLLISION = new InteractionType();
                    ZPP_Flags.internal = false;
                }
                if (param2 == ZPP_Flags.InteractionType_COLLISION)
                {
                    _loc_8 = ZPP_Flags.id_InteractionType_COLLISION;
                }
                else
                {
                    if (ZPP_Flags.InteractionType_SENSOR == null)
                    {
                        ZPP_Flags.internal = true;
                        ZPP_Flags.InteractionType_SENSOR = new InteractionType();
                        ZPP_Flags.internal = false;
                    }
                    if (param2 == ZPP_Flags.InteractionType_SENSOR)
                    {
                        _loc_8 = ZPP_Flags.id_InteractionType_SENSOR;
                    }
                    else
                    {
                        if (ZPP_Flags.InteractionType_FLUID == null)
                        {
                            ZPP_Flags.internal = true;
                            ZPP_Flags.InteractionType_FLUID = new InteractionType();
                            ZPP_Flags.internal = false;
                        }
                        if (param2 == ZPP_Flags.InteractionType_FLUID)
                        {
                            _loc_8 = ZPP_Flags.id_InteractionType_FLUID;
                        }
                        else
                        {
                            _loc_8 = ZPP_Flags.id_InteractionType_ANY;
                        }
                    }
                }
                zpp_inner_zn.itype = _loc_8;
            }
            _loc_8 = zpp_inner_zn.itype;
            if (_loc_8 == ZPP_Flags.id_InteractionType_COLLISION)
            {
                if (ZPP_Flags.InteractionType_COLLISION == null)
                {
                    ZPP_Flags.internal = true;
                    ZPP_Flags.InteractionType_COLLISION = new InteractionType();
                    ZPP_Flags.internal = false;
                }
            }
            else if (_loc_8 == ZPP_Flags.id_InteractionType_SENSOR)
            {
                if (ZPP_Flags.InteractionType_SENSOR == null)
                {
                    ZPP_Flags.internal = true;
                    ZPP_Flags.InteractionType_SENSOR = new InteractionType();
                    ZPP_Flags.internal = false;
                }
            }
            else if (_loc_8 == ZPP_Flags.id_InteractionType_FLUID)
            {
                if (ZPP_Flags.InteractionType_FLUID == null)
                {
                    ZPP_Flags.internal = true;
                    ZPP_Flags.InteractionType_FLUID = new InteractionType();
                    ZPP_Flags.internal = false;
                }
            }
            else if (_loc_8 == ZPP_Flags.id_InteractionType_ANY)
            {
                if (ZPP_Flags.InteractionType_ANY == null)
                {
                    ZPP_Flags.internal = true;
                    ZPP_Flags.InteractionType_ANY = new InteractionType();
                    ZPP_Flags.internal = false;
                }
            }
            else
            {
            }
            return;
        }// end function

        public function set_options2(param1:OptionType) : OptionType
        {
            zpp_inner_zn.options2.set(param1.zpp_inner);
            return zpp_inner_zn.options2.outer;
        }// end function

        public function set_options1(param1:OptionType) : OptionType
        {
            zpp_inner_zn.options1.set(param1.zpp_inner);
            return zpp_inner_zn.options1.outer;
        }// end function

        public function set_interactionType(param1:InteractionType) : InteractionType
        {
            var _loc_2:* = 0;
            if (param1 == null)
            {
                throw "Error: Cannot set listener interaction type to null";
            }
            _loc_2 = zpp_inner_zn.itype;
            if (ZPP_Flags.InteractionType_COLLISION == null)
            {
            }
            if (ZPP_Flags.InteractionType_SENSOR == null)
            {
            }
            if (ZPP_Flags.InteractionType_FLUID == null)
            {
            }
            if (ZPP_Flags.InteractionType_ANY == null)
            {
            }
            if ((_loc_2 == ZPP_Flags.id_InteractionType_COLLISION ? (if (!(ZPP_Flags.InteractionType_COLLISION == null)) goto 81, ZPP_Flags.internal = true, ZPP_Flags.InteractionType_COLLISION = new InteractionType(), ZPP_Flags.internal = false, ZPP_Flags.InteractionType_COLLISION) : (_loc_2 == ZPP_Flags.id_InteractionType_SENSOR ? (if (!(ZPP_Flags.InteractionType_SENSOR == null)) goto 143, ZPP_Flags.internal = true, ZPP_Flags.InteractionType_SENSOR = new InteractionType(), ZPP_Flags.internal = false, ZPP_Flags.InteractionType_SENSOR) : (_loc_2 == ZPP_Flags.id_InteractionType_FLUID ? (if (!(ZPP_Flags.InteractionType_FLUID == null)) goto 205, ZPP_Flags.internal = true, ZPP_Flags.InteractionType_FLUID = new InteractionType(), ZPP_Flags.internal = false, ZPP_Flags.InteractionType_FLUID) : (_loc_2 == ZPP_Flags.id_InteractionType_ANY ? (if (!(ZPP_Flags.InteractionType_ANY == null)) goto 267, ZPP_Flags.internal = true, ZPP_Flags.InteractionType_ANY = new InteractionType(), ZPP_Flags.internal = false, ZPP_Flags.InteractionType_ANY) : (null))))) != param1)
            {
                if (ZPP_Flags.InteractionType_COLLISION == null)
                {
                    ZPP_Flags.internal = true;
                    ZPP_Flags.InteractionType_COLLISION = new InteractionType();
                    ZPP_Flags.internal = false;
                }
                if (param1 == ZPP_Flags.InteractionType_COLLISION)
                {
                    _loc_2 = ZPP_Flags.id_InteractionType_COLLISION;
                }
                else
                {
                    if (ZPP_Flags.InteractionType_SENSOR == null)
                    {
                        ZPP_Flags.internal = true;
                        ZPP_Flags.InteractionType_SENSOR = new InteractionType();
                        ZPP_Flags.internal = false;
                    }
                    if (param1 == ZPP_Flags.InteractionType_SENSOR)
                    {
                        _loc_2 = ZPP_Flags.id_InteractionType_SENSOR;
                    }
                    else
                    {
                        if (ZPP_Flags.InteractionType_FLUID == null)
                        {
                            ZPP_Flags.internal = true;
                            ZPP_Flags.InteractionType_FLUID = new InteractionType();
                            ZPP_Flags.internal = false;
                        }
                        if (param1 == ZPP_Flags.InteractionType_FLUID)
                        {
                            _loc_2 = ZPP_Flags.id_InteractionType_FLUID;
                        }
                        else
                        {
                            _loc_2 = ZPP_Flags.id_InteractionType_ANY;
                        }
                    }
                }
                zpp_inner_zn.itype = _loc_2;
            }
            _loc_2 = zpp_inner_zn.itype;
            if (_loc_2 == ZPP_Flags.id_InteractionType_COLLISION)
            {
                if (ZPP_Flags.InteractionType_COLLISION == null)
                {
                    ZPP_Flags.internal = true;
                    ZPP_Flags.InteractionType_COLLISION = new InteractionType();
                    ZPP_Flags.internal = false;
                }
                return ZPP_Flags.InteractionType_COLLISION;
            }
            else if (_loc_2 == ZPP_Flags.id_InteractionType_SENSOR)
            {
                if (ZPP_Flags.InteractionType_SENSOR == null)
                {
                    ZPP_Flags.internal = true;
                    ZPP_Flags.InteractionType_SENSOR = new InteractionType();
                    ZPP_Flags.internal = false;
                }
                return ZPP_Flags.InteractionType_SENSOR;
            }
            else if (_loc_2 == ZPP_Flags.id_InteractionType_FLUID)
            {
                if (ZPP_Flags.InteractionType_FLUID == null)
                {
                    ZPP_Flags.internal = true;
                    ZPP_Flags.InteractionType_FLUID = new InteractionType();
                    ZPP_Flags.internal = false;
                }
                return ZPP_Flags.InteractionType_FLUID;
            }
            else if (_loc_2 == ZPP_Flags.id_InteractionType_ANY)
            {
                if (ZPP_Flags.InteractionType_ANY == null)
                {
                    ZPP_Flags.internal = true;
                    ZPP_Flags.InteractionType_ANY = new InteractionType();
                    ZPP_Flags.internal = false;
                }
                return ZPP_Flags.InteractionType_ANY;
            }
            else
            {
                return null;
            }
        }// end function

        public function set_handler(param1:Function) : Function
        {
            if (param1 == null)
            {
                throw "Error: InteractionListener::handler cannot be null";
            }
            zpp_inner_zn.handleri = param1;
            return zpp_inner_zn.handleri;
        }// end function

        public function set_allowSleepingCallbacks(param1:Boolean) : Boolean
        {
            zpp_inner_zn.allowSleepingCallbacks = param1;
            return zpp_inner_zn.allowSleepingCallbacks;
        }// end function

        public function get_options2() : OptionType
        {
            return zpp_inner_zn.options2.outer;
        }// end function

        public function get_options1() : OptionType
        {
            return zpp_inner_zn.options1.outer;
        }// end function

        public function get_interactionType() : InteractionType
        {
            var _loc_1:* = zpp_inner_zn.itype;
            if (_loc_1 == ZPP_Flags.id_InteractionType_COLLISION)
            {
                if (ZPP_Flags.InteractionType_COLLISION == null)
                {
                    ZPP_Flags.internal = true;
                    ZPP_Flags.InteractionType_COLLISION = new InteractionType();
                    ZPP_Flags.internal = false;
                }
                return ZPP_Flags.InteractionType_COLLISION;
            }
            else if (_loc_1 == ZPP_Flags.id_InteractionType_SENSOR)
            {
                if (ZPP_Flags.InteractionType_SENSOR == null)
                {
                    ZPP_Flags.internal = true;
                    ZPP_Flags.InteractionType_SENSOR = new InteractionType();
                    ZPP_Flags.internal = false;
                }
                return ZPP_Flags.InteractionType_SENSOR;
            }
            else if (_loc_1 == ZPP_Flags.id_InteractionType_FLUID)
            {
                if (ZPP_Flags.InteractionType_FLUID == null)
                {
                    ZPP_Flags.internal = true;
                    ZPP_Flags.InteractionType_FLUID = new InteractionType();
                    ZPP_Flags.internal = false;
                }
                return ZPP_Flags.InteractionType_FLUID;
            }
            else if (_loc_1 == ZPP_Flags.id_InteractionType_ANY)
            {
                if (ZPP_Flags.InteractionType_ANY == null)
                {
                    ZPP_Flags.internal = true;
                    ZPP_Flags.InteractionType_ANY = new InteractionType();
                    ZPP_Flags.internal = false;
                }
                return ZPP_Flags.InteractionType_ANY;
            }
            else
            {
                return null;
            }
        }// end function

        public function get_handler() : Function
        {
            return zpp_inner_zn.handleri;
        }// end function

        public function get_allowSleepingCallbacks() : Boolean
        {
            return zpp_inner_zn.allowSleepingCallbacks;
        }// end function

    }
}
