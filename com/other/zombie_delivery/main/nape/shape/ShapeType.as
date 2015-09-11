package nape.shape
{
    import flash.*;
    import zpp_nape.util.*;

    final public class ShapeType extends Object
    {

        public function ShapeType() : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            if (!ZPP_Flags.internal)
            {
                throw "Error: Cannot instantiate " + "ShapeType" + " derp!";
            }
            return;
        }// end function

        public function toString() : String
        {
            if (ZPP_Flags.ShapeType_CIRCLE == null)
            {
                ZPP_Flags.internal = true;
                ZPP_Flags.ShapeType_CIRCLE = new ShapeType();
                ZPP_Flags.internal = false;
            }
            if (ZPP_Flags.ShapeType_CIRCLE == this)
            {
                return "CIRCLE";
            }
            else
            {
                if (ZPP_Flags.ShapeType_POLYGON == null)
                {
                    ZPP_Flags.internal = true;
                    ZPP_Flags.ShapeType_POLYGON = new ShapeType();
                    ZPP_Flags.internal = false;
                }
                if (ZPP_Flags.ShapeType_POLYGON == this)
                {
                    return "POLYGON";
                }
                else
                {
                    return "";
                }
            }
        }// end function

        public static function get_CIRCLE() : ShapeType
        {
            if (ZPP_Flags.ShapeType_CIRCLE == null)
            {
                ZPP_Flags.internal = true;
                ZPP_Flags.ShapeType_CIRCLE = new ShapeType();
                ZPP_Flags.internal = false;
            }
            return ZPP_Flags.ShapeType_CIRCLE;
        }// end function

        public static function get_POLYGON() : ShapeType
        {
            if (ZPP_Flags.ShapeType_POLYGON == null)
            {
                ZPP_Flags.internal = true;
                ZPP_Flags.ShapeType_POLYGON = new ShapeType();
                ZPP_Flags.internal = false;
            }
            return ZPP_Flags.ShapeType_POLYGON;
        }// end function

    }
}
