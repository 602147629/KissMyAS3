package nape.dynamics
{
    import flash.*;
    import zpp_nape.util.*;

    final public class ArbiterType extends Object
    {

        public function ArbiterType() : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            if (!ZPP_Flags.internal)
            {
                throw "Error: Cannot instantiate " + "ArbiterType" + " derp!";
            }
            return;
        }// end function

        public function toString() : String
        {
            if (ZPP_Flags.ArbiterType_COLLISION == null)
            {
                ZPP_Flags.internal = true;
                ZPP_Flags.ArbiterType_COLLISION = new ArbiterType();
                ZPP_Flags.internal = false;
            }
            if (ZPP_Flags.ArbiterType_COLLISION == this)
            {
                return "COLLISION";
            }
            else
            {
                if (ZPP_Flags.ArbiterType_SENSOR == null)
                {
                    ZPP_Flags.internal = true;
                    ZPP_Flags.ArbiterType_SENSOR = new ArbiterType();
                    ZPP_Flags.internal = false;
                }
                if (ZPP_Flags.ArbiterType_SENSOR == this)
                {
                    return "SENSOR";
                }
                else
                {
                    if (ZPP_Flags.ArbiterType_FLUID == null)
                    {
                        ZPP_Flags.internal = true;
                        ZPP_Flags.ArbiterType_FLUID = new ArbiterType();
                        ZPP_Flags.internal = false;
                    }
                    if (ZPP_Flags.ArbiterType_FLUID == this)
                    {
                        return "FLUID";
                    }
                    else
                    {
                        return "";
                    }
                }
            }
        }// end function

        public static function get_COLLISION() : ArbiterType
        {
            if (ZPP_Flags.ArbiterType_COLLISION == null)
            {
                ZPP_Flags.internal = true;
                ZPP_Flags.ArbiterType_COLLISION = new ArbiterType();
                ZPP_Flags.internal = false;
            }
            return ZPP_Flags.ArbiterType_COLLISION;
        }// end function

        public static function get_SENSOR() : ArbiterType
        {
            if (ZPP_Flags.ArbiterType_SENSOR == null)
            {
                ZPP_Flags.internal = true;
                ZPP_Flags.ArbiterType_SENSOR = new ArbiterType();
                ZPP_Flags.internal = false;
            }
            return ZPP_Flags.ArbiterType_SENSOR;
        }// end function

        public static function get_FLUID() : ArbiterType
        {
            if (ZPP_Flags.ArbiterType_FLUID == null)
            {
                ZPP_Flags.internal = true;
                ZPP_Flags.ArbiterType_FLUID = new ArbiterType();
                ZPP_Flags.internal = false;
            }
            return ZPP_Flags.ArbiterType_FLUID;
        }// end function

    }
}
