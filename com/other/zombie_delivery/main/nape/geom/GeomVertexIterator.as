package nape.geom
{
    import flash.*;
    import zpp_nape.geom.*;
    import zpp_nape.util.*;

    public class GeomVertexIterator extends Object
    {
        public var zpp_inner:ZPP_GeomVertexIterator;

        public function GeomVertexIterator() : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            if (!ZPP_GeomVertexIterator.internal)
            {
                throw "Error: Cannot instantiate GeomVertexIterator";
            }
            return;
        }// end function

        public function next() : Vec2
        {
            var _loc_3:* = NaN;
            var _loc_4:* = NaN;
            var _loc_5:* = false;
            var _loc_6:* = null as Vec2;
            var _loc_7:* = false;
            var _loc_8:* = null as ZPP_Vec2;
            if (zpp_inner == null)
            {
                throw "Error: Iterator has been disposed";
            }
            var _loc_2:* = zpp_inner.ptr;
            if (_loc_2.wrap == null)
            {
                _loc_3 = _loc_2.x;
                _loc_4 = _loc_2.y;
                _loc_5 = false;
                if (_loc_3 == _loc_3)
                {
                }
                if (_loc_4 != _loc_4)
                {
                    throw "Error: Vec2 components cannot be NaN";
                }
                if (ZPP_PubPool.poolVec2 == null)
                {
                    _loc_6 = new Vec2();
                }
                else
                {
                    _loc_6 = ZPP_PubPool.poolVec2;
                    ZPP_PubPool.poolVec2 = _loc_6.zpp_pool;
                    _loc_6.zpp_pool = null;
                    _loc_6.zpp_disp = false;
                    if (_loc_6 == ZPP_PubPool.nextVec2)
                    {
                        ZPP_PubPool.nextVec2 = null;
                    }
                }
                if (_loc_6.zpp_inner == null)
                {
                    _loc_7 = false;
                    if (ZPP_Vec2.zpp_pool == null)
                    {
                        _loc_8 = new ZPP_Vec2();
                    }
                    else
                    {
                        _loc_8 = ZPP_Vec2.zpp_pool;
                        ZPP_Vec2.zpp_pool = _loc_8.next;
                        _loc_8.next = null;
                    }
                    _loc_8.weak = false;
                    _loc_8._immutable = _loc_7;
                    _loc_8.x = _loc_3;
                    _loc_8.y = _loc_4;
                    _loc_6.zpp_inner = _loc_8;
                    _loc_6.zpp_inner.outer = _loc_6;
                }
                else
                {
                    if (_loc_6 != null)
                    {
                    }
                    if (_loc_6.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_8 = _loc_6.zpp_inner;
                    if (_loc_8._immutable)
                    {
                        throw "Error: Vec2 is immutable";
                    }
                    if (_loc_8._isimmutable != null)
                    {
                        _loc_8._isimmutable();
                    }
                    if (_loc_3 == _loc_3)
                    {
                    }
                    if (_loc_4 != _loc_4)
                    {
                        throw "Error: Vec2 components cannot be NaN";
                    }
                    if (_loc_6 != null)
                    {
                    }
                    if (_loc_6.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_8 = _loc_6.zpp_inner;
                    if (_loc_8._validate != null)
                    {
                        _loc_8._validate();
                    }
                    if (_loc_6.zpp_inner.x == _loc_3)
                    {
                        if (_loc_6 != null)
                        {
                        }
                        if (_loc_6.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_8 = _loc_6.zpp_inner;
                        if (_loc_8._validate != null)
                        {
                            _loc_8._validate();
                        }
                    }
                    if (_loc_6.zpp_inner.y != _loc_4)
                    {
                        _loc_6.zpp_inner.x = _loc_3;
                        _loc_6.zpp_inner.y = _loc_4;
                        _loc_8 = _loc_6.zpp_inner;
                        if (_loc_8._invalidate != null)
                        {
                            _loc_8._invalidate(_loc_8);
                        }
                    }
                }
                _loc_6.zpp_inner.weak = _loc_5;
                _loc_2.wrap = _loc_6;
                _loc_2.wrap.zpp_inner._inuse = true;
                _loc_2.wrap.zpp_inner._invalidate = _loc_2.modwrap;
                _loc_2.wrap.zpp_inner._validate = _loc_2.getwrap;
            }
            var _loc_1:* = _loc_2.wrap;
            if (zpp_inner.forward)
            {
                zpp_inner.ptr = zpp_inner.ptr.next;
            }
            else
            {
                zpp_inner.ptr = zpp_inner.ptr.prev;
            }
            return _loc_1;
        }// end function

        public function hasNext() : Boolean
        {
            var _loc_2:* = null as ZPP_GeomVertexIterator;
            var _loc_3:* = null as ZPP_GeomVert;
            if (zpp_inner == null)
            {
                throw "Error: Iterator has been disposed";
            }
            if (zpp_inner.ptr == zpp_inner.start)
            {
            }
            var _loc_1:* = zpp_inner.first;
            zpp_inner.first = false;
            if (!_loc_1)
            {
                _loc_2 = zpp_inner;
                _loc_2.outer.zpp_inner = null;
                _loc_3 = null;
                _loc_2.start = _loc_3;
                _loc_2.ptr = _loc_3;
                _loc_2.next = ZPP_GeomVertexIterator.zpp_pool;
                ZPP_GeomVertexIterator.zpp_pool = _loc_2;
            }
            return _loc_1;
        }// end function

    }
}
