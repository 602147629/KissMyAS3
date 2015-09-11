package nape.dynamics
{
    import flash.*;
    import nape.shape.*;
    import zpp_nape.dynamics.*;
    import zpp_nape.util.*;

    final public class InteractionFilter extends Object
    {
        public var zpp_inner:ZPP_InteractionFilter;

        public function InteractionFilter(param1:int = 1, param2:int = -1, param3:int = 1, param4:int = -1, param5:int = 1, param6:int = -1) : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            zpp_inner = null;
            if (ZPP_InteractionFilter.zpp_pool == null)
            {
                zpp_inner = new ZPP_InteractionFilter();
            }
            else
            {
                zpp_inner = ZPP_InteractionFilter.zpp_pool;
                ZPP_InteractionFilter.zpp_pool = zpp_inner.next;
                zpp_inner.next = null;
            }
            zpp_inner.outer = this;
            if (zpp_inner.collisionGroup != param1)
            {
                zpp_inner.collisionGroup = param1;
                zpp_inner.invalidate();
            }
            if (zpp_inner.collisionMask != param2)
            {
                zpp_inner.collisionMask = param2;
                zpp_inner.invalidate();
            }
            if (zpp_inner.sensorGroup != param3)
            {
                zpp_inner.sensorGroup = param3;
                zpp_inner.invalidate();
            }
            if (zpp_inner.sensorMask != param4)
            {
                zpp_inner.sensorMask = param4;
                zpp_inner.invalidate();
            }
            if (zpp_inner.fluidGroup != param5)
            {
                zpp_inner.fluidGroup = param5;
                zpp_inner.invalidate();
            }
            if (zpp_inner.fluidMask != param6)
            {
                zpp_inner.fluidMask = param6;
                zpp_inner.invalidate();
            }
            return;
        }// end function

        public function toString() : String
        {
            return "{ collision: " + StringTools.hex(zpp_inner.collisionGroup, 8) + "~" + StringTools.hex(zpp_inner.collisionMask, 8) + " sensor: " + StringTools.hex(zpp_inner.sensorGroup, 8) + "~" + StringTools.hex(zpp_inner.sensorMask, 8) + " fluid: " + StringTools.hex(zpp_inner.fluidGroup, 8) + "~" + StringTools.hex(zpp_inner.fluidMask, 8) + " }";
        }// end function

        public function shouldSense(param1:InteractionFilter) : Boolean
        {
            if (param1 == null)
            {
                throw "Error: filter argument cannot be null for shouldSense";
            }
            var _loc_2:* = zpp_inner;
            var _loc_3:* = param1.zpp_inner;
            if ((_loc_2.sensorMask & _loc_3.sensorGroup) != 0)
            {
            }
            return (_loc_3.sensorMask & _loc_2.sensorGroup) != 0;
        }// end function

        public function shouldFlow(param1:InteractionFilter) : Boolean
        {
            if (param1 == null)
            {
                throw "Error: filter argument cannot be null for shouldFlow";
            }
            var _loc_2:* = zpp_inner;
            var _loc_3:* = param1.zpp_inner;
            if ((_loc_2.fluidMask & _loc_3.fluidGroup) != 0)
            {
            }
            return (_loc_3.fluidMask & _loc_2.fluidGroup) != 0;
        }// end function

        public function shouldCollide(param1:InteractionFilter) : Boolean
        {
            if (param1 == null)
            {
                throw "Error: filter argument cannot be null for shouldCollide";
            }
            var _loc_2:* = zpp_inner;
            var _loc_3:* = param1.zpp_inner;
            if ((_loc_2.collisionMask & _loc_3.collisionGroup) != 0)
            {
            }
            return (_loc_3.collisionMask & _loc_2.collisionGroup) != 0;
        }// end function

        public function set_sensorMask(param1:int) : int
        {
            if (zpp_inner.sensorMask != param1)
            {
                zpp_inner.sensorMask = param1;
                zpp_inner.invalidate();
            }
            return zpp_inner.sensorMask;
        }// end function

        public function set_sensorGroup(param1:int) : int
        {
            if (zpp_inner.sensorGroup != param1)
            {
                zpp_inner.sensorGroup = param1;
                zpp_inner.invalidate();
            }
            return zpp_inner.sensorGroup;
        }// end function

        public function set_fluidMask(param1:int) : int
        {
            if (zpp_inner.fluidMask != param1)
            {
                zpp_inner.fluidMask = param1;
                zpp_inner.invalidate();
            }
            return zpp_inner.fluidMask;
        }// end function

        public function set_fluidGroup(param1:int) : int
        {
            if (zpp_inner.fluidGroup != param1)
            {
                zpp_inner.fluidGroup = param1;
                zpp_inner.invalidate();
            }
            return zpp_inner.fluidGroup;
        }// end function

        public function set_collisionMask(param1:int) : int
        {
            if (zpp_inner.collisionMask != param1)
            {
                zpp_inner.collisionMask = param1;
                zpp_inner.invalidate();
            }
            return zpp_inner.collisionMask;
        }// end function

        public function set_collisionGroup(param1:int) : int
        {
            if (zpp_inner.collisionGroup != param1)
            {
                zpp_inner.collisionGroup = param1;
                zpp_inner.invalidate();
            }
            return zpp_inner.collisionGroup;
        }// end function

        public function get_userData()
        {
            if (zpp_inner.userData == null)
            {
                zpp_inner.userData = {};
            }
            return zpp_inner.userData;
        }// end function

        public function get_shapes() : ShapeList
        {
            if (zpp_inner.wrap_shapes == null)
            {
                zpp_inner.wrap_shapes = ZPP_ShapeList.get(zpp_inner.shapes, true);
            }
            return zpp_inner.wrap_shapes;
        }// end function

        public function get_sensorMask() : int
        {
            return zpp_inner.sensorMask;
        }// end function

        public function get_sensorGroup() : int
        {
            return zpp_inner.sensorGroup;
        }// end function

        public function get_fluidMask() : int
        {
            return zpp_inner.fluidMask;
        }// end function

        public function get_fluidGroup() : int
        {
            return zpp_inner.fluidGroup;
        }// end function

        public function get_collisionMask() : int
        {
            return zpp_inner.collisionMask;
        }// end function

        public function get_collisionGroup() : int
        {
            return zpp_inner.collisionGroup;
        }// end function

        public function copy() : InteractionFilter
        {
            return new InteractionFilter(zpp_inner.collisionGroup, zpp_inner.collisionMask, zpp_inner.sensorGroup, zpp_inner.sensorMask, zpp_inner.fluidGroup, zpp_inner.fluidMask);
        }// end function

    }
}
