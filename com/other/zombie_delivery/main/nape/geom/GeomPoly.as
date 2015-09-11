package nape.geom
{
    import __AS3__.vec.*;
    import flash.*;
    import nape.*;
    import zpp_nape.*;
    import zpp_nape.geom.*;
    import zpp_nape.util.*;

    final public class GeomPoly extends Object
    {
        public var zpp_pool:GeomPoly;
        public var zpp_inner:ZPP_GeomPoly;
        public var zpp_disp:Boolean;

        public function GeomPoly(param1 = undefined) : void
        {
            var _loc_2:* = null as Array;
            var _loc_3:* = 0;
            var _loc_4:* = null;
            var _loc_5:* = null as Vec2;
            var _loc_6:* = null as ZPP_GeomVert;
            var _loc_7:* = NaN;
            var _loc_8:* = null as ZPP_Vec2;
            var _loc_9:* = NaN;
            var _loc_10:* = null as ZPP_GeomVert;
            var _loc_11:* = null as Vector.<Vec2>;
            var _loc_12:* = null as Vec2;
            var _loc_13:* = null as Vec2List;
            var _loc_14:* = null as Vec2Iterator;
            var _loc_15:* = null as GeomPoly;
            var _loc_16:* = false;
            var _loc_17:* = false;
            var _loc_18:* = null as ZPP_GeomVert;
            var _loc_19:* = null as ZPP_GeomVert;
            var _loc_20:* = null as ZPP_Vec2;
            var _loc_21:* = null as ZNPList_ZPP_Vec2;
            var _loc_22:* = null as ZNPNode_ZPP_Vec2;
            var _loc_23:* = null as ZNPNode_ZPP_Vec2;
            var _loc_24:* = null as ZPP_Vec2;
            if (Boot.skip_constructor)
            {
                return;
            }
            zpp_inner = null;
            zpp_pool = null;
            zpp_inner = new ZPP_GeomPoly(this);
            if (param1 != null)
            {
                if (param1 is Array)
                {
                    _loc_2 = param1;
                    _loc_3 = 0;
                    while (_loc_3 < _loc_2.length)
                    {
                        
                        _loc_4 = _loc_2[_loc_3];
                        _loc_3++;
                        if (_loc_4 == null)
                        {
                            throw "Error: Array<Vec2> contains null objects";
                        }
                        if (!(_loc_4 is Vec2))
                        {
                            throw "Error: Array<Vec2> contains non Vec2 objects";
                        }
                        _loc_5 = _loc_4;
                        if (_loc_5 != null)
                        {
                        }
                        if (_loc_5.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        if (_loc_5 != null)
                        {
                        }
                        if (_loc_5.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_8 = _loc_5.zpp_inner;
                        if (_loc_8._validate != null)
                        {
                            _loc_8._validate();
                        }
                        _loc_7 = _loc_5.zpp_inner.x;
                        if (_loc_5 != null)
                        {
                        }
                        if (_loc_5.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_8 = _loc_5.zpp_inner;
                        if (_loc_8._validate != null)
                        {
                            _loc_8._validate();
                        }
                        _loc_9 = _loc_5.zpp_inner.y;
                        if (ZPP_GeomVert.zpp_pool == null)
                        {
                            _loc_10 = new ZPP_GeomVert();
                        }
                        else
                        {
                            _loc_10 = ZPP_GeomVert.zpp_pool;
                            ZPP_GeomVert.zpp_pool = _loc_10.next;
                            _loc_10.next = null;
                        }
                        _loc_10.forced = false;
                        _loc_10.x = _loc_7;
                        _loc_10.y = _loc_9;
                        _loc_6 = _loc_10;
                        if (zpp_inner.vertices == null)
                        {
                            _loc_10 = _loc_6;
                            _loc_6.next = _loc_10;
                            _loc_10 = _loc_10;
                            _loc_6.prev = _loc_10;
                            zpp_inner.vertices = _loc_10;
                        }
                        else
                        {
                            _loc_6.prev = zpp_inner.vertices;
                            _loc_6.next = zpp_inner.vertices.next;
                            zpp_inner.vertices.next.prev = _loc_6;
                            zpp_inner.vertices.next = _loc_6;
                        }
                        zpp_inner.vertices = _loc_6;
                    }
                }
                else if (param1 is ZPP_Const.vec2vector)
                {
                    _loc_11 = param1;
                    _loc_3 = 0;
                    while (_loc_3 < _loc_11.length)
                    {
                        
                        _loc_5 = _loc_11[_loc_3];
                        _loc_3++;
                        if (_loc_5 == null)
                        {
                            throw "Error: flash.Vector<Vec2> contains null objects";
                        }
                        _loc_12 = _loc_5;
                        if (_loc_12 != null)
                        {
                        }
                        if (_loc_12.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        if (_loc_12 != null)
                        {
                        }
                        if (_loc_12.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_8 = _loc_12.zpp_inner;
                        if (_loc_8._validate != null)
                        {
                            _loc_8._validate();
                        }
                        _loc_7 = _loc_12.zpp_inner.x;
                        if (_loc_12 != null)
                        {
                        }
                        if (_loc_12.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_8 = _loc_12.zpp_inner;
                        if (_loc_8._validate != null)
                        {
                            _loc_8._validate();
                        }
                        _loc_9 = _loc_12.zpp_inner.y;
                        if (ZPP_GeomVert.zpp_pool == null)
                        {
                            _loc_10 = new ZPP_GeomVert();
                        }
                        else
                        {
                            _loc_10 = ZPP_GeomVert.zpp_pool;
                            ZPP_GeomVert.zpp_pool = _loc_10.next;
                            _loc_10.next = null;
                        }
                        _loc_10.forced = false;
                        _loc_10.x = _loc_7;
                        _loc_10.y = _loc_9;
                        _loc_6 = _loc_10;
                        if (zpp_inner.vertices == null)
                        {
                            _loc_10 = _loc_6;
                            _loc_6.next = _loc_10;
                            _loc_10 = _loc_10;
                            _loc_6.prev = _loc_10;
                            zpp_inner.vertices = _loc_10;
                        }
                        else
                        {
                            _loc_6.prev = zpp_inner.vertices;
                            _loc_6.next = zpp_inner.vertices.next;
                            zpp_inner.vertices.next.prev = _loc_6;
                            zpp_inner.vertices.next = _loc_6;
                        }
                        zpp_inner.vertices = _loc_6;
                    }
                }
                else if (param1 is Vec2List)
                {
                    _loc_13 = param1;
                    _loc_14 = _loc_13.iterator();
                    do
                    {
                        
                        _loc_14.zpp_critical = false;
                        _loc_3 = _loc_14.zpp_i;
                        (_loc_14.zpp_i + 1);
                        _loc_5 = _loc_14.zpp_inner.at(_loc_3);
                        if (_loc_5 == null)
                        {
                            throw "Error: Vec2List contains null objects";
                        }
                        if (_loc_5 != null)
                        {
                        }
                        if (_loc_5.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        if (_loc_5 != null)
                        {
                        }
                        if (_loc_5.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_8 = _loc_5.zpp_inner;
                        if (_loc_8._validate != null)
                        {
                            _loc_8._validate();
                        }
                        _loc_7 = _loc_5.zpp_inner.x;
                        if (_loc_5 != null)
                        {
                        }
                        if (_loc_5.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_8 = _loc_5.zpp_inner;
                        if (_loc_8._validate != null)
                        {
                            _loc_8._validate();
                        }
                        _loc_9 = _loc_5.zpp_inner.y;
                        if (ZPP_GeomVert.zpp_pool == null)
                        {
                            _loc_10 = new ZPP_GeomVert();
                        }
                        else
                        {
                            _loc_10 = ZPP_GeomVert.zpp_pool;
                            ZPP_GeomVert.zpp_pool = _loc_10.next;
                            _loc_10.next = null;
                        }
                        _loc_10.forced = false;
                        _loc_10.x = _loc_7;
                        _loc_10.y = _loc_9;
                        _loc_6 = _loc_10;
                        if (zpp_inner.vertices == null)
                        {
                            _loc_10 = _loc_6;
                            _loc_6.next = _loc_10;
                            _loc_10 = _loc_10;
                            _loc_6.prev = _loc_10;
                            zpp_inner.vertices = _loc_10;
                        }
                        else
                        {
                            _loc_6.prev = zpp_inner.vertices;
                            _loc_6.next = zpp_inner.vertices.next;
                            zpp_inner.vertices.next.prev = _loc_6;
                            zpp_inner.vertices.next = _loc_6;
                        }
                        zpp_inner.vertices = _loc_6;
                        _loc_14.zpp_inner.zpp_inner.valmod();
                        _loc_3 = _loc_14.zpp_inner.zpp_gl();
                        _loc_14.zpp_critical = true;
                    }while (_loc_14.zpp_i < _loc_3 ? (true) : (_loc_14.zpp_next = Vec2Iterator.zpp_pool, Vec2Iterator.zpp_pool = _loc_14, _loc_14.zpp_inner = null, false))
                }
                else if (param1 is GeomPoly)
                {
                    _loc_15 = param1;
                    if (_loc_15 != null)
                    {
                    }
                    if (_loc_15.zpp_disp)
                    {
                        throw "Error: " + "GeomPoly" + " has been disposed and cannot be used!";
                    }
                    _loc_6 = _loc_15.zpp_inner.vertices;
                    if (_loc_6 != null)
                    {
                        _loc_10 = _loc_6;
                        do
                        {
                            
                            _loc_7 = _loc_10.x;
                            _loc_9 = _loc_10.y;
                            _loc_16 = false;
                            if (_loc_7 == _loc_7)
                            {
                            }
                            if (_loc_9 != _loc_9)
                            {
                                throw "Error: Vec2 components cannot be NaN";
                            }
                            if (ZPP_PubPool.poolVec2 == null)
                            {
                                _loc_12 = new Vec2();
                            }
                            else
                            {
                                _loc_12 = ZPP_PubPool.poolVec2;
                                ZPP_PubPool.poolVec2 = _loc_12.zpp_pool;
                                _loc_12.zpp_pool = null;
                                _loc_12.zpp_disp = false;
                                if (_loc_12 == ZPP_PubPool.nextVec2)
                                {
                                    ZPP_PubPool.nextVec2 = null;
                                }
                            }
                            if (_loc_12.zpp_inner == null)
                            {
                                _loc_17 = false;
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
                                _loc_8._immutable = _loc_17;
                                _loc_8.x = _loc_7;
                                _loc_8.y = _loc_9;
                                _loc_12.zpp_inner = _loc_8;
                                _loc_12.zpp_inner.outer = _loc_12;
                            }
                            else
                            {
                                if (_loc_12 != null)
                                {
                                }
                                if (_loc_12.zpp_disp)
                                {
                                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                                }
                                _loc_8 = _loc_12.zpp_inner;
                                if (_loc_8._immutable)
                                {
                                    throw "Error: Vec2 is immutable";
                                }
                                if (_loc_8._isimmutable != null)
                                {
                                    _loc_8._isimmutable();
                                }
                                if (_loc_7 == _loc_7)
                                {
                                }
                                if (_loc_9 != _loc_9)
                                {
                                    throw "Error: Vec2 components cannot be NaN";
                                }
                                if (_loc_12 != null)
                                {
                                }
                                if (_loc_12.zpp_disp)
                                {
                                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                                }
                                _loc_8 = _loc_12.zpp_inner;
                                if (_loc_8._validate != null)
                                {
                                    _loc_8._validate();
                                }
                                if (_loc_12.zpp_inner.x == _loc_7)
                                {
                                    if (_loc_12 != null)
                                    {
                                    }
                                    if (_loc_12.zpp_disp)
                                    {
                                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                                    }
                                    _loc_8 = _loc_12.zpp_inner;
                                    if (_loc_8._validate != null)
                                    {
                                        _loc_8._validate();
                                    }
                                }
                                if (_loc_12.zpp_inner.y != _loc_9)
                                {
                                    _loc_12.zpp_inner.x = _loc_7;
                                    _loc_12.zpp_inner.y = _loc_9;
                                    _loc_8 = _loc_12.zpp_inner;
                                    if (_loc_8._invalidate != null)
                                    {
                                        _loc_8._invalidate(_loc_8);
                                    }
                                }
                            }
                            _loc_12.zpp_inner.weak = _loc_16;
                            _loc_5 = _loc_12;
                            _loc_10 = _loc_10.next;
                            if (_loc_5 != null)
                            {
                            }
                            if (_loc_5.zpp_disp)
                            {
                                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                            }
                            _loc_8 = _loc_5.zpp_inner;
                            if (_loc_8._validate != null)
                            {
                                _loc_8._validate();
                            }
                            _loc_7 = _loc_5.zpp_inner.x;
                            if (_loc_5 != null)
                            {
                            }
                            if (_loc_5.zpp_disp)
                            {
                                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                            }
                            _loc_8 = _loc_5.zpp_inner;
                            if (_loc_8._validate != null)
                            {
                                _loc_8._validate();
                            }
                            _loc_9 = _loc_5.zpp_inner.y;
                            if (ZPP_GeomVert.zpp_pool == null)
                            {
                                _loc_19 = new ZPP_GeomVert();
                            }
                            else
                            {
                                _loc_19 = ZPP_GeomVert.zpp_pool;
                                ZPP_GeomVert.zpp_pool = _loc_19.next;
                                _loc_19.next = null;
                            }
                            _loc_19.forced = false;
                            _loc_19.x = _loc_7;
                            _loc_19.y = _loc_9;
                            _loc_18 = _loc_19;
                            if (zpp_inner.vertices == null)
                            {
                                _loc_19 = _loc_18;
                                _loc_18.next = _loc_19;
                                _loc_19 = _loc_19;
                                _loc_18.prev = _loc_19;
                                zpp_inner.vertices = _loc_19;
                            }
                            else
                            {
                                _loc_18.prev = zpp_inner.vertices;
                                _loc_18.next = zpp_inner.vertices.next;
                                zpp_inner.vertices.next.prev = _loc_18;
                                zpp_inner.vertices.next = _loc_18;
                            }
                            zpp_inner.vertices = _loc_18;
                            if (_loc_5 != null)
                            {
                            }
                            if (_loc_5.zpp_disp)
                            {
                                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                            }
                            _loc_8 = _loc_5.zpp_inner;
                            if (_loc_8._immutable)
                            {
                                throw "Error: Vec2 is immutable";
                            }
                            if (_loc_8._isimmutable != null)
                            {
                                _loc_8._isimmutable();
                            }
                            if (_loc_5.zpp_inner._inuse)
                            {
                                throw "Error: This Vec2 is not disposable";
                            }
                            _loc_8 = _loc_5.zpp_inner;
                            _loc_5.zpp_inner.outer = null;
                            _loc_5.zpp_inner = null;
                            _loc_12 = _loc_5;
                            _loc_12.zpp_pool = null;
                            if (ZPP_PubPool.nextVec2 != null)
                            {
                                ZPP_PubPool.nextVec2.zpp_pool = _loc_12;
                            }
                            else
                            {
                                ZPP_PubPool.poolVec2 = _loc_12;
                            }
                            ZPP_PubPool.nextVec2 = _loc_12;
                            _loc_12.zpp_disp = true;
                            _loc_20 = _loc_8;
                            if (_loc_20.outer != null)
                            {
                                _loc_20.outer.zpp_inner = null;
                                _loc_20.outer = null;
                            }
                            _loc_20._isimmutable = null;
                            _loc_20._validate = null;
                            _loc_20._invalidate = null;
                            _loc_20.next = ZPP_Vec2.zpp_pool;
                            ZPP_Vec2.zpp_pool = _loc_20;
                        }while (_loc_10 != _loc_6)
                    }
                }
                else
                {
                    throw "Error: Invalid type for polygon object, should be Array<Vec2>, Vec2List, GeomPoly or for flash10+ flash.Vector<Vec2>";
                }
                skipForward(1);
                if (param1 is Array)
                {
                    _loc_2 = param1;
                    _loc_3 = 0;
                    while (_loc_3 < _loc_2.length)
                    {
                        
                        _loc_5 = _loc_2[_loc_3];
                        if (_loc_5.zpp_inner.weak)
                        {
                            if (_loc_5 != null)
                            {
                            }
                            if (_loc_5.zpp_disp)
                            {
                                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                            }
                            _loc_8 = _loc_5.zpp_inner;
                            if (_loc_8._immutable)
                            {
                                throw "Error: Vec2 is immutable";
                            }
                            if (_loc_8._isimmutable != null)
                            {
                                _loc_8._isimmutable();
                            }
                            if (_loc_5.zpp_inner._inuse)
                            {
                                throw "Error: This Vec2 is not disposable";
                            }
                            _loc_8 = _loc_5.zpp_inner;
                            _loc_5.zpp_inner.outer = null;
                            _loc_5.zpp_inner = null;
                            _loc_12 = _loc_5;
                            _loc_12.zpp_pool = null;
                            if (ZPP_PubPool.nextVec2 != null)
                            {
                                ZPP_PubPool.nextVec2.zpp_pool = _loc_12;
                            }
                            else
                            {
                                ZPP_PubPool.poolVec2 = _loc_12;
                            }
                            ZPP_PubPool.nextVec2 = _loc_12;
                            _loc_12.zpp_disp = true;
                            _loc_20 = _loc_8;
                            if (_loc_20.outer != null)
                            {
                                _loc_20.outer.zpp_inner = null;
                                _loc_20.outer = null;
                            }
                            _loc_20._isimmutable = null;
                            _loc_20._validate = null;
                            _loc_20._invalidate = null;
                            _loc_20.next = ZPP_Vec2.zpp_pool;
                            ZPP_Vec2.zpp_pool = _loc_20;
                        }
                        else
                        {
                        }
                        if (false)
                        {
                            _loc_2.splice(_loc_3, 1);
                            continue;
                        }
                        _loc_3++;
                    }
                }
                else if (param1 is ZPP_Const.vec2vector)
                {
                    _loc_11 = param1;
                    if (!_loc_11.fixed)
                    {
                        _loc_3 = 0;
                        while (_loc_3 < _loc_11.length)
                        {
                            
                            _loc_5 = _loc_11[_loc_3];
                            if (_loc_5.zpp_inner.weak)
                            {
                                if (_loc_5 != null)
                                {
                                }
                                if (_loc_5.zpp_disp)
                                {
                                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                                }
                                _loc_8 = _loc_5.zpp_inner;
                                if (_loc_8._immutable)
                                {
                                    throw "Error: Vec2 is immutable";
                                }
                                if (_loc_8._isimmutable != null)
                                {
                                    _loc_8._isimmutable();
                                }
                                if (_loc_5.zpp_inner._inuse)
                                {
                                    throw "Error: This Vec2 is not disposable";
                                }
                                _loc_8 = _loc_5.zpp_inner;
                                _loc_5.zpp_inner.outer = null;
                                _loc_5.zpp_inner = null;
                                _loc_12 = _loc_5;
                                _loc_12.zpp_pool = null;
                                if (ZPP_PubPool.nextVec2 != null)
                                {
                                    ZPP_PubPool.nextVec2.zpp_pool = _loc_12;
                                }
                                else
                                {
                                    ZPP_PubPool.poolVec2 = _loc_12;
                                }
                                ZPP_PubPool.nextVec2 = _loc_12;
                                _loc_12.zpp_disp = true;
                                _loc_20 = _loc_8;
                                if (_loc_20.outer != null)
                                {
                                    _loc_20.outer.zpp_inner = null;
                                    _loc_20.outer = null;
                                }
                                _loc_20._isimmutable = null;
                                _loc_20._validate = null;
                                _loc_20._invalidate = null;
                                _loc_20.next = ZPP_Vec2.zpp_pool;
                                ZPP_Vec2.zpp_pool = _loc_20;
                            }
                            else
                            {
                            }
                            if (false)
                            {
                                _loc_11.splice(_loc_3, 1);
                                continue;
                            }
                            _loc_3++;
                        }
                    }
                }
                else if (param1 is Vec2List)
                {
                    _loc_13 = param1;
                    if (_loc_13.zpp_inner._validate != null)
                    {
                        _loc_13.zpp_inner._validate();
                    }
                    _loc_21 = _loc_13.zpp_inner.inner;
                    _loc_22 = null;
                    _loc_23 = _loc_21.head;
                    while (_loc_23 != null)
                    {
                        
                        _loc_8 = _loc_23.elt;
                        if (_loc_8.outer.zpp_inner.weak)
                        {
                            _loc_23 = _loc_21.erase(_loc_22);
                            if (_loc_8.outer.zpp_inner.weak)
                            {
                                _loc_5 = _loc_8.outer;
                                if (_loc_5 != null)
                                {
                                }
                                if (_loc_5.zpp_disp)
                                {
                                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                                }
                                _loc_20 = _loc_5.zpp_inner;
                                if (_loc_20._immutable)
                                {
                                    throw "Error: Vec2 is immutable";
                                }
                                if (_loc_20._isimmutable != null)
                                {
                                    _loc_20._isimmutable();
                                }
                                if (_loc_5.zpp_inner._inuse)
                                {
                                    throw "Error: This Vec2 is not disposable";
                                }
                                _loc_20 = _loc_5.zpp_inner;
                                _loc_5.zpp_inner.outer = null;
                                _loc_5.zpp_inner = null;
                                _loc_12 = _loc_5;
                                _loc_12.zpp_pool = null;
                                if (ZPP_PubPool.nextVec2 != null)
                                {
                                    ZPP_PubPool.nextVec2.zpp_pool = _loc_12;
                                }
                                else
                                {
                                    ZPP_PubPool.poolVec2 = _loc_12;
                                }
                                ZPP_PubPool.nextVec2 = _loc_12;
                                _loc_12.zpp_disp = true;
                                _loc_24 = _loc_20;
                                if (_loc_24.outer != null)
                                {
                                    _loc_24.outer.zpp_inner = null;
                                    _loc_24.outer = null;
                                }
                                _loc_24._isimmutable = null;
                                _loc_24._validate = null;
                                _loc_24._invalidate = null;
                                _loc_24.next = ZPP_Vec2.zpp_pool;
                                ZPP_Vec2.zpp_pool = _loc_24;
                            }
                            else
                            {
                            }
                            continue;
                        }
                        _loc_22 = _loc_23;
                        _loc_23 = _loc_23.next;
                    }
                }
            }
            return;
        }// end function

        public function winding() : Winding
        {
            var _loc_1:* = NaN;
            var _loc_2:* = NaN;
            var _loc_3:* = null as ZPP_GeomVert;
            var _loc_4:* = null as ZPP_GeomVert;
            var _loc_5:* = null as ZPP_GeomVert;
            var _loc_6:* = null as ZPP_GeomVert;
            if (zpp_disp)
            {
                throw "Error: " + "GeomPoly" + " has been disposed and cannot be used!";
            }
            if (zpp_inner.vertices != null)
            {
            }
            if (zpp_inner.vertices.next != null)
            {
            }
            if (zpp_inner.vertices.prev == zpp_inner.vertices.next)
            {
                if (ZPP_Flags.Winding_UNDEFINED == null)
                {
                    ZPP_Flags.internal = true;
                    ZPP_Flags.Winding_UNDEFINED = new Winding();
                    ZPP_Flags.internal = false;
                }
                return ZPP_Flags.Winding_UNDEFINED;
            }
            else
            {
                _loc_2 = 0;
                _loc_3 = zpp_inner.vertices;
                _loc_4 = zpp_inner.vertices;
                if (_loc_3 != null)
                {
                    _loc_5 = _loc_3;
                    do
                    {
                        
                        _loc_6 = _loc_5;
                        _loc_2 = _loc_2 + _loc_6.x * (_loc_6.next.y - _loc_6.prev.y);
                        _loc_5 = _loc_5.next;
                    }while (_loc_5 != _loc_4)
                }
                _loc_1 = _loc_2 * 0.5;
                if (_loc_1 > 0)
                {
                    if (ZPP_Flags.Winding_CLOCKWISE == null)
                    {
                        ZPP_Flags.internal = true;
                        ZPP_Flags.Winding_CLOCKWISE = new Winding();
                        ZPP_Flags.internal = false;
                    }
                    return ZPP_Flags.Winding_CLOCKWISE;
                }
                else if (_loc_1 == 0)
                {
                    if (ZPP_Flags.Winding_UNDEFINED == null)
                    {
                        ZPP_Flags.internal = true;
                        ZPP_Flags.Winding_UNDEFINED = new Winding();
                        ZPP_Flags.internal = false;
                    }
                    return ZPP_Flags.Winding_UNDEFINED;
                }
                else
                {
                    if (ZPP_Flags.Winding_ANTICLOCKWISE == null)
                    {
                        ZPP_Flags.internal = true;
                        ZPP_Flags.Winding_ANTICLOCKWISE = new Winding();
                        ZPP_Flags.internal = false;
                    }
                    return ZPP_Flags.Winding_ANTICLOCKWISE;
                }
            }
        }// end function

        public function unshift(param1:Vec2) : GeomPoly
        {
            var _loc_4:* = null as ZPP_Vec2;
            var _loc_6:* = null as ZPP_GeomVert;
            var _loc_7:* = null as Vec2;
            var _loc_8:* = null as ZPP_Vec2;
            if (param1 != null)
            {
            }
            if (param1.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            if (param1 == null)
            {
                throw "Error: Cannot unshift null vertex";
            }
            if (param1 != null)
            {
            }
            if (param1.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_4 = param1.zpp_inner;
            if (_loc_4._validate != null)
            {
                _loc_4._validate();
            }
            var _loc_3:* = param1.zpp_inner.x;
            if (param1 != null)
            {
            }
            if (param1.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_4 = param1.zpp_inner;
            if (_loc_4._validate != null)
            {
                _loc_4._validate();
            }
            var _loc_5:* = param1.zpp_inner.y;
            if (ZPP_GeomVert.zpp_pool == null)
            {
                _loc_6 = new ZPP_GeomVert();
            }
            else
            {
                _loc_6 = ZPP_GeomVert.zpp_pool;
                ZPP_GeomVert.zpp_pool = _loc_6.next;
                _loc_6.next = null;
            }
            _loc_6.forced = false;
            _loc_6.x = _loc_3;
            _loc_6.y = _loc_5;
            var _loc_2:* = _loc_6;
            if (zpp_inner.vertices == null)
            {
                _loc_6 = _loc_2;
                _loc_2.next = _loc_6;
                _loc_6 = _loc_6;
                _loc_2.prev = _loc_6;
                zpp_inner.vertices = _loc_6;
            }
            else
            {
                _loc_2.next = zpp_inner.vertices;
                _loc_2.prev = zpp_inner.vertices.prev;
                zpp_inner.vertices.prev.next = _loc_2;
                zpp_inner.vertices.prev = _loc_2;
            }
            zpp_inner.vertices = _loc_2;
            if (param1.zpp_inner.weak)
            {
                if (param1 != null)
                {
                }
                if (param1.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_4 = param1.zpp_inner;
                if (_loc_4._immutable)
                {
                    throw "Error: Vec2 is immutable";
                }
                if (_loc_4._isimmutable != null)
                {
                    _loc_4._isimmutable();
                }
                if (param1.zpp_inner._inuse)
                {
                    throw "Error: This Vec2 is not disposable";
                }
                _loc_4 = param1.zpp_inner;
                param1.zpp_inner.outer = null;
                param1.zpp_inner = null;
                _loc_7 = param1;
                _loc_7.zpp_pool = null;
                if (ZPP_PubPool.nextVec2 != null)
                {
                    ZPP_PubPool.nextVec2.zpp_pool = _loc_7;
                }
                else
                {
                    ZPP_PubPool.poolVec2 = _loc_7;
                }
                ZPP_PubPool.nextVec2 = _loc_7;
                _loc_7.zpp_disp = true;
                _loc_8 = _loc_4;
                if (_loc_8.outer != null)
                {
                    _loc_8.outer.zpp_inner = null;
                    _loc_8.outer = null;
                }
                _loc_8._isimmutable = null;
                _loc_8._validate = null;
                _loc_8._invalidate = null;
                _loc_8.next = ZPP_Vec2.zpp_pool;
                ZPP_Vec2.zpp_pool = _loc_8;
            }
            else
            {
            }
            return this;
        }// end function

        public function triangularDecomposition(param1:Boolean = false, param2:GeomPolyList = undefined) : GeomPolyList
        {
            var _loc_5:* = null as GeomPolyList;
            var _loc_6:* = null as ZPP_PartitionedPoly;
            var _loc_7:* = null as ZNPList_ZPP_GeomVert;
            var _loc_8:* = null as ZPP_PartitionedPoly;
            var _loc_9:* = null as ZPP_GeomVert;
            var _loc_10:* = null as GeomPoly;
            if (zpp_disp)
            {
                throw "Error: " + "GeomPoly" + " has been disposed and cannot be used!";
            }
            if (zpp_inner.vertices != null)
            {
            }
            if (zpp_inner.vertices.next != null)
            {
            }
            if (zpp_inner.vertices.prev == zpp_inner.vertices.next)
            {
                throw "Error: Cannot decompose a degenerate polygon";
            }
            if (ZPP_Monotone.sharedPPoly == null)
            {
                ZPP_Monotone.sharedPPoly = new ZPP_PartitionedPoly();
            }
            var _loc_3:* = ZPP_Monotone.decompose(zpp_inner.vertices, ZPP_Monotone.sharedPPoly);
            if (ZPP_PartitionedPoly.sharedPPList == null)
            {
                ZPP_PartitionedPoly.sharedPPList = new ZNPList_ZPP_PartitionedPoly();
            }
            var _loc_4:* = _loc_3.extract_partitions(ZPP_PartitionedPoly.sharedPPList);
            if (param2 == null)
            {
                _loc_5 = new GeomPolyList();
            }
            else
            {
                _loc_5 = param2;
            }
            while (_loc_4.head != null)
            {
                
                _loc_6 = _loc_4.pop_unsafe();
                ZPP_Triangular.triangulate(_loc_6);
                if (param1)
                {
                    ZPP_Triangular.optimise(_loc_6);
                }
                if (ZPP_PartitionedPoly.sharedGVList == null)
                {
                    ZPP_PartitionedPoly.sharedGVList = new ZNPList_ZPP_GeomVert();
                }
                _loc_7 = _loc_6.extract(ZPP_PartitionedPoly.sharedGVList);
                _loc_8 = _loc_6;
                _loc_8.next = ZPP_PartitionedPoly.zpp_pool;
                ZPP_PartitionedPoly.zpp_pool = _loc_8;
                while (_loc_7.head != null)
                {
                    
                    _loc_9 = _loc_7.pop_unsafe();
                    _loc_10 = GeomPoly.get();
                    _loc_10.zpp_inner.vertices = _loc_9;
                    if (_loc_5.zpp_inner.reverse_flag)
                    {
                        _loc_5.push(_loc_10);
                        continue;
                    }
                    _loc_5.unshift(_loc_10);
                }
            }
            return _loc_5;
        }// end function

        public function transform(param1:Mat23) : GeomPoly
        {
            var _loc_4:* = null as ZPP_GeomVert;
            var _loc_5:* = null as ZPP_GeomVert;
            var _loc_6:* = NaN;
            if (zpp_disp)
            {
                throw "Error: " + "GeomPoly" + " has been disposed and cannot be used!";
            }
            if (param1 == null)
            {
                throw "Error: Cannot transform by null matrix";
            }
            var _loc_2:* = zpp_inner.vertices;
            var _loc_3:* = zpp_inner.vertices;
            if (_loc_2 != null)
            {
                _loc_4 = _loc_2;
                do
                {
                    
                    _loc_5 = _loc_4;
                    _loc_6 = param1.zpp_inner.a * _loc_5.x + param1.zpp_inner.b * _loc_5.y + param1.zpp_inner.tx;
                    _loc_5.y = param1.zpp_inner.c * _loc_5.x + param1.zpp_inner.d * _loc_5.y + param1.zpp_inner.ty;
                    _loc_5.x = _loc_6;
                    _loc_4 = _loc_4.next;
                }while (_loc_4 != _loc_3)
            }
            return this;
        }// end function

        public function top() : Vec2
        {
            var _loc_4:* = null as ZPP_GeomVert;
            var _loc_5:* = null as ZPP_GeomVert;
            var _loc_6:* = NaN;
            var _loc_7:* = NaN;
            var _loc_8:* = false;
            var _loc_9:* = null as Vec2;
            var _loc_10:* = false;
            var _loc_11:* = null as ZPP_Vec2;
            if (zpp_disp)
            {
                throw "Error: " + "GeomPoly" + " has been disposed and cannot be used!";
            }
            if (zpp_disp)
            {
                throw "Error: " + "GeomPoly" + " has been disposed and cannot be used!";
            }
            if (zpp_inner.vertices == null)
            {
                throw "Error: empty GeomPoly has no defineable topmost vertex";
            }
            var _loc_1:* = zpp_inner.vertices;
            var _loc_2:* = zpp_inner.vertices.next;
            var _loc_3:* = zpp_inner.vertices;
            if (_loc_2 != null)
            {
                _loc_4 = _loc_2;
                do
                {
                    
                    _loc_5 = _loc_4;
                    if (_loc_5.y < _loc_1.y)
                    {
                        _loc_1 = _loc_5;
                    }
                    _loc_4 = _loc_4.next;
                }while (_loc_4 != _loc_3)
            }
            if (_loc_1.wrap == null)
            {
                _loc_6 = _loc_1.x;
                _loc_7 = _loc_1.y;
                _loc_8 = false;
                if (_loc_6 == _loc_6)
                {
                }
                if (_loc_7 != _loc_7)
                {
                    throw "Error: Vec2 components cannot be NaN";
                }
                if (ZPP_PubPool.poolVec2 == null)
                {
                    _loc_9 = new Vec2();
                }
                else
                {
                    _loc_9 = ZPP_PubPool.poolVec2;
                    ZPP_PubPool.poolVec2 = _loc_9.zpp_pool;
                    _loc_9.zpp_pool = null;
                    _loc_9.zpp_disp = false;
                    if (_loc_9 == ZPP_PubPool.nextVec2)
                    {
                        ZPP_PubPool.nextVec2 = null;
                    }
                }
                if (_loc_9.zpp_inner == null)
                {
                    _loc_10 = false;
                    if (ZPP_Vec2.zpp_pool == null)
                    {
                        _loc_11 = new ZPP_Vec2();
                    }
                    else
                    {
                        _loc_11 = ZPP_Vec2.zpp_pool;
                        ZPP_Vec2.zpp_pool = _loc_11.next;
                        _loc_11.next = null;
                    }
                    _loc_11.weak = false;
                    _loc_11._immutable = _loc_10;
                    _loc_11.x = _loc_6;
                    _loc_11.y = _loc_7;
                    _loc_9.zpp_inner = _loc_11;
                    _loc_9.zpp_inner.outer = _loc_9;
                }
                else
                {
                    if (_loc_9 != null)
                    {
                    }
                    if (_loc_9.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_11 = _loc_9.zpp_inner;
                    if (_loc_11._immutable)
                    {
                        throw "Error: Vec2 is immutable";
                    }
                    if (_loc_11._isimmutable != null)
                    {
                        _loc_11._isimmutable();
                    }
                    if (_loc_6 == _loc_6)
                    {
                    }
                    if (_loc_7 != _loc_7)
                    {
                        throw "Error: Vec2 components cannot be NaN";
                    }
                    if (_loc_9 != null)
                    {
                    }
                    if (_loc_9.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_11 = _loc_9.zpp_inner;
                    if (_loc_11._validate != null)
                    {
                        _loc_11._validate();
                    }
                    if (_loc_9.zpp_inner.x == _loc_6)
                    {
                        if (_loc_9 != null)
                        {
                        }
                        if (_loc_9.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_11 = _loc_9.zpp_inner;
                        if (_loc_11._validate != null)
                        {
                            _loc_11._validate();
                        }
                    }
                    if (_loc_9.zpp_inner.y != _loc_7)
                    {
                        _loc_9.zpp_inner.x = _loc_6;
                        _loc_9.zpp_inner.y = _loc_7;
                        _loc_11 = _loc_9.zpp_inner;
                        if (_loc_11._invalidate != null)
                        {
                            _loc_11._invalidate(_loc_11);
                        }
                    }
                }
                _loc_9.zpp_inner.weak = _loc_8;
                _loc_1.wrap = _loc_9;
                _loc_1.wrap.zpp_inner._inuse = true;
                _loc_1.wrap.zpp_inner._invalidate = _loc_1.modwrap;
                _loc_1.wrap.zpp_inner._validate = _loc_1.getwrap;
            }
            return _loc_1.wrap;
        }// end function

        public function toString() : String
        {
            var _loc_4:* = null as ZPP_GeomVert;
            var _loc_5:* = null as ZPP_GeomVert;
            var _loc_1:* = "GeomPoly[";
            var _loc_2:* = zpp_inner.vertices;
            var _loc_3:* = zpp_inner.vertices;
            if (_loc_2 != null)
            {
                _loc_4 = _loc_2;
                do
                {
                    
                    _loc_5 = _loc_4;
                    if (_loc_5 != zpp_inner.vertices)
                    {
                        _loc_1 = _loc_1 + ",";
                    }
                    _loc_1 = _loc_1 + ("{" + _loc_5.x + "," + _loc_5.y + "}");
                    _loc_4 = _loc_4.next;
                }while (_loc_4 != _loc_3)
            }
            return _loc_1 + "]";
        }// end function

        public function skipForward(param1:int) : GeomPoly
        {
            if (zpp_disp)
            {
                throw "Error: " + "GeomPoly" + " has been disposed and cannot be used!";
            }
            if (zpp_inner.vertices != null)
            {
                if (param1 > 0)
                {
                    do
                    {
                        
                        zpp_inner.vertices = zpp_inner.vertices.next;
                        param1--;
                    }while (param1 > 0)
                }
                else if (param1 < 0)
                {
                    do
                    {
                        
                        zpp_inner.vertices = zpp_inner.vertices.prev;
                        param1++;
                    }while (param1 < 0)
                }
            }
            return this;
        }// end function

        public function skipBackwards(param1:int) : GeomPoly
        {
            if (zpp_disp)
            {
                throw "Error: " + "GeomPoly" + " has been disposed and cannot be used!";
            }
            return skipForward(-param1);
        }// end function

        public function size() : int
        {
            var _loc_4:* = null as ZPP_GeomVert;
            var _loc_5:* = null as ZPP_GeomVert;
            if (zpp_disp)
            {
                throw "Error: " + "GeomPoly" + " has been disposed and cannot be used!";
            }
            var _loc_1:* = 0;
            var _loc_2:* = zpp_inner.vertices;
            var _loc_3:* = zpp_inner.vertices;
            if (_loc_2 != null)
            {
                _loc_4 = _loc_2;
                do
                {
                    
                    _loc_5 = _loc_4;
                    _loc_1++;
                    _loc_4 = _loc_4.next;
                }while (_loc_4 != _loc_3)
            }
            return _loc_1;
        }// end function

        public function simplify(param1:Number) : GeomPoly
        {
            var _loc_2:* = null as ZPP_GeomVert;
            var _loc_3:* = null as GeomPoly;
            if (zpp_disp)
            {
                throw "Error: " + "GeomPoly" + " has been disposed and cannot be used!";
            }
            if (param1 <= 0)
            {
                throw "Error: Epsilon should be > 0 for simplifying a GeomPoly";
            }
            if (zpp_inner.vertices != null)
            {
            }
            if (zpp_inner.vertices.next != null)
            {
            }
            if (zpp_inner.vertices.prev == zpp_inner.vertices.next)
            {
                return copy();
            }
            else
            {
                _loc_2 = ZPP_Simplify.simplify(zpp_inner.vertices, param1);
                _loc_3 = GeomPoly.get();
                _loc_3.zpp_inner.vertices = _loc_2;
                return _loc_3;
            }
        }// end function

        public function simpleDecomposition(param1:GeomPolyList = undefined) : GeomPolyList
        {
            var _loc_3:* = null as GeomPolyList;
            var _loc_4:* = null as ZPP_GeomVert;
            var _loc_5:* = null as GeomPoly;
            if (zpp_disp)
            {
                throw "Error: " + "GeomPoly" + " has been disposed and cannot be used!";
            }
            if (zpp_inner.vertices != null)
            {
            }
            if (zpp_inner.vertices.next != null)
            {
            }
            if (zpp_inner.vertices.prev == zpp_inner.vertices.next)
            {
                throw "Error: Cannot decompose a degenerate polygon";
            }
            if (ZPP_PartitionedPoly.sharedGVList == null)
            {
                ZPP_PartitionedPoly.sharedGVList = new ZNPList_ZPP_GeomVert();
            }
            var _loc_2:* = ZPP_Simple.decompose(zpp_inner.vertices, ZPP_PartitionedPoly.sharedGVList);
            if (param1 == null)
            {
                _loc_3 = new GeomPolyList();
            }
            else
            {
                _loc_3 = param1;
            }
            while (_loc_2.head != null)
            {
                
                _loc_4 = _loc_2.pop_unsafe();
                _loc_5 = GeomPoly.get();
                _loc_5.zpp_inner.vertices = _loc_4;
                if (_loc_3.zpp_inner.reverse_flag)
                {
                    _loc_3.push(_loc_5);
                    continue;
                }
                _loc_3.unshift(_loc_5);
            }
            return _loc_3;
        }// end function

        public function shift() : GeomPoly
        {
            var _loc_2:* = null as ZPP_GeomVert;
            var _loc_3:* = null as ZPP_GeomVert;
            var _loc_4:* = null as Vec2;
            var _loc_5:* = null as ZPP_Vec2;
            var _loc_6:* = null as Vec2;
            var _loc_7:* = null as ZPP_Vec2;
            if (zpp_disp)
            {
                throw "Error: " + "GeomPoly" + " has been disposed and cannot be used!";
            }
            if (zpp_inner.vertices == null)
            {
                throw "Error: Cannot shift from empty polygon";
            }
            var _loc_1:* = zpp_inner.vertices;
            if (zpp_inner.vertices != null)
            {
            }
            if (zpp_inner.vertices.prev == zpp_inner.vertices)
            {
                _loc_2 = null;
                zpp_inner.vertices.prev = _loc_2;
                zpp_inner.vertices.next = _loc_2;
                _loc_2 = null;
                zpp_inner.vertices = _loc_2;
                zpp_inner.vertices = _loc_2;
            }
            else
            {
                _loc_2 = zpp_inner.vertices.next;
                zpp_inner.vertices.prev.next = zpp_inner.vertices.next;
                zpp_inner.vertices.next.prev = zpp_inner.vertices.prev;
                _loc_3 = null;
                zpp_inner.vertices.prev = _loc_3;
                zpp_inner.vertices.next = _loc_3;
                zpp_inner.vertices = null;
                zpp_inner.vertices = _loc_2;
            }
            _loc_2 = _loc_1;
            if (_loc_2.wrap != null)
            {
                _loc_2.wrap.zpp_inner._inuse = false;
                _loc_4 = _loc_2.wrap;
                if (_loc_4 != null)
                {
                }
                if (_loc_4.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_5 = _loc_4.zpp_inner;
                if (_loc_5._immutable)
                {
                    throw "Error: Vec2 is immutable";
                }
                if (_loc_5._isimmutable != null)
                {
                    _loc_5._isimmutable();
                }
                if (_loc_4.zpp_inner._inuse)
                {
                    throw "Error: This Vec2 is not disposable";
                }
                _loc_5 = _loc_4.zpp_inner;
                _loc_4.zpp_inner.outer = null;
                _loc_4.zpp_inner = null;
                _loc_6 = _loc_4;
                _loc_6.zpp_pool = null;
                if (ZPP_PubPool.nextVec2 != null)
                {
                    ZPP_PubPool.nextVec2.zpp_pool = _loc_6;
                }
                else
                {
                    ZPP_PubPool.poolVec2 = _loc_6;
                }
                ZPP_PubPool.nextVec2 = _loc_6;
                _loc_6.zpp_disp = true;
                _loc_7 = _loc_5;
                if (_loc_7.outer != null)
                {
                    _loc_7.outer.zpp_inner = null;
                    _loc_7.outer = null;
                }
                _loc_7._isimmutable = null;
                _loc_7._validate = null;
                _loc_7._invalidate = null;
                _loc_7.next = ZPP_Vec2.zpp_pool;
                ZPP_Vec2.zpp_pool = _loc_7;
                _loc_2.wrap = null;
            }
            _loc_3 = null;
            _loc_2.next = _loc_3;
            _loc_2.prev = _loc_3;
            _loc_2.next = ZPP_GeomVert.zpp_pool;
            ZPP_GeomVert.zpp_pool = _loc_2;
            return this;
        }// end function

        public function right() : Vec2
        {
            var _loc_4:* = null as ZPP_GeomVert;
            var _loc_5:* = null as ZPP_GeomVert;
            var _loc_6:* = NaN;
            var _loc_7:* = NaN;
            var _loc_8:* = false;
            var _loc_9:* = null as Vec2;
            var _loc_10:* = false;
            var _loc_11:* = null as ZPP_Vec2;
            if (zpp_disp)
            {
                throw "Error: " + "GeomPoly" + " has been disposed and cannot be used!";
            }
            if (zpp_disp)
            {
                throw "Error: " + "GeomPoly" + " has been disposed and cannot be used!";
            }
            if (zpp_inner.vertices == null)
            {
                throw "Error: empty GeomPoly has no defineable rightmmost vertex";
            }
            var _loc_1:* = zpp_inner.vertices;
            var _loc_2:* = zpp_inner.vertices.next;
            var _loc_3:* = zpp_inner.vertices;
            if (_loc_2 != null)
            {
                _loc_4 = _loc_2;
                do
                {
                    
                    _loc_5 = _loc_4;
                    if (_loc_5.x > _loc_1.x)
                    {
                        _loc_1 = _loc_5;
                    }
                    _loc_4 = _loc_4.next;
                }while (_loc_4 != _loc_3)
            }
            if (_loc_1.wrap == null)
            {
                _loc_6 = _loc_1.x;
                _loc_7 = _loc_1.y;
                _loc_8 = false;
                if (_loc_6 == _loc_6)
                {
                }
                if (_loc_7 != _loc_7)
                {
                    throw "Error: Vec2 components cannot be NaN";
                }
                if (ZPP_PubPool.poolVec2 == null)
                {
                    _loc_9 = new Vec2();
                }
                else
                {
                    _loc_9 = ZPP_PubPool.poolVec2;
                    ZPP_PubPool.poolVec2 = _loc_9.zpp_pool;
                    _loc_9.zpp_pool = null;
                    _loc_9.zpp_disp = false;
                    if (_loc_9 == ZPP_PubPool.nextVec2)
                    {
                        ZPP_PubPool.nextVec2 = null;
                    }
                }
                if (_loc_9.zpp_inner == null)
                {
                    _loc_10 = false;
                    if (ZPP_Vec2.zpp_pool == null)
                    {
                        _loc_11 = new ZPP_Vec2();
                    }
                    else
                    {
                        _loc_11 = ZPP_Vec2.zpp_pool;
                        ZPP_Vec2.zpp_pool = _loc_11.next;
                        _loc_11.next = null;
                    }
                    _loc_11.weak = false;
                    _loc_11._immutable = _loc_10;
                    _loc_11.x = _loc_6;
                    _loc_11.y = _loc_7;
                    _loc_9.zpp_inner = _loc_11;
                    _loc_9.zpp_inner.outer = _loc_9;
                }
                else
                {
                    if (_loc_9 != null)
                    {
                    }
                    if (_loc_9.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_11 = _loc_9.zpp_inner;
                    if (_loc_11._immutable)
                    {
                        throw "Error: Vec2 is immutable";
                    }
                    if (_loc_11._isimmutable != null)
                    {
                        _loc_11._isimmutable();
                    }
                    if (_loc_6 == _loc_6)
                    {
                    }
                    if (_loc_7 != _loc_7)
                    {
                        throw "Error: Vec2 components cannot be NaN";
                    }
                    if (_loc_9 != null)
                    {
                    }
                    if (_loc_9.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_11 = _loc_9.zpp_inner;
                    if (_loc_11._validate != null)
                    {
                        _loc_11._validate();
                    }
                    if (_loc_9.zpp_inner.x == _loc_6)
                    {
                        if (_loc_9 != null)
                        {
                        }
                        if (_loc_9.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_11 = _loc_9.zpp_inner;
                        if (_loc_11._validate != null)
                        {
                            _loc_11._validate();
                        }
                    }
                    if (_loc_9.zpp_inner.y != _loc_7)
                    {
                        _loc_9.zpp_inner.x = _loc_6;
                        _loc_9.zpp_inner.y = _loc_7;
                        _loc_11 = _loc_9.zpp_inner;
                        if (_loc_11._invalidate != null)
                        {
                            _loc_11._invalidate(_loc_11);
                        }
                    }
                }
                _loc_9.zpp_inner.weak = _loc_8;
                _loc_1.wrap = _loc_9;
                _loc_1.wrap.zpp_inner._inuse = true;
                _loc_1.wrap.zpp_inner._invalidate = _loc_1.modwrap;
                _loc_1.wrap.zpp_inner._validate = _loc_1.getwrap;
            }
            return _loc_1.wrap;
        }// end function

        public function push(param1:Vec2) : GeomPoly
        {
            var _loc_4:* = null as ZPP_Vec2;
            var _loc_6:* = null as ZPP_GeomVert;
            var _loc_7:* = null as Vec2;
            var _loc_8:* = null as ZPP_Vec2;
            if (zpp_disp)
            {
                throw "Error: " + "GeomPoly" + " has been disposed and cannot be used!";
            }
            if (param1 != null)
            {
            }
            if (param1.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            if (param1 == null)
            {
                throw "Error: Cannot push null vertex";
            }
            if (param1 != null)
            {
            }
            if (param1.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_4 = param1.zpp_inner;
            if (_loc_4._validate != null)
            {
                _loc_4._validate();
            }
            var _loc_3:* = param1.zpp_inner.x;
            if (param1 != null)
            {
            }
            if (param1.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_4 = param1.zpp_inner;
            if (_loc_4._validate != null)
            {
                _loc_4._validate();
            }
            var _loc_5:* = param1.zpp_inner.y;
            if (ZPP_GeomVert.zpp_pool == null)
            {
                _loc_6 = new ZPP_GeomVert();
            }
            else
            {
                _loc_6 = ZPP_GeomVert.zpp_pool;
                ZPP_GeomVert.zpp_pool = _loc_6.next;
                _loc_6.next = null;
            }
            _loc_6.forced = false;
            _loc_6.x = _loc_3;
            _loc_6.y = _loc_5;
            var _loc_2:* = _loc_6;
            if (zpp_inner.vertices == null)
            {
                _loc_6 = _loc_2;
                _loc_2.next = _loc_6;
                _loc_6 = _loc_6;
                _loc_2.prev = _loc_6;
                zpp_inner.vertices = _loc_6;
            }
            else
            {
                _loc_2.prev = zpp_inner.vertices;
                _loc_2.next = zpp_inner.vertices.next;
                zpp_inner.vertices.next.prev = _loc_2;
                zpp_inner.vertices.next = _loc_2;
            }
            zpp_inner.vertices = _loc_2;
            if (param1.zpp_inner.weak)
            {
                if (param1 != null)
                {
                }
                if (param1.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_4 = param1.zpp_inner;
                if (_loc_4._immutable)
                {
                    throw "Error: Vec2 is immutable";
                }
                if (_loc_4._isimmutable != null)
                {
                    _loc_4._isimmutable();
                }
                if (param1.zpp_inner._inuse)
                {
                    throw "Error: This Vec2 is not disposable";
                }
                _loc_4 = param1.zpp_inner;
                param1.zpp_inner.outer = null;
                param1.zpp_inner = null;
                _loc_7 = param1;
                _loc_7.zpp_pool = null;
                if (ZPP_PubPool.nextVec2 != null)
                {
                    ZPP_PubPool.nextVec2.zpp_pool = _loc_7;
                }
                else
                {
                    ZPP_PubPool.poolVec2 = _loc_7;
                }
                ZPP_PubPool.nextVec2 = _loc_7;
                _loc_7.zpp_disp = true;
                _loc_8 = _loc_4;
                if (_loc_8.outer != null)
                {
                    _loc_8.outer.zpp_inner = null;
                    _loc_8.outer = null;
                }
                _loc_8._isimmutable = null;
                _loc_8._validate = null;
                _loc_8._invalidate = null;
                _loc_8.next = ZPP_Vec2.zpp_pool;
                ZPP_Vec2.zpp_pool = _loc_8;
            }
            else
            {
            }
            return this;
        }// end function

        public function pop() : GeomPoly
        {
            var _loc_2:* = null as ZPP_GeomVert;
            var _loc_3:* = null as ZPP_GeomVert;
            var _loc_4:* = null as Vec2;
            var _loc_5:* = null as ZPP_Vec2;
            var _loc_6:* = null as Vec2;
            var _loc_7:* = null as ZPP_Vec2;
            if (zpp_disp)
            {
                throw "Error: " + "GeomPoly" + " has been disposed and cannot be used!";
            }
            if (zpp_inner.vertices == null)
            {
                throw "Error: Cannot pop from empty polygon";
            }
            var _loc_1:* = zpp_inner.vertices;
            if (zpp_inner.vertices != null)
            {
            }
            if (zpp_inner.vertices.prev == zpp_inner.vertices)
            {
                _loc_2 = null;
                zpp_inner.vertices.prev = _loc_2;
                zpp_inner.vertices.next = _loc_2;
                zpp_inner.vertices = null;
            }
            else
            {
                _loc_2 = zpp_inner.vertices.prev;
                zpp_inner.vertices.prev.next = zpp_inner.vertices.next;
                zpp_inner.vertices.next.prev = zpp_inner.vertices.prev;
                _loc_3 = null;
                zpp_inner.vertices.prev = _loc_3;
                zpp_inner.vertices.next = _loc_3;
                zpp_inner.vertices = null;
                zpp_inner.vertices = _loc_2;
            }
            _loc_2 = _loc_1;
            if (_loc_2.wrap != null)
            {
                _loc_2.wrap.zpp_inner._inuse = false;
                _loc_4 = _loc_2.wrap;
                if (_loc_4 != null)
                {
                }
                if (_loc_4.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_5 = _loc_4.zpp_inner;
                if (_loc_5._immutable)
                {
                    throw "Error: Vec2 is immutable";
                }
                if (_loc_5._isimmutable != null)
                {
                    _loc_5._isimmutable();
                }
                if (_loc_4.zpp_inner._inuse)
                {
                    throw "Error: This Vec2 is not disposable";
                }
                _loc_5 = _loc_4.zpp_inner;
                _loc_4.zpp_inner.outer = null;
                _loc_4.zpp_inner = null;
                _loc_6 = _loc_4;
                _loc_6.zpp_pool = null;
                if (ZPP_PubPool.nextVec2 != null)
                {
                    ZPP_PubPool.nextVec2.zpp_pool = _loc_6;
                }
                else
                {
                    ZPP_PubPool.poolVec2 = _loc_6;
                }
                ZPP_PubPool.nextVec2 = _loc_6;
                _loc_6.zpp_disp = true;
                _loc_7 = _loc_5;
                if (_loc_7.outer != null)
                {
                    _loc_7.outer.zpp_inner = null;
                    _loc_7.outer = null;
                }
                _loc_7._isimmutable = null;
                _loc_7._validate = null;
                _loc_7._invalidate = null;
                _loc_7.next = ZPP_Vec2.zpp_pool;
                ZPP_Vec2.zpp_pool = _loc_7;
                _loc_2.wrap = null;
            }
            _loc_3 = null;
            _loc_2.next = _loc_3;
            _loc_2.prev = _loc_3;
            _loc_2.next = ZPP_GeomVert.zpp_pool;
            ZPP_GeomVert.zpp_pool = _loc_2;
            return this;
        }// end function

        public function monotoneDecomposition(param1:GeomPolyList = undefined) : GeomPolyList
        {
            var _loc_4:* = null as GeomPolyList;
            var _loc_5:* = null as ZPP_GeomVert;
            var _loc_6:* = null as GeomPoly;
            if (zpp_disp)
            {
                throw "Error: " + "GeomPoly" + " has been disposed and cannot be used!";
            }
            if (zpp_inner.vertices != null)
            {
            }
            if (zpp_inner.vertices.next != null)
            {
            }
            if (zpp_inner.vertices.prev == zpp_inner.vertices.next)
            {
                throw "Error: Cannot decompose a degenerate polygon";
            }
            if (ZPP_Monotone.sharedPPoly == null)
            {
                ZPP_Monotone.sharedPPoly = new ZPP_PartitionedPoly();
            }
            var _loc_2:* = ZPP_Monotone.decompose(zpp_inner.vertices, ZPP_Monotone.sharedPPoly);
            if (ZPP_PartitionedPoly.sharedGVList == null)
            {
                ZPP_PartitionedPoly.sharedGVList = new ZNPList_ZPP_GeomVert();
            }
            var _loc_3:* = _loc_2.extract(ZPP_PartitionedPoly.sharedGVList);
            if (param1 == null)
            {
                _loc_4 = new GeomPolyList();
            }
            else
            {
                _loc_4 = param1;
            }
            while (_loc_3.head != null)
            {
                
                _loc_5 = _loc_3.pop_unsafe();
                _loc_6 = GeomPoly.get();
                _loc_6.zpp_inner.vertices = _loc_5;
                if (_loc_4.zpp_inner.reverse_flag)
                {
                    _loc_4.push(_loc_6);
                    continue;
                }
                _loc_4.unshift(_loc_6);
            }
            return _loc_4;
        }// end function

        public function left() : Vec2
        {
            var _loc_4:* = null as ZPP_GeomVert;
            var _loc_5:* = null as ZPP_GeomVert;
            var _loc_6:* = NaN;
            var _loc_7:* = NaN;
            var _loc_8:* = false;
            var _loc_9:* = null as Vec2;
            var _loc_10:* = false;
            var _loc_11:* = null as ZPP_Vec2;
            if (zpp_disp)
            {
                throw "Error: " + "GeomPoly" + " has been disposed and cannot be used!";
            }
            if (zpp_disp)
            {
                throw "Error: " + "GeomPoly" + " has been disposed and cannot be used!";
            }
            if (zpp_inner.vertices == null)
            {
                throw "Error: empty GeomPoly has no defineable leftmost vertex";
            }
            var _loc_1:* = zpp_inner.vertices;
            var _loc_2:* = zpp_inner.vertices.next;
            var _loc_3:* = zpp_inner.vertices;
            if (_loc_2 != null)
            {
                _loc_4 = _loc_2;
                do
                {
                    
                    _loc_5 = _loc_4;
                    if (_loc_5.x < _loc_1.x)
                    {
                        _loc_1 = _loc_5;
                    }
                    _loc_4 = _loc_4.next;
                }while (_loc_4 != _loc_3)
            }
            if (_loc_1.wrap == null)
            {
                _loc_6 = _loc_1.x;
                _loc_7 = _loc_1.y;
                _loc_8 = false;
                if (_loc_6 == _loc_6)
                {
                }
                if (_loc_7 != _loc_7)
                {
                    throw "Error: Vec2 components cannot be NaN";
                }
                if (ZPP_PubPool.poolVec2 == null)
                {
                    _loc_9 = new Vec2();
                }
                else
                {
                    _loc_9 = ZPP_PubPool.poolVec2;
                    ZPP_PubPool.poolVec2 = _loc_9.zpp_pool;
                    _loc_9.zpp_pool = null;
                    _loc_9.zpp_disp = false;
                    if (_loc_9 == ZPP_PubPool.nextVec2)
                    {
                        ZPP_PubPool.nextVec2 = null;
                    }
                }
                if (_loc_9.zpp_inner == null)
                {
                    _loc_10 = false;
                    if (ZPP_Vec2.zpp_pool == null)
                    {
                        _loc_11 = new ZPP_Vec2();
                    }
                    else
                    {
                        _loc_11 = ZPP_Vec2.zpp_pool;
                        ZPP_Vec2.zpp_pool = _loc_11.next;
                        _loc_11.next = null;
                    }
                    _loc_11.weak = false;
                    _loc_11._immutable = _loc_10;
                    _loc_11.x = _loc_6;
                    _loc_11.y = _loc_7;
                    _loc_9.zpp_inner = _loc_11;
                    _loc_9.zpp_inner.outer = _loc_9;
                }
                else
                {
                    if (_loc_9 != null)
                    {
                    }
                    if (_loc_9.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_11 = _loc_9.zpp_inner;
                    if (_loc_11._immutable)
                    {
                        throw "Error: Vec2 is immutable";
                    }
                    if (_loc_11._isimmutable != null)
                    {
                        _loc_11._isimmutable();
                    }
                    if (_loc_6 == _loc_6)
                    {
                    }
                    if (_loc_7 != _loc_7)
                    {
                        throw "Error: Vec2 components cannot be NaN";
                    }
                    if (_loc_9 != null)
                    {
                    }
                    if (_loc_9.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_11 = _loc_9.zpp_inner;
                    if (_loc_11._validate != null)
                    {
                        _loc_11._validate();
                    }
                    if (_loc_9.zpp_inner.x == _loc_6)
                    {
                        if (_loc_9 != null)
                        {
                        }
                        if (_loc_9.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_11 = _loc_9.zpp_inner;
                        if (_loc_11._validate != null)
                        {
                            _loc_11._validate();
                        }
                    }
                    if (_loc_9.zpp_inner.y != _loc_7)
                    {
                        _loc_9.zpp_inner.x = _loc_6;
                        _loc_9.zpp_inner.y = _loc_7;
                        _loc_11 = _loc_9.zpp_inner;
                        if (_loc_11._invalidate != null)
                        {
                            _loc_11._invalidate(_loc_11);
                        }
                    }
                }
                _loc_9.zpp_inner.weak = _loc_8;
                _loc_1.wrap = _loc_9;
                _loc_1.wrap.zpp_inner._inuse = true;
                _loc_1.wrap.zpp_inner._invalidate = _loc_1.modwrap;
                _loc_1.wrap.zpp_inner._validate = _loc_1.getwrap;
            }
            return _loc_1.wrap;
        }// end function

        public function iterator() : GeomVertexIterator
        {
            if (zpp_disp)
            {
                throw "Error: " + "GeomPoly" + " has been disposed and cannot be used!";
            }
            return ZPP_GeomVertexIterator.get(zpp_inner.vertices, true);
        }// end function

        public function isSimple() : Boolean
        {
            if (zpp_disp)
            {
                throw "Error: " + "GeomPoly" + " has been disposed and cannot be used!";
            }
            if (zpp_inner.vertices != null)
            {
            }
            if (zpp_inner.vertices.next != null)
            {
            }
            if (zpp_inner.vertices.prev == zpp_inner.vertices.next)
            {
                return true;
            }
            else
            {
                return ZPP_Simple.isSimple(zpp_inner.vertices);
            }
        }// end function

        public function isMonotone() : Boolean
        {
            if (zpp_disp)
            {
                throw "Error: " + "GeomPoly" + " has been disposed and cannot be used!";
            }
            if (zpp_inner.vertices != null)
            {
            }
            if (zpp_inner.vertices.next != null)
            {
            }
            if (zpp_inner.vertices.prev == zpp_inner.vertices.next)
            {
                return true;
            }
            else
            {
                return ZPP_Monotone.isMonotone(zpp_inner.vertices);
            }
        }// end function

        public function isDegenerate() : Boolean
        {
            if (zpp_disp)
            {
                throw "Error: " + "GeomPoly" + " has been disposed and cannot be used!";
            }
            if (zpp_inner.vertices != null)
            {
            }
            if (zpp_inner.vertices.next != null)
            {
            }
            if (zpp_inner.vertices.prev == zpp_inner.vertices.next)
            {
                return true;
            }
            else
            {
                return area() < Config.epsilon;
            }
        }// end function

        public function isConvex() : Boolean
        {
            var _loc_1:* = false;
            var _loc_2:* = false;
            var _loc_3:* = false;
            var _loc_4:* = null as ZPP_GeomVert;
            var _loc_5:* = null as ZPP_GeomVert;
            var _loc_6:* = null as ZPP_GeomVert;
            var _loc_7:* = null as ZPP_GeomVert;
            var _loc_8:* = null as ZPP_GeomVert;
            var _loc_9:* = null as ZPP_GeomVert;
            var _loc_10:* = NaN;
            var _loc_11:* = NaN;
            var _loc_12:* = NaN;
            var _loc_13:* = NaN;
            var _loc_14:* = NaN;
            if (zpp_disp)
            {
                throw "Error: " + "GeomPoly" + " has been disposed and cannot be used!";
            }
            if (zpp_inner.vertices != null)
            {
            }
            if (zpp_inner.vertices.next != null)
            {
            }
            if (zpp_inner.vertices.prev == zpp_inner.vertices.next)
            {
                return true;
            }
            else
            {
                _loc_1 = false;
                _loc_2 = false;
                _loc_3 = true;
                _loc_4 = zpp_inner.vertices;
                _loc_5 = zpp_inner.vertices;
                if (_loc_4 != null)
                {
                    _loc_6 = _loc_4;
                    do
                    {
                        
                        _loc_7 = _loc_6;
                        _loc_8 = _loc_7.prev;
                        _loc_9 = _loc_7.next;
                        _loc_10 = 0;
                        _loc_11 = 0;
                        _loc_10 = _loc_9.x - _loc_7.x;
                        _loc_11 = _loc_9.y - _loc_7.y;
                        _loc_12 = 0;
                        _loc_13 = 0;
                        _loc_12 = _loc_7.x - _loc_8.x;
                        _loc_13 = _loc_7.y - _loc_8.y;
                        _loc_14 = _loc_13 * _loc_10 - _loc_12 * _loc_11;
                        if (_loc_14 > 0)
                        {
                            _loc_2 = true;
                        }
                        else if (_loc_14 < 0)
                        {
                            _loc_1 = true;
                        }
                        if (_loc_2)
                        {
                        }
                        if (_loc_1)
                        {
                            _loc_3 = false;
                            break;
                        }
                        _loc_6 = _loc_6.next;
                    }while (_loc_6 != _loc_5)
                }
                return _loc_3;
            }
        }// end function

        public function isClockwise() : Boolean
        {
            if (ZPP_Flags.Winding_CLOCKWISE == null)
            {
                ZPP_Flags.internal = true;
                ZPP_Flags.Winding_CLOCKWISE = new Winding();
                ZPP_Flags.internal = false;
            }
            return winding() == ZPP_Flags.Winding_CLOCKWISE;
        }// end function

        public function inflate(param1:Number) : GeomPoly
        {
            var _loc_5:* = null as ZPP_GeomVert;
            var _loc_6:* = null as ZPP_GeomVert;
            var _loc_7:* = null as ZPP_GeomVert;
            var _loc_8:* = null as ZPP_GeomVert;
            var _loc_9:* = NaN;
            var _loc_10:* = NaN;
            var _loc_11:* = NaN;
            var _loc_12:* = NaN;
            var _loc_13:* = NaN;
            var _loc_14:* = NaN;
            var _loc_15:* = NaN;
            var _loc_16:* = NaN;
            var _loc_17:* = NaN;
            var _loc_18:* = NaN;
            var _loc_19:* = 0;
            var _loc_20:* = NaN;
            var _loc_21:* = NaN;
            var _loc_22:* = NaN;
            var _loc_23:* = NaN;
            var _loc_24:* = NaN;
            var _loc_25:* = false;
            var _loc_26:* = null as Vec2;
            var _loc_27:* = false;
            var _loc_28:* = null as ZPP_Vec2;
            if (zpp_disp)
            {
                throw "Error: " + "GeomPoly" + " has been disposed and cannot be used!";
            }
            var _loc_2:* = GeomPoly.get();
            if (ZPP_Flags.Winding_CLOCKWISE == null)
            {
                ZPP_Flags.internal = true;
                ZPP_Flags.Winding_CLOCKWISE = new Winding();
                ZPP_Flags.internal = false;
            }
            if (winding() == ZPP_Flags.Winding_CLOCKWISE)
            {
                param1 = -param1;
            }
            var _loc_3:* = zpp_inner.vertices;
            var _loc_4:* = zpp_inner.vertices;
            if (_loc_3 != null)
            {
                _loc_5 = _loc_3;
                do
                {
                    
                    _loc_6 = _loc_5;
                    _loc_7 = _loc_6.prev;
                    _loc_8 = _loc_6.next;
                    _loc_9 = 0;
                    _loc_10 = 0;
                    _loc_11 = 0;
                    _loc_12 = 0;
                    _loc_9 = _loc_6.x - _loc_7.x;
                    _loc_10 = _loc_6.y - _loc_7.y;
                    _loc_11 = _loc_8.x - _loc_6.x;
                    _loc_12 = _loc_8.y - _loc_6.y;
                    _loc_13 = 0;
                    _loc_14 = 0;
                    _loc_15 = 0;
                    _loc_16 = 0;
                    _loc_13 = _loc_9;
                    _loc_14 = _loc_10;
                    _loc_17 = _loc_13 * _loc_13 + _loc_14 * _loc_14;
                    _loc_19 = 1597463007 - (0 >> 1);
                    _loc_20 = 0;
                    _loc_18 = _loc_20 * (1.5 - 0.5 * _loc_17 * _loc_20 * _loc_20);
                    _loc_20 = _loc_18;
                    _loc_13 = _loc_13 * _loc_20;
                    _loc_14 = _loc_14 * _loc_20;
                    _loc_17 = _loc_13;
                    _loc_13 = -_loc_14;
                    _loc_14 = _loc_17;
                    _loc_17 = param1;
                    _loc_13 = _loc_13 * _loc_17;
                    _loc_14 = _loc_14 * _loc_17;
                    _loc_15 = _loc_11;
                    _loc_16 = _loc_12;
                    _loc_17 = _loc_15 * _loc_15 + _loc_16 * _loc_16;
                    _loc_19 = 1597463007 - (0 >> 1);
                    _loc_20 = 0;
                    _loc_18 = _loc_20 * (1.5 - 0.5 * _loc_17 * _loc_20 * _loc_20);
                    _loc_20 = _loc_18;
                    _loc_15 = _loc_15 * _loc_20;
                    _loc_16 = _loc_16 * _loc_20;
                    _loc_17 = _loc_15;
                    _loc_15 = -_loc_16;
                    _loc_16 = _loc_17;
                    _loc_17 = param1;
                    _loc_15 = _loc_15 * _loc_17;
                    _loc_16 = _loc_16 * _loc_17;
                    _loc_17 = 0;
                    _loc_18 = 0;
                    _loc_17 = _loc_15 - _loc_13;
                    _loc_18 = _loc_16 - _loc_14;
                    _loc_20 = _loc_12 * _loc_17 - _loc_11 * _loc_18;
                    if (_loc_20 == 0)
                    {
                        _loc_21 = 0;
                    }
                    else
                    {
                        _loc_21 = _loc_20 / (_loc_12 * _loc_9 - _loc_11 * _loc_10);
                    }
                    _loc_22 = 0;
                    _loc_23 = 0;
                    _loc_22 = _loc_6.x + _loc_13;
                    _loc_23 = _loc_6.y + _loc_14;
                    _loc_24 = _loc_21;
                    _loc_22 = _loc_22 + _loc_9 * _loc_24;
                    _loc_23 = _loc_23 + _loc_10 * _loc_24;
                    _loc_25 = false;
                    if (_loc_22 == _loc_22)
                    {
                    }
                    if (_loc_23 != _loc_23)
                    {
                        throw "Error: Vec2 components cannot be NaN";
                    }
                    if (ZPP_PubPool.poolVec2 == null)
                    {
                        _loc_26 = new Vec2();
                    }
                    else
                    {
                        _loc_26 = ZPP_PubPool.poolVec2;
                        ZPP_PubPool.poolVec2 = _loc_26.zpp_pool;
                        _loc_26.zpp_pool = null;
                        _loc_26.zpp_disp = false;
                        if (_loc_26 == ZPP_PubPool.nextVec2)
                        {
                            ZPP_PubPool.nextVec2 = null;
                        }
                    }
                    if (_loc_26.zpp_inner == null)
                    {
                        _loc_27 = false;
                        if (ZPP_Vec2.zpp_pool == null)
                        {
                            _loc_28 = new ZPP_Vec2();
                        }
                        else
                        {
                            _loc_28 = ZPP_Vec2.zpp_pool;
                            ZPP_Vec2.zpp_pool = _loc_28.next;
                            _loc_28.next = null;
                        }
                        _loc_28.weak = false;
                        _loc_28._immutable = _loc_27;
                        _loc_28.x = _loc_22;
                        _loc_28.y = _loc_23;
                        _loc_26.zpp_inner = _loc_28;
                        _loc_26.zpp_inner.outer = _loc_26;
                    }
                    else
                    {
                        if (_loc_26 != null)
                        {
                        }
                        if (_loc_26.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_28 = _loc_26.zpp_inner;
                        if (_loc_28._immutable)
                        {
                            throw "Error: Vec2 is immutable";
                        }
                        if (_loc_28._isimmutable != null)
                        {
                            _loc_28._isimmutable();
                        }
                        if (_loc_22 == _loc_22)
                        {
                        }
                        if (_loc_23 != _loc_23)
                        {
                            throw "Error: Vec2 components cannot be NaN";
                        }
                        if (_loc_26 != null)
                        {
                        }
                        if (_loc_26.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_28 = _loc_26.zpp_inner;
                        if (_loc_28._validate != null)
                        {
                            _loc_28._validate();
                        }
                        if (_loc_26.zpp_inner.x == _loc_22)
                        {
                            if (_loc_26 != null)
                            {
                            }
                            if (_loc_26.zpp_disp)
                            {
                                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                            }
                            _loc_28 = _loc_26.zpp_inner;
                            if (_loc_28._validate != null)
                            {
                                _loc_28._validate();
                            }
                        }
                        if (_loc_26.zpp_inner.y != _loc_23)
                        {
                            _loc_26.zpp_inner.x = _loc_22;
                            _loc_26.zpp_inner.y = _loc_23;
                            _loc_28 = _loc_26.zpp_inner;
                            if (_loc_28._invalidate != null)
                            {
                                _loc_28._invalidate(_loc_28);
                            }
                        }
                    }
                    _loc_26.zpp_inner.weak = _loc_25;
                    _loc_2.push(_loc_26);
                    _loc_5 = _loc_5.next;
                }while (_loc_5 != _loc_4)
            }
            return _loc_2.skipForward(1);
        }// end function

        public function forwardIterator() : GeomVertexIterator
        {
            if (zpp_disp)
            {
                throw "Error: " + "GeomPoly" + " has been disposed and cannot be used!";
            }
            return ZPP_GeomVertexIterator.get(zpp_inner.vertices, true);
        }// end function

        public function erase(param1:int) : GeomPoly
        {
            var _loc_2:* = null as ZPP_GeomVert;
            var _loc_3:* = null as ZPP_GeomVert;
            var _loc_4:* = null as ZPP_GeomVert;
            var _loc_5:* = null as Vec2;
            var _loc_6:* = null as ZPP_Vec2;
            var _loc_7:* = null as Vec2;
            var _loc_8:* = null as ZPP_Vec2;
            if (zpp_disp)
            {
                throw "Error: " + "GeomPoly" + " has been disposed and cannot be used!";
            }
            do
            {
                
                _loc_2 = zpp_inner.vertices;
                if (param1 > 0)
                {
                    if (zpp_inner.vertices != null)
                    {
                    }
                    if (zpp_inner.vertices.prev == zpp_inner.vertices)
                    {
                        _loc_3 = null;
                        zpp_inner.vertices.prev = _loc_3;
                        zpp_inner.vertices.next = _loc_3;
                        _loc_3 = null;
                        zpp_inner.vertices = _loc_3;
                        zpp_inner.vertices = _loc_3;
                    }
                    else
                    {
                        _loc_3 = zpp_inner.vertices.next;
                        zpp_inner.vertices.prev.next = zpp_inner.vertices.next;
                        zpp_inner.vertices.next.prev = zpp_inner.vertices.prev;
                        _loc_4 = null;
                        zpp_inner.vertices.prev = _loc_4;
                        zpp_inner.vertices.next = _loc_4;
                        zpp_inner.vertices = null;
                        zpp_inner.vertices = _loc_3;
                    }
                    param1--;
                }
                else if (param1 < 0)
                {
                    if (zpp_inner.vertices != null)
                    {
                    }
                    if (zpp_inner.vertices.prev == zpp_inner.vertices)
                    {
                        _loc_3 = null;
                        zpp_inner.vertices.prev = _loc_3;
                        zpp_inner.vertices.next = _loc_3;
                        zpp_inner.vertices = null;
                    }
                    else
                    {
                        _loc_3 = zpp_inner.vertices.prev;
                        zpp_inner.vertices.prev.next = zpp_inner.vertices.next;
                        zpp_inner.vertices.next.prev = zpp_inner.vertices.prev;
                        _loc_4 = null;
                        zpp_inner.vertices.prev = _loc_4;
                        zpp_inner.vertices.next = _loc_4;
                        zpp_inner.vertices = null;
                        zpp_inner.vertices = _loc_3;
                    }
                    param1++;
                }
                _loc_3 = _loc_2;
                if (_loc_3.wrap != null)
                {
                    _loc_3.wrap.zpp_inner._inuse = false;
                    _loc_5 = _loc_3.wrap;
                    if (_loc_5 != null)
                    {
                    }
                    if (_loc_5.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_6 = _loc_5.zpp_inner;
                    if (_loc_6._immutable)
                    {
                        throw "Error: Vec2 is immutable";
                    }
                    if (_loc_6._isimmutable != null)
                    {
                        _loc_6._isimmutable();
                    }
                    if (_loc_5.zpp_inner._inuse)
                    {
                        throw "Error: This Vec2 is not disposable";
                    }
                    _loc_6 = _loc_5.zpp_inner;
                    _loc_5.zpp_inner.outer = null;
                    _loc_5.zpp_inner = null;
                    _loc_7 = _loc_5;
                    _loc_7.zpp_pool = null;
                    if (ZPP_PubPool.nextVec2 != null)
                    {
                        ZPP_PubPool.nextVec2.zpp_pool = _loc_7;
                    }
                    else
                    {
                        ZPP_PubPool.poolVec2 = _loc_7;
                    }
                    ZPP_PubPool.nextVec2 = _loc_7;
                    _loc_7.zpp_disp = true;
                    _loc_8 = _loc_6;
                    if (_loc_8.outer != null)
                    {
                        _loc_8.outer.zpp_inner = null;
                        _loc_8.outer = null;
                    }
                    _loc_8._isimmutable = null;
                    _loc_8._validate = null;
                    _loc_8._invalidate = null;
                    _loc_8.next = ZPP_Vec2.zpp_pool;
                    ZPP_Vec2.zpp_pool = _loc_8;
                    _loc_3.wrap = null;
                }
                _loc_4 = null;
                _loc_3.next = _loc_4;
                _loc_3.prev = _loc_4;
                _loc_3.next = ZPP_GeomVert.zpp_pool;
                ZPP_GeomVert.zpp_pool = _loc_3;
                if (param1 != 0)
                {
                }
            }while (zpp_inner.vertices != null)
            return this;
        }// end function

        public function empty() : Boolean
        {
            if (zpp_disp)
            {
                throw "Error: " + "GeomPoly" + " has been disposed and cannot be used!";
            }
            return zpp_inner.vertices == null;
        }// end function

        public function dispose() : void
        {
            if (zpp_disp)
            {
                throw "Error: " + "GeomPoly" + " has been disposed and cannot be used!";
            }
            clear();
            var _loc_1:* = this;
            _loc_1.zpp_pool = null;
            if (ZPP_PubPool.nextGeomPoly != null)
            {
                ZPP_PubPool.nextGeomPoly.zpp_pool = _loc_1;
            }
            else
            {
                ZPP_PubPool.poolGeomPoly = _loc_1;
            }
            ZPP_PubPool.nextGeomPoly = _loc_1;
            _loc_1.zpp_disp = true;
            return;
        }// end function

        public function cut(param1:Vec2, param2:Vec2, param3:Boolean = false, param4:Boolean = false, param5:GeomPolyList = undefined) : GeomPolyList
        {
            var _loc_7:* = null as ZPP_Vec2;
            var _loc_8:* = null as Vec2;
            var _loc_9:* = null as ZPP_Vec2;
            if (zpp_disp)
            {
                throw "Error: " + "GeomPoly" + " has been disposed and cannot be used!";
            }
            if (zpp_disp)
            {
                throw "Error: " + "GeomPoly" + " has been disposed and cannot be used!";
            }
            if (zpp_inner.vertices != null)
            {
            }
            if (zpp_inner.vertices.next != null)
            {
            }
            if (!(zpp_inner.vertices.prev == zpp_inner.vertices.next ? (true) : (ZPP_Simple.isSimple(zpp_inner.vertices))))
            {
                throw "Error: Cut requires a truly simple polygon";
            }
            if (param1 != null)
            {
            }
            if (param2 == null)
            {
                throw "Error: Cannot cut with null start/end\'s";
            }
            if (param1 != null)
            {
            }
            if (param1.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            if (param2 != null)
            {
            }
            if (param2.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            var _loc_6:* = ZPP_Cutter.run(zpp_inner.vertices, param1, param2, param3, param4, param5);
            if (param1.zpp_inner.weak)
            {
                if (param1 != null)
                {
                }
                if (param1.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_7 = param1.zpp_inner;
                if (_loc_7._immutable)
                {
                    throw "Error: Vec2 is immutable";
                }
                if (_loc_7._isimmutable != null)
                {
                    _loc_7._isimmutable();
                }
                if (param1.zpp_inner._inuse)
                {
                    throw "Error: This Vec2 is not disposable";
                }
                _loc_7 = param1.zpp_inner;
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
                _loc_9 = _loc_7;
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
            if (param2.zpp_inner.weak)
            {
                if (param2 != null)
                {
                }
                if (param2.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_7 = param2.zpp_inner;
                if (_loc_7._immutable)
                {
                    throw "Error: Vec2 is immutable";
                }
                if (_loc_7._isimmutable != null)
                {
                    _loc_7._isimmutable();
                }
                if (param2.zpp_inner._inuse)
                {
                    throw "Error: This Vec2 is not disposable";
                }
                _loc_7 = param2.zpp_inner;
                param2.zpp_inner.outer = null;
                param2.zpp_inner = null;
                _loc_8 = param2;
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
                _loc_9 = _loc_7;
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
            return _loc_6;
        }// end function

        public function current() : Vec2
        {
            var _loc_2:* = NaN;
            var _loc_3:* = NaN;
            var _loc_4:* = false;
            var _loc_5:* = null as Vec2;
            var _loc_6:* = false;
            var _loc_7:* = null as ZPP_Vec2;
            if (zpp_disp)
            {
                throw "Error: " + "GeomPoly" + " has been disposed and cannot be used!";
            }
            if (zpp_disp)
            {
                throw "Error: " + "GeomPoly" + " has been disposed and cannot be used!";
            }
            if (zpp_inner.vertices == null)
            {
                throw "Error: GeomPoly is empty";
            }
            var _loc_1:* = zpp_inner.vertices;
            if (_loc_1.wrap == null)
            {
                _loc_2 = _loc_1.x;
                _loc_3 = _loc_1.y;
                _loc_4 = false;
                if (_loc_2 == _loc_2)
                {
                }
                if (_loc_3 != _loc_3)
                {
                    throw "Error: Vec2 components cannot be NaN";
                }
                if (ZPP_PubPool.poolVec2 == null)
                {
                    _loc_5 = new Vec2();
                }
                else
                {
                    _loc_5 = ZPP_PubPool.poolVec2;
                    ZPP_PubPool.poolVec2 = _loc_5.zpp_pool;
                    _loc_5.zpp_pool = null;
                    _loc_5.zpp_disp = false;
                    if (_loc_5 == ZPP_PubPool.nextVec2)
                    {
                        ZPP_PubPool.nextVec2 = null;
                    }
                }
                if (_loc_5.zpp_inner == null)
                {
                    _loc_6 = false;
                    if (ZPP_Vec2.zpp_pool == null)
                    {
                        _loc_7 = new ZPP_Vec2();
                    }
                    else
                    {
                        _loc_7 = ZPP_Vec2.zpp_pool;
                        ZPP_Vec2.zpp_pool = _loc_7.next;
                        _loc_7.next = null;
                    }
                    _loc_7.weak = false;
                    _loc_7._immutable = _loc_6;
                    _loc_7.x = _loc_2;
                    _loc_7.y = _loc_3;
                    _loc_5.zpp_inner = _loc_7;
                    _loc_5.zpp_inner.outer = _loc_5;
                }
                else
                {
                    if (_loc_5 != null)
                    {
                    }
                    if (_loc_5.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_7 = _loc_5.zpp_inner;
                    if (_loc_7._immutable)
                    {
                        throw "Error: Vec2 is immutable";
                    }
                    if (_loc_7._isimmutable != null)
                    {
                        _loc_7._isimmutable();
                    }
                    if (_loc_2 == _loc_2)
                    {
                    }
                    if (_loc_3 != _loc_3)
                    {
                        throw "Error: Vec2 components cannot be NaN";
                    }
                    if (_loc_5 != null)
                    {
                    }
                    if (_loc_5.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_7 = _loc_5.zpp_inner;
                    if (_loc_7._validate != null)
                    {
                        _loc_7._validate();
                    }
                    if (_loc_5.zpp_inner.x == _loc_2)
                    {
                        if (_loc_5 != null)
                        {
                        }
                        if (_loc_5.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_7 = _loc_5.zpp_inner;
                        if (_loc_7._validate != null)
                        {
                            _loc_7._validate();
                        }
                    }
                    if (_loc_5.zpp_inner.y != _loc_3)
                    {
                        _loc_5.zpp_inner.x = _loc_2;
                        _loc_5.zpp_inner.y = _loc_3;
                        _loc_7 = _loc_5.zpp_inner;
                        if (_loc_7._invalidate != null)
                        {
                            _loc_7._invalidate(_loc_7);
                        }
                    }
                }
                _loc_5.zpp_inner.weak = _loc_4;
                _loc_1.wrap = _loc_5;
                _loc_1.wrap.zpp_inner._inuse = true;
                _loc_1.wrap.zpp_inner._invalidate = _loc_1.modwrap;
                _loc_1.wrap.zpp_inner._validate = _loc_1.getwrap;
            }
            return _loc_1.wrap;
        }// end function

        public function copy() : GeomPoly
        {
            var _loc_4:* = null as ZPP_GeomVert;
            var _loc_5:* = null as ZPP_GeomVert;
            var _loc_6:* = null as ZPP_GeomVert;
            var _loc_7:* = null as ZPP_GeomVert;
            if (zpp_disp)
            {
                throw "Error: " + "GeomPoly" + " has been disposed and cannot be used!";
            }
            var _loc_1:* = GeomPoly.get();
            var _loc_2:* = zpp_inner.vertices;
            var _loc_3:* = zpp_inner.vertices;
            if (_loc_2 != null)
            {
                _loc_4 = _loc_2;
                do
                {
                    
                    _loc_5 = _loc_4;
                    if (ZPP_GeomVert.zpp_pool == null)
                    {
                        _loc_7 = new ZPP_GeomVert();
                    }
                    else
                    {
                        _loc_7 = ZPP_GeomVert.zpp_pool;
                        ZPP_GeomVert.zpp_pool = _loc_7.next;
                        _loc_7.next = null;
                    }
                    _loc_7.forced = false;
                    _loc_7.x = _loc_5.x;
                    _loc_7.y = _loc_5.y;
                    _loc_6 = _loc_7;
                    if (_loc_1.zpp_inner.vertices == null)
                    {
                        _loc_7 = _loc_6;
                        _loc_6.next = _loc_7;
                        _loc_7 = _loc_7;
                        _loc_6.prev = _loc_7;
                        _loc_1.zpp_inner.vertices = _loc_7;
                    }
                    else
                    {
                        _loc_6.prev = _loc_1.zpp_inner.vertices;
                        _loc_6.next = _loc_1.zpp_inner.vertices.next;
                        _loc_1.zpp_inner.vertices.next.prev = _loc_6;
                        _loc_1.zpp_inner.vertices.next = _loc_6;
                    }
                    _loc_1.zpp_inner.vertices = _loc_6;
                    _loc_4 = _loc_4.next;
                }while (_loc_4 != _loc_3)
            }
            return _loc_1.skipForward(1);
        }// end function

        public function convexDecomposition(param1:Boolean = false, param2:GeomPolyList = undefined) : GeomPolyList
        {
            var _loc_5:* = null as GeomPolyList;
            var _loc_6:* = null as ZPP_PartitionedPoly;
            var _loc_7:* = null as ZNPList_ZPP_GeomVert;
            var _loc_8:* = null as ZPP_PartitionedPoly;
            var _loc_9:* = null as ZPP_GeomVert;
            var _loc_10:* = null as GeomPoly;
            if (zpp_disp)
            {
                throw "Error: " + "GeomPoly" + " has been disposed and cannot be used!";
            }
            if (zpp_inner.vertices != null)
            {
            }
            if (zpp_inner.vertices.next != null)
            {
            }
            if (zpp_inner.vertices.prev == zpp_inner.vertices.next)
            {
                throw "Error: Cannot decompose a degenerate polygon";
            }
            if (ZPP_Monotone.sharedPPoly == null)
            {
                ZPP_Monotone.sharedPPoly = new ZPP_PartitionedPoly();
            }
            var _loc_3:* = ZPP_Monotone.decompose(zpp_inner.vertices, ZPP_Monotone.sharedPPoly);
            if (ZPP_PartitionedPoly.sharedPPList == null)
            {
                ZPP_PartitionedPoly.sharedPPList = new ZNPList_ZPP_PartitionedPoly();
            }
            var _loc_4:* = _loc_3.extract_partitions(ZPP_PartitionedPoly.sharedPPList);
            if (param2 == null)
            {
                _loc_5 = new GeomPolyList();
            }
            else
            {
                _loc_5 = param2;
            }
            while (_loc_4.head != null)
            {
                
                _loc_6 = _loc_4.pop_unsafe();
                ZPP_Triangular.triangulate(_loc_6);
                if (param1)
                {
                    ZPP_Triangular.optimise(_loc_6);
                }
                ZPP_Convex.optimise(_loc_6);
                if (ZPP_PartitionedPoly.sharedGVList == null)
                {
                    ZPP_PartitionedPoly.sharedGVList = new ZNPList_ZPP_GeomVert();
                }
                _loc_7 = _loc_6.extract(ZPP_PartitionedPoly.sharedGVList);
                _loc_8 = _loc_6;
                _loc_8.next = ZPP_PartitionedPoly.zpp_pool;
                ZPP_PartitionedPoly.zpp_pool = _loc_8;
                while (_loc_7.head != null)
                {
                    
                    _loc_9 = _loc_7.pop_unsafe();
                    _loc_10 = GeomPoly.get();
                    _loc_10.zpp_inner.vertices = _loc_9;
                    if (_loc_5.zpp_inner.reverse_flag)
                    {
                        _loc_5.push(_loc_10);
                        continue;
                    }
                    _loc_5.unshift(_loc_10);
                }
            }
            return _loc_5;
        }// end function

        public function contains(param1:Vec2) : Boolean
        {
            var _loc_4:* = null as ZPP_Vec2;
            var _loc_9:* = null as ZPP_GeomVert;
            var _loc_10:* = null as ZPP_GeomVert;
            var _loc_11:* = null as ZPP_GeomVert;
            var _loc_12:* = null as Vec2;
            var _loc_13:* = null as ZPP_Vec2;
            if (zpp_disp)
            {
                throw "Error: " + "GeomPoly" + " has been disposed and cannot be used!";
            }
            if (param1 != null)
            {
            }
            if (param1.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            if (param1 == null)
            {
                throw "Error: GeomPoly::contains point cannot be null";
            }
            if (param1 != null)
            {
            }
            if (param1.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_4 = param1.zpp_inner;
            if (_loc_4._validate != null)
            {
                _loc_4._validate();
            }
            var _loc_3:* = param1.zpp_inner.x;
            if (param1 != null)
            {
            }
            if (param1.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_4 = param1.zpp_inner;
            if (_loc_4._validate != null)
            {
                _loc_4._validate();
            }
            var _loc_5:* = param1.zpp_inner.y;
            var _loc_6:* = false;
            var _loc_7:* = zpp_inner.vertices;
            var _loc_8:* = zpp_inner.vertices;
            if (_loc_7 != null)
            {
                _loc_9 = _loc_7;
                do
                {
                    
                    _loc_10 = _loc_9;
                    _loc_11 = _loc_10.prev;
                    if (_loc_10.y < _loc_5)
                    {
                    }
                    if (_loc_11.y < _loc_5)
                    {
                        if (_loc_11.y < _loc_5)
                        {
                        }
                    }
                    if (_loc_10.y >= _loc_5)
                    {
                        if (_loc_10.x > _loc_3)
                        {
                        }
                    }
                    if (_loc_11.x <= _loc_3)
                    {
                        if (_loc_10.x + (_loc_5 - _loc_10.y) / (_loc_11.y - _loc_10.y) * (_loc_11.x - _loc_10.x) < _loc_3)
                        {
                            _loc_6 = !_loc_6;
                        }
                    }
                    _loc_9 = _loc_9.next;
                }while (_loc_9 != _loc_8)
            }
            var _loc_2:* = _loc_6;
            if (param1.zpp_inner.weak)
            {
                if (param1 != null)
                {
                }
                if (param1.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_4 = param1.zpp_inner;
                if (_loc_4._immutable)
                {
                    throw "Error: Vec2 is immutable";
                }
                if (_loc_4._isimmutable != null)
                {
                    _loc_4._isimmutable();
                }
                if (param1.zpp_inner._inuse)
                {
                    throw "Error: This Vec2 is not disposable";
                }
                _loc_4 = param1.zpp_inner;
                param1.zpp_inner.outer = null;
                param1.zpp_inner = null;
                _loc_12 = param1;
                _loc_12.zpp_pool = null;
                if (ZPP_PubPool.nextVec2 != null)
                {
                    ZPP_PubPool.nextVec2.zpp_pool = _loc_12;
                }
                else
                {
                    ZPP_PubPool.poolVec2 = _loc_12;
                }
                ZPP_PubPool.nextVec2 = _loc_12;
                _loc_12.zpp_disp = true;
                _loc_13 = _loc_4;
                if (_loc_13.outer != null)
                {
                    _loc_13.outer.zpp_inner = null;
                    _loc_13.outer = null;
                }
                _loc_13._isimmutable = null;
                _loc_13._validate = null;
                _loc_13._invalidate = null;
                _loc_13.next = ZPP_Vec2.zpp_pool;
                ZPP_Vec2.zpp_pool = _loc_13;
            }
            else
            {
            }
            return _loc_2;
        }// end function

        public function clear() : GeomPoly
        {
            var _loc_1:* = null as ZPP_GeomVert;
            var _loc_2:* = null as ZPP_GeomVert;
            var _loc_3:* = null as ZPP_GeomVert;
            var _loc_4:* = null as Vec2;
            var _loc_5:* = null as ZPP_Vec2;
            var _loc_6:* = null as Vec2;
            var _loc_7:* = null as ZPP_Vec2;
            if (zpp_disp)
            {
                throw "Error: " + "GeomPoly" + " has been disposed and cannot be used!";
            }
            while (zpp_inner.vertices != null)
            {
                
                _loc_1 = zpp_inner.vertices;
                if (zpp_inner.vertices != null)
                {
                }
                if (zpp_inner.vertices.prev == zpp_inner.vertices)
                {
                    _loc_2 = null;
                    zpp_inner.vertices.prev = _loc_2;
                    zpp_inner.vertices.next = _loc_2;
                    _loc_2 = null;
                    zpp_inner.vertices = _loc_2;
                    zpp_inner.vertices = _loc_2;
                }
                else
                {
                    _loc_2 = zpp_inner.vertices.next;
                    zpp_inner.vertices.prev.next = zpp_inner.vertices.next;
                    zpp_inner.vertices.next.prev = zpp_inner.vertices.prev;
                    _loc_3 = null;
                    zpp_inner.vertices.prev = _loc_3;
                    zpp_inner.vertices.next = _loc_3;
                    zpp_inner.vertices = null;
                    zpp_inner.vertices = _loc_2;
                }
                _loc_2 = _loc_1;
                if (_loc_2.wrap != null)
                {
                    _loc_2.wrap.zpp_inner._inuse = false;
                    _loc_4 = _loc_2.wrap;
                    if (_loc_4 != null)
                    {
                    }
                    if (_loc_4.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_5 = _loc_4.zpp_inner;
                    if (_loc_5._immutable)
                    {
                        throw "Error: Vec2 is immutable";
                    }
                    if (_loc_5._isimmutable != null)
                    {
                        _loc_5._isimmutable();
                    }
                    if (_loc_4.zpp_inner._inuse)
                    {
                        throw "Error: This Vec2 is not disposable";
                    }
                    _loc_5 = _loc_4.zpp_inner;
                    _loc_4.zpp_inner.outer = null;
                    _loc_4.zpp_inner = null;
                    _loc_6 = _loc_4;
                    _loc_6.zpp_pool = null;
                    if (ZPP_PubPool.nextVec2 != null)
                    {
                        ZPP_PubPool.nextVec2.zpp_pool = _loc_6;
                    }
                    else
                    {
                        ZPP_PubPool.poolVec2 = _loc_6;
                    }
                    ZPP_PubPool.nextVec2 = _loc_6;
                    _loc_6.zpp_disp = true;
                    _loc_7 = _loc_5;
                    if (_loc_7.outer != null)
                    {
                        _loc_7.outer.zpp_inner = null;
                        _loc_7.outer = null;
                    }
                    _loc_7._isimmutable = null;
                    _loc_7._validate = null;
                    _loc_7._invalidate = null;
                    _loc_7.next = ZPP_Vec2.zpp_pool;
                    ZPP_Vec2.zpp_pool = _loc_7;
                    _loc_2.wrap = null;
                }
                _loc_3 = null;
                _loc_2.next = _loc_3;
                _loc_2.prev = _loc_3;
                _loc_2.next = ZPP_GeomVert.zpp_pool;
                ZPP_GeomVert.zpp_pool = _loc_2;
            }
            return this;
        }// end function

        public function bounds() : AABB
        {
            var _loc_7:* = null as ZPP_GeomVert;
            var _loc_8:* = null as ZPP_GeomVert;
            if (zpp_disp)
            {
                throw "Error: " + "GeomPoly" + " has been disposed and cannot be used!";
            }
            if (zpp_disp)
            {
                throw "Error: " + "GeomPoly" + " has been disposed and cannot be used!";
            }
            if (zpp_inner.vertices == null)
            {
                throw "Error: empty GeomPoly has no defineable bounds";
            }
            var _loc_1:* = 1000000000000000000000000000000;
            var _loc_2:* = 1000000000000000000000000000000;
            var _loc_3:* = -1000000000000000000000000000000;
            var _loc_4:* = -1000000000000000000000000000000;
            var _loc_5:* = zpp_inner.vertices;
            var _loc_6:* = zpp_inner.vertices;
            if (_loc_5 != null)
            {
                _loc_7 = _loc_5;
                do
                {
                    
                    _loc_8 = _loc_7;
                    if (_loc_8.x < _loc_1)
                    {
                        _loc_1 = _loc_8.x;
                    }
                    if (_loc_8.y < _loc_2)
                    {
                        _loc_2 = _loc_8.y;
                    }
                    if (_loc_8.x > _loc_3)
                    {
                        _loc_3 = _loc_8.x;
                    }
                    if (_loc_8.y > _loc_4)
                    {
                        _loc_4 = _loc_8.y;
                    }
                    _loc_7 = _loc_7.next;
                }while (_loc_7 != _loc_6)
            }
            return new AABB(_loc_1, _loc_2, _loc_3 - _loc_1, _loc_4 - _loc_2);
        }// end function

        public function bottom() : Vec2
        {
            var _loc_4:* = null as ZPP_GeomVert;
            var _loc_5:* = null as ZPP_GeomVert;
            var _loc_6:* = NaN;
            var _loc_7:* = NaN;
            var _loc_8:* = false;
            var _loc_9:* = null as Vec2;
            var _loc_10:* = false;
            var _loc_11:* = null as ZPP_Vec2;
            if (zpp_disp)
            {
                throw "Error: " + "GeomPoly" + " has been disposed and cannot be used!";
            }
            if (zpp_disp)
            {
                throw "Error: " + "GeomPoly" + " has been disposed and cannot be used!";
            }
            if (zpp_inner.vertices == null)
            {
                throw "Error: empty GeomPoly has no defineable bottommost vertex";
            }
            var _loc_1:* = zpp_inner.vertices;
            var _loc_2:* = zpp_inner.vertices.next;
            var _loc_3:* = zpp_inner.vertices;
            if (_loc_2 != null)
            {
                _loc_4 = _loc_2;
                do
                {
                    
                    _loc_5 = _loc_4;
                    if (_loc_5.y > _loc_1.y)
                    {
                        _loc_1 = _loc_5;
                    }
                    _loc_4 = _loc_4.next;
                }while (_loc_4 != _loc_3)
            }
            if (_loc_1.wrap == null)
            {
                _loc_6 = _loc_1.x;
                _loc_7 = _loc_1.y;
                _loc_8 = false;
                if (_loc_6 == _loc_6)
                {
                }
                if (_loc_7 != _loc_7)
                {
                    throw "Error: Vec2 components cannot be NaN";
                }
                if (ZPP_PubPool.poolVec2 == null)
                {
                    _loc_9 = new Vec2();
                }
                else
                {
                    _loc_9 = ZPP_PubPool.poolVec2;
                    ZPP_PubPool.poolVec2 = _loc_9.zpp_pool;
                    _loc_9.zpp_pool = null;
                    _loc_9.zpp_disp = false;
                    if (_loc_9 == ZPP_PubPool.nextVec2)
                    {
                        ZPP_PubPool.nextVec2 = null;
                    }
                }
                if (_loc_9.zpp_inner == null)
                {
                    _loc_10 = false;
                    if (ZPP_Vec2.zpp_pool == null)
                    {
                        _loc_11 = new ZPP_Vec2();
                    }
                    else
                    {
                        _loc_11 = ZPP_Vec2.zpp_pool;
                        ZPP_Vec2.zpp_pool = _loc_11.next;
                        _loc_11.next = null;
                    }
                    _loc_11.weak = false;
                    _loc_11._immutable = _loc_10;
                    _loc_11.x = _loc_6;
                    _loc_11.y = _loc_7;
                    _loc_9.zpp_inner = _loc_11;
                    _loc_9.zpp_inner.outer = _loc_9;
                }
                else
                {
                    if (_loc_9 != null)
                    {
                    }
                    if (_loc_9.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_11 = _loc_9.zpp_inner;
                    if (_loc_11._immutable)
                    {
                        throw "Error: Vec2 is immutable";
                    }
                    if (_loc_11._isimmutable != null)
                    {
                        _loc_11._isimmutable();
                    }
                    if (_loc_6 == _loc_6)
                    {
                    }
                    if (_loc_7 != _loc_7)
                    {
                        throw "Error: Vec2 components cannot be NaN";
                    }
                    if (_loc_9 != null)
                    {
                    }
                    if (_loc_9.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_11 = _loc_9.zpp_inner;
                    if (_loc_11._validate != null)
                    {
                        _loc_11._validate();
                    }
                    if (_loc_9.zpp_inner.x == _loc_6)
                    {
                        if (_loc_9 != null)
                        {
                        }
                        if (_loc_9.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_11 = _loc_9.zpp_inner;
                        if (_loc_11._validate != null)
                        {
                            _loc_11._validate();
                        }
                    }
                    if (_loc_9.zpp_inner.y != _loc_7)
                    {
                        _loc_9.zpp_inner.x = _loc_6;
                        _loc_9.zpp_inner.y = _loc_7;
                        _loc_11 = _loc_9.zpp_inner;
                        if (_loc_11._invalidate != null)
                        {
                            _loc_11._invalidate(_loc_11);
                        }
                    }
                }
                _loc_9.zpp_inner.weak = _loc_8;
                _loc_1.wrap = _loc_9;
                _loc_1.wrap.zpp_inner._inuse = true;
                _loc_1.wrap.zpp_inner._invalidate = _loc_1.modwrap;
                _loc_1.wrap.zpp_inner._validate = _loc_1.getwrap;
            }
            return _loc_1.wrap;
        }// end function

        public function backwardsIterator() : GeomVertexIterator
        {
            if (zpp_disp)
            {
                throw "Error: " + "GeomPoly" + " has been disposed and cannot be used!";
            }
            return ZPP_GeomVertexIterator.get(zpp_inner.vertices, false);
        }// end function

        public function area() : Number
        {
            var _loc_1:* = NaN;
            var _loc_2:* = NaN;
            var _loc_3:* = null as ZPP_GeomVert;
            var _loc_4:* = null as ZPP_GeomVert;
            var _loc_5:* = null as ZPP_GeomVert;
            var _loc_6:* = null as ZPP_GeomVert;
            if (zpp_disp)
            {
                throw "Error: " + "GeomPoly" + " has been disposed and cannot be used!";
            }
            if (zpp_inner.vertices != null)
            {
            }
            if (zpp_inner.vertices.next != null)
            {
            }
            if (zpp_inner.vertices.prev == zpp_inner.vertices.next)
            {
                return 0;
            }
            else
            {
                _loc_2 = 0;
                _loc_3 = zpp_inner.vertices;
                _loc_4 = zpp_inner.vertices;
                if (_loc_3 != null)
                {
                    _loc_5 = _loc_3;
                    do
                    {
                        
                        _loc_6 = _loc_5;
                        _loc_2 = _loc_2 + _loc_6.x * (_loc_6.next.y - _loc_6.prev.y);
                        _loc_5 = _loc_5.next;
                    }while (_loc_5 != _loc_4)
                }
                _loc_1 = _loc_2 * 0.5;
                if (_loc_1 < 0)
                {
                    return -_loc_1;
                }
                else
                {
                    return _loc_1;
                }
            }
        }// end function

        public static function get(param1 = undefined) : GeomPoly
        {
            var _loc_2:* = null as GeomPoly;
            var _loc_3:* = null as Array;
            var _loc_4:* = 0;
            var _loc_5:* = null;
            var _loc_6:* = null as Vec2;
            var _loc_7:* = null as ZPP_GeomVert;
            var _loc_8:* = NaN;
            var _loc_9:* = null as ZPP_Vec2;
            var _loc_10:* = NaN;
            var _loc_11:* = null as ZPP_GeomVert;
            var _loc_12:* = null as Vector.<Vec2>;
            var _loc_13:* = null as Vec2;
            var _loc_14:* = null as Vec2List;
            var _loc_15:* = null as Vec2Iterator;
            var _loc_16:* = null as GeomPoly;
            var _loc_17:* = false;
            var _loc_18:* = false;
            var _loc_19:* = null as ZPP_GeomVert;
            var _loc_20:* = null as ZPP_GeomVert;
            var _loc_21:* = null as ZPP_Vec2;
            var _loc_22:* = null as ZNPList_ZPP_Vec2;
            var _loc_23:* = null as ZNPNode_ZPP_Vec2;
            var _loc_24:* = null as ZNPNode_ZPP_Vec2;
            var _loc_25:* = null as ZPP_Vec2;
            if (ZPP_PubPool.poolGeomPoly == null)
            {
                _loc_2 = new GeomPoly();
            }
            else
            {
                _loc_2 = ZPP_PubPool.poolGeomPoly;
                ZPP_PubPool.poolGeomPoly = _loc_2.zpp_pool;
                _loc_2.zpp_pool = null;
                _loc_2.zpp_disp = false;
                if (_loc_2 == ZPP_PubPool.nextGeomPoly)
                {
                    ZPP_PubPool.nextGeomPoly = null;
                }
            }
            if (param1 != null)
            {
                if (param1 is Array)
                {
                    _loc_3 = param1;
                    _loc_4 = 0;
                    while (_loc_4 < _loc_3.length)
                    {
                        
                        _loc_5 = _loc_3[_loc_4];
                        _loc_4++;
                        if (_loc_5 == null)
                        {
                            throw "Error: Array<Vec2> contains null objects";
                        }
                        if (!(_loc_5 is Vec2))
                        {
                            throw "Error: Array<Vec2> contains non Vec2 objects";
                        }
                        _loc_6 = _loc_5;
                        if (_loc_6 != null)
                        {
                        }
                        if (_loc_6.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        if (_loc_6 != null)
                        {
                        }
                        if (_loc_6.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_9 = _loc_6.zpp_inner;
                        if (_loc_9._validate != null)
                        {
                            _loc_9._validate();
                        }
                        _loc_8 = _loc_6.zpp_inner.x;
                        if (_loc_6 != null)
                        {
                        }
                        if (_loc_6.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_9 = _loc_6.zpp_inner;
                        if (_loc_9._validate != null)
                        {
                            _loc_9._validate();
                        }
                        _loc_10 = _loc_6.zpp_inner.y;
                        if (ZPP_GeomVert.zpp_pool == null)
                        {
                            _loc_11 = new ZPP_GeomVert();
                        }
                        else
                        {
                            _loc_11 = ZPP_GeomVert.zpp_pool;
                            ZPP_GeomVert.zpp_pool = _loc_11.next;
                            _loc_11.next = null;
                        }
                        _loc_11.forced = false;
                        _loc_11.x = _loc_8;
                        _loc_11.y = _loc_10;
                        _loc_7 = _loc_11;
                        if (_loc_2.zpp_inner.vertices == null)
                        {
                            _loc_11 = _loc_7;
                            _loc_7.next = _loc_11;
                            _loc_11 = _loc_11;
                            _loc_7.prev = _loc_11;
                            _loc_2.zpp_inner.vertices = _loc_11;
                        }
                        else
                        {
                            _loc_7.prev = _loc_2.zpp_inner.vertices;
                            _loc_7.next = _loc_2.zpp_inner.vertices.next;
                            _loc_2.zpp_inner.vertices.next.prev = _loc_7;
                            _loc_2.zpp_inner.vertices.next = _loc_7;
                        }
                        _loc_2.zpp_inner.vertices = _loc_7;
                    }
                }
                else if (param1 is ZPP_Const.vec2vector)
                {
                    _loc_12 = param1;
                    _loc_4 = 0;
                    while (_loc_4 < _loc_12.length)
                    {
                        
                        _loc_6 = _loc_12[_loc_4];
                        _loc_4++;
                        if (_loc_6 == null)
                        {
                            throw "Error: flash.Vector<Vec2> contains null objects";
                        }
                        _loc_13 = _loc_6;
                        if (_loc_13 != null)
                        {
                        }
                        if (_loc_13.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        if (_loc_13 != null)
                        {
                        }
                        if (_loc_13.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_9 = _loc_13.zpp_inner;
                        if (_loc_9._validate != null)
                        {
                            _loc_9._validate();
                        }
                        _loc_8 = _loc_13.zpp_inner.x;
                        if (_loc_13 != null)
                        {
                        }
                        if (_loc_13.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_9 = _loc_13.zpp_inner;
                        if (_loc_9._validate != null)
                        {
                            _loc_9._validate();
                        }
                        _loc_10 = _loc_13.zpp_inner.y;
                        if (ZPP_GeomVert.zpp_pool == null)
                        {
                            _loc_11 = new ZPP_GeomVert();
                        }
                        else
                        {
                            _loc_11 = ZPP_GeomVert.zpp_pool;
                            ZPP_GeomVert.zpp_pool = _loc_11.next;
                            _loc_11.next = null;
                        }
                        _loc_11.forced = false;
                        _loc_11.x = _loc_8;
                        _loc_11.y = _loc_10;
                        _loc_7 = _loc_11;
                        if (_loc_2.zpp_inner.vertices == null)
                        {
                            _loc_11 = _loc_7;
                            _loc_7.next = _loc_11;
                            _loc_11 = _loc_11;
                            _loc_7.prev = _loc_11;
                            _loc_2.zpp_inner.vertices = _loc_11;
                        }
                        else
                        {
                            _loc_7.prev = _loc_2.zpp_inner.vertices;
                            _loc_7.next = _loc_2.zpp_inner.vertices.next;
                            _loc_2.zpp_inner.vertices.next.prev = _loc_7;
                            _loc_2.zpp_inner.vertices.next = _loc_7;
                        }
                        _loc_2.zpp_inner.vertices = _loc_7;
                    }
                }
                else if (param1 is Vec2List)
                {
                    _loc_14 = param1;
                    _loc_15 = _loc_14.iterator();
                    do
                    {
                        
                        _loc_15.zpp_critical = false;
                        _loc_4 = _loc_15.zpp_i;
                        (_loc_15.zpp_i + 1);
                        _loc_6 = _loc_15.zpp_inner.at(_loc_4);
                        if (_loc_6 == null)
                        {
                            throw "Error: Vec2List contains null objects";
                        }
                        if (_loc_6 != null)
                        {
                        }
                        if (_loc_6.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        if (_loc_6 != null)
                        {
                        }
                        if (_loc_6.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_9 = _loc_6.zpp_inner;
                        if (_loc_9._validate != null)
                        {
                            _loc_9._validate();
                        }
                        _loc_8 = _loc_6.zpp_inner.x;
                        if (_loc_6 != null)
                        {
                        }
                        if (_loc_6.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_9 = _loc_6.zpp_inner;
                        if (_loc_9._validate != null)
                        {
                            _loc_9._validate();
                        }
                        _loc_10 = _loc_6.zpp_inner.y;
                        if (ZPP_GeomVert.zpp_pool == null)
                        {
                            _loc_11 = new ZPP_GeomVert();
                        }
                        else
                        {
                            _loc_11 = ZPP_GeomVert.zpp_pool;
                            ZPP_GeomVert.zpp_pool = _loc_11.next;
                            _loc_11.next = null;
                        }
                        _loc_11.forced = false;
                        _loc_11.x = _loc_8;
                        _loc_11.y = _loc_10;
                        _loc_7 = _loc_11;
                        if (_loc_2.zpp_inner.vertices == null)
                        {
                            _loc_11 = _loc_7;
                            _loc_7.next = _loc_11;
                            _loc_11 = _loc_11;
                            _loc_7.prev = _loc_11;
                            _loc_2.zpp_inner.vertices = _loc_11;
                        }
                        else
                        {
                            _loc_7.prev = _loc_2.zpp_inner.vertices;
                            _loc_7.next = _loc_2.zpp_inner.vertices.next;
                            _loc_2.zpp_inner.vertices.next.prev = _loc_7;
                            _loc_2.zpp_inner.vertices.next = _loc_7;
                        }
                        _loc_2.zpp_inner.vertices = _loc_7;
                        _loc_15.zpp_inner.zpp_inner.valmod();
                        _loc_4 = _loc_15.zpp_inner.zpp_gl();
                        _loc_15.zpp_critical = true;
                    }while (_loc_15.zpp_i < _loc_4 ? (true) : (_loc_15.zpp_next = Vec2Iterator.zpp_pool, Vec2Iterator.zpp_pool = _loc_15, _loc_15.zpp_inner = null, false))
                }
                else if (param1 is GeomPoly)
                {
                    _loc_16 = param1;
                    if (_loc_16 != null)
                    {
                    }
                    if (_loc_16.zpp_disp)
                    {
                        throw "Error: " + "GeomPoly" + " has been disposed and cannot be used!";
                    }
                    _loc_7 = _loc_16.zpp_inner.vertices;
                    if (_loc_7 != null)
                    {
                        _loc_11 = _loc_7;
                        do
                        {
                            
                            _loc_8 = _loc_11.x;
                            _loc_10 = _loc_11.y;
                            _loc_17 = false;
                            if (_loc_8 == _loc_8)
                            {
                            }
                            if (_loc_10 != _loc_10)
                            {
                                throw "Error: Vec2 components cannot be NaN";
                            }
                            if (ZPP_PubPool.poolVec2 == null)
                            {
                                _loc_13 = new Vec2();
                            }
                            else
                            {
                                _loc_13 = ZPP_PubPool.poolVec2;
                                ZPP_PubPool.poolVec2 = _loc_13.zpp_pool;
                                _loc_13.zpp_pool = null;
                                _loc_13.zpp_disp = false;
                                if (_loc_13 == ZPP_PubPool.nextVec2)
                                {
                                    ZPP_PubPool.nextVec2 = null;
                                }
                            }
                            if (_loc_13.zpp_inner == null)
                            {
                                _loc_18 = false;
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
                                _loc_9._immutable = _loc_18;
                                _loc_9.x = _loc_8;
                                _loc_9.y = _loc_10;
                                _loc_13.zpp_inner = _loc_9;
                                _loc_13.zpp_inner.outer = _loc_13;
                            }
                            else
                            {
                                if (_loc_13 != null)
                                {
                                }
                                if (_loc_13.zpp_disp)
                                {
                                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                                }
                                _loc_9 = _loc_13.zpp_inner;
                                if (_loc_9._immutable)
                                {
                                    throw "Error: Vec2 is immutable";
                                }
                                if (_loc_9._isimmutable != null)
                                {
                                    _loc_9._isimmutable();
                                }
                                if (_loc_8 == _loc_8)
                                {
                                }
                                if (_loc_10 != _loc_10)
                                {
                                    throw "Error: Vec2 components cannot be NaN";
                                }
                                if (_loc_13 != null)
                                {
                                }
                                if (_loc_13.zpp_disp)
                                {
                                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                                }
                                _loc_9 = _loc_13.zpp_inner;
                                if (_loc_9._validate != null)
                                {
                                    _loc_9._validate();
                                }
                                if (_loc_13.zpp_inner.x == _loc_8)
                                {
                                    if (_loc_13 != null)
                                    {
                                    }
                                    if (_loc_13.zpp_disp)
                                    {
                                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                                    }
                                    _loc_9 = _loc_13.zpp_inner;
                                    if (_loc_9._validate != null)
                                    {
                                        _loc_9._validate();
                                    }
                                }
                                if (_loc_13.zpp_inner.y != _loc_10)
                                {
                                    _loc_13.zpp_inner.x = _loc_8;
                                    _loc_13.zpp_inner.y = _loc_10;
                                    _loc_9 = _loc_13.zpp_inner;
                                    if (_loc_9._invalidate != null)
                                    {
                                        _loc_9._invalidate(_loc_9);
                                    }
                                }
                            }
                            _loc_13.zpp_inner.weak = _loc_17;
                            _loc_6 = _loc_13;
                            _loc_11 = _loc_11.next;
                            if (_loc_6 != null)
                            {
                            }
                            if (_loc_6.zpp_disp)
                            {
                                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                            }
                            _loc_9 = _loc_6.zpp_inner;
                            if (_loc_9._validate != null)
                            {
                                _loc_9._validate();
                            }
                            _loc_8 = _loc_6.zpp_inner.x;
                            if (_loc_6 != null)
                            {
                            }
                            if (_loc_6.zpp_disp)
                            {
                                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                            }
                            _loc_9 = _loc_6.zpp_inner;
                            if (_loc_9._validate != null)
                            {
                                _loc_9._validate();
                            }
                            _loc_10 = _loc_6.zpp_inner.y;
                            if (ZPP_GeomVert.zpp_pool == null)
                            {
                                _loc_20 = new ZPP_GeomVert();
                            }
                            else
                            {
                                _loc_20 = ZPP_GeomVert.zpp_pool;
                                ZPP_GeomVert.zpp_pool = _loc_20.next;
                                _loc_20.next = null;
                            }
                            _loc_20.forced = false;
                            _loc_20.x = _loc_8;
                            _loc_20.y = _loc_10;
                            _loc_19 = _loc_20;
                            if (_loc_2.zpp_inner.vertices == null)
                            {
                                _loc_20 = _loc_19;
                                _loc_19.next = _loc_20;
                                _loc_20 = _loc_20;
                                _loc_19.prev = _loc_20;
                                _loc_2.zpp_inner.vertices = _loc_20;
                            }
                            else
                            {
                                _loc_19.prev = _loc_2.zpp_inner.vertices;
                                _loc_19.next = _loc_2.zpp_inner.vertices.next;
                                _loc_2.zpp_inner.vertices.next.prev = _loc_19;
                                _loc_2.zpp_inner.vertices.next = _loc_19;
                            }
                            _loc_2.zpp_inner.vertices = _loc_19;
                            if (_loc_6 != null)
                            {
                            }
                            if (_loc_6.zpp_disp)
                            {
                                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                            }
                            _loc_9 = _loc_6.zpp_inner;
                            if (_loc_9._immutable)
                            {
                                throw "Error: Vec2 is immutable";
                            }
                            if (_loc_9._isimmutable != null)
                            {
                                _loc_9._isimmutable();
                            }
                            if (_loc_6.zpp_inner._inuse)
                            {
                                throw "Error: This Vec2 is not disposable";
                            }
                            _loc_9 = _loc_6.zpp_inner;
                            _loc_6.zpp_inner.outer = null;
                            _loc_6.zpp_inner = null;
                            _loc_13 = _loc_6;
                            _loc_13.zpp_pool = null;
                            if (ZPP_PubPool.nextVec2 != null)
                            {
                                ZPP_PubPool.nextVec2.zpp_pool = _loc_13;
                            }
                            else
                            {
                                ZPP_PubPool.poolVec2 = _loc_13;
                            }
                            ZPP_PubPool.nextVec2 = _loc_13;
                            _loc_13.zpp_disp = true;
                            _loc_21 = _loc_9;
                            if (_loc_21.outer != null)
                            {
                                _loc_21.outer.zpp_inner = null;
                                _loc_21.outer = null;
                            }
                            _loc_21._isimmutable = null;
                            _loc_21._validate = null;
                            _loc_21._invalidate = null;
                            _loc_21.next = ZPP_Vec2.zpp_pool;
                            ZPP_Vec2.zpp_pool = _loc_21;
                        }while (_loc_11 != _loc_7)
                    }
                }
                else
                {
                    throw "Error: Invalid type for polygon object, should be Array<Vec2>, Vec2List, GeomPoly or for flash10+ flash.Vector<Vec2>";
                }
                _loc_2.skipForward(1);
                if (param1 is Array)
                {
                    _loc_3 = param1;
                    _loc_4 = 0;
                    while (_loc_4 < _loc_3.length)
                    {
                        
                        _loc_6 = _loc_3[_loc_4];
                        if (_loc_6.zpp_inner.weak)
                        {
                            if (_loc_6 != null)
                            {
                            }
                            if (_loc_6.zpp_disp)
                            {
                                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                            }
                            _loc_9 = _loc_6.zpp_inner;
                            if (_loc_9._immutable)
                            {
                                throw "Error: Vec2 is immutable";
                            }
                            if (_loc_9._isimmutable != null)
                            {
                                _loc_9._isimmutable();
                            }
                            if (_loc_6.zpp_inner._inuse)
                            {
                                throw "Error: This Vec2 is not disposable";
                            }
                            _loc_9 = _loc_6.zpp_inner;
                            _loc_6.zpp_inner.outer = null;
                            _loc_6.zpp_inner = null;
                            _loc_13 = _loc_6;
                            _loc_13.zpp_pool = null;
                            if (ZPP_PubPool.nextVec2 != null)
                            {
                                ZPP_PubPool.nextVec2.zpp_pool = _loc_13;
                            }
                            else
                            {
                                ZPP_PubPool.poolVec2 = _loc_13;
                            }
                            ZPP_PubPool.nextVec2 = _loc_13;
                            _loc_13.zpp_disp = true;
                            _loc_21 = _loc_9;
                            if (_loc_21.outer != null)
                            {
                                _loc_21.outer.zpp_inner = null;
                                _loc_21.outer = null;
                            }
                            _loc_21._isimmutable = null;
                            _loc_21._validate = null;
                            _loc_21._invalidate = null;
                            _loc_21.next = ZPP_Vec2.zpp_pool;
                            ZPP_Vec2.zpp_pool = _loc_21;
                        }
                        else
                        {
                        }
                        if (false)
                        {
                            _loc_3.splice(_loc_4, 1);
                            continue;
                        }
                        _loc_4++;
                    }
                }
                else if (param1 is ZPP_Const.vec2vector)
                {
                    _loc_12 = param1;
                    if (!_loc_12.fixed)
                    {
                        _loc_4 = 0;
                        while (_loc_4 < _loc_12.length)
                        {
                            
                            _loc_6 = _loc_12[_loc_4];
                            if (_loc_6.zpp_inner.weak)
                            {
                                if (_loc_6 != null)
                                {
                                }
                                if (_loc_6.zpp_disp)
                                {
                                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                                }
                                _loc_9 = _loc_6.zpp_inner;
                                if (_loc_9._immutable)
                                {
                                    throw "Error: Vec2 is immutable";
                                }
                                if (_loc_9._isimmutable != null)
                                {
                                    _loc_9._isimmutable();
                                }
                                if (_loc_6.zpp_inner._inuse)
                                {
                                    throw "Error: This Vec2 is not disposable";
                                }
                                _loc_9 = _loc_6.zpp_inner;
                                _loc_6.zpp_inner.outer = null;
                                _loc_6.zpp_inner = null;
                                _loc_13 = _loc_6;
                                _loc_13.zpp_pool = null;
                                if (ZPP_PubPool.nextVec2 != null)
                                {
                                    ZPP_PubPool.nextVec2.zpp_pool = _loc_13;
                                }
                                else
                                {
                                    ZPP_PubPool.poolVec2 = _loc_13;
                                }
                                ZPP_PubPool.nextVec2 = _loc_13;
                                _loc_13.zpp_disp = true;
                                _loc_21 = _loc_9;
                                if (_loc_21.outer != null)
                                {
                                    _loc_21.outer.zpp_inner = null;
                                    _loc_21.outer = null;
                                }
                                _loc_21._isimmutable = null;
                                _loc_21._validate = null;
                                _loc_21._invalidate = null;
                                _loc_21.next = ZPP_Vec2.zpp_pool;
                                ZPP_Vec2.zpp_pool = _loc_21;
                            }
                            else
                            {
                            }
                            if (false)
                            {
                                _loc_12.splice(_loc_4, 1);
                                continue;
                            }
                            _loc_4++;
                        }
                    }
                }
                else if (param1 is Vec2List)
                {
                    _loc_14 = param1;
                    if (_loc_14.zpp_inner._validate != null)
                    {
                        _loc_14.zpp_inner._validate();
                    }
                    _loc_22 = _loc_14.zpp_inner.inner;
                    _loc_23 = null;
                    _loc_24 = _loc_22.head;
                    while (_loc_24 != null)
                    {
                        
                        _loc_9 = _loc_24.elt;
                        if (_loc_9.outer.zpp_inner.weak)
                        {
                            _loc_24 = _loc_22.erase(_loc_23);
                            if (_loc_9.outer.zpp_inner.weak)
                            {
                                _loc_6 = _loc_9.outer;
                                if (_loc_6 != null)
                                {
                                }
                                if (_loc_6.zpp_disp)
                                {
                                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                                }
                                _loc_21 = _loc_6.zpp_inner;
                                if (_loc_21._immutable)
                                {
                                    throw "Error: Vec2 is immutable";
                                }
                                if (_loc_21._isimmutable != null)
                                {
                                    _loc_21._isimmutable();
                                }
                                if (_loc_6.zpp_inner._inuse)
                                {
                                    throw "Error: This Vec2 is not disposable";
                                }
                                _loc_21 = _loc_6.zpp_inner;
                                _loc_6.zpp_inner.outer = null;
                                _loc_6.zpp_inner = null;
                                _loc_13 = _loc_6;
                                _loc_13.zpp_pool = null;
                                if (ZPP_PubPool.nextVec2 != null)
                                {
                                    ZPP_PubPool.nextVec2.zpp_pool = _loc_13;
                                }
                                else
                                {
                                    ZPP_PubPool.poolVec2 = _loc_13;
                                }
                                ZPP_PubPool.nextVec2 = _loc_13;
                                _loc_13.zpp_disp = true;
                                _loc_25 = _loc_21;
                                if (_loc_25.outer != null)
                                {
                                    _loc_25.outer.zpp_inner = null;
                                    _loc_25.outer = null;
                                }
                                _loc_25._isimmutable = null;
                                _loc_25._validate = null;
                                _loc_25._invalidate = null;
                                _loc_25.next = ZPP_Vec2.zpp_pool;
                                ZPP_Vec2.zpp_pool = _loc_25;
                            }
                            else
                            {
                            }
                            continue;
                        }
                        _loc_23 = _loc_24;
                        _loc_24 = _loc_24.next;
                    }
                }
            }
            return _loc_2;
        }// end function

    }
}
