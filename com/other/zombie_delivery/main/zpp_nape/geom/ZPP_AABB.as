package zpp_nape.geom
{
    import flash.*;
    import nape.geom.*;
    import zpp_nape.util.*;

    public class ZPP_AABB extends Object
    {
        public var wrap_min:Vec2;
        public var wrap_max:Vec2;
        public var outer:AABB;
        public var next:ZPP_AABB;
        public var miny:Number;
        public var minx:Number;
        public var maxy:Number;
        public var maxx:Number;
        public var _validate:Object;
        public var _invalidate:Object;
        public var _immutable:Boolean;
        public static var zpp_pool:ZPP_AABB;

        public function ZPP_AABB() : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            wrap_max = null;
            maxy = 0;
            maxx = 0;
            wrap_min = null;
            miny = 0;
            minx = 0;
            next = null;
            outer = null;
            _immutable = false;
            _validate = null;
            _invalidate = null;
            return;
        }// end function

        public function wrapper() : AABB
        {
            var _loc_1:* = null as ZPP_AABB;
            var _loc_2:* = null as Vec2;
            if (outer == null)
            {
                outer = new AABB();
                _loc_1 = outer.zpp_inner;
                if (_loc_1.outer != null)
                {
                    _loc_1.outer.zpp_inner = null;
                    _loc_1.outer = null;
                }
                _loc_2 = null;
                _loc_1.wrap_max = _loc_2;
                _loc_1.wrap_min = _loc_2;
                _loc_1._invalidate = null;
                _loc_1._validate = null;
                _loc_1.next = ZPP_AABB.zpp_pool;
                ZPP_AABB.zpp_pool = _loc_1;
                outer.zpp_inner = this;
            }
            return outer;
        }// end function

        public function width() : Number
        {
            return maxx - minx;
        }// end function

        public function validate() : void
        {
            if (_validate != null)
            {
                _validate();
            }
            return;
        }// end function

        public function toString() : String
        {
            return "{ x: " + minx + " y: " + miny + " w: " + (maxx - minx) + " h: " + (maxy - miny) + " }";
        }// end function

        public function setExpandPoint(param1:Number, param2:Number) : void
        {
            if (param1 < minx)
            {
                minx = param1;
            }
            if (param1 > maxx)
            {
                maxx = param1;
            }
            if (param2 < miny)
            {
                miny = param2;
            }
            if (param2 > maxy)
            {
                maxy = param2;
            }
            return;
        }// end function

        public function setExpand(param1:ZPP_AABB, param2:Number) : void
        {
            minx = param1.minx - param2;
            miny = param1.miny - param2;
            maxx = param1.maxx + param2;
            maxy = param1.maxy + param2;
            return;
        }// end function

        public function setCombine(param1:ZPP_AABB, param2:ZPP_AABB) : void
        {
            if (param1.minx < param2.minx)
            {
                minx = param1.minx;
            }
            else
            {
                minx = param2.minx;
            }
            if (param1.miny < param2.miny)
            {
                miny = param1.miny;
            }
            else
            {
                miny = param2.miny;
            }
            if (param1.maxx > param2.maxx)
            {
                maxx = param1.maxx;
            }
            else
            {
                maxx = param2.maxx;
            }
            if (param1.maxy > param2.maxy)
            {
                maxy = param1.maxy;
            }
            else
            {
                maxy = param2.maxy;
            }
            return;
        }// end function

        public function perimeter() : Number
        {
            return (maxx - minx + (maxy - miny)) * 2;
        }// end function

        public function mod_min(param1:ZPP_Vec2) : void
        {
            if (param1.x == minx)
            {
            }
            if (param1.y != miny)
            {
                minx = param1.x;
                miny = param1.y;
                if (_invalidate != null)
                {
                    _invalidate(this);
                }
            }
            return;
        }// end function

        public function mod_max(param1:ZPP_Vec2) : void
        {
            if (param1.x == maxx)
            {
            }
            if (param1.y != maxy)
            {
                maxx = param1.x;
                maxy = param1.y;
                if (_invalidate != null)
                {
                    _invalidate(this);
                }
            }
            return;
        }// end function

        public function invalidate() : void
        {
            if (_invalidate != null)
            {
                _invalidate(this);
            }
            return;
        }// end function

        public function intersectY(param1:ZPP_AABB) : Boolean
        {
            if (param1.miny <= maxy)
            {
            }
            return miny <= param1.maxy;
        }// end function

        public function intersectX(param1:ZPP_AABB) : Boolean
        {
            if (param1.minx <= maxx)
            {
            }
            return minx <= param1.maxx;
        }// end function

        public function intersect(param1:ZPP_AABB) : Boolean
        {
            if (param1.miny <= maxy)
            {
            }
            if (miny <= param1.maxy)
            {
            }
            if (param1.minx <= maxx)
            {
            }
            return minx <= param1.maxx;
        }// end function

        public function height() : Number
        {
            return maxy - miny;
        }// end function

        public function getmin() : Vec2
        {
            var _loc_1:* = NaN;
            var _loc_2:* = NaN;
            var _loc_3:* = false;
            var _loc_4:* = null as Vec2;
            var _loc_5:* = false;
            var _loc_6:* = null as ZPP_Vec2;
            if (wrap_min == null)
            {
                _loc_1 = minx;
                _loc_2 = miny;
                _loc_3 = false;
                if (_loc_1 == _loc_1)
                {
                }
                if (_loc_2 != _loc_2)
                {
                    throw "Error: Vec2 components cannot be NaN";
                }
                if (ZPP_PubPool.poolVec2 == null)
                {
                    _loc_4 = new Vec2();
                }
                else
                {
                    _loc_4 = ZPP_PubPool.poolVec2;
                    ZPP_PubPool.poolVec2 = _loc_4.zpp_pool;
                    _loc_4.zpp_pool = null;
                    _loc_4.zpp_disp = false;
                    if (_loc_4 == ZPP_PubPool.nextVec2)
                    {
                        ZPP_PubPool.nextVec2 = null;
                    }
                }
                if (_loc_4.zpp_inner == null)
                {
                    _loc_5 = false;
                    if (ZPP_Vec2.zpp_pool == null)
                    {
                        _loc_6 = new ZPP_Vec2();
                    }
                    else
                    {
                        _loc_6 = ZPP_Vec2.zpp_pool;
                        ZPP_Vec2.zpp_pool = _loc_6.next;
                        _loc_6.next = null;
                    }
                    _loc_6.weak = false;
                    _loc_6._immutable = _loc_5;
                    _loc_6.x = _loc_1;
                    _loc_6.y = _loc_2;
                    _loc_4.zpp_inner = _loc_6;
                    _loc_4.zpp_inner.outer = _loc_4;
                }
                else
                {
                    if (_loc_4 != null)
                    {
                    }
                    if (_loc_4.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_6 = _loc_4.zpp_inner;
                    if (_loc_6._immutable)
                    {
                        throw "Error: Vec2 is immutable";
                    }
                    if (_loc_6._isimmutable != null)
                    {
                        _loc_6._isimmutable();
                    }
                    if (_loc_1 == _loc_1)
                    {
                    }
                    if (_loc_2 != _loc_2)
                    {
                        throw "Error: Vec2 components cannot be NaN";
                    }
                    if (_loc_4 != null)
                    {
                    }
                    if (_loc_4.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_6 = _loc_4.zpp_inner;
                    if (_loc_6._validate != null)
                    {
                        _loc_6._validate();
                    }
                    if (_loc_4.zpp_inner.x == _loc_1)
                    {
                        if (_loc_4 != null)
                        {
                        }
                        if (_loc_4.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_6 = _loc_4.zpp_inner;
                        if (_loc_6._validate != null)
                        {
                            _loc_6._validate();
                        }
                    }
                    if (_loc_4.zpp_inner.y != _loc_2)
                    {
                        _loc_4.zpp_inner.x = _loc_1;
                        _loc_4.zpp_inner.y = _loc_2;
                        _loc_6 = _loc_4.zpp_inner;
                        if (_loc_6._invalidate != null)
                        {
                            _loc_6._invalidate(_loc_6);
                        }
                    }
                }
                _loc_4.zpp_inner.weak = _loc_3;
                wrap_min = _loc_4;
                wrap_min.zpp_inner._inuse = true;
                if (_immutable)
                {
                    wrap_min.zpp_inner._immutable = true;
                }
                else
                {
                    wrap_min.zpp_inner._invalidate = mod_min;
                }
                wrap_min.zpp_inner._validate = dom_min;
            }
            return wrap_min;
        }// end function

        public function getmax() : Vec2
        {
            var _loc_1:* = NaN;
            var _loc_2:* = NaN;
            var _loc_3:* = false;
            var _loc_4:* = null as Vec2;
            var _loc_5:* = false;
            var _loc_6:* = null as ZPP_Vec2;
            if (wrap_max == null)
            {
                _loc_1 = maxx;
                _loc_2 = maxy;
                _loc_3 = false;
                if (_loc_1 == _loc_1)
                {
                }
                if (_loc_2 != _loc_2)
                {
                    throw "Error: Vec2 components cannot be NaN";
                }
                if (ZPP_PubPool.poolVec2 == null)
                {
                    _loc_4 = new Vec2();
                }
                else
                {
                    _loc_4 = ZPP_PubPool.poolVec2;
                    ZPP_PubPool.poolVec2 = _loc_4.zpp_pool;
                    _loc_4.zpp_pool = null;
                    _loc_4.zpp_disp = false;
                    if (_loc_4 == ZPP_PubPool.nextVec2)
                    {
                        ZPP_PubPool.nextVec2 = null;
                    }
                }
                if (_loc_4.zpp_inner == null)
                {
                    _loc_5 = false;
                    if (ZPP_Vec2.zpp_pool == null)
                    {
                        _loc_6 = new ZPP_Vec2();
                    }
                    else
                    {
                        _loc_6 = ZPP_Vec2.zpp_pool;
                        ZPP_Vec2.zpp_pool = _loc_6.next;
                        _loc_6.next = null;
                    }
                    _loc_6.weak = false;
                    _loc_6._immutable = _loc_5;
                    _loc_6.x = _loc_1;
                    _loc_6.y = _loc_2;
                    _loc_4.zpp_inner = _loc_6;
                    _loc_4.zpp_inner.outer = _loc_4;
                }
                else
                {
                    if (_loc_4 != null)
                    {
                    }
                    if (_loc_4.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_6 = _loc_4.zpp_inner;
                    if (_loc_6._immutable)
                    {
                        throw "Error: Vec2 is immutable";
                    }
                    if (_loc_6._isimmutable != null)
                    {
                        _loc_6._isimmutable();
                    }
                    if (_loc_1 == _loc_1)
                    {
                    }
                    if (_loc_2 != _loc_2)
                    {
                        throw "Error: Vec2 components cannot be NaN";
                    }
                    if (_loc_4 != null)
                    {
                    }
                    if (_loc_4.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_6 = _loc_4.zpp_inner;
                    if (_loc_6._validate != null)
                    {
                        _loc_6._validate();
                    }
                    if (_loc_4.zpp_inner.x == _loc_1)
                    {
                        if (_loc_4 != null)
                        {
                        }
                        if (_loc_4.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_6 = _loc_4.zpp_inner;
                        if (_loc_6._validate != null)
                        {
                            _loc_6._validate();
                        }
                    }
                    if (_loc_4.zpp_inner.y != _loc_2)
                    {
                        _loc_4.zpp_inner.x = _loc_1;
                        _loc_4.zpp_inner.y = _loc_2;
                        _loc_6 = _loc_4.zpp_inner;
                        if (_loc_6._invalidate != null)
                        {
                            _loc_6._invalidate(_loc_6);
                        }
                    }
                }
                _loc_4.zpp_inner.weak = _loc_3;
                wrap_max = _loc_4;
                wrap_max.zpp_inner._inuse = true;
                if (_immutable)
                {
                    wrap_max.zpp_inner._immutable = true;
                }
                else
                {
                    wrap_max.zpp_inner._invalidate = mod_max;
                }
                wrap_max.zpp_inner._validate = dom_max;
            }
            return wrap_max;
        }// end function

        public function free() : void
        {
            if (outer != null)
            {
                outer.zpp_inner = null;
                outer = null;
            }
            var _loc_1:* = null;
            wrap_max = null;
            wrap_min = _loc_1;
            _invalidate = null;
            _validate = null;
            return;
        }// end function

        public function dom_min() : void
        {
            if (_validate != null)
            {
                _validate();
            }
            wrap_min.zpp_inner.x = minx;
            wrap_min.zpp_inner.y = miny;
            return;
        }// end function

        public function dom_max() : void
        {
            if (_validate != null)
            {
                _validate();
            }
            wrap_max.zpp_inner.x = maxx;
            wrap_max.zpp_inner.y = maxy;
            return;
        }// end function

        public function copy() : ZPP_AABB
        {
            var _loc_1:* = null as ZPP_AABB;
            if (ZPP_AABB.zpp_pool == null)
            {
                _loc_1 = new ZPP_AABB();
            }
            else
            {
                _loc_1 = ZPP_AABB.zpp_pool;
                ZPP_AABB.zpp_pool = _loc_1.next;
                _loc_1.next = null;
            }
            _loc_1.minx = minx;
            _loc_1.miny = miny;
            _loc_1.maxx = maxx;
            _loc_1.maxy = maxy;
            return _loc_1;
        }// end function

        public function containsPoint(param1:ZPP_Vec2) : Boolean
        {
            if (param1.x >= minx)
            {
            }
            if (param1.x <= maxx)
            {
            }
            if (param1.y >= miny)
            {
            }
            return param1.y <= maxy;
        }// end function

        public function contains(param1:ZPP_AABB) : Boolean
        {
            if (param1.minx >= minx)
            {
            }
            if (param1.miny >= miny)
            {
            }
            if (param1.maxx <= maxx)
            {
            }
            return param1.maxy <= maxy;
        }// end function

        public function combine(param1:ZPP_AABB) : void
        {
            if (param1.minx < minx)
            {
                minx = param1.minx;
            }
            if (param1.maxx > maxx)
            {
                maxx = param1.maxx;
            }
            if (param1.miny < miny)
            {
                miny = param1.miny;
            }
            if (param1.maxy > maxy)
            {
                maxy = param1.maxy;
            }
            return;
        }// end function

        public function alloc() : void
        {
            return;
        }// end function

        public static function get(param1:Number, param2:Number, param3:Number, param4:Number) : ZPP_AABB
        {
            var _loc_5:* = null as ZPP_AABB;
            if (ZPP_AABB.zpp_pool == null)
            {
                _loc_5 = new ZPP_AABB();
            }
            else
            {
                _loc_5 = ZPP_AABB.zpp_pool;
                ZPP_AABB.zpp_pool = _loc_5.next;
                _loc_5.next = null;
            }
            _loc_5.minx = param1;
            _loc_5.miny = param2;
            _loc_5.maxx = param3;
            _loc_5.maxy = param4;
            return _loc_5;
        }// end function

    }
}
