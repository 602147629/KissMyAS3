package nape.callbacks
{
    import flash.*;
    import zpp_nape.util.*;

    final public class CbEvent extends Object
    {

        public function CbEvent() : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            if (!ZPP_Flags.internal)
            {
                throw "Error: Cannot instantiate " + "CbEvent" + " derp!";
            }
            return;
        }// end function

        public function toString() : String
        {
            if (ZPP_Flags.CbEvent_PRE == null)
            {
                ZPP_Flags.internal = true;
                ZPP_Flags.CbEvent_PRE = new CbEvent();
                ZPP_Flags.internal = false;
            }
            if (ZPP_Flags.CbEvent_PRE == this)
            {
                return "PRE";
            }
            else
            {
                if (ZPP_Flags.CbEvent_BEGIN == null)
                {
                    ZPP_Flags.internal = true;
                    ZPP_Flags.CbEvent_BEGIN = new CbEvent();
                    ZPP_Flags.internal = false;
                }
                if (ZPP_Flags.CbEvent_BEGIN == this)
                {
                    return "BEGIN";
                }
                else
                {
                    if (ZPP_Flags.CbEvent_ONGOING == null)
                    {
                        ZPP_Flags.internal = true;
                        ZPP_Flags.CbEvent_ONGOING = new CbEvent();
                        ZPP_Flags.internal = false;
                    }
                    if (ZPP_Flags.CbEvent_ONGOING == this)
                    {
                        return "ONGOING";
                    }
                    else
                    {
                        if (ZPP_Flags.CbEvent_END == null)
                        {
                            ZPP_Flags.internal = true;
                            ZPP_Flags.CbEvent_END = new CbEvent();
                            ZPP_Flags.internal = false;
                        }
                        if (ZPP_Flags.CbEvent_END == this)
                        {
                            return "END";
                        }
                        else
                        {
                            if (ZPP_Flags.CbEvent_WAKE == null)
                            {
                                ZPP_Flags.internal = true;
                                ZPP_Flags.CbEvent_WAKE = new CbEvent();
                                ZPP_Flags.internal = false;
                            }
                            if (ZPP_Flags.CbEvent_WAKE == this)
                            {
                                return "WAKE";
                            }
                            else
                            {
                                if (ZPP_Flags.CbEvent_SLEEP == null)
                                {
                                    ZPP_Flags.internal = true;
                                    ZPP_Flags.CbEvent_SLEEP = new CbEvent();
                                    ZPP_Flags.internal = false;
                                }
                                if (ZPP_Flags.CbEvent_SLEEP == this)
                                {
                                    return "SLEEP";
                                }
                                else
                                {
                                    if (ZPP_Flags.CbEvent_BREAK == null)
                                    {
                                        ZPP_Flags.internal = true;
                                        ZPP_Flags.CbEvent_BREAK = new CbEvent();
                                        ZPP_Flags.internal = false;
                                    }
                                    if (ZPP_Flags.CbEvent_BREAK == this)
                                    {
                                        return "BREAK";
                                    }
                                    else
                                    {
                                        return "";
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }// end function

        public static function get_BEGIN() : CbEvent
        {
            if (ZPP_Flags.CbEvent_BEGIN == null)
            {
                ZPP_Flags.internal = true;
                ZPP_Flags.CbEvent_BEGIN = new CbEvent();
                ZPP_Flags.internal = false;
            }
            return ZPP_Flags.CbEvent_BEGIN;
        }// end function

        public static function get_ONGOING() : CbEvent
        {
            if (ZPP_Flags.CbEvent_ONGOING == null)
            {
                ZPP_Flags.internal = true;
                ZPP_Flags.CbEvent_ONGOING = new CbEvent();
                ZPP_Flags.internal = false;
            }
            return ZPP_Flags.CbEvent_ONGOING;
        }// end function

        public static function get_END() : CbEvent
        {
            if (ZPP_Flags.CbEvent_END == null)
            {
                ZPP_Flags.internal = true;
                ZPP_Flags.CbEvent_END = new CbEvent();
                ZPP_Flags.internal = false;
            }
            return ZPP_Flags.CbEvent_END;
        }// end function

        public static function get_WAKE() : CbEvent
        {
            if (ZPP_Flags.CbEvent_WAKE == null)
            {
                ZPP_Flags.internal = true;
                ZPP_Flags.CbEvent_WAKE = new CbEvent();
                ZPP_Flags.internal = false;
            }
            return ZPP_Flags.CbEvent_WAKE;
        }// end function

        public static function get_SLEEP() : CbEvent
        {
            if (ZPP_Flags.CbEvent_SLEEP == null)
            {
                ZPP_Flags.internal = true;
                ZPP_Flags.CbEvent_SLEEP = new CbEvent();
                ZPP_Flags.internal = false;
            }
            return ZPP_Flags.CbEvent_SLEEP;
        }// end function

        public static function get_BREAK() : CbEvent
        {
            if (ZPP_Flags.CbEvent_BREAK == null)
            {
                ZPP_Flags.internal = true;
                ZPP_Flags.CbEvent_BREAK = new CbEvent();
                ZPP_Flags.internal = false;
            }
            return ZPP_Flags.CbEvent_BREAK;
        }// end function

        public static function get_PRE() : CbEvent
        {
            if (ZPP_Flags.CbEvent_PRE == null)
            {
                ZPP_Flags.internal = true;
                ZPP_Flags.CbEvent_PRE = new CbEvent();
                ZPP_Flags.internal = false;
            }
            return ZPP_Flags.CbEvent_PRE;
        }// end function

    }
}
