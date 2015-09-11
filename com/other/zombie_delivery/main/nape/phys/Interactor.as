package nape.phys
{
    import flash.*;
    import nape.callbacks.*;
    import nape.dynamics.*;
    import nape.shape.*;
    import zpp_nape.dynamics.*;
    import zpp_nape.phys.*;
    import zpp_nape.shape.*;

    public class Interactor extends Object
    {
        public var zpp_inner_i:ZPP_Interactor;

        public function Interactor() : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            zpp_inner_i = null;
            throw "Error: Cannot instantiate an Interactor, only Shape/Body/Compound";
            return;
        }// end function

        public function toString() : String
        {
            return "";
        }// end function

        public function set_group(param1:InteractionGroup) : InteractionGroup
        {
            zpp_inner_i.immutable_midstep("Interactor::group");
            zpp_inner_i.setGroup(param1 == null ? (null) : (param1.zpp_inner));
            if (zpp_inner_i.group == null)
            {
                return null;
            }
            else
            {
                return zpp_inner_i.group.outer;
            }
        }// end function

        public function isShape() : Boolean
        {
            return zpp_inner_i.ishape != null;
        }// end function

        public function isCompound() : Boolean
        {
            return zpp_inner_i.icompound != null;
        }// end function

        public function isBody() : Boolean
        {
            return zpp_inner_i.ibody != null;
        }// end function

        public function get_userData()
        {
            if (zpp_inner_i.userData == null)
            {
                zpp_inner_i.userData = {};
            }
            return zpp_inner_i.userData;
        }// end function

        public function get_id() : int
        {
            return zpp_inner_i.id;
        }// end function

        public function get_group() : InteractionGroup
        {
            if (zpp_inner_i.group == null)
            {
                return null;
            }
            else
            {
                return zpp_inner_i.group.outer;
            }
        }// end function

        public function get_cbTypes() : CbTypeList
        {
            if (zpp_inner_i.wrap_cbTypes == null)
            {
                zpp_inner_i.setupcbTypes();
            }
            return zpp_inner_i.wrap_cbTypes;
        }// end function

        public function get_castShape() : Shape
        {
            if (zpp_inner_i.ishape != null)
            {
                return zpp_inner_i.ishape.outer;
            }
            else
            {
                return null;
            }
        }// end function

        public function get_castCompound() : Compound
        {
            if (zpp_inner_i.icompound != null)
            {
                return zpp_inner_i.icompound.outer;
            }
            else
            {
                return null;
            }
        }// end function

        public function get_castBody() : Body
        {
            if (zpp_inner_i.ibody != null)
            {
                return zpp_inner_i.ibody.outer;
            }
            else
            {
                return null;
            }
        }// end function

    }
}
