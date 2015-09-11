package nape.phys
{
    import flash.*;
    import zpp_nape.util.*;

    final public class BodyType extends Object
    {

        public function BodyType() : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            if (!ZPP_Flags.internal)
            {
                throw "Error: Cannot instantiate " + "BodyType" + " derp!";
            }
            return;
        }// end function

        public function toString() : String
        {
            if (ZPP_Flags.BodyType_STATIC == null)
            {
                ZPP_Flags.internal = true;
                ZPP_Flags.BodyType_STATIC = new BodyType();
                ZPP_Flags.internal = false;
            }
            if (ZPP_Flags.BodyType_STATIC == this)
            {
                return "STATIC";
            }
            else
            {
                if (ZPP_Flags.BodyType_DYNAMIC == null)
                {
                    ZPP_Flags.internal = true;
                    ZPP_Flags.BodyType_DYNAMIC = new BodyType();
                    ZPP_Flags.internal = false;
                }
                if (ZPP_Flags.BodyType_DYNAMIC == this)
                {
                    return "DYNAMIC";
                }
                else
                {
                    if (ZPP_Flags.BodyType_KINEMATIC == null)
                    {
                        ZPP_Flags.internal = true;
                        ZPP_Flags.BodyType_KINEMATIC = new BodyType();
                        ZPP_Flags.internal = false;
                    }
                    if (ZPP_Flags.BodyType_KINEMATIC == this)
                    {
                        return "KINEMATIC";
                    }
                    else
                    {
                        return "";
                    }
                }
            }
        }// end function

        public static function get_STATIC() : BodyType
        {
            if (ZPP_Flags.BodyType_STATIC == null)
            {
                ZPP_Flags.internal = true;
                ZPP_Flags.BodyType_STATIC = new BodyType();
                ZPP_Flags.internal = false;
            }
            return ZPP_Flags.BodyType_STATIC;
        }// end function

        public static function get_DYNAMIC() : BodyType
        {
            if (ZPP_Flags.BodyType_DYNAMIC == null)
            {
                ZPP_Flags.internal = true;
                ZPP_Flags.BodyType_DYNAMIC = new BodyType();
                ZPP_Flags.internal = false;
            }
            return ZPP_Flags.BodyType_DYNAMIC;
        }// end function

        public static function get_KINEMATIC() : BodyType
        {
            if (ZPP_Flags.BodyType_KINEMATIC == null)
            {
                ZPP_Flags.internal = true;
                ZPP_Flags.BodyType_KINEMATIC = new BodyType();
                ZPP_Flags.internal = false;
            }
            return ZPP_Flags.BodyType_KINEMATIC;
        }// end function

    }
}
