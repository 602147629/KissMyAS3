package nape.phys
{
    import flash.*;
    import nape.shape.*;
    import zpp_nape.phys.*;
    import zpp_nape.util.*;

    final public class Material extends Object
    {
        public var zpp_inner:ZPP_Material;

        public function Material(param1:Number = 0, param2:Number = 1, param3:Number = 2, param4:Number = 1, param5:Number = 0.001) : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            zpp_inner = null;
            if (ZPP_Material.zpp_pool == null)
            {
                zpp_inner = new ZPP_Material();
            }
            else
            {
                zpp_inner = ZPP_Material.zpp_pool;
                ZPP_Material.zpp_pool = zpp_inner.next;
                zpp_inner.next = null;
            }
            zpp_inner.outer = this;
            if (param1 != zpp_inner.elasticity)
            {
                if (param1 != param1)
                {
                    throw "Error: Material::" + "elasticity" + " cannot be NaN";
                }
                zpp_inner.elasticity = param1 / 1;
                zpp_inner.invalidate(ZPP_Material.WAKE | ZPP_Material.ARBITERS);
            }
            if (param2 != zpp_inner.dynamicFriction)
            {
                if (param2 != param2)
                {
                    throw "Error: Material::" + "dynamicFriction" + " cannot be NaN";
                }
                if (param2 < 0)
                {
                    throw "Error: Material::" + "dynamicFriction" + " cannot be negative";
                }
                zpp_inner.dynamicFriction = param2 / 1;
                zpp_inner.invalidate(ZPP_Material.WAKE | ZPP_Material.ANGDRAG | ZPP_Material.ARBITERS);
            }
            if (param3 != zpp_inner.staticFriction)
            {
                if (param3 != param3)
                {
                    throw "Error: Material::" + "staticFriction" + " cannot be NaN";
                }
                if (param3 < 0)
                {
                    throw "Error: Material::" + "staticFriction" + " cannot be negative";
                }
                zpp_inner.staticFriction = param3 / 1;
                zpp_inner.invalidate(ZPP_Material.WAKE | ZPP_Material.ARBITERS);
            }
            if (param4 != zpp_inner.density * 1000)
            {
                if (param4 != param4)
                {
                    throw "Error: Material::" + "density" + " cannot be NaN";
                }
                if (param4 < 0)
                {
                    throw "Error: Material::density must be positive";
                }
                if (param4 < 0)
                {
                    throw "Error: Material::" + "density" + " cannot be negative";
                }
                zpp_inner.density = param4 / 1000;
                zpp_inner.invalidate(ZPP_Material.WAKE | ZPP_Material.PROPS);
            }
            if (param5 != zpp_inner.rollingFriction)
            {
                if (param5 != param5)
                {
                    throw "Error: Material::" + "rollingFriction" + " cannot be NaN";
                }
                if (param5 < 0)
                {
                    throw "Error: Material::" + "rollingFriction" + " cannot be negative";
                }
                zpp_inner.rollingFriction = param5 / 1;
                zpp_inner.invalidate(ZPP_Material.WAKE | ZPP_Material.ARBITERS);
            }
            return;
        }// end function

        public function toString() : String
        {
            return "{ elasticity: " + zpp_inner.elasticity + " dynamicFriction: " + zpp_inner.dynamicFriction + " staticFriction: " + zpp_inner.staticFriction + " density: " + zpp_inner.density * 1000 + " rollingFriction: " + zpp_inner.rollingFriction + " }";
        }// end function

        public function set_staticFriction(param1:Number) : Number
        {
            if (param1 != zpp_inner.staticFriction)
            {
                if (param1 != param1)
                {
                    throw "Error: Material::" + "staticFriction" + " cannot be NaN";
                }
                if (param1 < 0)
                {
                    throw "Error: Material::" + "staticFriction" + " cannot be negative";
                }
                zpp_inner.staticFriction = param1 / 1;
                zpp_inner.invalidate(ZPP_Material.WAKE | ZPP_Material.ARBITERS);
            }
            return zpp_inner.staticFriction;
        }// end function

        public function set_rollingFriction(param1:Number) : Number
        {
            if (param1 != zpp_inner.rollingFriction)
            {
                if (param1 != param1)
                {
                    throw "Error: Material::" + "rollingFriction" + " cannot be NaN";
                }
                if (param1 < 0)
                {
                    throw "Error: Material::" + "rollingFriction" + " cannot be negative";
                }
                zpp_inner.rollingFriction = param1 / 1;
                zpp_inner.invalidate(ZPP_Material.WAKE | ZPP_Material.ARBITERS);
            }
            return zpp_inner.rollingFriction;
        }// end function

        public function set_elasticity(param1:Number) : Number
        {
            if (param1 != zpp_inner.elasticity)
            {
                if (param1 != param1)
                {
                    throw "Error: Material::" + "elasticity" + " cannot be NaN";
                }
                zpp_inner.elasticity = param1 / 1;
                zpp_inner.invalidate(ZPP_Material.WAKE | ZPP_Material.ARBITERS);
            }
            return zpp_inner.elasticity;
        }// end function

        public function set_dynamicFriction(param1:Number) : Number
        {
            if (param1 != zpp_inner.dynamicFriction)
            {
                if (param1 != param1)
                {
                    throw "Error: Material::" + "dynamicFriction" + " cannot be NaN";
                }
                if (param1 < 0)
                {
                    throw "Error: Material::" + "dynamicFriction" + " cannot be negative";
                }
                zpp_inner.dynamicFriction = param1 / 1;
                zpp_inner.invalidate(ZPP_Material.WAKE | ZPP_Material.ANGDRAG | ZPP_Material.ARBITERS);
            }
            return zpp_inner.dynamicFriction;
        }// end function

        public function set_density(param1:Number) : Number
        {
            if (param1 != zpp_inner.density * 1000)
            {
                if (param1 != param1)
                {
                    throw "Error: Material::" + "density" + " cannot be NaN";
                }
                if (param1 < 0)
                {
                    throw "Error: Material::density must be positive";
                }
                if (param1 < 0)
                {
                    throw "Error: Material::" + "density" + " cannot be negative";
                }
                zpp_inner.density = param1 / 1000;
                zpp_inner.invalidate(ZPP_Material.WAKE | ZPP_Material.PROPS);
            }
            return zpp_inner.density * 1000;
        }// end function

        public function get_userData()
        {
            if (zpp_inner.userData == null)
            {
                zpp_inner.userData = {};
            }
            return zpp_inner.userData;
        }// end function

        public function get_staticFriction() : Number
        {
            return zpp_inner.staticFriction;
        }// end function

        public function get_shapes() : ShapeList
        {
            if (zpp_inner.wrap_shapes == null)
            {
                zpp_inner.wrap_shapes = ZPP_ShapeList.get(zpp_inner.shapes, true);
            }
            return zpp_inner.wrap_shapes;
        }// end function

        public function get_rollingFriction() : Number
        {
            return zpp_inner.rollingFriction;
        }// end function

        public function get_elasticity() : Number
        {
            return zpp_inner.elasticity;
        }// end function

        public function get_dynamicFriction() : Number
        {
            return zpp_inner.dynamicFriction;
        }// end function

        public function get_density() : Number
        {
            return zpp_inner.density * 1000;
        }// end function

        public function copy() : Material
        {
            var _loc_1:* = new Material(zpp_inner.elasticity, zpp_inner.dynamicFriction, zpp_inner.staticFriction, zpp_inner.density * 1000, zpp_inner.rollingFriction);
            if (zpp_inner.userData != null)
            {
                _loc_1.zpp_inner.userData = Reflect.copy(zpp_inner.userData);
            }
            return _loc_1;
        }// end function

        public static function wood() : Material
        {
            return new Material(0.4, 0.2, 0.38, 0.7, 0.005);
        }// end function

        public static function steel() : Material
        {
            return new Material(0.2, 0.57, 0.74, 7.8, 0.001);
        }// end function

        public static function ice() : Material
        {
            return new Material(0.3, 0.03, 0.1, 0.9, 0.0001);
        }// end function

        public static function rubber() : Material
        {
            return new Material(0.8, 1, 1.4, 1.5, 0.01);
        }// end function

        public static function glass() : Material
        {
            return new Material(0.4, 0.4, 0.94, 2.6, 0.002);
        }// end function

        public static function sand() : Material
        {
            return new Material(-1, 0.45, 0.6, 1.6, 16);
        }// end function

    }
}
