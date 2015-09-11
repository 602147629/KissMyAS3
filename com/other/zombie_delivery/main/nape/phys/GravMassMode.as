package nape.phys
{
    import flash.*;
    import zpp_nape.util.*;

    final public class GravMassMode extends Object
    {

        public function GravMassMode() : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            if (!ZPP_Flags.internal)
            {
                throw "Error: Cannot instantiate " + "GravMassMode" + " derp!";
            }
            return;
        }// end function

        public function toString() : String
        {
            if (ZPP_Flags.GravMassMode_DEFAULT == null)
            {
                ZPP_Flags.internal = true;
                ZPP_Flags.GravMassMode_DEFAULT = new GravMassMode();
                ZPP_Flags.internal = false;
            }
            if (ZPP_Flags.GravMassMode_DEFAULT == this)
            {
                return "DEFAULT";
            }
            else
            {
                if (ZPP_Flags.GravMassMode_FIXED == null)
                {
                    ZPP_Flags.internal = true;
                    ZPP_Flags.GravMassMode_FIXED = new GravMassMode();
                    ZPP_Flags.internal = false;
                }
                if (ZPP_Flags.GravMassMode_FIXED == this)
                {
                    return "FIXED";
                }
                else
                {
                    if (ZPP_Flags.GravMassMode_SCALED == null)
                    {
                        ZPP_Flags.internal = true;
                        ZPP_Flags.GravMassMode_SCALED = new GravMassMode();
                        ZPP_Flags.internal = false;
                    }
                    if (ZPP_Flags.GravMassMode_SCALED == this)
                    {
                        return "SCALED";
                    }
                    else
                    {
                        return "";
                    }
                }
            }
        }// end function

        public static function get_DEFAULT() : GravMassMode
        {
            if (ZPP_Flags.GravMassMode_DEFAULT == null)
            {
                ZPP_Flags.internal = true;
                ZPP_Flags.GravMassMode_DEFAULT = new GravMassMode();
                ZPP_Flags.internal = false;
            }
            return ZPP_Flags.GravMassMode_DEFAULT;
        }// end function

        public static function get_FIXED() : GravMassMode
        {
            if (ZPP_Flags.GravMassMode_FIXED == null)
            {
                ZPP_Flags.internal = true;
                ZPP_Flags.GravMassMode_FIXED = new GravMassMode();
                ZPP_Flags.internal = false;
            }
            return ZPP_Flags.GravMassMode_FIXED;
        }// end function

        public static function get_SCALED() : GravMassMode
        {
            if (ZPP_Flags.GravMassMode_SCALED == null)
            {
                ZPP_Flags.internal = true;
                ZPP_Flags.GravMassMode_SCALED = new GravMassMode();
                ZPP_Flags.internal = false;
            }
            return ZPP_Flags.GravMassMode_SCALED;
        }// end function

    }
}
