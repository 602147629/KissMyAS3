package nape.geom
{
    import flash.*;
    import zpp_nape.util.*;

    final public class Winding extends Object
    {

        public function Winding() : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            if (!ZPP_Flags.internal)
            {
                throw "Error: Cannot instantiate " + "Winding" + " derp!";
            }
            return;
        }// end function

        public function toString() : String
        {
            if (ZPP_Flags.Winding_UNDEFINED == null)
            {
                ZPP_Flags.internal = true;
                ZPP_Flags.Winding_UNDEFINED = new Winding();
                ZPP_Flags.internal = false;
            }
            if (ZPP_Flags.Winding_UNDEFINED == this)
            {
                return "UNDEFINED";
            }
            else
            {
                if (ZPP_Flags.Winding_CLOCKWISE == null)
                {
                    ZPP_Flags.internal = true;
                    ZPP_Flags.Winding_CLOCKWISE = new Winding();
                    ZPP_Flags.internal = false;
                }
                if (ZPP_Flags.Winding_CLOCKWISE == this)
                {
                    return "CLOCKWISE";
                }
                else
                {
                    if (ZPP_Flags.Winding_ANTICLOCKWISE == null)
                    {
                        ZPP_Flags.internal = true;
                        ZPP_Flags.Winding_ANTICLOCKWISE = new Winding();
                        ZPP_Flags.internal = false;
                    }
                    if (ZPP_Flags.Winding_ANTICLOCKWISE == this)
                    {
                        return "ANTICLOCKWISE";
                    }
                    else
                    {
                        return "";
                    }
                }
            }
        }// end function

        public static function get_UNDEFINED() : Winding
        {
            if (ZPP_Flags.Winding_UNDEFINED == null)
            {
                ZPP_Flags.internal = true;
                ZPP_Flags.Winding_UNDEFINED = new Winding();
                ZPP_Flags.internal = false;
            }
            return ZPP_Flags.Winding_UNDEFINED;
        }// end function

        public static function get_CLOCKWISE() : Winding
        {
            if (ZPP_Flags.Winding_CLOCKWISE == null)
            {
                ZPP_Flags.internal = true;
                ZPP_Flags.Winding_CLOCKWISE = new Winding();
                ZPP_Flags.internal = false;
            }
            return ZPP_Flags.Winding_CLOCKWISE;
        }// end function

        public static function get_ANTICLOCKWISE() : Winding
        {
            if (ZPP_Flags.Winding_ANTICLOCKWISE == null)
            {
                ZPP_Flags.internal = true;
                ZPP_Flags.Winding_ANTICLOCKWISE = new Winding();
                ZPP_Flags.internal = false;
            }
            return ZPP_Flags.Winding_ANTICLOCKWISE;
        }// end function

    }
}
