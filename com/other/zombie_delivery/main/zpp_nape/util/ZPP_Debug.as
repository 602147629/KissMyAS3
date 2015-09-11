package zpp_nape.util
{
    import flash.*;
    import nape.geom.*;
    import nape.util.*;
    import zpp_nape.geom.*;

    public class ZPP_Debug extends Object
    {
        public var xnull:Boolean;
        public var xform:ZPP_Mat23;
        public var xdet:Number;
        public var width:int;
        public var viewport:ZPP_AABB;
        public var tmpab:ZPP_AABB;
        public var outer:Debug;
        public var isbmp:Boolean;
        public var iport:ZPP_AABB;
        public var height:int;
        public var d_shape:ZPP_ShapeDebug;
        public var d_bmp:ZPP_BitmapDebug;
        public var bg_r:Number;
        public var bg_g:Number;
        public var bg_col:int;
        public var bg_b:Number;
        public static var internal:Boolean;

        public function ZPP_Debug(param1:int = 0, param2:int = 0) : void
        {
            var _loc_3:* = null as ZPP_AABB;
            if (Boot.skip_constructor)
            {
                return;
            }
            tmpab = null;
            iport = null;
            viewport = null;
            height = 0;
            width = 0;
            xdet = 0;
            xnull = false;
            xform = null;
            bg_col = 0;
            bg_b = 0;
            bg_g = 0;
            bg_r = 0;
            d_shape = null;
            d_bmp = null;
            isbmp = false;
            outer = null;
            xnull = true;
            xdet = 1;
            width = param1;
            height = param2;
            if (ZPP_AABB.zpp_pool == null)
            {
                _loc_3 = new ZPP_AABB();
            }
            else
            {
                _loc_3 = ZPP_AABB.zpp_pool;
                ZPP_AABB.zpp_pool = _loc_3.next;
                _loc_3.next = null;
            }
            _loc_3.minx = 0;
            _loc_3.miny = 0;
            _loc_3.maxx = param1;
            _loc_3.maxy = param2;
            viewport = _loc_3;
            if (ZPP_AABB.zpp_pool == null)
            {
                _loc_3 = new ZPP_AABB();
            }
            else
            {
                _loc_3 = ZPP_AABB.zpp_pool;
                ZPP_AABB.zpp_pool = _loc_3.next;
                _loc_3.next = null;
            }
            _loc_3.minx = 0;
            _loc_3.miny = 0;
            _loc_3.maxx = param1;
            _loc_3.maxy = param2;
            iport = _loc_3;
            tmpab = new ZPP_AABB();
            return;
        }// end function

        public function xform_invalidate() : void
        {
            var _loc_1:* = NaN;
            var _loc_2:* = NaN;
            var _loc_4:* = 0;
            var _loc_7:* = null as Vec2;
            var _loc_8:* = false;
            var _loc_9:* = null as ZPP_Vec2;
            var _loc_3:* = xform.outer;
            _loc_2 = _loc_3.zpp_inner.a * _loc_3.zpp_inner.d - _loc_3.zpp_inner.b * _loc_3.zpp_inner.c;
            if (_loc_2 < 0)
            {
                _loc_1 = -_loc_2;
            }
            else
            {
                _loc_1 = _loc_2;
            }
            if (_loc_1 == 0)
            {
                xdet = 0;
            }
            else
            {
                _loc_4 = 1597463007 - (0 >> 1);
                _loc_2 = 0;
                _loc_4.xdet = 0 / (_loc_2 * (1.5 - 0.5 * _loc_1 * _loc_2 * _loc_2));
            }
            if (xform.a == 1)
            {
            }
            if (xform.b == 0)
            {
            }
            if (xform.c == 0)
            {
            }
            if (xform.d == 1)
            {
            }
            if (xform.tx == 0)
            {
            }
            xnull = xform.ty == 0;
            _loc_3 = xform.outer.inverse();
            _loc_1 = 0;
            _loc_2 = 0;
            var _loc_6:* = false;
            if (_loc_1 == _loc_1)
            {
            }
            if (_loc_2 != _loc_2)
            {
                throw "Error: Vec2 components cannot be NaN";
            }
            if (ZPP_PubPool.poolVec2 == null)
            {
                _loc_7 = new Vec2();
            }
            else
            {
                _loc_7 = ZPP_PubPool.poolVec2;
                ZPP_PubPool.poolVec2 = _loc_7.zpp_pool;
                _loc_7.zpp_pool = null;
                _loc_7.zpp_disp = false;
                if (_loc_7 == ZPP_PubPool.nextVec2)
                {
                    ZPP_PubPool.nextVec2 = null;
                }
            }
            if (_loc_7.zpp_inner == null)
            {
                _loc_8 = false;
                if (ZPP_Vec2.zpp_pool == null)
                {
                    _loc_9 = new ZPP_Vec2();
                }
                else
                {
                    _loc_9 = ZPP_Vec2.zpp_pool;
                    ZPP_Vec2.zpp_pool = _loc_9.next;
                    _loc_9.next = null;
                }
                _loc_9.weak = false;
                _loc_9._immutable = _loc_8;
                _loc_9.x = _loc_1;
                _loc_9.y = _loc_2;
                _loc_7.zpp_inner = _loc_9;
                _loc_7.zpp_inner.outer = _loc_7;
            }
            else
            {
                if (_loc_7 != null)
                {
                }
                if (_loc_7.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_9 = _loc_7.zpp_inner;
                if (_loc_9._immutable)
                {
                    throw "Error: Vec2 is immutable";
                }
                if (_loc_9._isimmutable != null)
                {
                    _loc_9._isimmutable();
                }
                if (_loc_1 == _loc_1)
                {
                }
                if (_loc_2 != _loc_2)
                {
                    throw "Error: Vec2 components cannot be NaN";
                }
                if (_loc_7 != null)
                {
                }
                if (_loc_7.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_9 = _loc_7.zpp_inner;
                if (_loc_9._validate != null)
                {
                    _loc_9._validate();
                }
                if (_loc_7.zpp_inner.x == _loc_1)
                {
                    if (_loc_7 != null)
                    {
                    }
                    if (_loc_7.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_9 = _loc_7.zpp_inner;
                    if (_loc_9._validate != null)
                    {
                        _loc_9._validate();
                    }
                }
                if (_loc_7.zpp_inner.y != _loc_2)
                {
                    _loc_7.zpp_inner.x = _loc_1;
                    _loc_7.zpp_inner.y = _loc_2;
                    _loc_9 = _loc_7.zpp_inner;
                    if (_loc_9._invalidate != null)
                    {
                        _loc_9._invalidate(_loc_9);
                    }
                }
            }
            _loc_7.zpp_inner.weak = _loc_6;
            var _loc_5:* = _loc_7;
            _loc_7 = _loc_3.transform(_loc_5);
            if (_loc_7 != null)
            {
            }
            if (_loc_7.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_9 = _loc_7.zpp_inner;
            if (_loc_9._validate != null)
            {
                _loc_9._validate();
            }
            iport.minx = _loc_7.zpp_inner.x;
            if (_loc_7 != null)
            {
            }
            if (_loc_7.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_9 = _loc_7.zpp_inner;
            if (_loc_9._validate != null)
            {
                _loc_9._validate();
            }
            iport.miny = _loc_7.zpp_inner.y;
            iport.maxx = iport.minx;
            iport.maxy = iport.miny;
            if (_loc_7 != null)
            {
            }
            if (_loc_7.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_9 = _loc_7.zpp_inner;
            if (_loc_9._immutable)
            {
                throw "Error: Vec2 is immutable";
            }
            if (_loc_9._isimmutable != null)
            {
                _loc_9._isimmutable();
            }
            if (_loc_7.zpp_inner._inuse)
            {
                throw "Error: This Vec2 is not disposable";
            }
            _loc_9 = _loc_7.zpp_inner;
            _loc_7.zpp_inner.outer = null;
            _loc_7.zpp_inner = null;
            var _loc_10:* = _loc_7;
            _loc_10.zpp_pool = null;
            if (ZPP_PubPool.nextVec2 != null)
            {
                ZPP_PubPool.nextVec2.zpp_pool = _loc_10;
            }
            else
            {
                ZPP_PubPool.poolVec2 = _loc_10;
            }
            ZPP_PubPool.nextVec2 = _loc_10;
            _loc_10.zpp_disp = true;
            var _loc_11:* = _loc_9;
            if (_loc_11.outer != null)
            {
                _loc_11.outer.zpp_inner = null;
                _loc_11.outer = null;
            }
            _loc_11._isimmutable = null;
            _loc_11._validate = null;
            _loc_11._invalidate = null;
            _loc_11.next = ZPP_Vec2.zpp_pool;
            ZPP_Vec2.zpp_pool = _loc_11;
            _loc_1 = width;
            if (_loc_5 != null)
            {
            }
            if (_loc_5.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_9 = _loc_5.zpp_inner;
            if (_loc_9._immutable)
            {
                throw "Error: Vec2 is immutable";
            }
            if (_loc_9._isimmutable != null)
            {
                _loc_9._isimmutable();
            }
            if (_loc_5 != null)
            {
            }
            if (_loc_5.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_9 = _loc_5.zpp_inner;
            if (_loc_9._validate != null)
            {
                _loc_9._validate();
            }
            if (_loc_5.zpp_inner.x != _loc_1)
            {
                if (_loc_1 != _loc_1)
                {
                    throw "Error: Vec2::" + "x" + " cannot be NaN";
                }
                _loc_5.zpp_inner.x = _loc_1;
                _loc_9 = _loc_5.zpp_inner;
                if (_loc_9._invalidate != null)
                {
                    _loc_9._invalidate(_loc_9);
                }
            }
            if (_loc_5 != null)
            {
            }
            if (_loc_5.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_9 = _loc_5.zpp_inner;
            if (_loc_9._validate != null)
            {
                _loc_9._validate();
            }
            _loc_7 = _loc_3.transform(_loc_5);
            var _loc_12:* = iport;
            if (_loc_7 != null)
            {
            }
            if (_loc_7.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_9 = _loc_7.zpp_inner;
            if (_loc_9._validate != null)
            {
                _loc_9._validate();
            }
            _loc_1 = _loc_7.zpp_inner.x;
            if (_loc_7 != null)
            {
            }
            if (_loc_7.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_9 = _loc_7.zpp_inner;
            if (_loc_9._validate != null)
            {
                _loc_9._validate();
            }
            _loc_2 = _loc_7.zpp_inner.y;
            if (_loc_1 < _loc_12.minx)
            {
                _loc_12.minx = _loc_1;
            }
            if (_loc_1 > _loc_12.maxx)
            {
                _loc_12.maxx = _loc_1;
            }
            if (_loc_2 < _loc_12.miny)
            {
                _loc_12.miny = _loc_2;
            }
            if (_loc_2 > _loc_12.maxy)
            {
                _loc_12.maxy = _loc_2;
            }
            if (_loc_7 != null)
            {
            }
            if (_loc_7.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_9 = _loc_7.zpp_inner;
            if (_loc_9._immutable)
            {
                throw "Error: Vec2 is immutable";
            }
            if (_loc_9._isimmutable != null)
            {
                _loc_9._isimmutable();
            }
            if (_loc_7.zpp_inner._inuse)
            {
                throw "Error: This Vec2 is not disposable";
            }
            _loc_9 = _loc_7.zpp_inner;
            _loc_7.zpp_inner.outer = null;
            _loc_7.zpp_inner = null;
            _loc_10 = _loc_7;
            _loc_10.zpp_pool = null;
            if (ZPP_PubPool.nextVec2 != null)
            {
                ZPP_PubPool.nextVec2.zpp_pool = _loc_10;
            }
            else
            {
                ZPP_PubPool.poolVec2 = _loc_10;
            }
            ZPP_PubPool.nextVec2 = _loc_10;
            _loc_10.zpp_disp = true;
            _loc_11 = _loc_9;
            if (_loc_11.outer != null)
            {
                _loc_11.outer.zpp_inner = null;
                _loc_11.outer = null;
            }
            _loc_11._isimmutable = null;
            _loc_11._validate = null;
            _loc_11._invalidate = null;
            _loc_11.next = ZPP_Vec2.zpp_pool;
            ZPP_Vec2.zpp_pool = _loc_11;
            _loc_1 = height;
            if (_loc_5 != null)
            {
            }
            if (_loc_5.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_9 = _loc_5.zpp_inner;
            if (_loc_9._immutable)
            {
                throw "Error: Vec2 is immutable";
            }
            if (_loc_9._isimmutable != null)
            {
                _loc_9._isimmutable();
            }
            if (_loc_5 != null)
            {
            }
            if (_loc_5.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_9 = _loc_5.zpp_inner;
            if (_loc_9._validate != null)
            {
                _loc_9._validate();
            }
            if (_loc_5.zpp_inner.y != _loc_1)
            {
                if (_loc_1 != _loc_1)
                {
                    throw "Error: Vec2::" + "y" + " cannot be NaN";
                }
                _loc_5.zpp_inner.y = _loc_1;
                _loc_9 = _loc_5.zpp_inner;
                if (_loc_9._invalidate != null)
                {
                    _loc_9._invalidate(_loc_9);
                }
            }
            if (_loc_5 != null)
            {
            }
            if (_loc_5.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_9 = _loc_5.zpp_inner;
            if (_loc_9._validate != null)
            {
                _loc_9._validate();
            }
            _loc_7 = _loc_3.transform(_loc_5);
            _loc_12 = iport;
            if (_loc_7 != null)
            {
            }
            if (_loc_7.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_9 = _loc_7.zpp_inner;
            if (_loc_9._validate != null)
            {
                _loc_9._validate();
            }
            _loc_1 = _loc_7.zpp_inner.x;
            if (_loc_7 != null)
            {
            }
            if (_loc_7.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_9 = _loc_7.zpp_inner;
            if (_loc_9._validate != null)
            {
                _loc_9._validate();
            }
            _loc_2 = _loc_7.zpp_inner.y;
            if (_loc_1 < _loc_12.minx)
            {
                _loc_12.minx = _loc_1;
            }
            if (_loc_1 > _loc_12.maxx)
            {
                _loc_12.maxx = _loc_1;
            }
            if (_loc_2 < _loc_12.miny)
            {
                _loc_12.miny = _loc_2;
            }
            if (_loc_2 > _loc_12.maxy)
            {
                _loc_12.maxy = _loc_2;
            }
            if (_loc_7 != null)
            {
            }
            if (_loc_7.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_9 = _loc_7.zpp_inner;
            if (_loc_9._immutable)
            {
                throw "Error: Vec2 is immutable";
            }
            if (_loc_9._isimmutable != null)
            {
                _loc_9._isimmutable();
            }
            if (_loc_7.zpp_inner._inuse)
            {
                throw "Error: This Vec2 is not disposable";
            }
            _loc_9 = _loc_7.zpp_inner;
            _loc_7.zpp_inner.outer = null;
            _loc_7.zpp_inner = null;
            _loc_10 = _loc_7;
            _loc_10.zpp_pool = null;
            if (ZPP_PubPool.nextVec2 != null)
            {
                ZPP_PubPool.nextVec2.zpp_pool = _loc_10;
            }
            else
            {
                ZPP_PubPool.poolVec2 = _loc_10;
            }
            ZPP_PubPool.nextVec2 = _loc_10;
            _loc_10.zpp_disp = true;
            _loc_11 = _loc_9;
            if (_loc_11.outer != null)
            {
                _loc_11.outer.zpp_inner = null;
                _loc_11.outer = null;
            }
            _loc_11._isimmutable = null;
            _loc_11._validate = null;
            _loc_11._invalidate = null;
            _loc_11.next = ZPP_Vec2.zpp_pool;
            ZPP_Vec2.zpp_pool = _loc_11;
            if (_loc_5 != null)
            {
            }
            if (_loc_5.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_9 = _loc_5.zpp_inner;
            if (_loc_9._immutable)
            {
                throw "Error: Vec2 is immutable";
            }
            if (_loc_9._isimmutable != null)
            {
                _loc_9._isimmutable();
            }
            if (_loc_5 != null)
            {
            }
            if (_loc_5.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_9 = _loc_5.zpp_inner;
            if (_loc_9._validate != null)
            {
                _loc_9._validate();
            }
            if (_loc_5.zpp_inner.x != 0)
            {
                _loc_5.zpp_inner.x = 0;
                _loc_9 = _loc_5.zpp_inner;
                if (_loc_9._invalidate != null)
                {
                    _loc_9._invalidate(_loc_9);
                }
            }
            if (_loc_5 != null)
            {
            }
            if (_loc_5.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_9 = _loc_5.zpp_inner;
            if (_loc_9._validate != null)
            {
                _loc_9._validate();
            }
            _loc_7 = _loc_3.transform(_loc_5);
            _loc_12 = iport;
            if (_loc_7 != null)
            {
            }
            if (_loc_7.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_9 = _loc_7.zpp_inner;
            if (_loc_9._validate != null)
            {
                _loc_9._validate();
            }
            _loc_1 = _loc_7.zpp_inner.x;
            if (_loc_7 != null)
            {
            }
            if (_loc_7.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_9 = _loc_7.zpp_inner;
            if (_loc_9._validate != null)
            {
                _loc_9._validate();
            }
            _loc_2 = _loc_7.zpp_inner.y;
            if (_loc_1 < _loc_12.minx)
            {
                _loc_12.minx = _loc_1;
            }
            if (_loc_1 > _loc_12.maxx)
            {
                _loc_12.maxx = _loc_1;
            }
            if (_loc_2 < _loc_12.miny)
            {
                _loc_12.miny = _loc_2;
            }
            if (_loc_2 > _loc_12.maxy)
            {
                _loc_12.maxy = _loc_2;
            }
            if (_loc_7 != null)
            {
            }
            if (_loc_7.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_9 = _loc_7.zpp_inner;
            if (_loc_9._immutable)
            {
                throw "Error: Vec2 is immutable";
            }
            if (_loc_9._isimmutable != null)
            {
                _loc_9._isimmutable();
            }
            if (_loc_7.zpp_inner._inuse)
            {
                throw "Error: This Vec2 is not disposable";
            }
            _loc_9 = _loc_7.zpp_inner;
            _loc_7.zpp_inner.outer = null;
            _loc_7.zpp_inner = null;
            _loc_10 = _loc_7;
            _loc_10.zpp_pool = null;
            if (ZPP_PubPool.nextVec2 != null)
            {
                ZPP_PubPool.nextVec2.zpp_pool = _loc_10;
            }
            else
            {
                ZPP_PubPool.poolVec2 = _loc_10;
            }
            ZPP_PubPool.nextVec2 = _loc_10;
            _loc_10.zpp_disp = true;
            _loc_11 = _loc_9;
            if (_loc_11.outer != null)
            {
                _loc_11.outer.zpp_inner = null;
                _loc_11.outer = null;
            }
            _loc_11._isimmutable = null;
            _loc_11._validate = null;
            _loc_11._invalidate = null;
            _loc_11.next = ZPP_Vec2.zpp_pool;
            ZPP_Vec2.zpp_pool = _loc_11;
            if (_loc_5 != null)
            {
            }
            if (_loc_5.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_9 = _loc_5.zpp_inner;
            if (_loc_9._immutable)
            {
                throw "Error: Vec2 is immutable";
            }
            if (_loc_9._isimmutable != null)
            {
                _loc_9._isimmutable();
            }
            if (_loc_5.zpp_inner._inuse)
            {
                throw "Error: This Vec2 is not disposable";
            }
            _loc_9 = _loc_5.zpp_inner;
            _loc_5.zpp_inner.outer = null;
            _loc_5.zpp_inner = null;
            _loc_10 = _loc_5;
            _loc_10.zpp_pool = null;
            if (ZPP_PubPool.nextVec2 != null)
            {
                ZPP_PubPool.nextVec2.zpp_pool = _loc_10;
            }
            else
            {
                ZPP_PubPool.poolVec2 = _loc_10;
            }
            ZPP_PubPool.nextVec2 = _loc_10;
            _loc_10.zpp_disp = true;
            _loc_11 = _loc_9;
            if (_loc_11.outer != null)
            {
                _loc_11.outer.zpp_inner = null;
                _loc_11.outer = null;
            }
            _loc_11._isimmutable = null;
            _loc_11._validate = null;
            _loc_11._invalidate = null;
            _loc_11.next = ZPP_Vec2.zpp_pool;
            ZPP_Vec2.zpp_pool = _loc_11;
            return;
        }// end function

        public function sup_setbg(param1:int) : void
        {
            bg_r = param1 >> 16 & 255;
            bg_g = param1 >> 8 & 255;
            bg_b = param1 & 255;
            bg_col = param1;
            return;
        }// end function

        public function setform() : void
        {
            xform = new Mat23().zpp_inner;
            xform._invalidate = xform_invalidate;
            return;
        }// end function

        public function cull(param1:ZPP_AABB) : Boolean
        {
            var _loc_2:* = null as ZPP_AABB;
            var _loc_3:* = NaN;
            var _loc_4:* = NaN;
            var _loc_5:* = NaN;
            var _loc_6:* = NaN;
            var _loc_7:* = null as ZPP_AABB;
            if (xnull)
            {
                _loc_2 = viewport;
                if (_loc_2.miny <= param1.maxy)
                {
                }
                if (param1.miny <= _loc_2.maxy)
                {
                }
                if (_loc_2.minx <= param1.maxx)
                {
                }
                return param1.minx <= _loc_2.maxx;
            }
            else
            {
                _loc_3 = 0;
                _loc_4 = 0;
                _loc_5 = 0;
                _loc_6 = 0;
                _loc_5 = param1.minx;
                _loc_6 = param1.miny;
                tmpab.minx = xform.a * _loc_5 + xform.b * _loc_6 + xform.tx;
                tmpab.miny = xform.c * _loc_5 + xform.d * _loc_6 + xform.ty;
                tmpab.maxx = tmpab.minx;
                tmpab.maxy = tmpab.miny;
                _loc_5 = param1.maxx;
                _loc_3 = xform.a * _loc_5 + xform.b * _loc_6 + xform.tx;
                _loc_4 = xform.c * _loc_5 + xform.d * _loc_6 + xform.ty;
                _loc_2 = tmpab;
                if (_loc_3 < _loc_2.minx)
                {
                    _loc_2.minx = _loc_3;
                }
                if (_loc_3 > _loc_2.maxx)
                {
                    _loc_2.maxx = _loc_3;
                }
                if (_loc_4 < _loc_2.miny)
                {
                    _loc_2.miny = _loc_4;
                }
                if (_loc_4 > _loc_2.maxy)
                {
                    _loc_2.maxy = _loc_4;
                }
                _loc_6 = param1.maxy;
                _loc_3 = xform.a * _loc_5 + xform.b * _loc_6 + xform.tx;
                _loc_4 = xform.c * _loc_5 + xform.d * _loc_6 + xform.ty;
                _loc_2 = tmpab;
                if (_loc_3 < _loc_2.minx)
                {
                    _loc_2.minx = _loc_3;
                }
                if (_loc_3 > _loc_2.maxx)
                {
                    _loc_2.maxx = _loc_3;
                }
                if (_loc_4 < _loc_2.miny)
                {
                    _loc_2.miny = _loc_4;
                }
                if (_loc_4 > _loc_2.maxy)
                {
                    _loc_2.maxy = _loc_4;
                }
                _loc_5 = param1.minx;
                _loc_3 = xform.a * _loc_5 + xform.b * _loc_6 + xform.tx;
                _loc_4 = xform.c * _loc_5 + xform.d * _loc_6 + xform.ty;
                _loc_2 = tmpab;
                if (_loc_3 < _loc_2.minx)
                {
                    _loc_2.minx = _loc_3;
                }
                if (_loc_3 > _loc_2.maxx)
                {
                    _loc_2.maxx = _loc_3;
                }
                if (_loc_4 < _loc_2.miny)
                {
                    _loc_2.miny = _loc_4;
                }
                if (_loc_4 > _loc_2.maxy)
                {
                    _loc_2.maxy = _loc_4;
                }
                _loc_2 = tmpab;
                _loc_7 = viewport;
                if (_loc_7.miny <= _loc_2.maxy)
                {
                }
                if (_loc_2.miny <= _loc_7.maxy)
                {
                }
                if (_loc_7.minx <= _loc_2.maxx)
                {
                }
                return _loc_2.minx <= _loc_7.maxx;
            }
        }// end function

    }
}
