package nape.geom
{
    import flash.*;
    import flash.geom.*;
    import zpp_nape.geom.*;
    import zpp_nape.util.*;

    final public class AABB extends Object
    {
        public var zpp_inner:ZPP_AABB;

        public function AABB(param1:Number = 0, param2:Number = 0, param3:Number = 0, param4:Number = 0) : void
        {
            var _loc_5:* = null as ZPP_AABB;
            if (Boot.skip_constructor)
            {
                return;
            }
            zpp_inner = null;
            if (param1 == param1)
            {
            }
            if (param2 != param2)
            {
                throw "Error: AABB position cannot be NaN";
            }
            if (param3 == param3)
            {
            }
            if (param4 != param4)
            {
                throw "Error: AABB dimensions cannot be NaN";
            }
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
            _loc_5.maxx = param1 + param3;
            _loc_5.maxy = param2 + param4;
            zpp_inner = _loc_5;
            zpp_inner.outer = this;
            return;
        }// end function

        public function toString() : String
        {
            var _loc_1:* = zpp_inner;
            if (_loc_1._validate != null)
            {
                _loc_1._validate();
            }
            return zpp_inner.toString();
        }// end function

        public function toRect() : Rectangle
        {
            var _loc_1:* = zpp_inner;
            if (_loc_1._validate != null)
            {
                _loc_1._validate();
            }
            _loc_1 = zpp_inner;
            if (_loc_1._validate != null)
            {
                _loc_1._validate();
            }
            _loc_1 = zpp_inner;
            if (_loc_1._validate != null)
            {
                _loc_1._validate();
            }
            _loc_1 = zpp_inner;
            _loc_1 = zpp_inner;
            if (_loc_1._validate != null)
            {
                _loc_1._validate();
            }
            _loc_1 = zpp_inner;
            return new Rectangle(zpp_inner.minx, zpp_inner.miny, _loc_1.maxx - _loc_1.minx, _loc_1.maxy - _loc_1.miny);
        }// end function

        public function set_y(param1:Number) : Number
        {
            var _loc_2:* = null as ZPP_AABB;
            if (zpp_inner._immutable)
            {
                throw "Error: AABB is immutable";
            }
            _loc_2 = zpp_inner;
            if (_loc_2._validate != null)
            {
                _loc_2._validate();
            }
            if (zpp_inner.miny != param1)
            {
                if (param1 != param1)
                {
                    throw "Error: AABB::" + "y" + " cannot be NaN";
                }
                zpp_inner.maxy = zpp_inner.maxy + (param1 - zpp_inner.miny);
                zpp_inner.miny = param1;
                _loc_2 = zpp_inner;
                if (_loc_2._invalidate != null)
                {
                    _loc_2._invalidate(_loc_2);
                }
            }
            _loc_2 = zpp_inner;
            if (_loc_2._validate != null)
            {
                _loc_2._validate();
            }
            return zpp_inner.miny;
        }// end function

        public function set_x(param1:Number) : Number
        {
            var _loc_2:* = null as ZPP_AABB;
            if (zpp_inner._immutable)
            {
                throw "Error: AABB is immutable";
            }
            _loc_2 = zpp_inner;
            if (_loc_2._validate != null)
            {
                _loc_2._validate();
            }
            if (zpp_inner.minx != param1)
            {
                if (param1 != param1)
                {
                    throw "Error: AABB::" + "x" + " cannot be NaN";
                }
                zpp_inner.maxx = zpp_inner.maxx + (param1 - zpp_inner.minx);
                zpp_inner.minx = param1;
                _loc_2 = zpp_inner;
                if (_loc_2._invalidate != null)
                {
                    _loc_2._invalidate(_loc_2);
                }
            }
            _loc_2 = zpp_inner;
            if (_loc_2._validate != null)
            {
                _loc_2._validate();
            }
            return zpp_inner.minx;
        }// end function

        public function set_width(param1:Number) : Number
        {
            var _loc_2:* = null as ZPP_AABB;
            if (zpp_inner._immutable)
            {
                throw "Error: AABB is immutable";
            }
            _loc_2 = zpp_inner;
            if (_loc_2._validate != null)
            {
                _loc_2._validate();
            }
            _loc_2 = zpp_inner;
            if (_loc_2.maxx - _loc_2.minx != param1)
            {
                if (param1 != param1)
                {
                    throw "Error: AABB::" + "width" + " cannot be NaN";
                }
                if (param1 < 0)
                {
                    throw "Error: AABB::" + "width" + " (" + param1 + ") must be >= 0";
                }
                _loc_2 = zpp_inner;
                if (_loc_2._validate != null)
                {
                    _loc_2._validate();
                }
                zpp_inner.maxx = zpp_inner.minx + param1;
                _loc_2 = zpp_inner;
                if (_loc_2._invalidate != null)
                {
                    _loc_2._invalidate(_loc_2);
                }
            }
            _loc_2 = zpp_inner;
            if (_loc_2._validate != null)
            {
                _loc_2._validate();
            }
            _loc_2 = zpp_inner;
            return _loc_2.maxx - _loc_2.minx;
        }// end function

        public function set_min(param1:Vec2) : Vec2
        {
            var _loc_2:* = null as ZPP_AABB;
            var _loc_3:* = null as ZPP_Vec2;
            var _loc_8:* = null as Vec2;
            var _loc_9:* = null as ZPP_Vec2;
            if (param1 != null)
            {
            }
            if (param1.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            if (zpp_inner._immutable)
            {
                throw "Error: AABB is immutable";
            }
            if (param1 == null)
            {
                throw "Error: Cannot assign null to AABB::" + "min";
            }
            _loc_2 = zpp_inner;
            if (_loc_2._validate != null)
            {
                _loc_2._validate();
            }
            _loc_2 = zpp_inner;
            if (_loc_2._validate != null)
            {
                _loc_2._validate();
            }
            if (zpp_inner.minx == zpp_inner.minx)
            {
                _loc_2 = zpp_inner;
                if (_loc_2._validate != null)
                {
                    _loc_2._validate();
                }
                _loc_2 = zpp_inner;
                if (_loc_2._validate != null)
                {
                    _loc_2._validate();
                }
            }
            if (zpp_inner.miny != zpp_inner.miny)
            {
                throw "Error: AABB::" + "min" + " components cannot be NaN";
            }
            if (param1 != null)
            {
            }
            if (param1.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_3 = param1.zpp_inner;
            if (_loc_3._validate != null)
            {
                _loc_3._validate();
            }
            var _loc_4:* = zpp_inner.getmax();
            if (_loc_4 != null)
            {
            }
            if (_loc_4.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_3 = _loc_4.zpp_inner;
            if (_loc_3._validate != null)
            {
                _loc_3._validate();
            }
            if (param1.zpp_inner.x > _loc_4.zpp_inner.x)
            {
                throw "Error: Assignment would cause negative width";
            }
            if (param1 != null)
            {
            }
            if (param1.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_3 = param1.zpp_inner;
            if (_loc_3._validate != null)
            {
                _loc_3._validate();
            }
            _loc_4 = zpp_inner.getmax();
            if (_loc_4 != null)
            {
            }
            if (_loc_4.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_3 = _loc_4.zpp_inner;
            if (_loc_3._validate != null)
            {
                _loc_3._validate();
            }
            if (param1.zpp_inner.y > _loc_4.zpp_inner.y)
            {
                throw "Error: Assignment would cause negative height";
            }
            _loc_4 = zpp_inner.getmin();
            if (_loc_4 != null)
            {
            }
            if (_loc_4.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            if (param1 != null)
            {
            }
            if (param1.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_3 = _loc_4.zpp_inner;
            if (_loc_3._immutable)
            {
                throw "Error: Vec2 is immutable";
            }
            if (_loc_3._isimmutable != null)
            {
                _loc_3._isimmutable();
            }
            if (param1 == null)
            {
                throw "Error: Cannot assign null Vec2";
            }
            if (param1 != null)
            {
            }
            if (param1.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_3 = param1.zpp_inner;
            if (_loc_3._validate != null)
            {
                _loc_3._validate();
            }
            var _loc_6:* = param1.zpp_inner.x;
            if (param1 != null)
            {
            }
            if (param1.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_3 = param1.zpp_inner;
            if (_loc_3._validate != null)
            {
                _loc_3._validate();
            }
            var _loc_7:* = param1.zpp_inner.y;
            if (_loc_4 != null)
            {
            }
            if (_loc_4.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_3 = _loc_4.zpp_inner;
            if (_loc_3._immutable)
            {
                throw "Error: Vec2 is immutable";
            }
            if (_loc_3._isimmutable != null)
            {
                _loc_3._isimmutable();
            }
            if (_loc_6 == _loc_6)
            {
            }
            if (_loc_7 != _loc_7)
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
            _loc_3 = _loc_4.zpp_inner;
            if (_loc_3._validate != null)
            {
                _loc_3._validate();
            }
            if (_loc_4.zpp_inner.x == _loc_6)
            {
                if (_loc_4 != null)
                {
                }
                if (_loc_4.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_3 = _loc_4.zpp_inner;
                if (_loc_3._validate != null)
                {
                    _loc_3._validate();
                }
            }
            if (_loc_4.zpp_inner.y != _loc_7)
            {
                _loc_4.zpp_inner.x = _loc_6;
                _loc_4.zpp_inner.y = _loc_7;
                _loc_3 = _loc_4.zpp_inner;
                if (_loc_3._invalidate != null)
                {
                    _loc_3._invalidate(_loc_3);
                }
            }
            var _loc_5:* = _loc_4;
            if (param1.zpp_inner.weak)
            {
                if (param1 != null)
                {
                }
                if (param1.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_3 = param1.zpp_inner;
                if (_loc_3._immutable)
                {
                    throw "Error: Vec2 is immutable";
                }
                if (_loc_3._isimmutable != null)
                {
                    _loc_3._isimmutable();
                }
                if (param1.zpp_inner._inuse)
                {
                    throw "Error: This Vec2 is not disposable";
                }
                _loc_3 = param1.zpp_inner;
                param1.zpp_inner.outer = null;
                param1.zpp_inner = null;
                _loc_8 = param1;
                _loc_8.zpp_pool = null;
                if (ZPP_PubPool.nextVec2 != null)
                {
                    ZPP_PubPool.nextVec2.zpp_pool = _loc_8;
                }
                else
                {
                    ZPP_PubPool.poolVec2 = _loc_8;
                }
                ZPP_PubPool.nextVec2 = _loc_8;
                _loc_8.zpp_disp = true;
                _loc_9 = _loc_3;
                if (_loc_9.outer != null)
                {
                    _loc_9.outer.zpp_inner = null;
                    _loc_9.outer = null;
                }
                _loc_9._isimmutable = null;
                _loc_9._validate = null;
                _loc_9._invalidate = null;
                _loc_9.next = ZPP_Vec2.zpp_pool;
                ZPP_Vec2.zpp_pool = _loc_9;
            }
            else
            {
            }
            return zpp_inner.getmin();
        }// end function

        public function set_max(param1:Vec2) : Vec2
        {
            var _loc_2:* = null as ZPP_AABB;
            var _loc_3:* = null as ZPP_Vec2;
            var _loc_8:* = null as Vec2;
            var _loc_9:* = null as ZPP_Vec2;
            if (param1 != null)
            {
            }
            if (param1.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            if (zpp_inner._immutable)
            {
                throw "Error: AABB is immutable";
            }
            if (param1 == null)
            {
                throw "Error: Cannot assign null to AABB::" + "max";
            }
            _loc_2 = zpp_inner;
            if (_loc_2._validate != null)
            {
                _loc_2._validate();
            }
            _loc_2 = zpp_inner;
            if (_loc_2._validate != null)
            {
                _loc_2._validate();
            }
            if (zpp_inner.minx == zpp_inner.minx)
            {
                _loc_2 = zpp_inner;
                if (_loc_2._validate != null)
                {
                    _loc_2._validate();
                }
                _loc_2 = zpp_inner;
                if (_loc_2._validate != null)
                {
                    _loc_2._validate();
                }
            }
            if (zpp_inner.miny != zpp_inner.miny)
            {
                throw "Error: AABB::" + "max" + " components cannot be NaN";
            }
            if (param1 != null)
            {
            }
            if (param1.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_3 = param1.zpp_inner;
            if (_loc_3._validate != null)
            {
                _loc_3._validate();
            }
            var _loc_4:* = zpp_inner.getmin();
            if (_loc_4 != null)
            {
            }
            if (_loc_4.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_3 = _loc_4.zpp_inner;
            if (_loc_3._validate != null)
            {
                _loc_3._validate();
            }
            if (param1.zpp_inner.x < _loc_4.zpp_inner.x)
            {
                throw "Error: Assignment would cause negative width";
            }
            if (param1 != null)
            {
            }
            if (param1.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_3 = param1.zpp_inner;
            if (_loc_3._validate != null)
            {
                _loc_3._validate();
            }
            _loc_4 = zpp_inner.getmin();
            if (_loc_4 != null)
            {
            }
            if (_loc_4.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_3 = _loc_4.zpp_inner;
            if (_loc_3._validate != null)
            {
                _loc_3._validate();
            }
            if (param1.zpp_inner.y < _loc_4.zpp_inner.y)
            {
                throw "Error: Assignment would cause negative height";
            }
            _loc_4 = zpp_inner.getmax();
            if (_loc_4 != null)
            {
            }
            if (_loc_4.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            if (param1 != null)
            {
            }
            if (param1.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_3 = _loc_4.zpp_inner;
            if (_loc_3._immutable)
            {
                throw "Error: Vec2 is immutable";
            }
            if (_loc_3._isimmutable != null)
            {
                _loc_3._isimmutable();
            }
            if (param1 == null)
            {
                throw "Error: Cannot assign null Vec2";
            }
            if (param1 != null)
            {
            }
            if (param1.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_3 = param1.zpp_inner;
            if (_loc_3._validate != null)
            {
                _loc_3._validate();
            }
            var _loc_6:* = param1.zpp_inner.x;
            if (param1 != null)
            {
            }
            if (param1.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_3 = param1.zpp_inner;
            if (_loc_3._validate != null)
            {
                _loc_3._validate();
            }
            var _loc_7:* = param1.zpp_inner.y;
            if (_loc_4 != null)
            {
            }
            if (_loc_4.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_3 = _loc_4.zpp_inner;
            if (_loc_3._immutable)
            {
                throw "Error: Vec2 is immutable";
            }
            if (_loc_3._isimmutable != null)
            {
                _loc_3._isimmutable();
            }
            if (_loc_6 == _loc_6)
            {
            }
            if (_loc_7 != _loc_7)
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
            _loc_3 = _loc_4.zpp_inner;
            if (_loc_3._validate != null)
            {
                _loc_3._validate();
            }
            if (_loc_4.zpp_inner.x == _loc_6)
            {
                if (_loc_4 != null)
                {
                }
                if (_loc_4.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_3 = _loc_4.zpp_inner;
                if (_loc_3._validate != null)
                {
                    _loc_3._validate();
                }
            }
            if (_loc_4.zpp_inner.y != _loc_7)
            {
                _loc_4.zpp_inner.x = _loc_6;
                _loc_4.zpp_inner.y = _loc_7;
                _loc_3 = _loc_4.zpp_inner;
                if (_loc_3._invalidate != null)
                {
                    _loc_3._invalidate(_loc_3);
                }
            }
            var _loc_5:* = _loc_4;
            if (param1.zpp_inner.weak)
            {
                if (param1 != null)
                {
                }
                if (param1.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_3 = param1.zpp_inner;
                if (_loc_3._immutable)
                {
                    throw "Error: Vec2 is immutable";
                }
                if (_loc_3._isimmutable != null)
                {
                    _loc_3._isimmutable();
                }
                if (param1.zpp_inner._inuse)
                {
                    throw "Error: This Vec2 is not disposable";
                }
                _loc_3 = param1.zpp_inner;
                param1.zpp_inner.outer = null;
                param1.zpp_inner = null;
                _loc_8 = param1;
                _loc_8.zpp_pool = null;
                if (ZPP_PubPool.nextVec2 != null)
                {
                    ZPP_PubPool.nextVec2.zpp_pool = _loc_8;
                }
                else
                {
                    ZPP_PubPool.poolVec2 = _loc_8;
                }
                ZPP_PubPool.nextVec2 = _loc_8;
                _loc_8.zpp_disp = true;
                _loc_9 = _loc_3;
                if (_loc_9.outer != null)
                {
                    _loc_9.outer.zpp_inner = null;
                    _loc_9.outer = null;
                }
                _loc_9._isimmutable = null;
                _loc_9._validate = null;
                _loc_9._invalidate = null;
                _loc_9.next = ZPP_Vec2.zpp_pool;
                ZPP_Vec2.zpp_pool = _loc_9;
            }
            else
            {
            }
            return zpp_inner.getmax();
        }// end function

        public function set_height(param1:Number) : Number
        {
            var _loc_2:* = null as ZPP_AABB;
            if (zpp_inner._immutable)
            {
                throw "Error: AABB is immutable";
            }
            _loc_2 = zpp_inner;
            if (_loc_2._validate != null)
            {
                _loc_2._validate();
            }
            _loc_2 = zpp_inner;
            if (_loc_2.maxy - _loc_2.miny != param1)
            {
                if (param1 != param1)
                {
                    throw "Error: AABB::" + "height" + " cannot be NaN";
                }
                if (param1 < 0)
                {
                    throw "Error: AABB::" + "height" + " (" + param1 + ") must be >= 0";
                }
                _loc_2 = zpp_inner;
                if (_loc_2._validate != null)
                {
                    _loc_2._validate();
                }
                zpp_inner.maxy = zpp_inner.miny + param1;
                _loc_2 = zpp_inner;
                if (_loc_2._invalidate != null)
                {
                    _loc_2._invalidate(_loc_2);
                }
            }
            _loc_2 = zpp_inner;
            if (_loc_2._validate != null)
            {
                _loc_2._validate();
            }
            _loc_2 = zpp_inner;
            return _loc_2.maxy - _loc_2.miny;
        }// end function

        public function get_y() : Number
        {
            var _loc_1:* = zpp_inner;
            if (_loc_1._validate != null)
            {
                _loc_1._validate();
            }
            return zpp_inner.miny;
        }// end function

        public function get_x() : Number
        {
            var _loc_1:* = zpp_inner;
            if (_loc_1._validate != null)
            {
                _loc_1._validate();
            }
            return zpp_inner.minx;
        }// end function

        public function get_width() : Number
        {
            var _loc_1:* = zpp_inner;
            if (_loc_1._validate != null)
            {
                _loc_1._validate();
            }
            _loc_1 = zpp_inner;
            return _loc_1.maxx - _loc_1.minx;
        }// end function

        public function get_min() : Vec2
        {
            return zpp_inner.getmin();
        }// end function

        public function get_max() : Vec2
        {
            return zpp_inner.getmax();
        }// end function

        public function get_height() : Number
        {
            var _loc_1:* = zpp_inner;
            if (_loc_1._validate != null)
            {
                _loc_1._validate();
            }
            _loc_1 = zpp_inner;
            return _loc_1.maxy - _loc_1.miny;
        }// end function

        public function copy() : AABB
        {
            var _loc_2:* = null as ZPP_AABB;
            var _loc_1:* = zpp_inner;
            if (_loc_1._validate != null)
            {
                _loc_1._validate();
            }
            _loc_1 = zpp_inner;
            if (ZPP_AABB.zpp_pool == null)
            {
                _loc_2 = new ZPP_AABB();
            }
            else
            {
                _loc_2 = ZPP_AABB.zpp_pool;
                ZPP_AABB.zpp_pool = _loc_2.next;
                _loc_2.next = null;
            }
            _loc_2.minx = _loc_1.minx;
            _loc_2.miny = _loc_1.miny;
            _loc_2.maxx = _loc_1.maxx;
            _loc_2.maxy = _loc_1.maxy;
            return _loc_2.wrapper();
        }// end function

        public static function fromRect(param1:Rectangle) : AABB
        {
            if (param1 == null)
            {
                throw "Error: Cannot create AABB from null Rectangle";
            }
            return new AABB(param1.x, param1.y, param1.width, param1.height);
        }// end function

    }
}
