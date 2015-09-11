package zpp_nape.geom
{
    import flash.*;
    import nape.*;
    import nape.geom.*;
    import zpp_nape.phys.*;
    import zpp_nape.shape.*;
    import zpp_nape.util.*;

    public class ZPP_Ray extends Object
    {
        public var zip_dir:Boolean;
        public var userData:Object;
        public var originy:Number;
        public var originx:Number;
        public var origin:Vec2;
        public var normaly:Number;
        public var normalx:Number;
        public var maxdist:Number;
        public var idiry:Number;
        public var idirx:Number;
        public var diry:Number;
        public var dirx:Number;
        public var direction:Vec2;
        public var absnormaly:Number;
        public var absnormalx:Number;
        public static var internal:Boolean;

        public function ZPP_Ray() : void
        {
            var _loc_4:* = null as Vec2;
            var _loc_5:* = false;
            var _loc_6:* = null as ZPP_Vec2;
            if (Boot.skip_constructor)
            {
                return;
            }
            zip_dir = false;
            absnormaly = 0;
            absnormalx = 0;
            normaly = 0;
            normalx = 0;
            idiry = 0;
            idirx = 0;
            diry = 0;
            dirx = 0;
            originy = 0;
            originx = 0;
            userData = null;
            maxdist = 0;
            direction = null;
            origin = null;
            var _loc_1:* = 0;
            var _loc_2:* = 0;
            var _loc_3:* = false;
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
            origin = _loc_4;
            origin.zpp_inner._invalidate = origin_invalidate;
            _loc_1 = 0;
            _loc_2 = 0;
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
            direction = _loc_4;
            direction.zpp_inner._invalidate = direction_invalidate;
            originx = 0;
            originy = 0;
            dirx = 0;
            diry = 0;
            zip_dir = false;
            return;
        }// end function

        public function validate_dir() : void
        {
            var _loc_1:* = NaN;
            var _loc_2:* = NaN;
            var _loc_3:* = NaN;
            if (zip_dir)
            {
                zip_dir = false;
                if (dirx * dirx + diry * diry < Config.epsilon)
                {
                    throw "Error: Ray::direction is degenerate";
                }
                _loc_1 = dirx * dirx + diry * diry;
                _loc_2 = 1 / Math.sqrt(_loc_1);
                _loc_3 = _loc_2;
                dirx = dirx * _loc_3;
                diry = diry * _loc_3;
                idirx = 1 / dirx;
                idiry = 1 / diry;
                normalx = -diry;
                normaly = dirx;
                _loc_1 = normalx;
                if (_loc_1 < 0)
                {
                    absnormalx = -_loc_1;
                }
                else
                {
                    absnormalx = _loc_1;
                }
                _loc_1 = normaly;
                if (_loc_1 < 0)
                {
                    absnormaly = -_loc_1;
                }
                else
                {
                    absnormaly = _loc_1;
                }
            }
            return;
        }// end function

        public function rayAABB() : ZPP_AABB
        {
            var _loc_5:* = NaN;
            var _loc_7:* = null as ZPP_AABB;
            var _loc_1:* = originx;
            var _loc_2:* = _loc_1;
            var _loc_3:* = originy;
            var _loc_4:* = _loc_3;
            if (maxdist >= 17899999999999994000000000000)
            {
                if (dirx > 0)
                {
                    _loc_2 = 17899999999999994000000000000;
                }
                else if (dirx < 0)
                {
                    _loc_2 = -17899999999999994000000000000;
                }
                if (diry > 0)
                {
                    _loc_4 = 17899999999999994000000000000;
                }
                else if (diry < 0)
                {
                    _loc_4 = -17899999999999994000000000000;
                }
            }
            else
            {
                _loc_2 = _loc_2 + maxdist * dirx;
                _loc_4 = _loc_4 + maxdist * diry;
            }
            if (_loc_2 < _loc_1)
            {
                _loc_5 = _loc_1;
                _loc_1 = _loc_2;
                _loc_2 = _loc_5;
            }
            if (_loc_4 < _loc_3)
            {
                _loc_5 = _loc_3;
                _loc_3 = _loc_4;
                _loc_4 = _loc_5;
            }
            if (ZPP_AABB.zpp_pool == null)
            {
                _loc_7 = new ZPP_AABB();
            }
            else
            {
                _loc_7 = ZPP_AABB.zpp_pool;
                ZPP_AABB.zpp_pool = _loc_7.next;
                _loc_7.next = null;
            }
            _loc_7.minx = _loc_1;
            _loc_7.miny = _loc_3;
            _loc_7.maxx = _loc_2;
            _loc_7.maxy = _loc_4;
            var _loc_6:* = _loc_7;
            return _loc_6;
        }// end function

        public function polysect2(param1:ZPP_Polygon, param2:Boolean, param3:RayResultList) : void
        {
            var _loc_9:* = false;
            var _loc_10:* = null as ZPP_Vec2;
            var _loc_13:* = null as ZPP_Vec2;
            var _loc_14:* = null as ZPP_Edge;
            var _loc_15:* = NaN;
            var _loc_16:* = NaN;
            var _loc_17:* = NaN;
            var _loc_18:* = NaN;
            var _loc_19:* = NaN;
            var _loc_20:* = NaN;
            var _loc_21:* = NaN;
            var _loc_22:* = null as RayResult;
            var _loc_23:* = false;
            var _loc_24:* = null as Vec2;
            var _loc_25:* = false;
            var _loc_26:* = null as ZNPNode_RayResult;
            var _loc_27:* = null as ZNPNode_RayResult;
            var _loc_28:* = null as RayResult;
            var _loc_29:* = null as ZNPList_RayResult;
            var _loc_30:* = null as ZNPNode_RayResult;
            var _loc_4:* = 17899999999999994000000000000;
            var _loc_5:* = -1;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = param1.edges.head;
            _loc_9 = true;
            _loc_10 = param1.gverts.next;
            var _loc_11:* = _loc_10;
            var _loc_12:* = _loc_10.next;
            while (_loc_12 != null)
            {
                
                _loc_13 = _loc_12;
                _loc_14 = _loc_8.elt;
                if (!param2)
                {
                }
                if (_loc_14.gnormx * dirx + _loc_14.gnormy * diry < 0)
                {
                    _loc_15 = 0;
                    _loc_16 = 0;
                    _loc_15 = _loc_13.x - _loc_11.x;
                    _loc_16 = _loc_13.y - _loc_11.y;
                    _loc_17 = 0;
                    _loc_18 = 0;
                    _loc_17 = _loc_11.x - originx;
                    _loc_18 = _loc_11.y - originy;
                    _loc_19 = _loc_16 * dirx - _loc_15 * diry;
                    if (_loc_19 * _loc_19 > Config.epsilon)
                    {
                        _loc_19 = 1 / _loc_19;
                        _loc_20 = (_loc_16 * _loc_17 - _loc_15 * _loc_18) * _loc_19;
                        if (_loc_20 > 0)
                        {
                        }
                        if (_loc_20 <= maxdist)
                        {
                            if (_loc_20 >= _loc_4)
                            {
                            }
                        }
                        if (_loc_20 > _loc_5)
                        {
                            _loc_21 = (diry * _loc_17 - dirx * _loc_18) * _loc_19;
                            if (_loc_21 > -Config.epsilon)
                            {
                            }
                            if (_loc_21 < 1 + Config.epsilon)
                            {
                                if (_loc_20 < _loc_4)
                                {
                                    _loc_4 = _loc_20;
                                    _loc_6 = _loc_8.elt;
                                }
                                if (_loc_20 > _loc_5)
                                {
                                    _loc_5 = _loc_20;
                                    _loc_7 = _loc_8.elt;
                                }
                            }
                        }
                    }
                }
                _loc_8 = _loc_8.next;
                _loc_10 = _loc_12;
                _loc_11 = _loc_13;
                _loc_12 = _loc_12.next;
            }
            if (_loc_9)
            {
                do
                {
                    
                    _loc_12 = param1.gverts.next;
                    _loc_13 = _loc_12;
                    _loc_14 = _loc_8.elt;
                    if (!param2)
                    {
                    }
                    if (_loc_14.gnormx * dirx + _loc_14.gnormy * diry < 0)
                    {
                        _loc_15 = 0;
                        _loc_16 = 0;
                        _loc_15 = _loc_13.x - _loc_11.x;
                        _loc_16 = _loc_13.y - _loc_11.y;
                        _loc_17 = 0;
                        _loc_18 = 0;
                        _loc_17 = _loc_11.x - originx;
                        _loc_18 = _loc_11.y - originy;
                        _loc_19 = _loc_16 * dirx - _loc_15 * diry;
                        if (_loc_19 * _loc_19 > Config.epsilon)
                        {
                            _loc_19 = 1 / _loc_19;
                            _loc_20 = (_loc_16 * _loc_17 - _loc_15 * _loc_18) * _loc_19;
                            if (_loc_20 > 0)
                            {
                            }
                            if (_loc_20 <= maxdist)
                            {
                                if (_loc_20 >= _loc_4)
                                {
                                }
                            }
                            if (_loc_20 > _loc_5)
                            {
                                _loc_21 = (diry * _loc_17 - dirx * _loc_18) * _loc_19;
                                if (_loc_21 > -Config.epsilon)
                                {
                                }
                                if (_loc_21 < 1 + Config.epsilon)
                                {
                                    if (_loc_20 < _loc_4)
                                    {
                                        _loc_4 = _loc_20;
                                        _loc_6 = _loc_8.elt;
                                    }
                                    if (_loc_20 > _loc_5)
                                    {
                                        _loc_5 = _loc_20;
                                        _loc_7 = _loc_8.elt;
                                    }
                                }
                            }
                        }
                    }
                    _loc_8 = _loc_8.next;
                }while (false)
            }
            if (_loc_6 != null)
            {
                _loc_15 = 0;
                _loc_16 = 0;
                _loc_15 = _loc_6.gnormx;
                _loc_16 = _loc_6.gnormy;
                _loc_9 = _loc_15 * dirx + _loc_16 * diry > 0;
                if (_loc_9)
                {
                    _loc_15 = -_loc_15;
                    _loc_16 = -_loc_16;
                }
                _loc_23 = false;
                if (_loc_15 == _loc_15)
                {
                }
                if (_loc_16 != _loc_16)
                {
                    throw "Error: Vec2 components cannot be NaN";
                }
                if (ZPP_PubPool.poolVec2 == null)
                {
                    _loc_24 = new Vec2();
                }
                else
                {
                    _loc_24 = ZPP_PubPool.poolVec2;
                    ZPP_PubPool.poolVec2 = _loc_24.zpp_pool;
                    _loc_24.zpp_pool = null;
                    _loc_24.zpp_disp = false;
                    if (_loc_24 == ZPP_PubPool.nextVec2)
                    {
                        ZPP_PubPool.nextVec2 = null;
                    }
                }
                if (_loc_24.zpp_inner == null)
                {
                    _loc_25 = false;
                    if (ZPP_Vec2.zpp_pool == null)
                    {
                        _loc_10 = new ZPP_Vec2();
                    }
                    else
                    {
                        _loc_10 = ZPP_Vec2.zpp_pool;
                        ZPP_Vec2.zpp_pool = _loc_10.next;
                        _loc_10.next = null;
                    }
                    _loc_10.weak = false;
                    _loc_10._immutable = _loc_25;
                    _loc_10.x = _loc_15;
                    _loc_10.y = _loc_16;
                    _loc_24.zpp_inner = _loc_10;
                    _loc_24.zpp_inner.outer = _loc_24;
                }
                else
                {
                    if (_loc_24 != null)
                    {
                    }
                    if (_loc_24.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_10 = _loc_24.zpp_inner;
                    if (_loc_10._immutable)
                    {
                        throw "Error: Vec2 is immutable";
                    }
                    if (_loc_10._isimmutable != null)
                    {
                        _loc_10._isimmutable();
                    }
                    if (_loc_15 == _loc_15)
                    {
                    }
                    if (_loc_16 != _loc_16)
                    {
                        throw "Error: Vec2 components cannot be NaN";
                    }
                    if (_loc_24 != null)
                    {
                    }
                    if (_loc_24.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_10 = _loc_24.zpp_inner;
                    if (_loc_10._validate != null)
                    {
                        _loc_10._validate();
                    }
                    if (_loc_24.zpp_inner.x == _loc_15)
                    {
                        if (_loc_24 != null)
                        {
                        }
                        if (_loc_24.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_10 = _loc_24.zpp_inner;
                        if (_loc_10._validate != null)
                        {
                            _loc_10._validate();
                        }
                    }
                    if (_loc_24.zpp_inner.y != _loc_16)
                    {
                        _loc_24.zpp_inner.x = _loc_15;
                        _loc_24.zpp_inner.y = _loc_16;
                        _loc_10 = _loc_24.zpp_inner;
                        if (_loc_10._invalidate != null)
                        {
                            _loc_10._invalidate(_loc_10);
                        }
                    }
                }
                _loc_24.zpp_inner.weak = _loc_23;
                _loc_22 = ZPP_ConvexRayResult.getRay(_loc_24, _loc_4, _loc_9, param1.outer);
                _loc_26 = null;
                _loc_27 = param3.zpp_inner.inner.head;
                while (_loc_27 != null)
                {
                    
                    _loc_28 = _loc_27.elt;
                    if (_loc_22.zpp_inner.next != null)
                    {
                        throw "Error: This object has been disposed of and cannot be used";
                    }
                    if (_loc_28.zpp_inner.next != null)
                    {
                        throw "Error: This object has been disposed of and cannot be used";
                    }
                    if (_loc_22.zpp_inner.toiDistance < _loc_28.zpp_inner.toiDistance)
                    {
                        break;
                    }
                    _loc_26 = _loc_27;
                    _loc_27 = _loc_27.next;
                }
                _loc_29 = param3.zpp_inner.inner;
                if (ZNPNode_RayResult.zpp_pool == null)
                {
                    _loc_30 = new ZNPNode_RayResult();
                }
                else
                {
                    _loc_30 = ZNPNode_RayResult.zpp_pool;
                    ZNPNode_RayResult.zpp_pool = _loc_30.next;
                    _loc_30.next = null;
                }
                _loc_30.elt = _loc_22;
                _loc_27 = _loc_30;
                if (_loc_26 == null)
                {
                    _loc_27.next = _loc_29.head;
                    _loc_29.head = _loc_27;
                }
                else
                {
                    _loc_27.next = _loc_26.next;
                    _loc_26.next = _loc_27;
                }
                _loc_23 = true;
                _loc_29.modified = _loc_23;
                _loc_29.pushmod = _loc_23;
                (_loc_29.length + 1);
            }
            if (_loc_7 != null)
            {
            }
            if (_loc_6 != _loc_7)
            {
                _loc_15 = 0;
                _loc_16 = 0;
                _loc_15 = _loc_7.gnormx;
                _loc_16 = _loc_7.gnormy;
                _loc_9 = _loc_15 * dirx + _loc_16 * diry > 0;
                if (_loc_9)
                {
                    _loc_15 = -_loc_15;
                    _loc_16 = -_loc_16;
                }
                _loc_23 = false;
                if (_loc_15 == _loc_15)
                {
                }
                if (_loc_16 != _loc_16)
                {
                    throw "Error: Vec2 components cannot be NaN";
                }
                if (ZPP_PubPool.poolVec2 == null)
                {
                    _loc_24 = new Vec2();
                }
                else
                {
                    _loc_24 = ZPP_PubPool.poolVec2;
                    ZPP_PubPool.poolVec2 = _loc_24.zpp_pool;
                    _loc_24.zpp_pool = null;
                    _loc_24.zpp_disp = false;
                    if (_loc_24 == ZPP_PubPool.nextVec2)
                    {
                        ZPP_PubPool.nextVec2 = null;
                    }
                }
                if (_loc_24.zpp_inner == null)
                {
                    _loc_25 = false;
                    if (ZPP_Vec2.zpp_pool == null)
                    {
                        _loc_10 = new ZPP_Vec2();
                    }
                    else
                    {
                        _loc_10 = ZPP_Vec2.zpp_pool;
                        ZPP_Vec2.zpp_pool = _loc_10.next;
                        _loc_10.next = null;
                    }
                    _loc_10.weak = false;
                    _loc_10._immutable = _loc_25;
                    _loc_10.x = _loc_15;
                    _loc_10.y = _loc_16;
                    _loc_24.zpp_inner = _loc_10;
                    _loc_24.zpp_inner.outer = _loc_24;
                }
                else
                {
                    if (_loc_24 != null)
                    {
                    }
                    if (_loc_24.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_10 = _loc_24.zpp_inner;
                    if (_loc_10._immutable)
                    {
                        throw "Error: Vec2 is immutable";
                    }
                    if (_loc_10._isimmutable != null)
                    {
                        _loc_10._isimmutable();
                    }
                    if (_loc_15 == _loc_15)
                    {
                    }
                    if (_loc_16 != _loc_16)
                    {
                        throw "Error: Vec2 components cannot be NaN";
                    }
                    if (_loc_24 != null)
                    {
                    }
                    if (_loc_24.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_10 = _loc_24.zpp_inner;
                    if (_loc_10._validate != null)
                    {
                        _loc_10._validate();
                    }
                    if (_loc_24.zpp_inner.x == _loc_15)
                    {
                        if (_loc_24 != null)
                        {
                        }
                        if (_loc_24.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_10 = _loc_24.zpp_inner;
                        if (_loc_10._validate != null)
                        {
                            _loc_10._validate();
                        }
                    }
                    if (_loc_24.zpp_inner.y != _loc_16)
                    {
                        _loc_24.zpp_inner.x = _loc_15;
                        _loc_24.zpp_inner.y = _loc_16;
                        _loc_10 = _loc_24.zpp_inner;
                        if (_loc_10._invalidate != null)
                        {
                            _loc_10._invalidate(_loc_10);
                        }
                    }
                }
                _loc_24.zpp_inner.weak = _loc_23;
                _loc_22 = ZPP_ConvexRayResult.getRay(_loc_24, _loc_5, _loc_9, param1.outer);
                _loc_26 = null;
                _loc_27 = param3.zpp_inner.inner.head;
                while (_loc_27 != null)
                {
                    
                    _loc_28 = _loc_27.elt;
                    if (_loc_22.zpp_inner.next != null)
                    {
                        throw "Error: This object has been disposed of and cannot be used";
                    }
                    if (_loc_28.zpp_inner.next != null)
                    {
                        throw "Error: This object has been disposed of and cannot be used";
                    }
                    if (_loc_22.zpp_inner.toiDistance < _loc_28.zpp_inner.toiDistance)
                    {
                        break;
                    }
                    _loc_26 = _loc_27;
                    _loc_27 = _loc_27.next;
                }
                _loc_29 = param3.zpp_inner.inner;
                if (ZNPNode_RayResult.zpp_pool == null)
                {
                    _loc_30 = new ZNPNode_RayResult();
                }
                else
                {
                    _loc_30 = ZNPNode_RayResult.zpp_pool;
                    ZNPNode_RayResult.zpp_pool = _loc_30.next;
                    _loc_30.next = null;
                }
                _loc_30.elt = _loc_22;
                _loc_27 = _loc_30;
                if (_loc_26 == null)
                {
                    _loc_27.next = _loc_29.head;
                    _loc_29.head = _loc_27;
                }
                else
                {
                    _loc_27.next = _loc_26.next;
                    _loc_26.next = _loc_27;
                }
                _loc_23 = true;
                _loc_29.modified = _loc_23;
                _loc_29.pushmod = _loc_23;
                (_loc_29.length + 1);
            }
            return;
        }// end function

        public function polysect(param1:ZPP_Polygon, param2:Boolean, param3:Number) : RayResult
        {
            var _loc_7:* = false;
            var _loc_8:* = null as ZPP_Vec2;
            var _loc_11:* = null as ZPP_Vec2;
            var _loc_12:* = null as ZPP_Edge;
            var _loc_13:* = NaN;
            var _loc_14:* = NaN;
            var _loc_15:* = NaN;
            var _loc_16:* = NaN;
            var _loc_17:* = NaN;
            var _loc_18:* = NaN;
            var _loc_19:* = NaN;
            var _loc_20:* = false;
            var _loc_21:* = null as Vec2;
            var _loc_22:* = false;
            var _loc_4:* = param3;
            var _loc_5:* = null;
            var _loc_6:* = param1.edges.head;
            _loc_7 = true;
            _loc_8 = param1.gverts.next;
            var _loc_9:* = _loc_8;
            var _loc_10:* = _loc_8.next;
            while (_loc_10 != null)
            {
                
                _loc_11 = _loc_10;
                _loc_12 = _loc_6.elt;
                if (!param2)
                {
                }
                if (_loc_12.gnormx * dirx + _loc_12.gnormy * diry < 0)
                {
                    _loc_13 = 0;
                    _loc_14 = 0;
                    _loc_13 = _loc_11.x - _loc_9.x;
                    _loc_14 = _loc_11.y - _loc_9.y;
                    _loc_15 = 0;
                    _loc_16 = 0;
                    _loc_15 = _loc_9.x - originx;
                    _loc_16 = _loc_9.y - originy;
                    _loc_17 = _loc_14 * dirx - _loc_13 * diry;
                    if (_loc_17 * _loc_17 > Config.epsilon)
                    {
                        _loc_17 = 1 / _loc_17;
                        _loc_18 = (_loc_14 * _loc_15 - _loc_13 * _loc_16) * _loc_17;
                        if (_loc_18 > 0)
                        {
                        }
                        if (_loc_18 < _loc_4)
                        {
                        }
                        if (_loc_18 <= maxdist)
                        {
                            _loc_19 = (diry * _loc_15 - dirx * _loc_16) * _loc_17;
                            if (_loc_19 > -Config.epsilon)
                            {
                            }
                            if (_loc_19 < 1 + Config.epsilon)
                            {
                                _loc_4 = _loc_18;
                                _loc_5 = _loc_6.elt;
                            }
                        }
                    }
                }
                _loc_6 = _loc_6.next;
                _loc_8 = _loc_10;
                _loc_9 = _loc_11;
                _loc_10 = _loc_10.next;
            }
            if (_loc_7)
            {
                do
                {
                    
                    _loc_10 = param1.gverts.next;
                    _loc_11 = _loc_10;
                    _loc_12 = _loc_6.elt;
                    if (!param2)
                    {
                    }
                    if (_loc_12.gnormx * dirx + _loc_12.gnormy * diry < 0)
                    {
                        _loc_13 = 0;
                        _loc_14 = 0;
                        _loc_13 = _loc_11.x - _loc_9.x;
                        _loc_14 = _loc_11.y - _loc_9.y;
                        _loc_15 = 0;
                        _loc_16 = 0;
                        _loc_15 = _loc_9.x - originx;
                        _loc_16 = _loc_9.y - originy;
                        _loc_17 = _loc_14 * dirx - _loc_13 * diry;
                        if (_loc_17 * _loc_17 > Config.epsilon)
                        {
                            _loc_17 = 1 / _loc_17;
                            _loc_18 = (_loc_14 * _loc_15 - _loc_13 * _loc_16) * _loc_17;
                            if (_loc_18 > 0)
                            {
                            }
                            if (_loc_18 < _loc_4)
                            {
                            }
                            if (_loc_18 <= maxdist)
                            {
                                _loc_19 = (diry * _loc_15 - dirx * _loc_16) * _loc_17;
                                if (_loc_19 > -Config.epsilon)
                                {
                                }
                                if (_loc_19 < 1 + Config.epsilon)
                                {
                                    _loc_4 = _loc_18;
                                    _loc_5 = _loc_6.elt;
                                }
                            }
                        }
                    }
                    _loc_6 = _loc_6.next;
                }while (false)
            }
            if (_loc_5 != null)
            {
                _loc_13 = 0;
                _loc_14 = 0;
                _loc_13 = _loc_5.gnormx;
                _loc_14 = _loc_5.gnormy;
                _loc_7 = _loc_13 * dirx + _loc_14 * diry > 0;
                if (_loc_7)
                {
                    _loc_13 = -_loc_13;
                    _loc_14 = -_loc_14;
                }
                _loc_20 = false;
                if (_loc_13 == _loc_13)
                {
                }
                if (_loc_14 != _loc_14)
                {
                    throw "Error: Vec2 components cannot be NaN";
                }
                if (ZPP_PubPool.poolVec2 == null)
                {
                    _loc_21 = new Vec2();
                }
                else
                {
                    _loc_21 = ZPP_PubPool.poolVec2;
                    ZPP_PubPool.poolVec2 = _loc_21.zpp_pool;
                    _loc_21.zpp_pool = null;
                    _loc_21.zpp_disp = false;
                    if (_loc_21 == ZPP_PubPool.nextVec2)
                    {
                        ZPP_PubPool.nextVec2 = null;
                    }
                }
                if (_loc_21.zpp_inner == null)
                {
                    _loc_22 = false;
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
                    _loc_8._immutable = _loc_22;
                    _loc_8.x = _loc_13;
                    _loc_8.y = _loc_14;
                    _loc_21.zpp_inner = _loc_8;
                    _loc_21.zpp_inner.outer = _loc_21;
                }
                else
                {
                    if (_loc_21 != null)
                    {
                    }
                    if (_loc_21.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_8 = _loc_21.zpp_inner;
                    if (_loc_8._immutable)
                    {
                        throw "Error: Vec2 is immutable";
                    }
                    if (_loc_8._isimmutable != null)
                    {
                        _loc_8._isimmutable();
                    }
                    if (_loc_13 == _loc_13)
                    {
                    }
                    if (_loc_14 != _loc_14)
                    {
                        throw "Error: Vec2 components cannot be NaN";
                    }
                    if (_loc_21 != null)
                    {
                    }
                    if (_loc_21.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_8 = _loc_21.zpp_inner;
                    if (_loc_8._validate != null)
                    {
                        _loc_8._validate();
                    }
                    if (_loc_21.zpp_inner.x == _loc_13)
                    {
                        if (_loc_21 != null)
                        {
                        }
                        if (_loc_21.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_8 = _loc_21.zpp_inner;
                        if (_loc_8._validate != null)
                        {
                            _loc_8._validate();
                        }
                    }
                    if (_loc_21.zpp_inner.y != _loc_14)
                    {
                        _loc_21.zpp_inner.x = _loc_13;
                        _loc_21.zpp_inner.y = _loc_14;
                        _loc_8 = _loc_21.zpp_inner;
                        if (_loc_8._invalidate != null)
                        {
                            _loc_8._invalidate(_loc_8);
                        }
                    }
                }
                _loc_21.zpp_inner.weak = _loc_20;
                return ZPP_ConvexRayResult.getRay(_loc_21, _loc_4, _loc_7, param1.outer);
            }
            else
            {
                return null;
            }
        }// end function

        public function origin_invalidate(param1:ZPP_Vec2) : void
        {
            originx = param1.x;
            originy = param1.y;
            return;
        }// end function

        public function invalidate_dir() : void
        {
            zip_dir = true;
            return;
        }// end function

        public function direction_invalidate(param1:ZPP_Vec2) : void
        {
            dirx = param1.x;
            diry = param1.y;
            zip_dir = true;
            return;
        }// end function

        public function circlesect2(param1:ZPP_Circle, param2:Boolean, param3:RayResultList) : void
        {
            var _loc_4:* = null as ZPP_Polygon;
            var _loc_5:* = NaN;
            var _loc_6:* = null as ZPP_Vec2;
            var _loc_7:* = null as ZPP_Vec2;
            var _loc_8:* = null as ZPP_Vec2;
            var _loc_9:* = null as ZPP_Vec2;
            var _loc_10:* = NaN;
            var _loc_11:* = null as ZPP_Vec2;
            var _loc_12:* = null as ZPP_Body;
            var _loc_17:* = NaN;
            var _loc_18:* = NaN;
            var _loc_19:* = NaN;
            var _loc_20:* = NaN;
            var _loc_21:* = NaN;
            var _loc_22:* = NaN;
            var _loc_23:* = null as RayResult;
            var _loc_24:* = false;
            var _loc_25:* = null as Vec2;
            var _loc_26:* = false;
            var _loc_27:* = null as ZNPNode_RayResult;
            var _loc_28:* = null as ZNPNode_RayResult;
            var _loc_29:* = null as RayResult;
            var _loc_30:* = null as ZNPList_RayResult;
            var _loc_31:* = null as ZNPNode_RayResult;
            var _loc_32:* = NaN;
            if (param1.zip_worldCOM)
            {
                if (param1.body != null)
                {
                    param1.zip_worldCOM = false;
                    if (param1.zip_localCOM)
                    {
                        param1.zip_localCOM = false;
                        if (param1.type == ZPP_Flags.id_ShapeType_POLYGON)
                        {
                            _loc_4 = param1.polygon;
                            if (_loc_4.lverts.next == null)
                            {
                                throw "Error: An empty polygon has no meaningful localCOM";
                            }
                            if (_loc_4.lverts.next.next == null)
                            {
                                _loc_4.localCOMx = _loc_4.lverts.next.x;
                                _loc_4.localCOMy = _loc_4.lverts.next.y;
                            }
                            else if (_loc_4.lverts.next.next.next == null)
                            {
                                _loc_4.localCOMx = _loc_4.lverts.next.x;
                                _loc_4.localCOMy = _loc_4.lverts.next.y;
                                _loc_5 = 1;
                                _loc_4.localCOMx = _loc_4.localCOMx + _loc_4.lverts.next.next.x * _loc_5;
                                _loc_4.localCOMy = _loc_4.localCOMy + _loc_4.lverts.next.next.y * _loc_5;
                                _loc_5 = 0.5;
                                _loc_4.localCOMx = _loc_4.localCOMx * _loc_5;
                                _loc_4.localCOMy = _loc_4.localCOMy * _loc_5;
                            }
                            else
                            {
                                _loc_4.localCOMx = 0;
                                _loc_4.localCOMy = 0;
                                _loc_5 = 0;
                                _loc_6 = _loc_4.lverts.next;
                                _loc_7 = _loc_6;
                                _loc_6 = _loc_6.next;
                                _loc_8 = _loc_6;
                                _loc_6 = _loc_6.next;
                                while (_loc_6 != null)
                                {
                                    
                                    _loc_9 = _loc_6;
                                    _loc_5 = _loc_5 + _loc_8.x * (_loc_9.y - _loc_7.y);
                                    _loc_10 = _loc_9.y * _loc_8.x - _loc_9.x * _loc_8.y;
                                    _loc_4.localCOMx = _loc_4.localCOMx + (_loc_8.x + _loc_9.x) * _loc_10;
                                    _loc_4.localCOMy = _loc_4.localCOMy + (_loc_8.y + _loc_9.y) * _loc_10;
                                    _loc_7 = _loc_8;
                                    _loc_8 = _loc_9;
                                    _loc_6 = _loc_6.next;
                                }
                                _loc_6 = _loc_4.lverts.next;
                                _loc_9 = _loc_6;
                                _loc_5 = _loc_5 + _loc_8.x * (_loc_9.y - _loc_7.y);
                                _loc_10 = _loc_9.y * _loc_8.x - _loc_9.x * _loc_8.y;
                                _loc_4.localCOMx = _loc_4.localCOMx + (_loc_8.x + _loc_9.x) * _loc_10;
                                _loc_4.localCOMy = _loc_4.localCOMy + (_loc_8.y + _loc_9.y) * _loc_10;
                                _loc_7 = _loc_8;
                                _loc_8 = _loc_9;
                                _loc_6 = _loc_6.next;
                                _loc_11 = _loc_6;
                                _loc_5 = _loc_5 + _loc_8.x * (_loc_11.y - _loc_7.y);
                                _loc_10 = _loc_11.y * _loc_8.x - _loc_11.x * _loc_8.y;
                                _loc_4.localCOMx = _loc_4.localCOMx + (_loc_8.x + _loc_11.x) * _loc_10;
                                _loc_4.localCOMy = _loc_4.localCOMy + (_loc_8.y + _loc_11.y) * _loc_10;
                                _loc_5 = 1 / (3 * _loc_5);
                                _loc_10 = _loc_5;
                                _loc_4.localCOMx = _loc_4.localCOMx * _loc_10;
                                _loc_4.localCOMy = _loc_4.localCOMy * _loc_10;
                            }
                        }
                        if (param1.wrap_localCOM != null)
                        {
                            param1.wrap_localCOM.zpp_inner.x = param1.localCOMx;
                            param1.wrap_localCOM.zpp_inner.y = param1.localCOMy;
                        }
                    }
                    _loc_12 = param1.body;
                    if (_loc_12.zip_axis)
                    {
                        _loc_12.zip_axis = false;
                        _loc_12.axisx = Math.sin(_loc_12.rot);
                        _loc_12.axisy = Math.cos(_loc_12.rot);
                    }
                    param1.worldCOMx = param1.body.posx + (param1.body.axisy * param1.localCOMx - param1.body.axisx * param1.localCOMy);
                    param1.worldCOMy = param1.body.posy + (param1.localCOMx * param1.body.axisx + param1.localCOMy * param1.body.axisy);
                }
            }
            _loc_5 = 0;
            _loc_10 = 0;
            _loc_5 = originx - param1.worldCOMx;
            _loc_10 = originy - param1.worldCOMy;
            var _loc_13:* = dirx * dirx + diry * diry;
            var _loc_14:* = 2 * (_loc_5 * dirx + _loc_10 * diry);
            var _loc_15:* = _loc_5 * _loc_5 + _loc_10 * _loc_10 - param1.radius * param1.radius;
            var _loc_16:* = _loc_14 * _loc_14 - 4 * _loc_13 * _loc_15;
            if (_loc_16 == 0)
            {
                _loc_17 = (-_loc_14) / 2 * _loc_13;
                if (param2)
                {
                }
                if (_loc_15 > 0)
                {
                }
                if (_loc_17 > 0)
                {
                }
                if (_loc_17 <= maxdist)
                {
                    _loc_18 = 0;
                    _loc_19 = 0;
                    _loc_18 = originx;
                    _loc_19 = originy;
                    _loc_20 = _loc_17;
                    _loc_18 = _loc_18 + dirx * _loc_20;
                    _loc_19 = _loc_19 + diry * _loc_20;
                    _loc_20 = 1;
                    _loc_18 = _loc_18 - param1.worldCOMx * _loc_20;
                    _loc_19 = _loc_19 - param1.worldCOMy * _loc_20;
                    _loc_20 = _loc_18 * _loc_18 + _loc_19 * _loc_19;
                    _loc_21 = 1 / Math.sqrt(_loc_20);
                    _loc_22 = _loc_21;
                    _loc_18 = _loc_18 * _loc_22;
                    _loc_19 = _loc_19 * _loc_22;
                    if (_loc_15 <= 0)
                    {
                        _loc_18 = -_loc_18;
                        _loc_19 = -_loc_19;
                    }
                    _loc_24 = false;
                    if (_loc_18 == _loc_18)
                    {
                    }
                    if (_loc_19 != _loc_19)
                    {
                        throw "Error: Vec2 components cannot be NaN";
                    }
                    if (ZPP_PubPool.poolVec2 == null)
                    {
                        _loc_25 = new Vec2();
                    }
                    else
                    {
                        _loc_25 = ZPP_PubPool.poolVec2;
                        ZPP_PubPool.poolVec2 = _loc_25.zpp_pool;
                        _loc_25.zpp_pool = null;
                        _loc_25.zpp_disp = false;
                        if (_loc_25 == ZPP_PubPool.nextVec2)
                        {
                            ZPP_PubPool.nextVec2 = null;
                        }
                    }
                    if (_loc_25.zpp_inner == null)
                    {
                        _loc_26 = false;
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
                        _loc_6._immutable = _loc_26;
                        _loc_6.x = _loc_18;
                        _loc_6.y = _loc_19;
                        _loc_25.zpp_inner = _loc_6;
                        _loc_25.zpp_inner.outer = _loc_25;
                    }
                    else
                    {
                        if (_loc_25 != null)
                        {
                        }
                        if (_loc_25.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_6 = _loc_25.zpp_inner;
                        if (_loc_6._immutable)
                        {
                            throw "Error: Vec2 is immutable";
                        }
                        if (_loc_6._isimmutable != null)
                        {
                            _loc_6._isimmutable();
                        }
                        if (_loc_18 == _loc_18)
                        {
                        }
                        if (_loc_19 != _loc_19)
                        {
                            throw "Error: Vec2 components cannot be NaN";
                        }
                        if (_loc_25 != null)
                        {
                        }
                        if (_loc_25.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_6 = _loc_25.zpp_inner;
                        if (_loc_6._validate != null)
                        {
                            _loc_6._validate();
                        }
                        if (_loc_25.zpp_inner.x == _loc_18)
                        {
                            if (_loc_25 != null)
                            {
                            }
                            if (_loc_25.zpp_disp)
                            {
                                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                            }
                            _loc_6 = _loc_25.zpp_inner;
                            if (_loc_6._validate != null)
                            {
                                _loc_6._validate();
                            }
                        }
                        if (_loc_25.zpp_inner.y != _loc_19)
                        {
                            _loc_25.zpp_inner.x = _loc_18;
                            _loc_25.zpp_inner.y = _loc_19;
                            _loc_6 = _loc_25.zpp_inner;
                            if (_loc_6._invalidate != null)
                            {
                                _loc_6._invalidate(_loc_6);
                            }
                        }
                    }
                    _loc_25.zpp_inner.weak = _loc_24;
                    _loc_23 = ZPP_ConvexRayResult.getRay(_loc_25, _loc_17, _loc_15 <= 0, param1.outer);
                    _loc_27 = null;
                    _loc_28 = param3.zpp_inner.inner.head;
                    while (_loc_28 != null)
                    {
                        
                        _loc_29 = _loc_28.elt;
                        if (_loc_23.zpp_inner.next != null)
                        {
                            throw "Error: This object has been disposed of and cannot be used";
                        }
                        if (_loc_29.zpp_inner.next != null)
                        {
                            throw "Error: This object has been disposed of and cannot be used";
                        }
                        if (_loc_23.zpp_inner.toiDistance < _loc_29.zpp_inner.toiDistance)
                        {
                            break;
                        }
                        _loc_27 = _loc_28;
                        _loc_28 = _loc_28.next;
                    }
                    _loc_30 = param3.zpp_inner.inner;
                    if (ZNPNode_RayResult.zpp_pool == null)
                    {
                        _loc_31 = new ZNPNode_RayResult();
                    }
                    else
                    {
                        _loc_31 = ZNPNode_RayResult.zpp_pool;
                        ZNPNode_RayResult.zpp_pool = _loc_31.next;
                        _loc_31.next = null;
                    }
                    _loc_31.elt = _loc_23;
                    _loc_28 = _loc_31;
                    if (_loc_27 == null)
                    {
                        _loc_28.next = _loc_30.head;
                        _loc_30.head = _loc_28;
                    }
                    else
                    {
                        _loc_28.next = _loc_27.next;
                        _loc_27.next = _loc_28;
                    }
                    _loc_24 = true;
                    _loc_30.modified = _loc_24;
                    _loc_30.pushmod = _loc_24;
                    (_loc_30.length + 1);
                }
            }
            else
            {
                _loc_16 = Math.sqrt(_loc_16);
                _loc_13 = 1 / (2 * _loc_13);
                _loc_17 = (-_loc_14 - _loc_16) * _loc_13;
                _loc_18 = (-_loc_14 + _loc_16) * _loc_13;
                if (_loc_17 > 0)
                {
                }
                if (_loc_17 <= maxdist)
                {
                    _loc_19 = 0;
                    _loc_20 = 0;
                    _loc_19 = originx;
                    _loc_20 = originy;
                    _loc_21 = _loc_17;
                    _loc_19 = _loc_19 + dirx * _loc_21;
                    _loc_20 = _loc_20 + diry * _loc_21;
                    _loc_21 = 1;
                    _loc_19 = _loc_19 - param1.worldCOMx * _loc_21;
                    _loc_20 = _loc_20 - param1.worldCOMy * _loc_21;
                    _loc_21 = _loc_19 * _loc_19 + _loc_20 * _loc_20;
                    _loc_22 = 1 / Math.sqrt(_loc_21);
                    _loc_32 = _loc_22;
                    _loc_19 = _loc_19 * _loc_32;
                    _loc_20 = _loc_20 * _loc_32;
                    _loc_24 = false;
                    if (_loc_19 == _loc_19)
                    {
                    }
                    if (_loc_20 != _loc_20)
                    {
                        throw "Error: Vec2 components cannot be NaN";
                    }
                    if (ZPP_PubPool.poolVec2 == null)
                    {
                        _loc_25 = new Vec2();
                    }
                    else
                    {
                        _loc_25 = ZPP_PubPool.poolVec2;
                        ZPP_PubPool.poolVec2 = _loc_25.zpp_pool;
                        _loc_25.zpp_pool = null;
                        _loc_25.zpp_disp = false;
                        if (_loc_25 == ZPP_PubPool.nextVec2)
                        {
                            ZPP_PubPool.nextVec2 = null;
                        }
                    }
                    if (_loc_25.zpp_inner == null)
                    {
                        _loc_26 = false;
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
                        _loc_6._immutable = _loc_26;
                        _loc_6.x = _loc_19;
                        _loc_6.y = _loc_20;
                        _loc_25.zpp_inner = _loc_6;
                        _loc_25.zpp_inner.outer = _loc_25;
                    }
                    else
                    {
                        if (_loc_25 != null)
                        {
                        }
                        if (_loc_25.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_6 = _loc_25.zpp_inner;
                        if (_loc_6._immutable)
                        {
                            throw "Error: Vec2 is immutable";
                        }
                        if (_loc_6._isimmutable != null)
                        {
                            _loc_6._isimmutable();
                        }
                        if (_loc_19 == _loc_19)
                        {
                        }
                        if (_loc_20 != _loc_20)
                        {
                            throw "Error: Vec2 components cannot be NaN";
                        }
                        if (_loc_25 != null)
                        {
                        }
                        if (_loc_25.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_6 = _loc_25.zpp_inner;
                        if (_loc_6._validate != null)
                        {
                            _loc_6._validate();
                        }
                        if (_loc_25.zpp_inner.x == _loc_19)
                        {
                            if (_loc_25 != null)
                            {
                            }
                            if (_loc_25.zpp_disp)
                            {
                                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                            }
                            _loc_6 = _loc_25.zpp_inner;
                            if (_loc_6._validate != null)
                            {
                                _loc_6._validate();
                            }
                        }
                        if (_loc_25.zpp_inner.y != _loc_20)
                        {
                            _loc_25.zpp_inner.x = _loc_19;
                            _loc_25.zpp_inner.y = _loc_20;
                            _loc_6 = _loc_25.zpp_inner;
                            if (_loc_6._invalidate != null)
                            {
                                _loc_6._invalidate(_loc_6);
                            }
                        }
                    }
                    _loc_25.zpp_inner.weak = _loc_24;
                    _loc_23 = ZPP_ConvexRayResult.getRay(_loc_25, _loc_17, false, param1.outer);
                    _loc_27 = null;
                    _loc_28 = param3.zpp_inner.inner.head;
                    while (_loc_28 != null)
                    {
                        
                        _loc_29 = _loc_28.elt;
                        if (_loc_23.zpp_inner.next != null)
                        {
                            throw "Error: This object has been disposed of and cannot be used";
                        }
                        if (_loc_29.zpp_inner.next != null)
                        {
                            throw "Error: This object has been disposed of and cannot be used";
                        }
                        if (_loc_23.zpp_inner.toiDistance < _loc_29.zpp_inner.toiDistance)
                        {
                            break;
                        }
                        _loc_27 = _loc_28;
                        _loc_28 = _loc_28.next;
                    }
                    _loc_30 = param3.zpp_inner.inner;
                    if (ZNPNode_RayResult.zpp_pool == null)
                    {
                        _loc_31 = new ZNPNode_RayResult();
                    }
                    else
                    {
                        _loc_31 = ZNPNode_RayResult.zpp_pool;
                        ZNPNode_RayResult.zpp_pool = _loc_31.next;
                        _loc_31.next = null;
                    }
                    _loc_31.elt = _loc_23;
                    _loc_28 = _loc_31;
                    if (_loc_27 == null)
                    {
                        _loc_28.next = _loc_30.head;
                        _loc_30.head = _loc_28;
                    }
                    else
                    {
                        _loc_28.next = _loc_27.next;
                        _loc_27.next = _loc_28;
                    }
                    _loc_24 = true;
                    _loc_30.modified = _loc_24;
                    _loc_30.pushmod = _loc_24;
                    (_loc_30.length + 1);
                }
                if (_loc_18 > 0)
                {
                }
                if (_loc_18 <= maxdist)
                {
                }
                if (param2)
                {
                    _loc_19 = 0;
                    _loc_20 = 0;
                    _loc_19 = originx;
                    _loc_20 = originy;
                    _loc_21 = _loc_18;
                    _loc_19 = _loc_19 + dirx * _loc_21;
                    _loc_20 = _loc_20 + diry * _loc_21;
                    _loc_21 = 1;
                    _loc_19 = _loc_19 - param1.worldCOMx * _loc_21;
                    _loc_20 = _loc_20 - param1.worldCOMy * _loc_21;
                    _loc_21 = _loc_19 * _loc_19 + _loc_20 * _loc_20;
                    _loc_22 = 1 / Math.sqrt(_loc_21);
                    _loc_32 = _loc_22;
                    _loc_19 = _loc_19 * _loc_32;
                    _loc_20 = _loc_20 * _loc_32;
                    _loc_19 = -_loc_19;
                    _loc_20 = -_loc_20;
                    _loc_24 = false;
                    if (_loc_19 == _loc_19)
                    {
                    }
                    if (_loc_20 != _loc_20)
                    {
                        throw "Error: Vec2 components cannot be NaN";
                    }
                    if (ZPP_PubPool.poolVec2 == null)
                    {
                        _loc_25 = new Vec2();
                    }
                    else
                    {
                        _loc_25 = ZPP_PubPool.poolVec2;
                        ZPP_PubPool.poolVec2 = _loc_25.zpp_pool;
                        _loc_25.zpp_pool = null;
                        _loc_25.zpp_disp = false;
                        if (_loc_25 == ZPP_PubPool.nextVec2)
                        {
                            ZPP_PubPool.nextVec2 = null;
                        }
                    }
                    if (_loc_25.zpp_inner == null)
                    {
                        _loc_26 = false;
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
                        _loc_6._immutable = _loc_26;
                        _loc_6.x = _loc_19;
                        _loc_6.y = _loc_20;
                        _loc_25.zpp_inner = _loc_6;
                        _loc_25.zpp_inner.outer = _loc_25;
                    }
                    else
                    {
                        if (_loc_25 != null)
                        {
                        }
                        if (_loc_25.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_6 = _loc_25.zpp_inner;
                        if (_loc_6._immutable)
                        {
                            throw "Error: Vec2 is immutable";
                        }
                        if (_loc_6._isimmutable != null)
                        {
                            _loc_6._isimmutable();
                        }
                        if (_loc_19 == _loc_19)
                        {
                        }
                        if (_loc_20 != _loc_20)
                        {
                            throw "Error: Vec2 components cannot be NaN";
                        }
                        if (_loc_25 != null)
                        {
                        }
                        if (_loc_25.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_6 = _loc_25.zpp_inner;
                        if (_loc_6._validate != null)
                        {
                            _loc_6._validate();
                        }
                        if (_loc_25.zpp_inner.x == _loc_19)
                        {
                            if (_loc_25 != null)
                            {
                            }
                            if (_loc_25.zpp_disp)
                            {
                                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                            }
                            _loc_6 = _loc_25.zpp_inner;
                            if (_loc_6._validate != null)
                            {
                                _loc_6._validate();
                            }
                        }
                        if (_loc_25.zpp_inner.y != _loc_20)
                        {
                            _loc_25.zpp_inner.x = _loc_19;
                            _loc_25.zpp_inner.y = _loc_20;
                            _loc_6 = _loc_25.zpp_inner;
                            if (_loc_6._invalidate != null)
                            {
                                _loc_6._invalidate(_loc_6);
                            }
                        }
                    }
                    _loc_25.zpp_inner.weak = _loc_24;
                    _loc_23 = ZPP_ConvexRayResult.getRay(_loc_25, _loc_18, true, param1.outer);
                    _loc_27 = null;
                    _loc_28 = param3.zpp_inner.inner.head;
                    while (_loc_28 != null)
                    {
                        
                        _loc_29 = _loc_28.elt;
                        if (_loc_23.zpp_inner.next != null)
                        {
                            throw "Error: This object has been disposed of and cannot be used";
                        }
                        if (_loc_29.zpp_inner.next != null)
                        {
                            throw "Error: This object has been disposed of and cannot be used";
                        }
                        if (_loc_23.zpp_inner.toiDistance < _loc_29.zpp_inner.toiDistance)
                        {
                            break;
                        }
                        _loc_27 = _loc_28;
                        _loc_28 = _loc_28.next;
                    }
                    _loc_30 = param3.zpp_inner.inner;
                    if (ZNPNode_RayResult.zpp_pool == null)
                    {
                        _loc_31 = new ZNPNode_RayResult();
                    }
                    else
                    {
                        _loc_31 = ZNPNode_RayResult.zpp_pool;
                        ZNPNode_RayResult.zpp_pool = _loc_31.next;
                        _loc_31.next = null;
                    }
                    _loc_31.elt = _loc_23;
                    _loc_28 = _loc_31;
                    if (_loc_27 == null)
                    {
                        _loc_28.next = _loc_30.head;
                        _loc_30.head = _loc_28;
                    }
                    else
                    {
                        _loc_28.next = _loc_27.next;
                        _loc_27.next = _loc_28;
                    }
                    _loc_24 = true;
                    _loc_30.modified = _loc_24;
                    _loc_30.pushmod = _loc_24;
                    (_loc_30.length + 1);
                }
            }
            return;
        }// end function

        public function circlesect(param1:ZPP_Circle, param2:Boolean, param3:Number) : RayResult
        {
            var _loc_4:* = null as ZPP_Polygon;
            var _loc_5:* = NaN;
            var _loc_6:* = null as ZPP_Vec2;
            var _loc_7:* = null as ZPP_Vec2;
            var _loc_8:* = null as ZPP_Vec2;
            var _loc_9:* = null as ZPP_Vec2;
            var _loc_10:* = NaN;
            var _loc_11:* = null as ZPP_Vec2;
            var _loc_12:* = null as ZPP_Body;
            var _loc_17:* = NaN;
            var _loc_18:* = NaN;
            var _loc_19:* = NaN;
            var _loc_20:* = NaN;
            var _loc_21:* = NaN;
            var _loc_22:* = NaN;
            var _loc_23:* = false;
            var _loc_24:* = null as Vec2;
            var _loc_25:* = false;
            var _loc_26:* = NaN;
            if (param1.zip_worldCOM)
            {
                if (param1.body != null)
                {
                    param1.zip_worldCOM = false;
                    if (param1.zip_localCOM)
                    {
                        param1.zip_localCOM = false;
                        if (param1.type == ZPP_Flags.id_ShapeType_POLYGON)
                        {
                            _loc_4 = param1.polygon;
                            if (_loc_4.lverts.next == null)
                            {
                                throw "Error: An empty polygon has no meaningful localCOM";
                            }
                            if (_loc_4.lverts.next.next == null)
                            {
                                _loc_4.localCOMx = _loc_4.lverts.next.x;
                                _loc_4.localCOMy = _loc_4.lverts.next.y;
                            }
                            else if (_loc_4.lverts.next.next.next == null)
                            {
                                _loc_4.localCOMx = _loc_4.lverts.next.x;
                                _loc_4.localCOMy = _loc_4.lverts.next.y;
                                _loc_5 = 1;
                                _loc_4.localCOMx = _loc_4.localCOMx + _loc_4.lverts.next.next.x * _loc_5;
                                _loc_4.localCOMy = _loc_4.localCOMy + _loc_4.lverts.next.next.y * _loc_5;
                                _loc_5 = 0.5;
                                _loc_4.localCOMx = _loc_4.localCOMx * _loc_5;
                                _loc_4.localCOMy = _loc_4.localCOMy * _loc_5;
                            }
                            else
                            {
                                _loc_4.localCOMx = 0;
                                _loc_4.localCOMy = 0;
                                _loc_5 = 0;
                                _loc_6 = _loc_4.lverts.next;
                                _loc_7 = _loc_6;
                                _loc_6 = _loc_6.next;
                                _loc_8 = _loc_6;
                                _loc_6 = _loc_6.next;
                                while (_loc_6 != null)
                                {
                                    
                                    _loc_9 = _loc_6;
                                    _loc_5 = _loc_5 + _loc_8.x * (_loc_9.y - _loc_7.y);
                                    _loc_10 = _loc_9.y * _loc_8.x - _loc_9.x * _loc_8.y;
                                    _loc_4.localCOMx = _loc_4.localCOMx + (_loc_8.x + _loc_9.x) * _loc_10;
                                    _loc_4.localCOMy = _loc_4.localCOMy + (_loc_8.y + _loc_9.y) * _loc_10;
                                    _loc_7 = _loc_8;
                                    _loc_8 = _loc_9;
                                    _loc_6 = _loc_6.next;
                                }
                                _loc_6 = _loc_4.lverts.next;
                                _loc_9 = _loc_6;
                                _loc_5 = _loc_5 + _loc_8.x * (_loc_9.y - _loc_7.y);
                                _loc_10 = _loc_9.y * _loc_8.x - _loc_9.x * _loc_8.y;
                                _loc_4.localCOMx = _loc_4.localCOMx + (_loc_8.x + _loc_9.x) * _loc_10;
                                _loc_4.localCOMy = _loc_4.localCOMy + (_loc_8.y + _loc_9.y) * _loc_10;
                                _loc_7 = _loc_8;
                                _loc_8 = _loc_9;
                                _loc_6 = _loc_6.next;
                                _loc_11 = _loc_6;
                                _loc_5 = _loc_5 + _loc_8.x * (_loc_11.y - _loc_7.y);
                                _loc_10 = _loc_11.y * _loc_8.x - _loc_11.x * _loc_8.y;
                                _loc_4.localCOMx = _loc_4.localCOMx + (_loc_8.x + _loc_11.x) * _loc_10;
                                _loc_4.localCOMy = _loc_4.localCOMy + (_loc_8.y + _loc_11.y) * _loc_10;
                                _loc_5 = 1 / (3 * _loc_5);
                                _loc_10 = _loc_5;
                                _loc_4.localCOMx = _loc_4.localCOMx * _loc_10;
                                _loc_4.localCOMy = _loc_4.localCOMy * _loc_10;
                            }
                        }
                        if (param1.wrap_localCOM != null)
                        {
                            param1.wrap_localCOM.zpp_inner.x = param1.localCOMx;
                            param1.wrap_localCOM.zpp_inner.y = param1.localCOMy;
                        }
                    }
                    _loc_12 = param1.body;
                    if (_loc_12.zip_axis)
                    {
                        _loc_12.zip_axis = false;
                        _loc_12.axisx = Math.sin(_loc_12.rot);
                        _loc_12.axisy = Math.cos(_loc_12.rot);
                    }
                    param1.worldCOMx = param1.body.posx + (param1.body.axisy * param1.localCOMx - param1.body.axisx * param1.localCOMy);
                    param1.worldCOMy = param1.body.posy + (param1.localCOMx * param1.body.axisx + param1.localCOMy * param1.body.axisy);
                }
            }
            _loc_5 = 0;
            _loc_10 = 0;
            _loc_5 = originx - param1.worldCOMx;
            _loc_10 = originy - param1.worldCOMy;
            var _loc_13:* = dirx * dirx + diry * diry;
            var _loc_14:* = 2 * (_loc_5 * dirx + _loc_10 * diry);
            var _loc_15:* = _loc_5 * _loc_5 + _loc_10 * _loc_10 - param1.radius * param1.radius;
            var _loc_16:* = _loc_14 * _loc_14 - 4 * _loc_13 * _loc_15;
            if (_loc_16 == 0)
            {
                _loc_17 = (-_loc_14) / 2 * _loc_13;
                if (param2)
                {
                }
                if (_loc_15 > 0)
                {
                }
                if (_loc_17 > 0)
                {
                }
                if (_loc_17 < param3)
                {
                }
                if (_loc_17 <= maxdist)
                {
                    _loc_18 = 0;
                    _loc_19 = 0;
                    _loc_18 = originx;
                    _loc_19 = originy;
                    _loc_20 = _loc_17;
                    _loc_18 = _loc_18 + dirx * _loc_20;
                    _loc_19 = _loc_19 + diry * _loc_20;
                    _loc_20 = 1;
                    _loc_18 = _loc_18 - param1.worldCOMx * _loc_20;
                    _loc_19 = _loc_19 - param1.worldCOMy * _loc_20;
                    _loc_20 = _loc_18 * _loc_18 + _loc_19 * _loc_19;
                    _loc_21 = 1 / Math.sqrt(_loc_20);
                    _loc_22 = _loc_21;
                    _loc_18 = _loc_18 * _loc_22;
                    _loc_19 = _loc_19 * _loc_22;
                    if (_loc_15 <= 0)
                    {
                        _loc_18 = -_loc_18;
                        _loc_19 = -_loc_19;
                    }
                    _loc_23 = false;
                    if (_loc_18 == _loc_18)
                    {
                    }
                    if (_loc_19 != _loc_19)
                    {
                        throw "Error: Vec2 components cannot be NaN";
                    }
                    if (ZPP_PubPool.poolVec2 == null)
                    {
                        _loc_24 = new Vec2();
                    }
                    else
                    {
                        _loc_24 = ZPP_PubPool.poolVec2;
                        ZPP_PubPool.poolVec2 = _loc_24.zpp_pool;
                        _loc_24.zpp_pool = null;
                        _loc_24.zpp_disp = false;
                        if (_loc_24 == ZPP_PubPool.nextVec2)
                        {
                            ZPP_PubPool.nextVec2 = null;
                        }
                    }
                    if (_loc_24.zpp_inner == null)
                    {
                        _loc_25 = false;
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
                        _loc_6._immutable = _loc_25;
                        _loc_6.x = _loc_18;
                        _loc_6.y = _loc_19;
                        _loc_24.zpp_inner = _loc_6;
                        _loc_24.zpp_inner.outer = _loc_24;
                    }
                    else
                    {
                        if (_loc_24 != null)
                        {
                        }
                        if (_loc_24.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_6 = _loc_24.zpp_inner;
                        if (_loc_6._immutable)
                        {
                            throw "Error: Vec2 is immutable";
                        }
                        if (_loc_6._isimmutable != null)
                        {
                            _loc_6._isimmutable();
                        }
                        if (_loc_18 == _loc_18)
                        {
                        }
                        if (_loc_19 != _loc_19)
                        {
                            throw "Error: Vec2 components cannot be NaN";
                        }
                        if (_loc_24 != null)
                        {
                        }
                        if (_loc_24.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_6 = _loc_24.zpp_inner;
                        if (_loc_6._validate != null)
                        {
                            _loc_6._validate();
                        }
                        if (_loc_24.zpp_inner.x == _loc_18)
                        {
                            if (_loc_24 != null)
                            {
                            }
                            if (_loc_24.zpp_disp)
                            {
                                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                            }
                            _loc_6 = _loc_24.zpp_inner;
                            if (_loc_6._validate != null)
                            {
                                _loc_6._validate();
                            }
                        }
                        if (_loc_24.zpp_inner.y != _loc_19)
                        {
                            _loc_24.zpp_inner.x = _loc_18;
                            _loc_24.zpp_inner.y = _loc_19;
                            _loc_6 = _loc_24.zpp_inner;
                            if (_loc_6._invalidate != null)
                            {
                                _loc_6._invalidate(_loc_6);
                            }
                        }
                    }
                    _loc_24.zpp_inner.weak = _loc_23;
                    return ZPP_ConvexRayResult.getRay(_loc_24, _loc_17, _loc_15 <= 0, param1.outer);
                }
                else
                {
                    return null;
                }
            }
            else
            {
                _loc_16 = Math.sqrt(_loc_16);
                _loc_13 = 1 / (2 * _loc_13);
                _loc_17 = (-_loc_14 - _loc_16) * _loc_13;
                _loc_18 = (-_loc_14 + _loc_16) * _loc_13;
                if (_loc_17 > 0)
                {
                    if (_loc_17 < param3)
                    {
                    }
                    if (_loc_17 <= maxdist)
                    {
                        _loc_19 = 0;
                        _loc_20 = 0;
                        _loc_19 = originx;
                        _loc_20 = originy;
                        _loc_21 = _loc_17;
                        _loc_19 = _loc_19 + dirx * _loc_21;
                        _loc_20 = _loc_20 + diry * _loc_21;
                        _loc_21 = 1;
                        _loc_19 = _loc_19 - param1.worldCOMx * _loc_21;
                        _loc_20 = _loc_20 - param1.worldCOMy * _loc_21;
                        _loc_21 = _loc_19 * _loc_19 + _loc_20 * _loc_20;
                        _loc_22 = 1 / Math.sqrt(_loc_21);
                        _loc_26 = _loc_22;
                        _loc_19 = _loc_19 * _loc_26;
                        _loc_20 = _loc_20 * _loc_26;
                        _loc_23 = false;
                        if (_loc_19 == _loc_19)
                        {
                        }
                        if (_loc_20 != _loc_20)
                        {
                            throw "Error: Vec2 components cannot be NaN";
                        }
                        if (ZPP_PubPool.poolVec2 == null)
                        {
                            _loc_24 = new Vec2();
                        }
                        else
                        {
                            _loc_24 = ZPP_PubPool.poolVec2;
                            ZPP_PubPool.poolVec2 = _loc_24.zpp_pool;
                            _loc_24.zpp_pool = null;
                            _loc_24.zpp_disp = false;
                            if (_loc_24 == ZPP_PubPool.nextVec2)
                            {
                                ZPP_PubPool.nextVec2 = null;
                            }
                        }
                        if (_loc_24.zpp_inner == null)
                        {
                            _loc_25 = false;
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
                            _loc_6._immutable = _loc_25;
                            _loc_6.x = _loc_19;
                            _loc_6.y = _loc_20;
                            _loc_24.zpp_inner = _loc_6;
                            _loc_24.zpp_inner.outer = _loc_24;
                        }
                        else
                        {
                            if (_loc_24 != null)
                            {
                            }
                            if (_loc_24.zpp_disp)
                            {
                                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                            }
                            _loc_6 = _loc_24.zpp_inner;
                            if (_loc_6._immutable)
                            {
                                throw "Error: Vec2 is immutable";
                            }
                            if (_loc_6._isimmutable != null)
                            {
                                _loc_6._isimmutable();
                            }
                            if (_loc_19 == _loc_19)
                            {
                            }
                            if (_loc_20 != _loc_20)
                            {
                                throw "Error: Vec2 components cannot be NaN";
                            }
                            if (_loc_24 != null)
                            {
                            }
                            if (_loc_24.zpp_disp)
                            {
                                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                            }
                            _loc_6 = _loc_24.zpp_inner;
                            if (_loc_6._validate != null)
                            {
                                _loc_6._validate();
                            }
                            if (_loc_24.zpp_inner.x == _loc_19)
                            {
                                if (_loc_24 != null)
                                {
                                }
                                if (_loc_24.zpp_disp)
                                {
                                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                                }
                                _loc_6 = _loc_24.zpp_inner;
                                if (_loc_6._validate != null)
                                {
                                    _loc_6._validate();
                                }
                            }
                            if (_loc_24.zpp_inner.y != _loc_20)
                            {
                                _loc_24.zpp_inner.x = _loc_19;
                                _loc_24.zpp_inner.y = _loc_20;
                                _loc_6 = _loc_24.zpp_inner;
                                if (_loc_6._invalidate != null)
                                {
                                    _loc_6._invalidate(_loc_6);
                                }
                            }
                        }
                        _loc_24.zpp_inner.weak = _loc_23;
                        return ZPP_ConvexRayResult.getRay(_loc_24, _loc_17, false, param1.outer);
                    }
                    else
                    {
                        return null;
                    }
                }
                else
                {
                    if (_loc_18 > 0)
                    {
                    }
                    if (param2)
                    {
                        if (_loc_18 < param3)
                        {
                        }
                        if (_loc_18 <= maxdist)
                        {
                            _loc_19 = 0;
                            _loc_20 = 0;
                            _loc_19 = originx;
                            _loc_20 = originy;
                            _loc_21 = _loc_18;
                            _loc_19 = _loc_19 + dirx * _loc_21;
                            _loc_20 = _loc_20 + diry * _loc_21;
                            _loc_21 = 1;
                            _loc_19 = _loc_19 - param1.worldCOMx * _loc_21;
                            _loc_20 = _loc_20 - param1.worldCOMy * _loc_21;
                            _loc_21 = _loc_19 * _loc_19 + _loc_20 * _loc_20;
                            _loc_22 = 1 / Math.sqrt(_loc_21);
                            _loc_26 = _loc_22;
                            _loc_19 = _loc_19 * _loc_26;
                            _loc_20 = _loc_20 * _loc_26;
                            _loc_19 = -_loc_19;
                            _loc_20 = -_loc_20;
                            _loc_23 = false;
                            if (_loc_19 == _loc_19)
                            {
                            }
                            if (_loc_20 != _loc_20)
                            {
                                throw "Error: Vec2 components cannot be NaN";
                            }
                            if (ZPP_PubPool.poolVec2 == null)
                            {
                                _loc_24 = new Vec2();
                            }
                            else
                            {
                                _loc_24 = ZPP_PubPool.poolVec2;
                                ZPP_PubPool.poolVec2 = _loc_24.zpp_pool;
                                _loc_24.zpp_pool = null;
                                _loc_24.zpp_disp = false;
                                if (_loc_24 == ZPP_PubPool.nextVec2)
                                {
                                    ZPP_PubPool.nextVec2 = null;
                                }
                            }
                            if (_loc_24.zpp_inner == null)
                            {
                                _loc_25 = false;
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
                                _loc_6._immutable = _loc_25;
                                _loc_6.x = _loc_19;
                                _loc_6.y = _loc_20;
                                _loc_24.zpp_inner = _loc_6;
                                _loc_24.zpp_inner.outer = _loc_24;
                            }
                            else
                            {
                                if (_loc_24 != null)
                                {
                                }
                                if (_loc_24.zpp_disp)
                                {
                                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                                }
                                _loc_6 = _loc_24.zpp_inner;
                                if (_loc_6._immutable)
                                {
                                    throw "Error: Vec2 is immutable";
                                }
                                if (_loc_6._isimmutable != null)
                                {
                                    _loc_6._isimmutable();
                                }
                                if (_loc_19 == _loc_19)
                                {
                                }
                                if (_loc_20 != _loc_20)
                                {
                                    throw "Error: Vec2 components cannot be NaN";
                                }
                                if (_loc_24 != null)
                                {
                                }
                                if (_loc_24.zpp_disp)
                                {
                                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                                }
                                _loc_6 = _loc_24.zpp_inner;
                                if (_loc_6._validate != null)
                                {
                                    _loc_6._validate();
                                }
                                if (_loc_24.zpp_inner.x == _loc_19)
                                {
                                    if (_loc_24 != null)
                                    {
                                    }
                                    if (_loc_24.zpp_disp)
                                    {
                                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                                    }
                                    _loc_6 = _loc_24.zpp_inner;
                                    if (_loc_6._validate != null)
                                    {
                                        _loc_6._validate();
                                    }
                                }
                                if (_loc_24.zpp_inner.y != _loc_20)
                                {
                                    _loc_24.zpp_inner.x = _loc_19;
                                    _loc_24.zpp_inner.y = _loc_20;
                                    _loc_6 = _loc_24.zpp_inner;
                                    if (_loc_6._invalidate != null)
                                    {
                                        _loc_6._invalidate(_loc_6);
                                    }
                                }
                            }
                            _loc_24.zpp_inner.weak = _loc_23;
                            return ZPP_ConvexRayResult.getRay(_loc_24, _loc_18, true, param1.outer);
                        }
                        else
                        {
                            return null;
                        }
                    }
                    else
                    {
                        return null;
                    }
                }
            }
        }// end function

        public function aabbtest(param1:ZPP_AABB) : Boolean
        {
            var _loc_2:* = normalx * (originx - 0.5 * (param1.minx + param1.maxx)) + normaly * (originy - 0.5 * (param1.miny + param1.maxy));
            var _loc_3:* = absnormalx * 0.5 * (param1.maxx - param1.minx) + absnormaly * 0.5 * (param1.maxy - param1.miny);
            var _loc_4:* = _loc_2;
            return (_loc_4 < 0 ? (-_loc_4) : (_loc_4)) < _loc_3;
        }// end function

        public function aabbsect(param1:ZPP_AABB) : Number
        {
            var _loc_4:* = NaN;
            var _loc_5:* = NaN;
            var _loc_6:* = NaN;
            if (originx >= param1.minx)
            {
            }
            var _loc_2:* = originx <= param1.maxx;
            if (originy >= param1.miny)
            {
            }
            var _loc_3:* = originy <= param1.maxy;
            if (_loc_2)
            {
            }
            if (_loc_3)
            {
                return 0;
            }
            else
            {
                _loc_4 = -1;
                do
                {
                    
                    if (dirx >= 0)
                    {
                    }
                    if (originx >= param1.maxx)
                    {
                        break;
                    }
                    if (dirx <= 0)
                    {
                    }
                    if (originx <= param1.minx)
                    {
                        break;
                    }
                    if (diry >= 0)
                    {
                    }
                    if (originy >= param1.maxy)
                    {
                        break;
                    }
                    if (diry <= 0)
                    {
                    }
                    if (originy <= param1.miny)
                    {
                        break;
                    }
                    if (dirx > 0)
                    {
                        _loc_5 = (param1.minx - originx) * idirx;
                        if (_loc_5 >= 0)
                        {
                        }
                        if (_loc_5 <= maxdist)
                        {
                            _loc_6 = originy + _loc_5 * diry;
                            if (_loc_6 >= param1.miny)
                            {
                            }
                            if (_loc_6 <= param1.maxy)
                            {
                                _loc_4 = _loc_5;
                                break;
                            }
                        }
                    }
                    else if (dirx < 0)
                    {
                        _loc_5 = (param1.maxx - originx) * idirx;
                        if (_loc_5 >= 0)
                        {
                        }
                        if (_loc_5 <= maxdist)
                        {
                            _loc_6 = originy + _loc_5 * diry;
                            if (_loc_6 >= param1.miny)
                            {
                            }
                            if (_loc_6 <= param1.maxy)
                            {
                                _loc_4 = _loc_5;
                                break;
                            }
                        }
                    }
                    if (diry > 0)
                    {
                        _loc_5 = (param1.miny - originy) * idiry;
                        if (_loc_5 >= 0)
                        {
                        }
                        if (_loc_5 <= maxdist)
                        {
                            _loc_6 = originx + _loc_5 * dirx;
                            if (_loc_6 >= param1.minx)
                            {
                            }
                            if (_loc_6 <= param1.maxx)
                            {
                                _loc_4 = _loc_5;
                                break;
                            }
                        }
                        continue;
                    }
                    if (diry < 0)
                    {
                        _loc_5 = (param1.maxy - originy) * idiry;
                        if (_loc_5 >= 0)
                        {
                        }
                        if (_loc_5 <= maxdist)
                        {
                            _loc_6 = originx + _loc_5 * dirx;
                            if (_loc_6 >= param1.minx)
                            {
                            }
                            if (_loc_6 <= param1.maxx)
                            {
                                _loc_4 = _loc_5;
                                break;
                            }
                        }
                    }
                }while (false)
                return _loc_4;
            }
        }// end function

    }
}
