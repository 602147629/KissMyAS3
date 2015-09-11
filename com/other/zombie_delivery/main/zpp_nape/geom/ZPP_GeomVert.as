package zpp_nape.geom
{
    import flash.*;
    import nape.geom.*;
    import zpp_nape.util.*;

    public class ZPP_GeomVert extends Object
    {
        public var y:Number;
        public var x:Number;
        public var wrap:Vec2;
        public var prev:ZPP_GeomVert;
        public var next:ZPP_GeomVert;
        public var forced:Boolean;
        public static var zpp_pool:ZPP_GeomVert;

        public function ZPP_GeomVert() : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            forced = false;
            wrap = null;
            next = null;
            prev = null;
            y = 0;
            x = 0;
            return;
        }// end function

        public function wrapper() : Vec2
        {
            var _loc_1:* = NaN;
            var _loc_2:* = NaN;
            var _loc_3:* = false;
            var _loc_4:* = null as Vec2;
            var _loc_5:* = false;
            var _loc_6:* = null as ZPP_Vec2;
            if (wrap == null)
            {
                _loc_1 = x;
                _loc_2 = y;
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
                wrap = _loc_4;
                wrap.zpp_inner._inuse = true;
                wrap.zpp_inner._invalidate = modwrap;
                wrap.zpp_inner._validate = getwrap;
            }
            return wrap;
        }// end function

        public function modwrap(param1:ZPP_Vec2) : void
        {
            x = param1.x;
            y = param1.y;
            return;
        }// end function

        public function getwrap() : void
        {
            wrap.zpp_inner.x = x;
            wrap.zpp_inner.y = y;
            return;
        }// end function

        public function free() : void
        {
            var _loc_1:* = null as Vec2;
            var _loc_2:* = null as ZPP_Vec2;
            var _loc_3:* = null as Vec2;
            var _loc_4:* = null as ZPP_Vec2;
            if (wrap != null)
            {
                wrap.zpp_inner._inuse = false;
                _loc_1 = wrap;
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
                wrap = null;
            }
            var _loc_5:* = null;
            next = null;
            prev = _loc_5;
            return;
        }// end function

        public function alloc() : void
        {
            forced = false;
            return;
        }// end function

        public static function get(param1:Number, param2:Number) : ZPP_GeomVert
        {
            var _loc_3:* = null as ZPP_GeomVert;
            if (ZPP_GeomVert.zpp_pool == null)
            {
                _loc_3 = new ZPP_GeomVert();
            }
            else
            {
                _loc_3 = ZPP_GeomVert.zpp_pool;
                ZPP_GeomVert.zpp_pool = _loc_3.next;
                _loc_3.next = null;
            }
            _loc_3.forced = false;
            _loc_3.x = param1;
            _loc_3.y = param2;
            return _loc_3;
        }// end function

    }
}
