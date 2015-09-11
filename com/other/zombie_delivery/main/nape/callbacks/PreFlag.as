package nape.callbacks
{
    import flash.*;
    import zpp_nape.util.*;

    final public class PreFlag extends Object
    {

        public function PreFlag() : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            if (!ZPP_Flags.internal)
            {
                throw "Error: Cannot instantiate " + "PreFlag" + " derp!";
            }
            return;
        }// end function

        public function toString() : String
        {
            if (ZPP_Flags.PreFlag_ACCEPT == null)
            {
                ZPP_Flags.internal = true;
                ZPP_Flags.PreFlag_ACCEPT = new PreFlag();
                ZPP_Flags.internal = false;
            }
            if (ZPP_Flags.PreFlag_ACCEPT == this)
            {
                return "ACCEPT";
            }
            else
            {
                if (ZPP_Flags.PreFlag_IGNORE == null)
                {
                    ZPP_Flags.internal = true;
                    ZPP_Flags.PreFlag_IGNORE = new PreFlag();
                    ZPP_Flags.internal = false;
                }
                if (ZPP_Flags.PreFlag_IGNORE == this)
                {
                    return "IGNORE";
                }
                else
                {
                    if (ZPP_Flags.PreFlag_ACCEPT_ONCE == null)
                    {
                        ZPP_Flags.internal = true;
                        ZPP_Flags.PreFlag_ACCEPT_ONCE = new PreFlag();
                        ZPP_Flags.internal = false;
                    }
                    if (ZPP_Flags.PreFlag_ACCEPT_ONCE == this)
                    {
                        return "ACCEPT_ONCE";
                    }
                    else
                    {
                        if (ZPP_Flags.PreFlag_IGNORE_ONCE == null)
                        {
                            ZPP_Flags.internal = true;
                            ZPP_Flags.PreFlag_IGNORE_ONCE = new PreFlag();
                            ZPP_Flags.internal = false;
                        }
                        if (ZPP_Flags.PreFlag_IGNORE_ONCE == this)
                        {
                            return "IGNORE_ONCE";
                        }
                        else
                        {
                            return "";
                        }
                    }
                }
            }
        }// end function

        public static function get_ACCEPT() : PreFlag
        {
            if (ZPP_Flags.PreFlag_ACCEPT == null)
            {
                ZPP_Flags.internal = true;
                ZPP_Flags.PreFlag_ACCEPT = new PreFlag();
                ZPP_Flags.internal = false;
            }
            return ZPP_Flags.PreFlag_ACCEPT;
        }// end function

        public static function get_IGNORE() : PreFlag
        {
            if (ZPP_Flags.PreFlag_IGNORE == null)
            {
                ZPP_Flags.internal = true;
                ZPP_Flags.PreFlag_IGNORE = new PreFlag();
                ZPP_Flags.internal = false;
            }
            return ZPP_Flags.PreFlag_IGNORE;
        }// end function

        public static function get_ACCEPT_ONCE() : PreFlag
        {
            if (ZPP_Flags.PreFlag_ACCEPT_ONCE == null)
            {
                ZPP_Flags.internal = true;
                ZPP_Flags.PreFlag_ACCEPT_ONCE = new PreFlag();
                ZPP_Flags.internal = false;
            }
            return ZPP_Flags.PreFlag_ACCEPT_ONCE;
        }// end function

        public static function get_IGNORE_ONCE() : PreFlag
        {
            if (ZPP_Flags.PreFlag_IGNORE_ONCE == null)
            {
                ZPP_Flags.internal = true;
                ZPP_Flags.PreFlag_IGNORE_ONCE = new PreFlag();
                ZPP_Flags.internal = false;
            }
            return ZPP_Flags.PreFlag_IGNORE_ONCE;
        }// end function

    }
}
