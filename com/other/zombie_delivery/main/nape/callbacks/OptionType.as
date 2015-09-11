package nape.callbacks
{
    import flash.*;
    import zpp_nape.callbacks.*;

    final public class OptionType extends Object
    {
        public var zpp_inner:ZPP_OptionType;

        public function OptionType(param1 = undefined, param2 = undefined) : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            zpp_inner = null;
            zpp_inner = new ZPP_OptionType();
            zpp_inner.outer = this;
            if (param1 != null)
            {
                including(param1);
            }
            if (param2 != null)
            {
                excluding(param2);
            }
            return;
        }// end function

        public function toString() : String
        {
            if (zpp_inner.wrap_includes == null)
            {
                zpp_inner.setup_includes();
            }
            var _loc_1:* = zpp_inner.wrap_includes.toString();
            if (zpp_inner.wrap_excludes == null)
            {
                zpp_inner.setup_excludes();
            }
            var _loc_2:* = zpp_inner.wrap_excludes.toString();
            return "@{" + _loc_1 + " excluding " + _loc_2 + "}";
        }// end function

        public function including(param1 = undefined) : OptionType
        {
            zpp_inner.append(zpp_inner.includes, param1);
            return this;
        }// end function

        public function get_includes() : CbTypeList
        {
            if (zpp_inner.wrap_includes == null)
            {
                zpp_inner.setup_includes();
            }
            return zpp_inner.wrap_includes;
        }// end function

        public function get_excludes() : CbTypeList
        {
            if (zpp_inner.wrap_excludes == null)
            {
                zpp_inner.setup_excludes();
            }
            return zpp_inner.wrap_excludes;
        }// end function

        public function excluding(param1 = undefined) : OptionType
        {
            zpp_inner.append(zpp_inner.excludes, param1);
            return this;
        }// end function

    }
}
