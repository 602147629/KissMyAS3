package nape.callbacks
{
    import flash.*;
    import zpp_nape.util.*;

    final public class InteractionType extends Object
    {

        public function InteractionType() : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            if (!ZPP_Flags.internal)
            {
                throw "Error: Cannot instantiate " + "InteractionType" + " derp!";
            }
            return;
        }// end function

        public function toString() : String
        {
            if (ZPP_Flags.InteractionType_COLLISION == null)
            {
                ZPP_Flags.internal = true;
                ZPP_Flags.InteractionType_COLLISION = new InteractionType();
                ZPP_Flags.internal = false;
            }
            if (ZPP_Flags.InteractionType_COLLISION == this)
            {
                return "COLLISION";
            }
            else
            {
                if (ZPP_Flags.InteractionType_SENSOR == null)
                {
                    ZPP_Flags.internal = true;
                    ZPP_Flags.InteractionType_SENSOR = new InteractionType();
                    ZPP_Flags.internal = false;
                }
                if (ZPP_Flags.InteractionType_SENSOR == this)
                {
                    return "SENSOR";
                }
                else
                {
                    if (ZPP_Flags.InteractionType_FLUID == null)
                    {
                        ZPP_Flags.internal = true;
                        ZPP_Flags.InteractionType_FLUID = new InteractionType();
                        ZPP_Flags.internal = false;
                    }
                    if (ZPP_Flags.InteractionType_FLUID == this)
                    {
                        return "FLUID";
                    }
                    else
                    {
                        if (ZPP_Flags.InteractionType_ANY == null)
                        {
                            ZPP_Flags.internal = true;
                            ZPP_Flags.InteractionType_ANY = new InteractionType();
                            ZPP_Flags.internal = false;
                        }
                        if (ZPP_Flags.InteractionType_ANY == this)
                        {
                            return "ANY";
                        }
                        else
                        {
                            return "";
                        }
                    }
                }
            }
        }// end function

        public static function get_COLLISION() : InteractionType
        {
            if (ZPP_Flags.InteractionType_COLLISION == null)
            {
                ZPP_Flags.internal = true;
                ZPP_Flags.InteractionType_COLLISION = new InteractionType();
                ZPP_Flags.internal = false;
            }
            return ZPP_Flags.InteractionType_COLLISION;
        }// end function

        public static function get_SENSOR() : InteractionType
        {
            if (ZPP_Flags.InteractionType_SENSOR == null)
            {
                ZPP_Flags.internal = true;
                ZPP_Flags.InteractionType_SENSOR = new InteractionType();
                ZPP_Flags.internal = false;
            }
            return ZPP_Flags.InteractionType_SENSOR;
        }// end function

        public static function get_FLUID() : InteractionType
        {
            if (ZPP_Flags.InteractionType_FLUID == null)
            {
                ZPP_Flags.internal = true;
                ZPP_Flags.InteractionType_FLUID = new InteractionType();
                ZPP_Flags.internal = false;
            }
            return ZPP_Flags.InteractionType_FLUID;
        }// end function

        public static function get_ANY() : InteractionType
        {
            if (ZPP_Flags.InteractionType_ANY == null)
            {
                ZPP_Flags.internal = true;
                ZPP_Flags.InteractionType_ANY = new InteractionType();
                ZPP_Flags.internal = false;
            }
            return ZPP_Flags.InteractionType_ANY;
        }// end function

    }
}
