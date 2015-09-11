package nape.phys
{
    import flash.*;
    import zpp_nape.util.*;

    final public class InertiaMode extends Object
    {

        public function InertiaMode() : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            if (!ZPP_Flags.internal)
            {
                throw "Error: Cannot instantiate " + "InertiaMode" + " derp!";
            }
            return;
        }// end function

        public function toString() : String
        {
            if (ZPP_Flags.InertiaMode_DEFAULT == null)
            {
                ZPP_Flags.internal = true;
                ZPP_Flags.InertiaMode_DEFAULT = new InertiaMode();
                ZPP_Flags.internal = false;
            }
            if (ZPP_Flags.InertiaMode_DEFAULT == this)
            {
                return "DEFAULT";
            }
            else
            {
                if (ZPP_Flags.InertiaMode_FIXED == null)
                {
                    ZPP_Flags.internal = true;
                    ZPP_Flags.InertiaMode_FIXED = new InertiaMode();
                    ZPP_Flags.internal = false;
                }
                if (ZPP_Flags.InertiaMode_FIXED == this)
                {
                    return "FIXED";
                }
                else
                {
                    return "";
                }
            }
        }// end function

        public static function get_DEFAULT() : InertiaMode
        {
            if (ZPP_Flags.InertiaMode_DEFAULT == null)
            {
                ZPP_Flags.internal = true;
                ZPP_Flags.InertiaMode_DEFAULT = new InertiaMode();
                ZPP_Flags.internal = false;
            }
            return ZPP_Flags.InertiaMode_DEFAULT;
        }// end function

        public static function get_FIXED() : InertiaMode
        {
            if (ZPP_Flags.InertiaMode_FIXED == null)
            {
                ZPP_Flags.internal = true;
                ZPP_Flags.InertiaMode_FIXED = new InertiaMode();
                ZPP_Flags.internal = false;
            }
            return ZPP_Flags.InertiaMode_FIXED;
        }// end function

    }
}
