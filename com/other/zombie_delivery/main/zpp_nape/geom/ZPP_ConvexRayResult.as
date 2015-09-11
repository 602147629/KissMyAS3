package zpp_nape.geom
{
    import flash.*;
    import nape.geom.*;
    import nape.shape.*;
    import zpp_nape.util.*;

    public class ZPP_ConvexRayResult extends Object
    {
        public var toiDistance:Number;
        public var shape:Shape;
        public var ray:RayResult;
        public var position:Vec2;
        public var normal:Vec2;
        public var next:ZPP_ConvexRayResult;
        public var inner:Boolean;
        public var convex:ConvexResult;
        public static var convexPool:ZPP_ConvexRayResult;
        public static var rayPool:ZPP_ConvexRayResult;
        public static var internal:Boolean;

        public function ZPP_ConvexRayResult() : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            toiDistance = 0;
            next = null;
            inner = false;
            ray = null;
            position = null;
            convex = null;
            shape = null;
            normal = null;
            return;
        }// end function

        public function free() : void
        {
            var _loc_1:* = null as Vec2;
            var _loc_2:* = null as ZPP_Vec2;
            var _loc_3:* = null as Vec2;
            var _loc_4:* = null as ZPP_Vec2;
            normal.zpp_inner._immutable = false;
            _loc_1 = normal;
            if (_loc_1 != null)
            {
            }
            if (_loc_1.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_2 = _loc_1.zpp_inner;
            if (_loc_2._immutable)
            {
                throw "Error: Vec2 is immutable";
            }
            if (_loc_2._isimmutable != null)
            {
                _loc_2._isimmutable();
            }
            if (_loc_1.zpp_inner._inuse)
            {
                throw "Error: This Vec2 is not disposable";
            }
            _loc_2 = _loc_1.zpp_inner;
            _loc_1.zpp_inner.outer = null;
            _loc_1.zpp_inner = null;
            _loc_3 = _loc_1;
            _loc_3.zpp_pool = null;
            if (ZPP_PubPool.nextVec2 != null)
            {
                ZPP_PubPool.nextVec2.zpp_pool = _loc_3;
            }
            else
            {
                ZPP_PubPool.poolVec2 = _loc_3;
            }
            ZPP_PubPool.nextVec2 = _loc_3;
            _loc_3.zpp_disp = true;
            _loc_4 = _loc_2;
            if (_loc_4.outer != null)
            {
                _loc_4.outer.zpp_inner = null;
                _loc_4.outer = null;
            }
            _loc_4._isimmutable = null;
            _loc_4._validate = null;
            _loc_4._invalidate = null;
            _loc_4.next = ZPP_Vec2.zpp_pool;
            ZPP_Vec2.zpp_pool = _loc_4;
            if (position != null)
            {
                position.zpp_inner._immutable = false;
                _loc_1 = position;
                if (_loc_1 != null)
                {
                }
                if (_loc_1.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_2 = _loc_1.zpp_inner;
                if (_loc_2._immutable)
                {
                    throw "Error: Vec2 is immutable";
                }
                if (_loc_2._isimmutable != null)
                {
                    _loc_2._isimmutable();
                }
                if (_loc_1.zpp_inner._inuse)
                {
                    throw "Error: This Vec2 is not disposable";
                }
                _loc_2 = _loc_1.zpp_inner;
                _loc_1.zpp_inner.outer = null;
                _loc_1.zpp_inner = null;
                _loc_3 = _loc_1;
                _loc_3.zpp_pool = null;
                if (ZPP_PubPool.nextVec2 != null)
                {
                    ZPP_PubPool.nextVec2.zpp_pool = _loc_3;
                }
                else
                {
                    ZPP_PubPool.poolVec2 = _loc_3;
                }
                ZPP_PubPool.nextVec2 = _loc_3;
                _loc_3.zpp_disp = true;
                _loc_4 = _loc_2;
                if (_loc_4.outer != null)
                {
                    _loc_4.outer.zpp_inner = null;
                    _loc_4.outer = null;
                }
                _loc_4._isimmutable = null;
                _loc_4._validate = null;
                _loc_4._invalidate = null;
                _loc_4.next = ZPP_Vec2.zpp_pool;
                ZPP_Vec2.zpp_pool = _loc_4;
            }
            shape = null;
            toiDistance = 0;
            if (convex != null)
            {
                next = ZPP_ConvexRayResult.convexPool;
                ZPP_ConvexRayResult.convexPool = this;
            }
            else
            {
                next = ZPP_ConvexRayResult.rayPool;
                ZPP_ConvexRayResult.rayPool = this;
            }
            return;
        }// end function

        public function disposed() : void
        {
            if (next != null)
            {
                throw "Error: This object has been disposed of and cannot be used";
            }
            return;
        }// end function

        public static function getRay(param1:Vec2, param2:Number, param3:Boolean, param4:Shape) : RayResult
        {
            var _loc_5:* = null as RayResult;
            if (ZPP_ConvexRayResult.rayPool == null)
            {
                ZPP_ConvexRayResult.internal = true;
                _loc_5 = new RayResult();
                _loc_5.zpp_inner = new ZPP_ConvexRayResult();
                _loc_5.zpp_inner.ray = _loc_5;
                ZPP_ConvexRayResult.internal = false;
            }
            else
            {
                _loc_5 = ZPP_ConvexRayResult.rayPool.ray;
                ZPP_ConvexRayResult.rayPool = ZPP_ConvexRayResult.rayPool.next;
                _loc_5.zpp_inner.next = null;
            }
            var _loc_6:* = _loc_5.zpp_inner;
            _loc_6.normal = param1;
            param1.zpp_inner._immutable = true;
            _loc_6.toiDistance = param2;
            _loc_6.inner = param3;
            _loc_6.shape = param4;
            return _loc_5;
        }// end function

        public static function getConvex(param1:Vec2, param2:Vec2, param3:Number, param4:Shape) : ConvexResult
        {
            var _loc_5:* = null as ConvexResult;
            if (ZPP_ConvexRayResult.convexPool == null)
            {
                ZPP_ConvexRayResult.internal = true;
                _loc_5 = new ConvexResult();
                _loc_5.zpp_inner = new ZPP_ConvexRayResult();
                _loc_5.zpp_inner.convex = _loc_5;
                ZPP_ConvexRayResult.internal = false;
            }
            else
            {
                _loc_5 = ZPP_ConvexRayResult.convexPool.convex;
                ZPP_ConvexRayResult.convexPool = ZPP_ConvexRayResult.convexPool.next;
                _loc_5.zpp_inner.next = null;
            }
            var _loc_6:* = _loc_5.zpp_inner;
            _loc_6.normal = param1;
            _loc_6.position = param2;
            param1.zpp_inner._immutable = true;
            param2.zpp_inner._immutable = true;
            _loc_6.toiDistance = param3;
            _loc_6.shape = param4;
            return _loc_5;
        }// end function

    }
}
