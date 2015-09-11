package nape.callbacks
{
    import flash.*;
    import zpp_nape.callbacks.*;
    import zpp_nape.util.*;

    final public class ConstraintListener extends Listener
    {
        public var zpp_inner_zn:ZPP_ConstraintListener;

        public function ConstraintListener(event:CbEvent = undefined, param2 = undefined, param3:Function = undefined, param4:int = 0) : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            zpp_inner_zn = null;
            ZPP_Listener.internal = true;
            ZPP_Listener.internal = false;
            if (param3 == null)
            {
                throw "Error: ConstraintListener::handler cannot be null";
            }
            var _loc_5:* = -1;
            if (ZPP_Flags.CbEvent_WAKE == null)
            {
                ZPP_Flags.internal = true;
                ZPP_Flags.CbEvent_WAKE = new CbEvent();
                ZPP_Flags.internal = false;
            }
            if (event == ZPP_Flags.CbEvent_WAKE)
            {
                _loc_5 = ZPP_Flags.id_CbEvent_WAKE;
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
                    _loc_5 = ZPP_Flags.id_CbEvent_SLEEP;
                }
                else
                {
                    if (ZPP_Flags.CbEvent_BREAK == null)
                    {
                        ZPP_Flags.internal = true;
                        ZPP_Flags.CbEvent_BREAK = new CbEvent();
                        ZPP_Flags.internal = false;
                    }
                    if (event == ZPP_Flags.CbEvent_BREAK)
                    {
                        _loc_5 = ZPP_Flags.id_CbEvent_BREAK;
                    }
                    else
                    {
                        throw "Error: cbEvent \'" + event.toString() + "\' is not a valid event type for a ConstraintListener";
                    }
                }
            }
            zpp_inner_zn = new ZPP_ConstraintListener(ZPP_OptionType.argument(param2), _loc_5, param3);
            zpp_inner = zpp_inner_zn;
            zpp_inner.outer = this;
            zpp_inner_zn.outer_zn = this;
            zpp_inner.precedence = param4;
            return;
        }// end function

        public function set_options(param1:OptionType) : OptionType
        {
            zpp_inner_zn.options.set(param1.zpp_inner);
            return zpp_inner_zn.options.outer;
        }// end function

        public function set_handler(param1:Function) : Function
        {
            if (param1 == null)
            {
                throw "Error: ConstraintListener::handler cannot be null";
            }
            zpp_inner_zn.handler = param1;
            return zpp_inner_zn.handler;
        }// end function

        public function get_options() : OptionType
        {
            return zpp_inner_zn.options.outer;
        }// end function

        public function get_handler() : Function
        {
            return zpp_inner_zn.handler;
        }// end function

    }
}
