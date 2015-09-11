package zpp_nape.dynamics
{
    import flash.*;
    import nape.dynamics.*;
    import nape.shape.*;
    import zpp_nape.shape.*;
    import zpp_nape.util.*;

    public class ZPP_InteractionFilter extends Object
    {
        public var wrap_shapes:ShapeList;
        public var userData:Object;
        public var shapes:ZNPList_ZPP_Shape;
        public var sensorMask:int;
        public var sensorGroup:int;
        public var outer:InteractionFilter;
        public var next:ZPP_InteractionFilter;
        public var fluidMask:int;
        public var fluidGroup:int;
        public var collisionMask:int;
        public var collisionGroup:int;
        public static var zpp_pool:ZPP_InteractionFilter;

        public function ZPP_InteractionFilter() : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            fluidMask = 0;
            fluidGroup = 0;
            sensorMask = 0;
            sensorGroup = 0;
            collisionMask = 0;
            collisionGroup = 0;
            wrap_shapes = null;
            shapes = null;
            outer = null;
            userData = null;
            next = null;
            shapes = new ZNPList_ZPP_Shape();
            var _loc_1:* = 1;
            fluidGroup = 1;
            _loc_1 = _loc_1;
            sensorGroup = _loc_1;
            collisionGroup = _loc_1;
            _loc_1 = -1;
            fluidMask = _loc_1;
            _loc_1 = _loc_1;
            sensorMask = _loc_1;
            collisionMask = _loc_1;
            return;
        }// end function

        public function wrapper() : InteractionFilter
        {
            var _loc_1:* = null as ZPP_InteractionFilter;
            if (outer == null)
            {
                outer = new InteractionFilter();
                _loc_1 = outer.zpp_inner;
                _loc_1.outer = null;
                _loc_1.next = ZPP_InteractionFilter.zpp_pool;
                ZPP_InteractionFilter.zpp_pool = _loc_1;
                outer.zpp_inner = this;
            }
            return outer;
        }// end function

        public function shouldSense(param1:ZPP_InteractionFilter) : Boolean
        {
            if ((sensorMask & param1.sensorGroup) != 0)
            {
            }
            return (param1.sensorMask & sensorGroup) != 0;
        }// end function

        public function shouldFlow(param1:ZPP_InteractionFilter) : Boolean
        {
            if ((fluidMask & param1.fluidGroup) != 0)
            {
            }
            return (param1.fluidMask & fluidGroup) != 0;
        }// end function

        public function shouldCollide(param1:ZPP_InteractionFilter) : Boolean
        {
            if ((collisionMask & param1.collisionGroup) != 0)
            {
            }
            return (param1.collisionMask & collisionGroup) != 0;
        }// end function

        public function remShape(param1:ZPP_Shape) : void
        {
            shapes.remove(param1);
            return;
        }// end function

        public function invalidate() : void
        {
            var _loc_2:* = null as ZPP_Shape;
            var _loc_1:* = shapes.head;
            while (_loc_1 != null)
            {
                
                _loc_2 = _loc_1.elt;
                _loc_2.invalidate_filter();
                _loc_1 = _loc_1.next;
            }
            return;
        }// end function

        public function free() : void
        {
            outer = null;
            return;
        }// end function

        public function feature_cons() : void
        {
            shapes = new ZNPList_ZPP_Shape();
            return;
        }// end function

        public function copy() : ZPP_InteractionFilter
        {
            var _loc_1:* = null as ZPP_InteractionFilter;
            if (ZPP_InteractionFilter.zpp_pool == null)
            {
                _loc_1 = new ZPP_InteractionFilter();
            }
            else
            {
                _loc_1 = ZPP_InteractionFilter.zpp_pool;
                ZPP_InteractionFilter.zpp_pool = _loc_1.next;
                _loc_1.next = null;
            }
            _loc_1.collisionGroup = collisionGroup;
            _loc_1.collisionMask = collisionMask;
            _loc_1.sensorGroup = sensorGroup;
            _loc_1.sensorMask = sensorMask;
            _loc_1.fluidGroup = fluidGroup;
            _loc_1.fluidMask = fluidMask;
            return _loc_1;
        }// end function

        public function alloc() : void
        {
            return;
        }// end function

        public function addShape(param1:ZPP_Shape) : void
        {
            shapes.add(param1);
            return;
        }// end function

    }
}
