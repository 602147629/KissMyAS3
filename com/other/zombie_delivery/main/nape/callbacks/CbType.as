package nape.callbacks
{
    import flash.*;
    import nape.constraint.*;
    import nape.phys.*;
    import zpp_nape.callbacks.*;
    import zpp_nape.util.*;

    final public class CbType extends Object
    {
        public var zpp_inner:ZPP_CbType;

        public function CbType() : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            zpp_inner = null;
            zpp_inner = new ZPP_CbType();
            zpp_inner.outer = this;
            return;
        }// end function

        public function toString() : String
        {
            if (ZPP_CbType.ANY_BODY == this)
            {
                return "ANY_BODY";
            }
            else if (ZPP_CbType.ANY_SHAPE == this)
            {
                return "ANY_SHAPE";
            }
            else if (ZPP_CbType.ANY_COMPOUND == this)
            {
                return "ANY_COMPOUND";
            }
            else if (ZPP_CbType.ANY_CONSTRAINT == this)
            {
                return "ANY_CONSTRAINT";
            }
            else
            {
                return "CbType#" + zpp_inner.id;
            }
        }// end function

        public function including(param1) : OptionType
        {
            return new OptionType(this).including(param1);
        }// end function

        public function get_userData()
        {
            if (zpp_inner.userData == null)
            {
                zpp_inner.userData = {};
            }
            return zpp_inner.userData;
        }// end function

        public function get_interactors() : InteractorList
        {
            if (zpp_inner.wrap_interactors == null)
            {
                zpp_inner.wrap_interactors = ZPP_InteractorList.get(zpp_inner.interactors, true);
            }
            return zpp_inner.wrap_interactors;
        }// end function

        public function get_id() : int
        {
            return zpp_inner.id;
        }// end function

        public function get_constraints() : ConstraintList
        {
            if (zpp_inner.wrap_constraints == null)
            {
                zpp_inner.wrap_constraints = ZPP_ConstraintList.get(zpp_inner.constraints, true);
            }
            return zpp_inner.wrap_constraints;
        }// end function

        public function excluding(param1) : OptionType
        {
            return new OptionType(this).excluding(param1);
        }// end function

        public static function get_ANY_BODY() : CbType
        {
            return ZPP_CbType.ANY_BODY;
        }// end function

        public static function get_ANY_CONSTRAINT() : CbType
        {
            return ZPP_CbType.ANY_CONSTRAINT;
        }// end function

        public static function get_ANY_SHAPE() : CbType
        {
            return ZPP_CbType.ANY_SHAPE;
        }// end function

        public static function get_ANY_COMPOUND() : CbType
        {
            return ZPP_CbType.ANY_COMPOUND;
        }// end function

    }
}
