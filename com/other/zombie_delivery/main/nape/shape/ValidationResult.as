package nape.shape
{
    import flash.*;
    import zpp_nape.util.*;

    final public class ValidationResult extends Object
    {

        public function ValidationResult() : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            if (!ZPP_Flags.internal)
            {
                throw "Error: Cannot instantiate " + "ValidationResult" + " derp!";
            }
            return;
        }// end function

        public function toString() : String
        {
            if (ZPP_Flags.ValidationResult_VALID == null)
            {
                ZPP_Flags.internal = true;
                ZPP_Flags.ValidationResult_VALID = new ValidationResult();
                ZPP_Flags.internal = false;
            }
            if (ZPP_Flags.ValidationResult_VALID == this)
            {
                return "VALID";
            }
            else
            {
                if (ZPP_Flags.ValidationResult_DEGENERATE == null)
                {
                    ZPP_Flags.internal = true;
                    ZPP_Flags.ValidationResult_DEGENERATE = new ValidationResult();
                    ZPP_Flags.internal = false;
                }
                if (ZPP_Flags.ValidationResult_DEGENERATE == this)
                {
                    return "DEGENERATE";
                }
                else
                {
                    if (ZPP_Flags.ValidationResult_CONCAVE == null)
                    {
                        ZPP_Flags.internal = true;
                        ZPP_Flags.ValidationResult_CONCAVE = new ValidationResult();
                        ZPP_Flags.internal = false;
                    }
                    if (ZPP_Flags.ValidationResult_CONCAVE == this)
                    {
                        return "CONCAVE";
                    }
                    else
                    {
                        if (ZPP_Flags.ValidationResult_SELF_INTERSECTING == null)
                        {
                            ZPP_Flags.internal = true;
                            ZPP_Flags.ValidationResult_SELF_INTERSECTING = new ValidationResult();
                            ZPP_Flags.internal = false;
                        }
                        if (ZPP_Flags.ValidationResult_SELF_INTERSECTING == this)
                        {
                            return "SELF_INTERSECTING";
                        }
                        else
                        {
                            return "";
                        }
                    }
                }
            }
        }// end function

        public static function get_VALID() : ValidationResult
        {
            if (ZPP_Flags.ValidationResult_VALID == null)
            {
                ZPP_Flags.internal = true;
                ZPP_Flags.ValidationResult_VALID = new ValidationResult();
                ZPP_Flags.internal = false;
            }
            return ZPP_Flags.ValidationResult_VALID;
        }// end function

        public static function get_DEGENERATE() : ValidationResult
        {
            if (ZPP_Flags.ValidationResult_DEGENERATE == null)
            {
                ZPP_Flags.internal = true;
                ZPP_Flags.ValidationResult_DEGENERATE = new ValidationResult();
                ZPP_Flags.internal = false;
            }
            return ZPP_Flags.ValidationResult_DEGENERATE;
        }// end function

        public static function get_CONCAVE() : ValidationResult
        {
            if (ZPP_Flags.ValidationResult_CONCAVE == null)
            {
                ZPP_Flags.internal = true;
                ZPP_Flags.ValidationResult_CONCAVE = new ValidationResult();
                ZPP_Flags.internal = false;
            }
            return ZPP_Flags.ValidationResult_CONCAVE;
        }// end function

        public static function get_SELF_INTERSECTING() : ValidationResult
        {
            if (ZPP_Flags.ValidationResult_SELF_INTERSECTING == null)
            {
                ZPP_Flags.internal = true;
                ZPP_Flags.ValidationResult_SELF_INTERSECTING = new ValidationResult();
                ZPP_Flags.internal = false;
            }
            return ZPP_Flags.ValidationResult_SELF_INTERSECTING;
        }// end function

    }
}
