package nape.callbacks
{
    import flash.*;
    import zpp_nape.util.*;

    final public class ListenerType extends Object
    {

        public function ListenerType() : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            if (!ZPP_Flags.internal)
            {
                throw "Error: Cannot instantiate " + "ListenerType" + " derp!";
            }
            return;
        }// end function

        public function toString() : String
        {
            if (ZPP_Flags.ListenerType_BODY == null)
            {
                ZPP_Flags.internal = true;
                ZPP_Flags.ListenerType_BODY = new ListenerType();
                ZPP_Flags.internal = false;
            }
            if (ZPP_Flags.ListenerType_BODY == this)
            {
                return "BODY";
            }
            else
            {
                if (ZPP_Flags.ListenerType_CONSTRAINT == null)
                {
                    ZPP_Flags.internal = true;
                    ZPP_Flags.ListenerType_CONSTRAINT = new ListenerType();
                    ZPP_Flags.internal = false;
                }
                if (ZPP_Flags.ListenerType_CONSTRAINT == this)
                {
                    return "CONSTRAINT";
                }
                else
                {
                    if (ZPP_Flags.ListenerType_INTERACTION == null)
                    {
                        ZPP_Flags.internal = true;
                        ZPP_Flags.ListenerType_INTERACTION = new ListenerType();
                        ZPP_Flags.internal = false;
                    }
                    if (ZPP_Flags.ListenerType_INTERACTION == this)
                    {
                        return "INTERACTION";
                    }
                    else
                    {
                        if (ZPP_Flags.ListenerType_PRE == null)
                        {
                            ZPP_Flags.internal = true;
                            ZPP_Flags.ListenerType_PRE = new ListenerType();
                            ZPP_Flags.internal = false;
                        }
                        if (ZPP_Flags.ListenerType_PRE == this)
                        {
                            return "PRE";
                        }
                        else
                        {
                            return "";
                        }
                    }
                }
            }
        }// end function

        public static function get_BODY() : ListenerType
        {
            if (ZPP_Flags.ListenerType_BODY == null)
            {
                ZPP_Flags.internal = true;
                ZPP_Flags.ListenerType_BODY = new ListenerType();
                ZPP_Flags.internal = false;
            }
            return ZPP_Flags.ListenerType_BODY;
        }// end function

        public static function get_CONSTRAINT() : ListenerType
        {
            if (ZPP_Flags.ListenerType_CONSTRAINT == null)
            {
                ZPP_Flags.internal = true;
                ZPP_Flags.ListenerType_CONSTRAINT = new ListenerType();
                ZPP_Flags.internal = false;
            }
            return ZPP_Flags.ListenerType_CONSTRAINT;
        }// end function

        public static function get_INTERACTION() : ListenerType
        {
            if (ZPP_Flags.ListenerType_INTERACTION == null)
            {
                ZPP_Flags.internal = true;
                ZPP_Flags.ListenerType_INTERACTION = new ListenerType();
                ZPP_Flags.internal = false;
            }
            return ZPP_Flags.ListenerType_INTERACTION;
        }// end function

        public static function get_PRE() : ListenerType
        {
            if (ZPP_Flags.ListenerType_PRE == null)
            {
                ZPP_Flags.internal = true;
                ZPP_Flags.ListenerType_PRE = new ListenerType();
                ZPP_Flags.internal = false;
            }
            return ZPP_Flags.ListenerType_PRE;
        }// end function

    }
}
