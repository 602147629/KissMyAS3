package zpp_nape.dynamics
{
    import flash.*;
    import nape.dynamics.*;
    import nape.phys.*;
    import zpp_nape.phys.*;
    import zpp_nape.shape.*;
    import zpp_nape.util.*;

    public class ZPP_InteractionGroup extends Object
    {
        public var wrap_interactors:InteractorList;
        public var wrap_groups:InteractionGroupList;
        public var outer:InteractionGroup;
        public var interactors:ZNPList_ZPP_Interactor;
        public var ignore:Boolean;
        public var groups:ZNPList_ZPP_InteractionGroup;
        public var group:ZPP_InteractionGroup;
        public var depth:int;
        public static var SHAPE:int;
        public static var BODY:int;

        public function ZPP_InteractionGroup() : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            depth = 0;
            wrap_interactors = null;
            interactors = null;
            wrap_groups = null;
            groups = null;
            group = null;
            ignore = false;
            outer = null;
            depth = 0;
            groups = new ZNPList_ZPP_InteractionGroup();
            interactors = new ZNPList_ZPP_Interactor();
            return;
        }// end function

        public function setGroup(param1:ZPP_InteractionGroup) : void
        {
            if (group != param1)
            {
                if (group != null)
                {
                    group.groups.remove(this);
                    depth = 0;
                    group.invalidate(true);
                }
                group = param1;
                if (param1 != null)
                {
                    param1.groups.add(this);
                    depth = param1.depth + 1;
                    param1.invalidate(true);
                }
                else
                {
                    invalidate(true);
                }
            }
            return;
        }// end function

        public function remInteractor(param1:ZPP_Interactor, param2:int = -1) : void
        {
            interactors.remove(param1);
            return;
        }// end function

        public function remGroup(param1:ZPP_InteractionGroup) : void
        {
            groups.remove(param1);
            param1.depth = 0;
            return;
        }// end function

        public function invalidate(param1:Boolean = false) : void
        {
            var _loc_3:* = null as ZPP_Interactor;
            var _loc_5:* = null as ZPP_InteractionGroup;
            if (!param1)
            {
            }
            if (!ignore)
            {
                return;
            }
            var _loc_2:* = interactors.head;
            while (_loc_2 != null)
            {
                
                _loc_3 = _loc_2.elt;
                if (_loc_3.ibody != null)
                {
                    _loc_3.ibody.wake();
                }
                else if (_loc_3.ishape != null)
                {
                    _loc_3.ishape.body.wake();
                }
                else
                {
                    _loc_3.icompound.wake();
                }
                _loc_2 = _loc_2.next;
            }
            var _loc_4:* = groups.head;
            while (_loc_4 != null)
            {
                
                _loc_5 = _loc_4.elt;
                _loc_5.invalidate(param1);
                _loc_4 = _loc_4.next;
            }
            return;
        }// end function

        public function addInteractor(param1:ZPP_Interactor) : void
        {
            interactors.add(param1);
            return;
        }// end function

        public function addGroup(param1:ZPP_InteractionGroup) : void
        {
            groups.add(param1);
            param1.depth = depth + 1;
            return;
        }// end function

    }
}
