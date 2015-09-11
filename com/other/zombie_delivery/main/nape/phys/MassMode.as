package nape.phys
{
    import flash.*;
    import zpp_nape.util.*;

    final public class MassMode extends Object
    {

        public function MassMode() : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            if (!ZPP_Flags.internal)
            {
                throw "Error: Cannot instantiate " + "MassMode" + " derp!";
            }
            return;
        }// end function

        public function toString() : String
        {
            if (ZPP_Flags.MassMode_DEFAULT == null)
            {
                ZPP_Flags.internal = true;
                ZPP_Flags.MassMode_DEFAULT = new MassMode();
                ZPP_Flags.internal = false;
            }
            if (ZPP_Flags.MassMode_DEFAULT == this)
            {
                return "DEFAULT";
            }
            else
            {
                if (ZPP_Flags.MassMode_FIXED == null)
                {
                    ZPP_Flags.internal = true;
                    ZPP_Flags.MassMode_FIXED = new MassMode();
                    ZPP_Flags.internal = false;
                }
                if (ZPP_Flags.MassMode_FIXED == this)
                {
                    return "FIXED";
                }
                else
                {
                    return "";
                }
            }
        }// end function

        public static function get_DEFAULT() : MassMode
        {
            if (ZPP_Flags.MassMode_DEFAULT == null)
            {
                ZPP_Flags.internal = true;
                ZPP_Flags.MassMode_DEFAULT = new MassMode();
                ZPP_Flags.internal = false;
            }
            return ZPP_Flags.MassMode_DEFAULT;
        }// end function

        public static function get_FIXED() : MassMode
        {
            if (ZPP_Flags.MassMode_FIXED == null)
            {
                ZPP_Flags.internal = true;
                ZPP_Flags.MassMode_FIXED = new MassMode();
                ZPP_Flags.internal = false;
            }
            return ZPP_Flags.MassMode_FIXED;
        }// end function

    }
}
