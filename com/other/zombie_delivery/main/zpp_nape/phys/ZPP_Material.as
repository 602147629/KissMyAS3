package zpp_nape.phys
{
    import flash.*;
    import nape.phys.*;
    import nape.shape.*;
    import zpp_nape.shape.*;
    import zpp_nape.util.*;

    public class ZPP_Material extends Object
    {
        public var wrap_shapes:ShapeList;
        public var userData:Object;
        public var staticFriction:Number;
        public var shapes:ZNPList_ZPP_Shape;
        public var rollingFriction:Number;
        public var outer:Material;
        public var next:ZPP_Material;
        public var elasticity:Number;
        public var dynamicFriction:Number;
        public var density:Number;
        public static var zpp_pool:ZPP_Material;
        public static var WAKE:int;
        public static var PROPS:int;
        public static var ANGDRAG:int;
        public static var ARBITERS:int;

        public function ZPP_Material() : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            rollingFriction = 0;
            elasticity = 0;
            density = 0;
            staticFriction = 0;
            dynamicFriction = 0;
            wrap_shapes = null;
            shapes = null;
            outer = null;
            userData = null;
            next = null;
            shapes = new ZNPList_ZPP_Shape();
            elasticity = 0;
            dynamicFriction = 1;
            staticFriction = 2;
            density = 0.001;
            rollingFriction = 0.01;
            return;
        }// end function

        public function wrapper() : Material
        {
            var _loc_1:* = null as ZPP_Material;
            if (outer == null)
            {
                outer = new Material();
                _loc_1 = outer.zpp_inner;
                _loc_1.outer = null;
                _loc_1.next = ZPP_Material.zpp_pool;
                ZPP_Material.zpp_pool = _loc_1;
                outer.zpp_inner = this;
            }
            return outer;
        }// end function

        public function set(param1:ZPP_Material) : void
        {
            dynamicFriction = param1.dynamicFriction;
            staticFriction = param1.staticFriction;
            density = param1.density;
            elasticity = param1.elasticity;
            rollingFriction = param1.rollingFriction;
            return;
        }// end function

        public function remShape(param1:ZPP_Shape) : void
        {
            shapes.remove(param1);
            return;
        }// end function

        public function invalidate(param1:int) : void
        {
            var _loc_3:* = null as ZPP_Shape;
            var _loc_2:* = shapes.head;
            while (_loc_2 != null)
            {
                
                _loc_3 = _loc_2.elt;
                _loc_3.invalidate_material(param1);
                _loc_2 = _loc_2.next;
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

        public function copy() : ZPP_Material
        {
            var _loc_1:* = new ZPP_Material();
            _loc_1.dynamicFriction = dynamicFriction;
            _loc_1.staticFriction = staticFriction;
            _loc_1.density = density;
            _loc_1.elasticity = elasticity;
            _loc_1.rollingFriction = rollingFriction;
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
