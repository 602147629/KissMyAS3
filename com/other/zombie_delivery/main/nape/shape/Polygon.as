package nape.shape
{
    import __AS3__.vec.*;
    import flash.*;
    import nape.dynamics.*;
    import nape.geom.*;
    import nape.phys.*;
    import zpp_nape.*;
    import zpp_nape.callbacks.*;
    import zpp_nape.dynamics.*;
    import zpp_nape.geom.*;
    import zpp_nape.phys.*;
    import zpp_nape.shape.*;
    import zpp_nape.util.*;

    final public class Polygon extends Shape
    {
        public var zpp_inner_zn:ZPP_Polygon;

        public function Polygon(param1 = undefined, param2:Material = undefined, param3:InteractionFilter = undefined) : void
        {
            var _loc_5:* = null;
            var _loc_6:* = null as Array;
            var _loc_7:* = 0;
            var _loc_8:* = null as Vec2;
            var _loc_9:* = false;
            var _loc_10:* = NaN;
            var _loc_11:* = null as ZPP_Vec2;
            var _loc_12:* = NaN;
            var _loc_13:* = null as Vec2;
            var _loc_14:* = false;
            var _loc_15:* = null as Vector.<Vec2>;
            var _loc_16:* = null as Vec2;
            var _loc_17:* = null as Vec2List;
            var _loc_18:* = null as Vec2Iterator;
            var _loc_19:* = null as GeomPoly;
            var _loc_20:* = null as ZPP_GeomVert;
            var _loc_21:* = null as ZPP_GeomVert;
            var _loc_22:* = null as ZPP_Vec2;
            var _loc_23:* = null as ZNPList_ZPP_Vec2;
            var _loc_24:* = null as ZNPNode_ZPP_Vec2;
            var _loc_25:* = null as ZNPNode_ZPP_Vec2;
            var _loc_26:* = null as ZPP_Vec2;
            if (Boot.skip_constructor)
            {
                return;
            }
            zpp_inner_zn = null;
            ;
            _loc_5 = this;
            if (param1 == null)
            {
                throw "Error: localVerts cannot be null";
            }
            zpp_inner_zn = new ZPP_Polygon();
            zpp_inner_zn.outer = this;
            zpp_inner_zn.outer_zn = this;
            zpp_inner = zpp_inner_zn;
            zpp_inner_i = zpp_inner;
            zpp_inner_i.outer_i = this;
            if (param1 is Array)
            {
                _loc_6 = param1;
                _loc_7 = 0;
                while (_loc_7 < _loc_6.length)
                {
                    
                    _loc_5 = _loc_6[_loc_7];
                    _loc_7++;
                    if (_loc_5 == null)
                    {
                        throw "Error: Array<Vec2> contains null objects";
                    }
                    if (!(_loc_5 is Vec2))
                    {
                        throw "Error: Array<Vec2> contains non Vec2 objects";
                    }
                    _loc_8 = _loc_5;
                    if (_loc_8 != null)
                    {
                    }
                    if (_loc_8.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    if (zpp_inner_zn.wrap_lverts == null)
                    {
                        zpp_inner_zn.getlverts();
                    }
                    _loc_9 = false;
                    if (_loc_8 != null)
                    {
                    }
                    if (_loc_8.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    if (_loc_8.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_11 = _loc_8.zpp_inner;
                    if (_loc_11._validate != null)
                    {
                        _loc_11._validate();
                    }
                    _loc_10 = _loc_8.zpp_inner.x;
                    if (_loc_8.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_11 = _loc_8.zpp_inner;
                    if (_loc_11._validate != null)
                    {
                        _loc_11._validate();
                    }
                    _loc_12 = _loc_8.zpp_inner.y;
                    if (_loc_10 == _loc_10)
                    {
                    }
                    if (_loc_12 != _loc_12)
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
                        _loc_14 = false;
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
                        _loc_11._immutable = _loc_14;
                        _loc_11.x = _loc_10;
                        _loc_11.y = _loc_12;
                        _loc_13.zpp_inner = _loc_11;
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
                        _loc_11 = _loc_13.zpp_inner;
                        if (_loc_11._immutable)
                        {
                            throw "Error: Vec2 is immutable";
                        }
                        if (_loc_11._isimmutable != null)
                        {
                            _loc_11._isimmutable();
                        }
                        if (_loc_10 == _loc_10)
                        {
                        }
                        if (_loc_12 != _loc_12)
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
                        _loc_11 = _loc_13.zpp_inner;
                        if (_loc_11._validate != null)
                        {
                            _loc_11._validate();
                        }
                        if (_loc_13.zpp_inner.x == _loc_10)
                        {
                            if (_loc_13 != null)
                            {
                            }
                            if (_loc_13.zpp_disp)
                            {
                                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                            }
                            _loc_11 = _loc_13.zpp_inner;
                            if (_loc_11._validate != null)
                            {
                                _loc_11._validate();
                            }
                        }
                        if (_loc_13.zpp_inner.y != _loc_12)
                        {
                            _loc_13.zpp_inner.x = _loc_10;
                            _loc_13.zpp_inner.y = _loc_12;
                            _loc_11 = _loc_13.zpp_inner;
                            if (_loc_11._invalidate != null)
                            {
                                _loc_11._invalidate(_loc_11);
                            }
                        }
                    }
                    _loc_13.zpp_inner.weak = _loc_9;
                    zpp_inner_zn.wrap_lverts.push(_loc_13);
                }
            }
            else if (param1 is ZPP_Const.vec2vector)
            {
                _loc_15 = param1;
                _loc_7 = 0;
                while (_loc_7 < _loc_15.length)
                {
                    
                    _loc_8 = _loc_15[_loc_7];
                    _loc_7++;
                    if (_loc_8 == null)
                    {
                        throw "Error: flash.Vector<Vec2> contains null objects";
                    }
                    _loc_13 = _loc_8;
                    if (_loc_13 != null)
                    {
                    }
                    if (_loc_13.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    if (zpp_inner_zn.wrap_lverts == null)
                    {
                        zpp_inner_zn.getlverts();
                    }
                    _loc_9 = false;
                    if (_loc_13 != null)
                    {
                    }
                    if (_loc_13.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    if (_loc_13.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_11 = _loc_13.zpp_inner;
                    if (_loc_11._validate != null)
                    {
                        _loc_11._validate();
                    }
                    _loc_10 = _loc_13.zpp_inner.x;
                    if (_loc_13.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_11 = _loc_13.zpp_inner;
                    if (_loc_11._validate != null)
                    {
                        _loc_11._validate();
                    }
                    _loc_12 = _loc_13.zpp_inner.y;
                    if (_loc_10 == _loc_10)
                    {
                    }
                    if (_loc_12 != _loc_12)
                    {
                        throw "Error: Vec2 components cannot be NaN";
                    }
                    if (ZPP_PubPool.poolVec2 == null)
                    {
                        _loc_16 = new Vec2();
                    }
                    else
                    {
                        _loc_16 = ZPP_PubPool.poolVec2;
                        ZPP_PubPool.poolVec2 = _loc_16.zpp_pool;
                        _loc_16.zpp_pool = null;
                        _loc_16.zpp_disp = false;
                        if (_loc_16 == ZPP_PubPool.nextVec2)
                        {
                            ZPP_PubPool.nextVec2 = null;
                        }
                    }
                    if (_loc_16.zpp_inner == null)
                    {
                        _loc_14 = false;
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
                        _loc_11._immutable = _loc_14;
                        _loc_11.x = _loc_10;
                        _loc_11.y = _loc_12;
                        _loc_16.zpp_inner = _loc_11;
                        _loc_16.zpp_inner.outer = _loc_16;
                    }
                    else
                    {
                        if (_loc_16 != null)
                        {
                        }
                        if (_loc_16.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_11 = _loc_16.zpp_inner;
                        if (_loc_11._immutable)
                        {
                            throw "Error: Vec2 is immutable";
                        }
                        if (_loc_11._isimmutable != null)
                        {
                            _loc_11._isimmutable();
                        }
                        if (_loc_10 == _loc_10)
                        {
                        }
                        if (_loc_12 != _loc_12)
                        {
                            throw "Error: Vec2 components cannot be NaN";
                        }
                        if (_loc_16 != null)
                        {
                        }
                        if (_loc_16.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_11 = _loc_16.zpp_inner;
                        if (_loc_11._validate != null)
                        {
                            _loc_11._validate();
                        }
                        if (_loc_16.zpp_inner.x == _loc_10)
                        {
                            if (_loc_16 != null)
                            {
                            }
                            if (_loc_16.zpp_disp)
                            {
                                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                            }
                            _loc_11 = _loc_16.zpp_inner;
                            if (_loc_11._validate != null)
                            {
                                _loc_11._validate();
                            }
                        }
                        if (_loc_16.zpp_inner.y != _loc_12)
                        {
                            _loc_16.zpp_inner.x = _loc_10;
                            _loc_16.zpp_inner.y = _loc_12;
                            _loc_11 = _loc_16.zpp_inner;
                            if (_loc_11._invalidate != null)
                            {
                                _loc_11._invalidate(_loc_11);
                            }
                        }
                    }
                    _loc_16.zpp_inner.weak = _loc_9;
                    zpp_inner_zn.wrap_lverts.push(_loc_16);
                }
            }
            else if (param1 is Vec2List)
            {
                _loc_17 = param1;
                _loc_18 = _loc_17.iterator();
                do
                {
                    
                    _loc_18.zpp_critical = false;
                    _loc_7 = _loc_18.zpp_i;
                    (_loc_18.zpp_i + 1);
                    _loc_8 = _loc_18.zpp_inner.at(_loc_7);
                    if (_loc_8 == null)
                    {
                        throw "Error: Vec2List contains null objects";
                    }
                    if (_loc_8 != null)
                    {
                    }
                    if (_loc_8.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    if (zpp_inner_zn.wrap_lverts == null)
                    {
                        zpp_inner_zn.getlverts();
                    }
                    _loc_9 = false;
                    if (_loc_8 != null)
                    {
                    }
                    if (_loc_8.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    if (_loc_8.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_11 = _loc_8.zpp_inner;
                    if (_loc_11._validate != null)
                    {
                        _loc_11._validate();
                    }
                    _loc_10 = _loc_8.zpp_inner.x;
                    if (_loc_8.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_11 = _loc_8.zpp_inner;
                    if (_loc_11._validate != null)
                    {
                        _loc_11._validate();
                    }
                    _loc_12 = _loc_8.zpp_inner.y;
                    if (_loc_10 == _loc_10)
                    {
                    }
                    if (_loc_12 != _loc_12)
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
                        _loc_14 = false;
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
                        _loc_11._immutable = _loc_14;
                        _loc_11.x = _loc_10;
                        _loc_11.y = _loc_12;
                        _loc_13.zpp_inner = _loc_11;
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
                        _loc_11 = _loc_13.zpp_inner;
                        if (_loc_11._immutable)
                        {
                            throw "Error: Vec2 is immutable";
                        }
                        if (_loc_11._isimmutable != null)
                        {
                            _loc_11._isimmutable();
                        }
                        if (_loc_10 == _loc_10)
                        {
                        }
                        if (_loc_12 != _loc_12)
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
                        _loc_11 = _loc_13.zpp_inner;
                        if (_loc_11._validate != null)
                        {
                            _loc_11._validate();
                        }
                        if (_loc_13.zpp_inner.x == _loc_10)
                        {
                            if (_loc_13 != null)
                            {
                            }
                            if (_loc_13.zpp_disp)
                            {
                                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                            }
                            _loc_11 = _loc_13.zpp_inner;
                            if (_loc_11._validate != null)
                            {
                                _loc_11._validate();
                            }
                        }
                        if (_loc_13.zpp_inner.y != _loc_12)
                        {
                            _loc_13.zpp_inner.x = _loc_10;
                            _loc_13.zpp_inner.y = _loc_12;
                            _loc_11 = _loc_13.zpp_inner;
                            if (_loc_11._invalidate != null)
                            {
                                _loc_11._invalidate(_loc_11);
                            }
                        }
                    }
                    _loc_13.zpp_inner.weak = _loc_9;
                    zpp_inner_zn.wrap_lverts.push(_loc_13);
                    _loc_18.zpp_inner.zpp_inner.valmod();
                    _loc_7 = _loc_18.zpp_inner.zpp_gl();
                    _loc_18.zpp_critical = true;
                }while (_loc_18.zpp_i < _loc_7 ? (true) : (_loc_18.zpp_next = Vec2Iterator.zpp_pool, Vec2Iterator.zpp_pool = _loc_18, _loc_18.zpp_inner = null, false))
            }
            else if (param1 is GeomPoly)
            {
                _loc_19 = param1;
                if (_loc_19 != null)
                {
                }
                if (_loc_19.zpp_disp)
                {
                    throw "Error: " + "GeomPoly" + " has been disposed and cannot be used!";
                }
                _loc_20 = _loc_19.zpp_inner.vertices;
                if (_loc_20 != null)
                {
                    _loc_21 = _loc_20;
                    do
                    {
                        
                        _loc_10 = _loc_21.x;
                        _loc_12 = _loc_21.y;
                        _loc_9 = false;
                        if (_loc_10 == _loc_10)
                        {
                        }
                        if (_loc_12 != _loc_12)
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
                            _loc_14 = false;
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
                            _loc_11._immutable = _loc_14;
                            _loc_11.x = _loc_10;
                            _loc_11.y = _loc_12;
                            _loc_13.zpp_inner = _loc_11;
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
                            _loc_11 = _loc_13.zpp_inner;
                            if (_loc_11._immutable)
                            {
                                throw "Error: Vec2 is immutable";
                            }
                            if (_loc_11._isimmutable != null)
                            {
                                _loc_11._isimmutable();
                            }
                            if (_loc_10 == _loc_10)
                            {
                            }
                            if (_loc_12 != _loc_12)
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
                            _loc_11 = _loc_13.zpp_inner;
                            if (_loc_11._validate != null)
                            {
                                _loc_11._validate();
                            }
                            if (_loc_13.zpp_inner.x == _loc_10)
                            {
                                if (_loc_13 != null)
                                {
                                }
                                if (_loc_13.zpp_disp)
                                {
                                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                                }
                                _loc_11 = _loc_13.zpp_inner;
                                if (_loc_11._validate != null)
                                {
                                    _loc_11._validate();
                                }
                            }
                            if (_loc_13.zpp_inner.y != _loc_12)
                            {
                                _loc_13.zpp_inner.x = _loc_10;
                                _loc_13.zpp_inner.y = _loc_12;
                                _loc_11 = _loc_13.zpp_inner;
                                if (_loc_11._invalidate != null)
                                {
                                    _loc_11._invalidate(_loc_11);
                                }
                            }
                        }
                        _loc_13.zpp_inner.weak = _loc_9;
                        _loc_8 = _loc_13;
                        _loc_21 = _loc_21.next;
                        if (zpp_inner_zn.wrap_lverts == null)
                        {
                            zpp_inner_zn.getlverts();
                        }
                        _loc_9 = false;
                        if (_loc_8 != null)
                        {
                        }
                        if (_loc_8.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        if (_loc_8.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_11 = _loc_8.zpp_inner;
                        if (_loc_11._validate != null)
                        {
                            _loc_11._validate();
                        }
                        _loc_10 = _loc_8.zpp_inner.x;
                        if (_loc_8.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_11 = _loc_8.zpp_inner;
                        if (_loc_11._validate != null)
                        {
                            _loc_11._validate();
                        }
                        _loc_12 = _loc_8.zpp_inner.y;
                        if (_loc_10 == _loc_10)
                        {
                        }
                        if (_loc_12 != _loc_12)
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
                            _loc_14 = false;
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
                            _loc_11._immutable = _loc_14;
                            _loc_11.x = _loc_10;
                            _loc_11.y = _loc_12;
                            _loc_13.zpp_inner = _loc_11;
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
                            _loc_11 = _loc_13.zpp_inner;
                            if (_loc_11._immutable)
                            {
                                throw "Error: Vec2 is immutable";
                            }
                            if (_loc_11._isimmutable != null)
                            {
                                _loc_11._isimmutable();
                            }
                            if (_loc_10 == _loc_10)
                            {
                            }
                            if (_loc_12 != _loc_12)
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
                            _loc_11 = _loc_13.zpp_inner;
                            if (_loc_11._validate != null)
                            {
                                _loc_11._validate();
                            }
                            if (_loc_13.zpp_inner.x == _loc_10)
                            {
                                if (_loc_13 != null)
                                {
                                }
                                if (_loc_13.zpp_disp)
                                {
                                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                                }
                                _loc_11 = _loc_13.zpp_inner;
                                if (_loc_11._validate != null)
                                {
                                    _loc_11._validate();
                                }
                            }
                            if (_loc_13.zpp_inner.y != _loc_12)
                            {
                                _loc_13.zpp_inner.x = _loc_10;
                                _loc_13.zpp_inner.y = _loc_12;
                                _loc_11 = _loc_13.zpp_inner;
                                if (_loc_11._invalidate != null)
                                {
                                    _loc_11._invalidate(_loc_11);
                                }
                            }
                        }
                        _loc_13.zpp_inner.weak = _loc_9;
                        zpp_inner_zn.wrap_lverts.push(_loc_13);
                        if (_loc_8 != null)
                        {
                        }
                        if (_loc_8.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_11 = _loc_8.zpp_inner;
                        if (_loc_11._immutable)
                        {
                            throw "Error: Vec2 is immutable";
                        }
                        if (_loc_11._isimmutable != null)
                        {
                            _loc_11._isimmutable();
                        }
                        if (_loc_8.zpp_inner._inuse)
                        {
                            throw "Error: This Vec2 is not disposable";
                        }
                        _loc_11 = _loc_8.zpp_inner;
                        _loc_8.zpp_inner.outer = null;
                        _loc_8.zpp_inner = null;
                        _loc_13 = _loc_8;
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
                        _loc_22 = _loc_11;
                        if (_loc_22.outer != null)
                        {
                            _loc_22.outer.zpp_inner = null;
                            _loc_22.outer = null;
                        }
                        _loc_22._isimmutable = null;
                        _loc_22._validate = null;
                        _loc_22._invalidate = null;
                        _loc_22.next = ZPP_Vec2.zpp_pool;
                        ZPP_Vec2.zpp_pool = _loc_22;
                    }while (_loc_21 != _loc_20)
                }
            }
            else
            {
                throw "Error: Invalid type for polygon object, should be Array<Vec2>, Vec2List, GeomPoly or for flash10+ flash.Vector<Vec2>";
            }
            if (param1 is Array)
            {
                _loc_6 = param1;
                _loc_7 = 0;
                while (_loc_7 < _loc_6.length)
                {
                    
                    _loc_8 = _loc_6[_loc_7];
                    if (_loc_8.zpp_inner.weak)
                    {
                        if (_loc_8 != null)
                        {
                        }
                        if (_loc_8.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_11 = _loc_8.zpp_inner;
                        if (_loc_11._immutable)
                        {
                            throw "Error: Vec2 is immutable";
                        }
                        if (_loc_11._isimmutable != null)
                        {
                            _loc_11._isimmutable();
                        }
                        if (_loc_8.zpp_inner._inuse)
                        {
                            throw "Error: This Vec2 is not disposable";
                        }
                        _loc_11 = _loc_8.zpp_inner;
                        _loc_8.zpp_inner.outer = null;
                        _loc_8.zpp_inner = null;
                        _loc_13 = _loc_8;
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
                        _loc_22 = _loc_11;
                        if (_loc_22.outer != null)
                        {
                            _loc_22.outer.zpp_inner = null;
                            _loc_22.outer = null;
                        }
                        _loc_22._isimmutable = null;
                        _loc_22._validate = null;
                        _loc_22._invalidate = null;
                        _loc_22.next = ZPP_Vec2.zpp_pool;
                        ZPP_Vec2.zpp_pool = _loc_22;
                    }
                    else
                    {
                    }
                    if (false)
                    {
                        _loc_6.splice(_loc_7, 1);
                        continue;
                    }
                    _loc_7++;
                }
            }
            else if (param1 is ZPP_Const.vec2vector)
            {
                _loc_15 = param1;
                if (!_loc_15.fixed)
                {
                    _loc_7 = 0;
                    while (_loc_7 < _loc_15.length)
                    {
                        
                        _loc_8 = _loc_15[_loc_7];
                        if (_loc_8.zpp_inner.weak)
                        {
                            if (_loc_8 != null)
                            {
                            }
                            if (_loc_8.zpp_disp)
                            {
                                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                            }
                            _loc_11 = _loc_8.zpp_inner;
                            if (_loc_11._immutable)
                            {
                                throw "Error: Vec2 is immutable";
                            }
                            if (_loc_11._isimmutable != null)
                            {
                                _loc_11._isimmutable();
                            }
                            if (_loc_8.zpp_inner._inuse)
                            {
                                throw "Error: This Vec2 is not disposable";
                            }
                            _loc_11 = _loc_8.zpp_inner;
                            _loc_8.zpp_inner.outer = null;
                            _loc_8.zpp_inner = null;
                            _loc_13 = _loc_8;
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
                            _loc_22 = _loc_11;
                            if (_loc_22.outer != null)
                            {
                                _loc_22.outer.zpp_inner = null;
                                _loc_22.outer = null;
                            }
                            _loc_22._isimmutable = null;
                            _loc_22._validate = null;
                            _loc_22._invalidate = null;
                            _loc_22.next = ZPP_Vec2.zpp_pool;
                            ZPP_Vec2.zpp_pool = _loc_22;
                        }
                        else
                        {
                        }
                        if (false)
                        {
                            _loc_15.splice(_loc_7, 1);
                            continue;
                        }
                        _loc_7++;
                    }
                }
            }
            else if (param1 is Vec2List)
            {
                _loc_17 = param1;
                if (_loc_17.zpp_inner._validate != null)
                {
                    _loc_17.zpp_inner._validate();
                }
                _loc_23 = _loc_17.zpp_inner.inner;
                _loc_24 = null;
                _loc_25 = _loc_23.head;
                while (_loc_25 != null)
                {
                    
                    _loc_11 = _loc_25.elt;
                    if (_loc_11.outer.zpp_inner.weak)
                    {
                        _loc_25 = _loc_23.erase(_loc_24);
                        if (_loc_11.outer.zpp_inner.weak)
                        {
                            _loc_8 = _loc_11.outer;
                            if (_loc_8 != null)
                            {
                            }
                            if (_loc_8.zpp_disp)
                            {
                                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                            }
                            _loc_22 = _loc_8.zpp_inner;
                            if (_loc_22._immutable)
                            {
                                throw "Error: Vec2 is immutable";
                            }
                            if (_loc_22._isimmutable != null)
                            {
                                _loc_22._isimmutable();
                            }
                            if (_loc_8.zpp_inner._inuse)
                            {
                                throw "Error: This Vec2 is not disposable";
                            }
                            _loc_22 = _loc_8.zpp_inner;
                            _loc_8.zpp_inner.outer = null;
                            _loc_8.zpp_inner = null;
                            _loc_13 = _loc_8;
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
                            _loc_26 = _loc_22;
                            if (_loc_26.outer != null)
                            {
                                _loc_26.outer.zpp_inner = null;
                                _loc_26.outer = null;
                            }
                            _loc_26._isimmutable = null;
                            _loc_26._validate = null;
                            _loc_26._invalidate = null;
                            _loc_26.next = ZPP_Vec2.zpp_pool;
                            ZPP_Vec2.zpp_pool = _loc_26;
                        }
                        else
                        {
                        }
                        continue;
                    }
                    _loc_24 = _loc_25;
                    _loc_25 = _loc_25.next;
                }
            }
            if (param2 == null)
            {
                if (ZPP_Material.zpp_pool == null)
                {
                    zpp_inner.material = new ZPP_Material();
                }
                else
                {
                    zpp_inner.material = ZPP_Material.zpp_pool;
                    ZPP_Material.zpp_pool = zpp_inner.material.next;
                    zpp_inner.material.next = null;
                }
            }
            else
            {
                zpp_inner.immutable_midstep("Shape::material");
                if (param2 == null)
                {
                    throw "Error: Cannot assign null as Shape material";
                }
                zpp_inner.setMaterial(param2.zpp_inner);
                zpp_inner.material.wrapper();
            }
            if (param3 == null)
            {
                if (ZPP_InteractionFilter.zpp_pool == null)
                {
                    zpp_inner.filter = new ZPP_InteractionFilter();
                }
                else
                {
                    zpp_inner.filter = ZPP_InteractionFilter.zpp_pool;
                    ZPP_InteractionFilter.zpp_pool = zpp_inner.filter.next;
                    zpp_inner.filter.next = null;
                }
            }
            else
            {
                zpp_inner.immutable_midstep("Shape::filter");
                if (param3 == null)
                {
                    throw "Error: Cannot assign null as Shape filter";
                }
                zpp_inner.setFilter(param3.zpp_inner);
                zpp_inner.filter.wrapper();
            }
            zpp_inner_i.insert_cbtype(ZPP_CbType.ANY_SHAPE.zpp_inner);
            return;
        }// end function

        public function validity() : ValidationResult
        {
            return zpp_inner_zn.valid();
        }// end function

        public function get_worldVerts() : Vec2List
        {
            if (zpp_inner_zn.wrap_gverts == null)
            {
                zpp_inner_zn.getgverts();
            }
            return zpp_inner_zn.wrap_gverts;
        }// end function

        public function get_localVerts() : Vec2List
        {
            if (zpp_inner_zn.wrap_lverts == null)
            {
                zpp_inner_zn.getlverts();
            }
            return zpp_inner_zn.wrap_lverts;
        }// end function

        public function get_edges() : EdgeList
        {
            if (zpp_inner_zn.wrap_edges == null)
            {
                zpp_inner_zn.getedges();
            }
            return zpp_inner_zn.wrap_edges;
        }// end function

        public static function rect(param1:Number, param2:Number, param3:Number, param4:Number, param5:Boolean = false) : Array
        {
            var _loc_6:* = null as Vec2;
            var _loc_7:* = false;
            var _loc_8:* = null as ZPP_Vec2;
            if (param1 == param1)
            {
            }
            if (param2 == param2)
            {
            }
            if (param3 == param3)
            {
            }
            if (param4 != param4)
            {
                throw "Error: Polygon.rect cannot accept NaN arguments";
            }
            if (param1 == param1)
            {
            }
            if (param2 != param2)
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
                _loc_8.x = param1;
                _loc_8.y = param2;
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
                if (param1 == param1)
                {
                }
                if (param2 != param2)
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
                if (_loc_6.zpp_inner.x == param1)
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
                if (_loc_6.zpp_inner.y != param2)
                {
                    _loc_6.zpp_inner.x = param1;
                    _loc_6.zpp_inner.y = param2;
                    _loc_8 = _loc_6.zpp_inner;
                    if (_loc_8._invalidate != null)
                    {
                        _loc_8._invalidate(_loc_8);
                    }
                }
            }
            _loc_6.zpp_inner.weak = param5;
            var _loc_9:* = param1 + param3;
            if (_loc_9 == _loc_9)
            {
            }
            if (param2 != param2)
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
                _loc_8.x = _loc_9;
                _loc_8.y = param2;
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
                if (_loc_9 == _loc_9)
                {
                }
                if (param2 != param2)
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
                if (_loc_6.zpp_inner.x == _loc_9)
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
                if (_loc_6.zpp_inner.y != param2)
                {
                    _loc_6.zpp_inner.x = _loc_9;
                    _loc_6.zpp_inner.y = param2;
                    _loc_8 = _loc_6.zpp_inner;
                    if (_loc_8._invalidate != null)
                    {
                        _loc_8._invalidate(_loc_8);
                    }
                }
            }
            _loc_6.zpp_inner.weak = param5;
            _loc_9 = param1 + param3;
            var _loc_10:* = param2 + param4;
            if (_loc_9 == _loc_9)
            {
            }
            if (_loc_10 != _loc_10)
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
                _loc_8.x = _loc_9;
                _loc_8.y = _loc_10;
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
                if (_loc_9 == _loc_9)
                {
                }
                if (_loc_10 != _loc_10)
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
                if (_loc_6.zpp_inner.x == _loc_9)
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
                if (_loc_6.zpp_inner.y != _loc_10)
                {
                    _loc_6.zpp_inner.x = _loc_9;
                    _loc_6.zpp_inner.y = _loc_10;
                    _loc_8 = _loc_6.zpp_inner;
                    if (_loc_8._invalidate != null)
                    {
                        _loc_8._invalidate(_loc_8);
                    }
                }
            }
            _loc_6.zpp_inner.weak = param5;
            _loc_9 = param2 + param4;
            if (param1 == param1)
            {
            }
            if (_loc_9 != _loc_9)
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
                _loc_8.x = param1;
                _loc_8.y = _loc_9;
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
                if (param1 == param1)
                {
                }
                if (_loc_9 != _loc_9)
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
                if (_loc_6.zpp_inner.x == param1)
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
                if (_loc_6.zpp_inner.y != _loc_9)
                {
                    _loc_6.zpp_inner.x = param1;
                    _loc_6.zpp_inner.y = _loc_9;
                    _loc_8 = _loc_6.zpp_inner;
                    if (_loc_8._invalidate != null)
                    {
                        _loc_8._invalidate(_loc_8);
                    }
                }
            }
            _loc_6.zpp_inner.weak = param5;
            return [_loc_6, _loc_6, _loc_6, _loc_6];
        }// end function

        public static function box(param1:Number, param2:Number, param3:Boolean = false) : Array
        {
            if (param1 == param1)
            {
            }
            if (param2 != param2)
            {
                throw "Error: Polygon.box cannot accept NaN arguments";
            }
            return Polygon.rect((-param1) / 2, (-param2) / 2, param1, param2, param3);
        }// end function

        public static function regular(param1:Number, param2:Number, param3:int, param4:Number = 0, param5:Boolean = false) : Array
        {
            var _loc_9:* = 0;
            var _loc_10:* = NaN;
            var _loc_11:* = null as Vec2;
            var _loc_12:* = NaN;
            var _loc_13:* = NaN;
            var _loc_14:* = null as Vec2;
            var _loc_15:* = false;
            var _loc_16:* = null as ZPP_Vec2;
            if (param1 == param1)
            {
            }
            if (param2 == param2)
            {
            }
            if (param4 != param4)
            {
                throw "Error: Polygon.regular cannot accept NaN arguments";
            }
            var _loc_6:* = [];
            var _loc_7:* = Math.PI * 2 / param3;
            var _loc_8:* = 0;
            while (_loc_8 < param3)
            {
                
                _loc_8++;
                _loc_9 = _loc_8;
                _loc_10 = _loc_9 * _loc_7 + param4;
                _loc_12 = Math.cos(_loc_10) * param1;
                _loc_13 = Math.sin(_loc_10) * param2;
                if (_loc_12 == _loc_12)
                {
                }
                if (_loc_13 != _loc_13)
                {
                    throw "Error: Vec2 components cannot be NaN";
                }
                if (ZPP_PubPool.poolVec2 == null)
                {
                    _loc_14 = new Vec2();
                }
                else
                {
                    _loc_14 = ZPP_PubPool.poolVec2;
                    ZPP_PubPool.poolVec2 = _loc_14.zpp_pool;
                    _loc_14.zpp_pool = null;
                    _loc_14.zpp_disp = false;
                    if (_loc_14 == ZPP_PubPool.nextVec2)
                    {
                        ZPP_PubPool.nextVec2 = null;
                    }
                }
                if (_loc_14.zpp_inner == null)
                {
                    _loc_15 = false;
                    if (ZPP_Vec2.zpp_pool == null)
                    {
                        _loc_16 = new ZPP_Vec2();
                    }
                    else
                    {
                        _loc_16 = ZPP_Vec2.zpp_pool;
                        ZPP_Vec2.zpp_pool = _loc_16.next;
                        _loc_16.next = null;
                    }
                    _loc_16.weak = false;
                    _loc_16._immutable = _loc_15;
                    _loc_16.x = _loc_12;
                    _loc_16.y = _loc_13;
                    _loc_14.zpp_inner = _loc_16;
                    _loc_14.zpp_inner.outer = _loc_14;
                }
                else
                {
                    if (_loc_14 != null)
                    {
                    }
                    if (_loc_14.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_16 = _loc_14.zpp_inner;
                    if (_loc_16._immutable)
                    {
                        throw "Error: Vec2 is immutable";
                    }
                    if (_loc_16._isimmutable != null)
                    {
                        _loc_16._isimmutable();
                    }
                    if (_loc_12 == _loc_12)
                    {
                    }
                    if (_loc_13 != _loc_13)
                    {
                        throw "Error: Vec2 components cannot be NaN";
                    }
                    if (_loc_14 != null)
                    {
                    }
                    if (_loc_14.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_16 = _loc_14.zpp_inner;
                    if (_loc_16._validate != null)
                    {
                        _loc_16._validate();
                    }
                    if (_loc_14.zpp_inner.x == _loc_12)
                    {
                        if (_loc_14 != null)
                        {
                        }
                        if (_loc_14.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_16 = _loc_14.zpp_inner;
                        if (_loc_16._validate != null)
                        {
                            _loc_16._validate();
                        }
                    }
                    if (_loc_14.zpp_inner.y != _loc_13)
                    {
                        _loc_14.zpp_inner.x = _loc_12;
                        _loc_14.zpp_inner.y = _loc_13;
                        _loc_16 = _loc_14.zpp_inner;
                        if (_loc_16._invalidate != null)
                        {
                            _loc_16._invalidate(_loc_16);
                        }
                    }
                }
                _loc_14.zpp_inner.weak = param5;
                _loc_11 = _loc_14;
                _loc_6.push(_loc_11);
            }
            return _loc_6;
        }// end function

    }
}
