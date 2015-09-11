package nape.dynamics
{
    import flash.*;
    import nape.phys.*;
    import zpp_nape.dynamics.*;
    import zpp_nape.util.*;

    final public class InteractionGroup extends Object
    {
        public var zpp_inner:ZPP_InteractionGroup;

        public function InteractionGroup(param1:Boolean = false) : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            zpp_inner = null;
            zpp_inner = new ZPP_InteractionGroup();
            zpp_inner.outer = this;
            if (zpp_inner.ignore != param1)
            {
                zpp_inner.invalidate(true);
                zpp_inner.ignore = param1;
            }
            return;
        }// end function

        public function toString() : String
        {
            var _loc_1:* = "InteractionGroup";
            if (zpp_inner.ignore)
            {
                _loc_1 = _loc_1 + ":ignore";
            }
            return _loc_1;
        }// end function

        public function set_ignore(param1:Boolean) : Boolean
        {
            if (zpp_inner.ignore != param1)
            {
                zpp_inner.invalidate(true);
                zpp_inner.ignore = param1;
            }
            return zpp_inner.ignore;
        }// end function

        public function set_group(param1:InteractionGroup) : InteractionGroup
        {
            if (param1 == this)
            {
                throw "Error: Cannot assign InteractionGroup to itself";
            }
            zpp_inner.setGroup(param1 == null ? (null) : (param1.zpp_inner));
            if (zpp_inner.group == null)
            {
                return null;
            }
            else
            {
                return zpp_inner.group.outer;
            }
        }// end function

        public function get_interactors() : InteractorList
        {
            if (zpp_inner.wrap_interactors == null)
            {
                zpp_inner.wrap_interactors = ZPP_InteractorList.get(zpp_inner.interactors, true);
            }
            return zpp_inner.wrap_interactors;
        }// end function

        public function get_ignore() : Boolean
        {
            return zpp_inner.ignore;
        }// end function

        public function get_groups() : InteractionGroupList
        {
            if (zpp_inner.wrap_groups == null)
            {
                zpp_inner.wrap_groups = ZPP_InteractionGroupList.get(zpp_inner.groups, true);
            }
            return zpp_inner.wrap_groups;
        }// end function

        public function get_group() : InteractionGroup
        {
            if (zpp_inner.group == null)
            {
                return null;
            }
            else
            {
                return zpp_inner.group.outer;
            }
        }// end function

    }
}
