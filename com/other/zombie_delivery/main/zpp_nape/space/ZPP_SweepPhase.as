package zpp_nape.space
{
    import flash.*;
    import nape.geom.*;
    import nape.phys.*;
    import nape.shape.*;
    import zpp_nape.dynamics.*;
    import zpp_nape.geom.*;
    import zpp_nape.phys.*;
    import zpp_nape.shape.*;
    import zpp_nape.util.*;

    public class ZPP_SweepPhase extends ZPP_Broadphase
    {
        public var list:ZPP_SweepData;
        public var failed:BodyList;

        public function ZPP_SweepPhase(param1:ZPP_Space = undefined) : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            failed = null;
            list = null;
            space = param1;
            is_sweep = true;
            sweep = this;
            return;
        }// end function

        public function sync_broadphase_fast() : void
        {
            var _loc_2:* = null as ZPP_SweepData;
            var _loc_3:* = null as ZPP_SweepData;
            var _loc_4:* = null as ZPP_SweepData;
            var _loc_1:* = list.next;
            while (_loc_1 != null)
            {
                
                _loc_2 = _loc_1.next;
                _loc_3 = _loc_1.prev;
                if (_loc_1.aabb.minx > _loc_3.aabb.minx)
                {
                    _loc_1 = _loc_2;
                    continue;
                }
                do
                {
                    
                    _loc_3 = _loc_3.prev;
                    if (_loc_3.prev != null)
                    {
                    }
                }while (_loc_3.prev.aabb.minx > _loc_1.aabb.minx)
                _loc_4 = _loc_1.prev;
                _loc_4.next = _loc_1.next;
                if (_loc_1.next != null)
                {
                    _loc_1.next.prev = _loc_4;
                }
                if (_loc_3.prev == null)
                {
                    _loc_1.prev = null;
                    list = _loc_1;
                    _loc_1.next = _loc_3;
                    _loc_3.prev = _loc_1;
                }
                else
                {
                    _loc_1.prev = _loc_3.prev;
                    _loc_3.prev = _loc_1;
                    _loc_1.prev.next = _loc_1;
                    _loc_1.next = _loc_3;
                }
                _loc_1 = _loc_2;
            }
            return;
        }// end function

        public function sync_broadphase() : void
        {
            var _loc_1:* = null as ZPP_SweepData;
            var _loc_2:* = null as ZPP_SweepData;
            var _loc_3:* = null as ZPP_SweepData;
            var _loc_4:* = null as ZPP_SweepData;
            space.validation();
            if (list != null)
            {
                _loc_1 = list.next;
                while (_loc_1 != null)
                {
                    
                    _loc_2 = _loc_1.next;
                    _loc_3 = _loc_1.prev;
                    if (_loc_1.aabb.minx > _loc_3.aabb.minx)
                    {
                        _loc_1 = _loc_2;
                        continue;
                    }
                    do
                    {
                        
                        _loc_3 = _loc_3.prev;
                        if (_loc_3.prev != null)
                        {
                        }
                    }while (_loc_3.prev.aabb.minx > _loc_1.aabb.minx)
                    _loc_4 = _loc_1.prev;
                    _loc_4.next = _loc_1.next;
                    if (_loc_1.next != null)
                    {
                        _loc_1.next.prev = _loc_4;
                    }
                    if (_loc_3.prev == null)
                    {
                        _loc_1.prev = null;
                        list = _loc_1;
                        _loc_1.next = _loc_3;
                        _loc_3.prev = _loc_1;
                    }
                    else
                    {
                        _loc_1.prev = _loc_3.prev;
                        _loc_3.prev = _loc_1;
                        _loc_1.prev.next = _loc_1;
                        _loc_1.next = _loc_3;
                    }
                    _loc_1 = _loc_2;
                }
            }
            return;
        }// end function

        override public function shapesUnderPoint(param1:Number, param2:Number, param3:ZPP_InteractionFilter, param4:ShapeList) : ShapeList
        {
            var _loc_7:* = null as ZPP_Vec2;
            var _loc_8:* = null as ShapeList;
            var _loc_10:* = null as ZPP_Shape;
            var _loc_11:* = null as ZPP_InteractionFilter;
            sync_broadphase();
            var _loc_6:* = false;
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
            _loc_7.x = param1;
            _loc_7.y = param2;
            var _loc_5:* = _loc_7;
            if (param4 == null)
            {
                _loc_8 = new ShapeList();
            }
            else
            {
                _loc_8 = param4;
            }
            var _loc_9:* = list;
            do
            {
                
                _loc_9 = _loc_9.next;
                if (_loc_9 != null)
                {
                }
            }while (_loc_9.aabb.minx > param1)
            do
            {
                
                if (_loc_9.aabb.maxx >= param1)
                {
                }
                if (_loc_9.aabb.miny <= param2)
                {
                }
                if (_loc_9.aabb.maxy >= param2)
                {
                    _loc_10 = _loc_9.shape;
                    if (param3 != null)
                    {
                        _loc_11 = _loc_10.filter;
                        if ((_loc_11.collisionMask & param3.collisionGroup) != 0)
                        {
                        }
                    }
                    if ((param3.collisionMask & _loc_11.collisionGroup) != 0)
                    {
                        if (_loc_10.type == ZPP_Flags.id_ShapeType_CIRCLE)
                        {
                            if (ZPP_Collide.circleContains(_loc_10.circle, _loc_5))
                            {
                                _loc_8.push(_loc_10.outer);
                            }
                        }
                        else if (ZPP_Collide.polyContains(_loc_10.polygon, _loc_5))
                        {
                            _loc_8.push(_loc_10.outer);
                        }
                    }
                }
                _loc_9 = _loc_9.next;
                if (_loc_9 != null)
                {
                }
            }while (_loc_9.aabb.minx <= param1)
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
            return _loc_8;
        }// end function

        override public function shapesInShape(param1:ZPP_Shape, param2:Boolean, param3:ZPP_InteractionFilter, param4:ShapeList) : ShapeList
        {
            var _loc_6:* = null as ShapeList;
            var _loc_8:* = null as ZPP_AABB;
            var _loc_9:* = null as ZPP_Shape;
            var _loc_10:* = null as ZPP_InteractionFilter;
            sync_broadphase();
            validateShape(param1);
            var _loc_5:* = param1.aabb;
            if (param4 == null)
            {
                _loc_6 = new ShapeList();
            }
            else
            {
                _loc_6 = param4;
            }
            var _loc_7:* = list;
            do
            {
                
                _loc_7 = _loc_7.next;
                if (_loc_7 != null)
                {
                }
            }while (_loc_7.aabb.maxx < _loc_5.minx)
            do
            {
                
                _loc_8 = _loc_7.aabb;
                if (_loc_5.miny <= _loc_8.maxy)
                {
                }
                if (_loc_8.miny <= _loc_5.maxy)
                {
                }
                if (_loc_5.minx <= _loc_8.maxx)
                {
                }
                if (_loc_8.minx <= _loc_5.maxx)
                {
                    _loc_9 = _loc_7.shape;
                    if (param3 != null)
                    {
                        _loc_10 = _loc_9.filter;
                        if ((_loc_10.collisionMask & param3.collisionGroup) != 0)
                        {
                        }
                    }
                    if ((param3.collisionMask & _loc_10.collisionGroup) != 0)
                    {
                        if (param2)
                        {
                            if (ZPP_Collide.containTest(param1, _loc_9))
                            {
                                _loc_6.push(_loc_9.outer);
                            }
                        }
                        else if (ZPP_Collide.testCollide_safe(_loc_9, param1))
                        {
                            _loc_6.push(_loc_9.outer);
                        }
                    }
                }
                _loc_7 = _loc_7.next;
                if (_loc_7 != null)
                {
                }
            }while (_loc_7.aabb.minx <= _loc_5.maxx)
            return _loc_6;
        }// end function

        override public function shapesInCircle(param1:Number, param2:Number, param3:Number, param4:Boolean, param5:ZPP_InteractionFilter, param6:ShapeList) : ShapeList
        {
            var _loc_8:* = null as ShapeList;
            var _loc_10:* = null as ZPP_AABB;
            var _loc_11:* = null as ZPP_Shape;
            var _loc_12:* = null as ZPP_InteractionFilter;
            sync_broadphase();
            updateCircShape(param1, param2, param3);
            var _loc_7:* = circShape.zpp_inner.aabb;
            if (param6 == null)
            {
                _loc_8 = new ShapeList();
            }
            else
            {
                _loc_8 = param6;
            }
            var _loc_9:* = list;
            do
            {
                
                _loc_9 = _loc_9.next;
                if (_loc_9 != null)
                {
                }
            }while (_loc_9.aabb.maxx < _loc_7.minx)
            do
            {
                
                _loc_10 = _loc_9.aabb;
                if (_loc_7.miny <= _loc_10.maxy)
                {
                }
                if (_loc_10.miny <= _loc_7.maxy)
                {
                }
                if (_loc_7.minx <= _loc_10.maxx)
                {
                }
                if (_loc_10.minx <= _loc_7.maxx)
                {
                    _loc_11 = _loc_9.shape;
                    if (param5 != null)
                    {
                        _loc_12 = _loc_11.filter;
                        if ((_loc_12.collisionMask & param5.collisionGroup) != 0)
                        {
                        }
                    }
                    if ((param5.collisionMask & _loc_12.collisionGroup) != 0)
                    {
                        if (param4)
                        {
                            if (ZPP_Collide.containTest(circShape.zpp_inner, _loc_11))
                            {
                                _loc_8.push(_loc_11.outer);
                            }
                        }
                        else if (ZPP_Collide.testCollide_safe(_loc_11, circShape.zpp_inner))
                        {
                            _loc_8.push(_loc_11.outer);
                        }
                    }
                }
                _loc_9 = _loc_9.next;
                if (_loc_9 != null)
                {
                }
            }while (_loc_9.aabb.minx <= _loc_7.maxx)
            return _loc_8;
        }// end function

        override public function shapesInAABB(param1:ZPP_AABB, param2:Boolean, param3:Boolean, param4:ZPP_InteractionFilter, param5:ShapeList) : ShapeList
        {
            var _loc_7:* = null as ShapeList;
            var _loc_9:* = null as ZPP_Shape;
            var _loc_10:* = null as ZPP_InteractionFilter;
            var _loc_11:* = null as ZPP_AABB;
            sync_broadphase();
            updateAABBShape(param1);
            var _loc_6:* = aabbShape.zpp_inner.aabb;
            if (param5 == null)
            {
                _loc_7 = new ShapeList();
            }
            else
            {
                _loc_7 = param5;
            }
            var _loc_8:* = list;
            do
            {
                
                _loc_8 = _loc_8.next;
                if (_loc_8 != null)
                {
                }
            }while (_loc_8.aabb.maxx < _loc_6.minx)
            do
            {
                
                _loc_9 = _loc_8.shape;
                if (param4 != null)
                {
                    _loc_10 = _loc_9.filter;
                    if ((_loc_10.collisionMask & param4.collisionGroup) != 0)
                    {
                    }
                }
                if ((param4.collisionMask & _loc_10.collisionGroup) != 0)
                {
                    if (param2)
                    {
                        if (param3)
                        {
                            if (ZPP_Collide.containTest(aabbShape.zpp_inner, _loc_9))
                            {
                                _loc_7.push(_loc_9.outer);
                            }
                        }
                        else
                        {
                            _loc_11 = _loc_8.aabb;
                            if (_loc_11.minx >= _loc_6.minx)
                            {
                            }
                            if (_loc_11.miny >= _loc_6.miny)
                            {
                            }
                            if (_loc_11.maxx <= _loc_6.maxx)
                            {
                            }
                            if (_loc_11.maxy <= _loc_6.maxy)
                            {
                                _loc_7.push(_loc_9.outer);
                            }
                            else
                            {
                                _loc_11 = _loc_8.aabb;
                                if (_loc_6.miny <= _loc_11.maxy)
                                {
                                }
                                if (_loc_11.miny <= _loc_6.maxy)
                                {
                                }
                                if (_loc_6.minx <= _loc_11.maxx)
                                {
                                }
                                if (_loc_11.minx <= _loc_6.maxx)
                                {
                                    if (ZPP_Collide.testCollide_safe(_loc_9, aabbShape.zpp_inner))
                                    {
                                        _loc_7.push(_loc_9.outer);
                                    }
                                }
                            }
                        }
                    }
                    else
                    {
                        if (_loc_11.minx >= _loc_6.minx)
                        {
                        }
                        if (_loc_11.miny >= _loc_6.miny)
                        {
                        }
                        if (_loc_11.maxx <= _loc_6.maxx)
                        {
                        }
                        if (_loc_6.miny <= _loc_11.maxy)
                        {
                        }
                        if (_loc_11.miny <= _loc_6.maxy)
                        {
                        }
                        if (_loc_6.minx <= _loc_11.maxx)
                        {
                        }
                        if (param3 ? (_loc_11 = _loc_8.aabb, if (!(_loc_11.minx >= _loc_6.minx)) goto 526, if (!(_loc_11.miny >= _loc_6.miny)) goto 543, if (!(_loc_11.maxx <= _loc_6.maxx)) goto 560, _loc_11.maxy <= _loc_6.maxy) : (_loc_11 = _loc_8.aabb, if (!(_loc_6.miny <= _loc_11.maxy)) goto 604, if (!(_loc_11.miny <= _loc_6.maxy)) goto 621, if (!(_loc_6.minx <= _loc_11.maxx)) goto 638, _loc_11.minx <= _loc_6.maxx))
                        {
                            _loc_7.push(_loc_9.outer);
                        }
                    }
                }
                _loc_8 = _loc_8.next;
                if (_loc_8 != null)
                {
                }
            }while (_loc_8.aabb.minx <= _loc_6.maxx)
            return _loc_7;
        }// end function

        override public function rayMultiCast(param1:ZPP_Ray, param2:Boolean, param3:ZPP_InteractionFilter, param4:RayResultList) : RayResultList
        {
            var _loc_6:* = null as RayResultList;
            var _loc_7:* = null as ZPP_SweepData;
            var _loc_8:* = null as ZPP_AABB;
            var _loc_9:* = null as ZPP_InteractionFilter;
            var _loc_10:* = NaN;
            var _loc_11:* = null as ZPP_SweepData;
            sync_broadphase();
            param1.validate_dir();
            var _loc_5:* = param1.rayAABB();
            if (param4 == null)
            {
                _loc_6 = new RayResultList();
            }
            else
            {
                _loc_6 = param4;
            }
            if (param1.dirx == 0)
            {
                _loc_7 = list;
                do
                {
                    
                    _loc_8 = _loc_7.aabb;
                    if (_loc_5.miny <= _loc_8.maxy)
                    {
                    }
                    if (_loc_8.miny <= _loc_5.maxy)
                    {
                    }
                    if (_loc_5.minx <= _loc_8.maxx)
                    {
                    }
                    if (_loc_8.minx <= _loc_5.maxx)
                    {
                        if (param3 != null)
                        {
                            _loc_9 = _loc_7.shape.filter;
                            if ((_loc_9.collisionMask & param3.collisionGroup) != 0)
                            {
                            }
                        }
                    }
                    if ((param3.collisionMask & _loc_9.collisionGroup) != 0)
                    {
                        _loc_10 = param1.aabbsect(_loc_7.aabb);
                        if (_loc_10 >= 0)
                        {
                            if (_loc_7.shape.type == ZPP_Flags.id_ShapeType_CIRCLE)
                            {
                                param1.circlesect2(_loc_7.shape.circle, param2, _loc_6);
                            }
                            else
                            {
                                param1.polysect2(_loc_7.shape.polygon, param2, _loc_6);
                            }
                        }
                    }
                    _loc_7 = _loc_7.next;
                    if (_loc_7 != null)
                    {
                    }
                }while (_loc_7.aabb.minx <= _loc_5.minx)
            }
            else if (param1.dirx < 0)
            {
                _loc_7 = list;
                _loc_11 = null;
                do
                {
                    
                    _loc_11 = _loc_7;
                    _loc_7 = _loc_7.next;
                    if (_loc_7 != null)
                    {
                    }
                }while (_loc_7.aabb.minx <= _loc_5.maxx)
                _loc_7 = _loc_11;
                while (_loc_7 != null)
                {
                    
                    _loc_8 = _loc_7.aabb;
                    if (_loc_5.miny <= _loc_8.maxy)
                    {
                    }
                    if (_loc_8.miny <= _loc_5.maxy)
                    {
                    }
                    if (_loc_5.minx <= _loc_8.maxx)
                    {
                    }
                    if (_loc_8.minx <= _loc_5.maxx)
                    {
                        if (param3 != null)
                        {
                            _loc_9 = _loc_7.shape.filter;
                            if ((_loc_9.collisionMask & param3.collisionGroup) != 0)
                            {
                            }
                        }
                    }
                    if ((param3.collisionMask & _loc_9.collisionGroup) != 0)
                    {
                        _loc_10 = param1.aabbsect(_loc_7.aabb);
                        if (_loc_10 >= 0)
                        {
                            if (_loc_7.shape.type == ZPP_Flags.id_ShapeType_CIRCLE)
                            {
                                param1.circlesect2(_loc_7.shape.circle, param2, _loc_6);
                            }
                            else
                            {
                                param1.polysect2(_loc_7.shape.polygon, param2, _loc_6);
                            }
                        }
                    }
                    _loc_7 = _loc_7.prev;
                }
            }
            else
            {
                _loc_7 = list;
                do
                {
                    
                    _loc_8 = _loc_7.aabb;
                    if (_loc_5.miny <= _loc_8.maxy)
                    {
                    }
                    if (_loc_8.miny <= _loc_5.maxy)
                    {
                    }
                    if (_loc_5.minx <= _loc_8.maxx)
                    {
                    }
                    if (_loc_8.minx <= _loc_5.maxx)
                    {
                        if (param3 != null)
                        {
                            _loc_9 = _loc_7.shape.filter;
                            if ((_loc_9.collisionMask & param3.collisionGroup) != 0)
                            {
                            }
                        }
                    }
                    if ((param3.collisionMask & _loc_9.collisionGroup) != 0)
                    {
                        _loc_10 = param1.aabbsect(_loc_7.aabb);
                        if (_loc_10 >= 0)
                        {
                            if (_loc_7.shape.type == ZPP_Flags.id_ShapeType_CIRCLE)
                            {
                                param1.circlesect2(_loc_7.shape.circle, param2, _loc_6);
                            }
                            else
                            {
                                param1.polysect2(_loc_7.shape.polygon, param2, _loc_6);
                            }
                        }
                    }
                    _loc_7 = _loc_7.next;
                    if (_loc_7 != null)
                    {
                    }
                }while (_loc_7.aabb.minx <= _loc_5.maxx)
            }
            _loc_8 = _loc_5;
            if (_loc_8.outer != null)
            {
                _loc_8.outer.zpp_inner = null;
                _loc_8.outer = null;
            }
            var _loc_12:* = null;
            _loc_8.wrap_max = null;
            _loc_8.wrap_min = _loc_12;
            _loc_8._invalidate = null;
            _loc_8._validate = null;
            _loc_8.next = ZPP_AABB.zpp_pool;
            ZPP_AABB.zpp_pool = _loc_8;
            return _loc_6;
        }// end function

        override public function rayCast(param1:ZPP_Ray, param2:Boolean, param3:ZPP_InteractionFilter) : RayResult
        {
            var _loc_7:* = null as ZPP_SweepData;
            var _loc_8:* = null as ZPP_AABB;
            var _loc_9:* = null as ZPP_InteractionFilter;
            var _loc_10:* = NaN;
            var _loc_11:* = null as RayResult;
            var _loc_12:* = null as ZPP_SweepData;
            sync_broadphase();
            param1.validate_dir();
            var _loc_4:* = param1.rayAABB();
            var _loc_5:* = param1.maxdist;
            var _loc_6:* = null;
            if (param1.dirx == 0)
            {
                _loc_7 = list;
                do
                {
                    
                    _loc_8 = _loc_7.aabb;
                    if (_loc_4.miny <= _loc_8.maxy)
                    {
                    }
                    if (_loc_8.miny <= _loc_4.maxy)
                    {
                    }
                    if (_loc_4.minx <= _loc_8.maxx)
                    {
                    }
                    if (_loc_8.minx <= _loc_4.maxx)
                    {
                        if (param3 != null)
                        {
                            _loc_9 = _loc_7.shape.filter;
                            if ((_loc_9.collisionMask & param3.collisionGroup) != 0)
                            {
                            }
                        }
                    }
                    if ((param3.collisionMask & _loc_9.collisionGroup) != 0)
                    {
                        _loc_10 = param1.aabbsect(_loc_7.aabb);
                        if (_loc_10 >= 0)
                        {
                        }
                        if (_loc_10 < _loc_5)
                        {
                            if (_loc_7.shape.type == ZPP_Flags.id_ShapeType_CIRCLE)
                            {
                                _loc_11 = param1.circlesect(_loc_7.shape.circle, param2, _loc_5);
                            }
                            else
                            {
                                _loc_11 = param1.polysect(_loc_7.shape.polygon, param2, _loc_5);
                            }
                            if (_loc_11 != null)
                            {
                                if (_loc_11.zpp_inner.next != null)
                                {
                                    throw "Error: This object has been disposed of and cannot be used";
                                }
                                _loc_5 = _loc_11.zpp_inner.toiDistance;
                                if (_loc_6 != null)
                                {
                                    if (_loc_6.zpp_inner.next != null)
                                    {
                                        throw "Error: This object has been disposed of and cannot be used";
                                    }
                                    _loc_6.zpp_inner.free();
                                }
                                _loc_6 = _loc_11;
                            }
                        }
                    }
                    _loc_7 = _loc_7.next;
                    if (_loc_7 != null)
                    {
                    }
                }while (_loc_7.aabb.minx <= _loc_4.minx)
            }
            else if (param1.dirx < 0)
            {
                _loc_7 = list;
                _loc_12 = null;
                do
                {
                    
                    _loc_12 = _loc_7;
                    _loc_7 = _loc_7.next;
                    if (_loc_7 != null)
                    {
                    }
                }while (_loc_7.aabb.minx <= _loc_4.maxx)
                _loc_7 = _loc_12;
                while (_loc_7 != null)
                {
                    
                    _loc_8 = _loc_7.aabb;
                    if (_loc_4.miny <= _loc_8.maxy)
                    {
                    }
                    if (_loc_8.miny <= _loc_4.maxy)
                    {
                    }
                    if (_loc_4.minx <= _loc_8.maxx)
                    {
                    }
                    if (_loc_8.minx <= _loc_4.maxx)
                    {
                        if (param3 != null)
                        {
                            _loc_9 = _loc_7.shape.filter;
                            if ((_loc_9.collisionMask & param3.collisionGroup) != 0)
                            {
                            }
                        }
                    }
                    if ((param3.collisionMask & _loc_9.collisionGroup) != 0)
                    {
                        _loc_10 = param1.aabbsect(_loc_7.aabb);
                        if (_loc_10 >= 0)
                        {
                        }
                        if (_loc_10 < _loc_5)
                        {
                            if (_loc_7.shape.type == ZPP_Flags.id_ShapeType_CIRCLE)
                            {
                                _loc_11 = param1.circlesect(_loc_7.shape.circle, param2, _loc_5);
                            }
                            else
                            {
                                _loc_11 = param1.polysect(_loc_7.shape.polygon, param2, _loc_5);
                            }
                            if (_loc_11 != null)
                            {
                                if (_loc_11.zpp_inner.next != null)
                                {
                                    throw "Error: This object has been disposed of and cannot be used";
                                }
                                _loc_5 = _loc_11.zpp_inner.toiDistance;
                                if (_loc_6 != null)
                                {
                                    if (_loc_6.zpp_inner.next != null)
                                    {
                                        throw "Error: This object has been disposed of and cannot be used";
                                    }
                                    _loc_6.zpp_inner.free();
                                }
                                _loc_6 = _loc_11;
                            }
                        }
                    }
                    _loc_7 = _loc_7.prev;
                }
            }
            else
            {
                _loc_7 = list;
                do
                {
                    
                    _loc_8 = _loc_7.aabb;
                    if (_loc_4.miny <= _loc_8.maxy)
                    {
                    }
                    if (_loc_8.miny <= _loc_4.maxy)
                    {
                    }
                    if (_loc_4.minx <= _loc_8.maxx)
                    {
                    }
                    if (_loc_8.minx <= _loc_4.maxx)
                    {
                        if (param3 != null)
                        {
                            _loc_9 = _loc_7.shape.filter;
                            if ((_loc_9.collisionMask & param3.collisionGroup) != 0)
                            {
                            }
                        }
                    }
                    if ((param3.collisionMask & _loc_9.collisionGroup) != 0)
                    {
                        _loc_10 = param1.aabbsect(_loc_7.aabb);
                        if (_loc_10 >= 0)
                        {
                        }
                        if (_loc_10 < _loc_5)
                        {
                            if (_loc_7.shape.type == ZPP_Flags.id_ShapeType_CIRCLE)
                            {
                                _loc_11 = param1.circlesect(_loc_7.shape.circle, param2, _loc_5);
                            }
                            else
                            {
                                _loc_11 = param1.polysect(_loc_7.shape.polygon, param2, _loc_5);
                            }
                            if (_loc_11 != null)
                            {
                                if (_loc_11.zpp_inner.next != null)
                                {
                                    throw "Error: This object has been disposed of and cannot be used";
                                }
                                _loc_5 = _loc_11.zpp_inner.toiDistance;
                                if (_loc_6 != null)
                                {
                                    if (_loc_6.zpp_inner.next != null)
                                    {
                                        throw "Error: This object has been disposed of and cannot be used";
                                    }
                                    _loc_6.zpp_inner.free();
                                }
                                _loc_6 = _loc_11;
                            }
                        }
                    }
                    _loc_7 = _loc_7.next;
                    if (_loc_7 != null)
                    {
                    }
                    if (_loc_7.aabb.minx <= _loc_4.maxx)
                    {
                    }
                }while (_loc_7.aabb.minx < param1.originx + param1.dirx * _loc_5)
            }
            _loc_8 = _loc_4;
            if (_loc_8.outer != null)
            {
                _loc_8.outer.zpp_inner = null;
                _loc_8.outer = null;
            }
            var _loc_13:* = null;
            _loc_8.wrap_max = null;
            _loc_8.wrap_min = _loc_13;
            _loc_8._invalidate = null;
            _loc_8._validate = null;
            _loc_8.next = ZPP_AABB.zpp_pool;
            ZPP_AABB.zpp_pool = _loc_8;
            return _loc_6;
        }// end function

        override public function clear() : void
        {
            while (list != null)
            {
                
                list.shape.removedFromSpace();
                __remove(list.shape);
            }
            return;
        }// end function

        override public function broadphase(param1:ZPP_Space, param2:Boolean) : void
        {
            var _loc_3:* = null as ZPP_SweepData;
            var _loc_4:* = null as ZPP_SweepData;
            var _loc_5:* = null as ZPP_SweepData;
            var _loc_6:* = null as ZPP_SweepData;
            var _loc_7:* = null as ZPP_Shape;
            var _loc_8:* = null as ZPP_Body;
            var _loc_9:* = NaN;
            var _loc_10:* = null as ZPP_Shape;
            var _loc_11:* = null as ZPP_Body;
            var _loc_12:* = null as ZPP_AABB;
            var _loc_13:* = null as ZPP_AABB;
            if (list != null)
            {
                _loc_3 = list.next;
                while (_loc_3 != null)
                {
                    
                    _loc_4 = _loc_3.next;
                    _loc_5 = _loc_3.prev;
                    if (_loc_3.aabb.minx > _loc_5.aabb.minx)
                    {
                        _loc_3 = _loc_4;
                        continue;
                    }
                    do
                    {
                        
                        _loc_5 = _loc_5.prev;
                        if (_loc_5.prev != null)
                        {
                        }
                    }while (_loc_5.prev.aabb.minx > _loc_3.aabb.minx)
                    _loc_6 = _loc_3.prev;
                    _loc_6.next = _loc_3.next;
                    if (_loc_3.next != null)
                    {
                        _loc_3.next.prev = _loc_6;
                    }
                    if (_loc_5.prev == null)
                    {
                        _loc_3.prev = null;
                        list = _loc_3;
                        _loc_3.next = _loc_5;
                        _loc_5.prev = _loc_3;
                    }
                    else
                    {
                        _loc_3.prev = _loc_5.prev;
                        _loc_5.prev = _loc_3;
                        _loc_3.prev.next = _loc_3;
                        _loc_3.next = _loc_5;
                    }
                    _loc_3 = _loc_4;
                }
                _loc_3 = list;
                while (_loc_3 != null)
                {
                    
                    _loc_4 = _loc_3.next;
                    _loc_7 = _loc_3.shape;
                    _loc_8 = _loc_7.body;
                    _loc_9 = _loc_3.aabb.maxx;
                    while (_loc_4 != null)
                    {
                        
                        if (_loc_4.aabb.minx > _loc_9)
                        {
                            break;
                        }
                        _loc_10 = _loc_4.shape;
                        _loc_11 = _loc_10.body;
                        if (_loc_11 == _loc_8)
                        {
                            _loc_4 = _loc_4.next;
                            continue;
                        }
                        if (_loc_8.type == ZPP_Flags.id_BodyType_STATIC)
                        {
                        }
                        if (_loc_11.type == ZPP_Flags.id_BodyType_STATIC)
                        {
                            _loc_4 = _loc_4.next;
                            continue;
                        }
                        if (_loc_8.component.sleeping)
                        {
                        }
                        if (_loc_11.component.sleeping)
                        {
                            _loc_4 = _loc_4.next;
                            continue;
                        }
                        _loc_12 = _loc_7.aabb;
                        _loc_13 = _loc_10.aabb;
                        if (_loc_13.miny <= _loc_12.maxy)
                        {
                        }
                        if (_loc_12.miny <= _loc_13.maxy)
                        {
                            if (param2)
                            {
                                if (_loc_8.type == ZPP_Flags.id_BodyType_DYNAMIC)
                                {
                                }
                                param1.narrowPhase(_loc_7, _loc_10, _loc_11.type != ZPP_Flags.id_BodyType_DYNAMIC, null, false);
                            }
                            else
                            {
                                if (_loc_8.type == ZPP_Flags.id_BodyType_DYNAMIC)
                                {
                                }
                                param1.continuousEvent(_loc_7, _loc_10, _loc_11.type != ZPP_Flags.id_BodyType_DYNAMIC, null, false);
                            }
                        }
                        _loc_4 = _loc_4.next;
                    }
                    _loc_3 = _loc_3.next;
                }
            }
            return;
        }// end function

        override public function bodiesUnderPoint(param1:Number, param2:Number, param3:ZPP_InteractionFilter, param4:BodyList) : BodyList
        {
            var _loc_7:* = null as ZPP_Vec2;
            var _loc_8:* = null as BodyList;
            var _loc_10:* = null as ZPP_Shape;
            var _loc_11:* = null as Body;
            var _loc_12:* = null as ZPP_InteractionFilter;
            sync_broadphase();
            var _loc_6:* = false;
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
            _loc_7.x = param1;
            _loc_7.y = param2;
            var _loc_5:* = _loc_7;
            if (param4 == null)
            {
                _loc_8 = new BodyList();
            }
            else
            {
                _loc_8 = param4;
            }
            var _loc_9:* = list;
            do
            {
                
                _loc_9 = _loc_9.next;
                if (_loc_9 != null)
                {
                }
            }while (_loc_9.aabb.minx > param1)
            do
            {
                
                if (_loc_9.aabb.maxx >= param1)
                {
                }
                if (_loc_9.aabb.miny <= param2)
                {
                }
                if (_loc_9.aabb.maxy >= param2)
                {
                    _loc_10 = _loc_9.shape;
                    _loc_11 = _loc_10.body.outer;
                    if (!_loc_8.has(_loc_11))
                    {
                        if (param3 != null)
                        {
                            _loc_12 = _loc_10.filter;
                            if ((_loc_12.collisionMask & param3.collisionGroup) != 0)
                            {
                            }
                        }
                        if ((param3.collisionMask & _loc_12.collisionGroup) != 0)
                        {
                            if (_loc_10.type == ZPP_Flags.id_ShapeType_CIRCLE)
                            {
                                if (ZPP_Collide.circleContains(_loc_10.circle, _loc_5))
                                {
                                    _loc_8.push(_loc_11);
                                }
                            }
                            else if (ZPP_Collide.polyContains(_loc_10.polygon, _loc_5))
                            {
                                _loc_8.push(_loc_11);
                            }
                        }
                    }
                }
                _loc_9 = _loc_9.next;
                if (_loc_9 != null)
                {
                }
            }while (_loc_9.aabb.minx <= param1)
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
            return _loc_8;
        }// end function

        override public function bodiesInShape(param1:ZPP_Shape, param2:Boolean, param3:ZPP_InteractionFilter, param4:BodyList) : BodyList
        {
            var _loc_6:* = null as BodyList;
            var _loc_8:* = null as ZPP_AABB;
            var _loc_9:* = null as ZPP_Shape;
            var _loc_10:* = null as Body;
            var _loc_11:* = null as ZPP_InteractionFilter;
            var _loc_12:* = false;
            sync_broadphase();
            validateShape(param1);
            var _loc_5:* = param1.aabb;
            if (param4 == null)
            {
                _loc_6 = new BodyList();
            }
            else
            {
                _loc_6 = param4;
            }
            if (failed == null)
            {
                failed = new BodyList();
            }
            var _loc_7:* = list;
            do
            {
                
                _loc_7 = _loc_7.next;
                if (_loc_7 != null)
                {
                }
            }while (_loc_7.aabb.maxx < _loc_5.minx)
            do
            {
                
                _loc_8 = _loc_7.aabb;
                if (_loc_5.miny <= _loc_8.maxy)
                {
                }
                if (_loc_8.miny <= _loc_5.maxy)
                {
                }
                if (_loc_5.minx <= _loc_8.maxx)
                {
                }
                if (_loc_8.minx <= _loc_5.maxx)
                {
                    _loc_9 = _loc_7.shape;
                    _loc_10 = _loc_9.body.outer;
                    if (param3 != null)
                    {
                        _loc_11 = _loc_9.filter;
                        if ((_loc_11.collisionMask & param3.collisionGroup) != 0)
                        {
                        }
                    }
                    if ((param3.collisionMask & _loc_11.collisionGroup) != 0)
                    {
                        if (param2)
                        {
                            if (!failed.has(_loc_10))
                            {
                                _loc_12 = ZPP_Collide.containTest(param1, _loc_9);
                                if (!_loc_6.has(_loc_10))
                                {
                                }
                                if (_loc_12)
                                {
                                    _loc_6.push(_loc_10);
                                }
                                else if (!_loc_12)
                                {
                                    _loc_6.remove(_loc_10);
                                    failed.push(_loc_10);
                                }
                            }
                        }
                        else
                        {
                            if (!_loc_6.has(_loc_10))
                            {
                            }
                            if (ZPP_Collide.testCollide_safe(param1, _loc_9))
                            {
                                _loc_6.push(_loc_10);
                            }
                        }
                    }
                }
                _loc_7 = _loc_7.next;
                if (_loc_7 != null)
                {
                }
            }while (_loc_7.aabb.minx <= _loc_5.maxx)
            failed.clear();
            return _loc_6;
        }// end function

        override public function bodiesInCircle(param1:Number, param2:Number, param3:Number, param4:Boolean, param5:ZPP_InteractionFilter, param6:BodyList) : BodyList
        {
            var _loc_8:* = null as BodyList;
            var _loc_10:* = null as ZPP_AABB;
            var _loc_11:* = null as ZPP_Shape;
            var _loc_12:* = null as Body;
            var _loc_13:* = null as ZPP_InteractionFilter;
            var _loc_14:* = false;
            sync_broadphase();
            updateCircShape(param1, param2, param3);
            var _loc_7:* = circShape.zpp_inner.aabb;
            if (param6 == null)
            {
                _loc_8 = new BodyList();
            }
            else
            {
                _loc_8 = param6;
            }
            if (failed == null)
            {
                failed = new BodyList();
            }
            var _loc_9:* = list;
            do
            {
                
                _loc_9 = _loc_9.next;
                if (_loc_9 != null)
                {
                }
            }while (_loc_9.aabb.maxx < _loc_7.minx)
            do
            {
                
                _loc_10 = _loc_9.aabb;
                if (_loc_7.miny <= _loc_10.maxy)
                {
                }
                if (_loc_10.miny <= _loc_7.maxy)
                {
                }
                if (_loc_7.minx <= _loc_10.maxx)
                {
                }
                if (_loc_10.minx <= _loc_7.maxx)
                {
                    _loc_11 = _loc_9.shape;
                    _loc_12 = _loc_11.body.outer;
                    if (param5 != null)
                    {
                        _loc_13 = _loc_11.filter;
                        if ((_loc_13.collisionMask & param5.collisionGroup) != 0)
                        {
                        }
                    }
                    if ((param5.collisionMask & _loc_13.collisionGroup) != 0)
                    {
                        if (param4)
                        {
                            if (!failed.has(_loc_12))
                            {
                                _loc_14 = ZPP_Collide.containTest(circShape.zpp_inner, _loc_11);
                                if (!_loc_8.has(_loc_12))
                                {
                                }
                                if (_loc_14)
                                {
                                    _loc_8.push(_loc_12);
                                }
                                else if (!_loc_14)
                                {
                                    _loc_8.remove(_loc_12);
                                    failed.push(_loc_12);
                                }
                            }
                        }
                        else
                        {
                            if (!_loc_8.has(_loc_12))
                            {
                            }
                            if (ZPP_Collide.testCollide_safe(_loc_11, circShape.zpp_inner))
                            {
                                _loc_8.push(_loc_12);
                            }
                        }
                    }
                }
                _loc_9 = _loc_9.next;
                if (_loc_9 != null)
                {
                }
            }while (_loc_9.aabb.minx <= _loc_7.maxx)
            failed.clear();
            return _loc_8;
        }// end function

        override public function bodiesInAABB(param1:ZPP_AABB, param2:Boolean, param3:Boolean, param4:ZPP_InteractionFilter, param5:BodyList) : BodyList
        {
            var _loc_7:* = null as BodyList;
            var _loc_9:* = null as ZPP_Shape;
            var _loc_10:* = null as Body;
            var _loc_11:* = null as ZPP_AABB;
            var _loc_12:* = null as ZPP_InteractionFilter;
            var _loc_13:* = false;
            sync_broadphase();
            updateAABBShape(param1);
            var _loc_6:* = aabbShape.zpp_inner.aabb;
            if (param5 == null)
            {
                _loc_7 = new BodyList();
            }
            else
            {
                _loc_7 = param5;
            }
            if (failed == null)
            {
                failed = new BodyList();
            }
            var _loc_8:* = list;
            do
            {
                
                _loc_8 = _loc_8.next;
                if (_loc_8 != null)
                {
                }
            }while (_loc_8.aabb.maxx < _loc_6.minx)
            do
            {
                
                _loc_9 = _loc_8.shape;
                _loc_10 = _loc_9.body.outer;
                _loc_11 = _loc_8.aabb;
                if (_loc_6.miny <= _loc_11.maxy)
                {
                }
                if (_loc_11.miny <= _loc_6.maxy)
                {
                }
                if (_loc_6.minx <= _loc_11.maxx)
                {
                }
                if (_loc_11.minx <= _loc_6.maxx)
                {
                    if (param4 != null)
                    {
                        _loc_12 = _loc_9.filter;
                        if ((_loc_12.collisionMask & param4.collisionGroup) != 0)
                        {
                        }
                    }
                    if ((param4.collisionMask & _loc_12.collisionGroup) != 0)
                    {
                        if (param2)
                        {
                            if (param3)
                            {
                                if (!failed.has(_loc_10))
                                {
                                    _loc_13 = ZPP_Collide.containTest(aabbShape.zpp_inner, _loc_9);
                                    if (!_loc_7.has(_loc_10))
                                    {
                                    }
                                    if (_loc_13)
                                    {
                                        _loc_7.push(_loc_10);
                                    }
                                    else if (!_loc_13)
                                    {
                                        _loc_7.remove(_loc_10);
                                        failed.push(_loc_10);
                                    }
                                }
                            }
                            else
                            {
                                if (!_loc_7.has(_loc_10))
                                {
                                }
                                if (ZPP_Collide.testCollide_safe(_loc_9, aabbShape.zpp_inner))
                                {
                                    _loc_7.push(_loc_10);
                                }
                            }
                        }
                        else if (param3)
                        {
                            if (!failed.has(_loc_10))
                            {
                                _loc_11 = _loc_9.aabb;
                                if (_loc_11.minx >= _loc_6.minx)
                                {
                                }
                                if (_loc_11.miny >= _loc_6.miny)
                                {
                                }
                                if (_loc_11.maxx <= _loc_6.maxx)
                                {
                                }
                                _loc_13 = _loc_11.maxy <= _loc_6.maxy;
                                if (!_loc_7.has(_loc_10))
                                {
                                }
                                if (_loc_13)
                                {
                                    _loc_7.push(_loc_10);
                                }
                                else if (!_loc_13)
                                {
                                    _loc_7.remove(_loc_10);
                                    failed.push(_loc_10);
                                }
                            }
                        }
                        else
                        {
                            if (!_loc_7.has(_loc_10))
                            {
                                _loc_11 = _loc_9.aabb;
                                if (_loc_11.minx >= _loc_6.minx)
                                {
                                }
                                if (_loc_11.miny >= _loc_6.miny)
                                {
                                }
                                if (_loc_11.maxx <= _loc_6.maxx)
                                {
                                }
                            }
                            if (_loc_11.maxy <= _loc_6.maxy)
                            {
                                _loc_7.push(_loc_10);
                            }
                        }
                    }
                }
                _loc_8 = _loc_8.next;
                if (_loc_8 != null)
                {
                }
            }while (_loc_8.aabb.minx <= _loc_6.maxx)
            failed.clear();
            return _loc_7;
        }// end function

        public function __sync(param1:ZPP_Shape) : void
        {
            var _loc_2:* = null as ZPP_Circle;
            var _loc_3:* = null as ZPP_Polygon;
            var _loc_4:* = NaN;
            var _loc_5:* = null as ZPP_Vec2;
            var _loc_6:* = null as ZPP_Vec2;
            var _loc_7:* = null as ZPP_Vec2;
            var _loc_8:* = null as ZPP_Vec2;
            var _loc_9:* = NaN;
            var _loc_10:* = null as ZPP_Vec2;
            var _loc_11:* = null as ZPP_Body;
            if (!space.continuous)
            {
                if (param1.zip_aabb)
                {
                    if (param1.body != null)
                    {
                        param1.zip_aabb = false;
                        if (param1.type == ZPP_Flags.id_ShapeType_CIRCLE)
                        {
                            _loc_2 = param1.circle;
                            if (_loc_2.zip_worldCOM)
                            {
                                if (_loc_2.body != null)
                                {
                                    _loc_2.zip_worldCOM = false;
                                    if (_loc_2.zip_localCOM)
                                    {
                                        _loc_2.zip_localCOM = false;
                                        if (_loc_2.type == ZPP_Flags.id_ShapeType_POLYGON)
                                        {
                                            _loc_3 = _loc_2.polygon;
                                            if (_loc_3.lverts.next == null)
                                            {
                                                throw "Error: An empty polygon has no meaningful localCOM";
                                            }
                                            if (_loc_3.lverts.next.next == null)
                                            {
                                                _loc_3.localCOMx = _loc_3.lverts.next.x;
                                                _loc_3.localCOMy = _loc_3.lverts.next.y;
                                            }
                                            else if (_loc_3.lverts.next.next.next == null)
                                            {
                                                _loc_3.localCOMx = _loc_3.lverts.next.x;
                                                _loc_3.localCOMy = _loc_3.lverts.next.y;
                                                _loc_4 = 1;
                                                _loc_3.localCOMx = _loc_3.localCOMx + _loc_3.lverts.next.next.x * _loc_4;
                                                _loc_3.localCOMy = _loc_3.localCOMy + _loc_3.lverts.next.next.y * _loc_4;
                                                _loc_4 = 0.5;
                                                _loc_3.localCOMx = _loc_3.localCOMx * _loc_4;
                                                _loc_3.localCOMy = _loc_3.localCOMy * _loc_4;
                                            }
                                            else
                                            {
                                                _loc_3.localCOMx = 0;
                                                _loc_3.localCOMy = 0;
                                                _loc_4 = 0;
                                                _loc_5 = _loc_3.lverts.next;
                                                _loc_6 = _loc_5;
                                                _loc_5 = _loc_5.next;
                                                _loc_7 = _loc_5;
                                                _loc_5 = _loc_5.next;
                                                while (_loc_5 != null)
                                                {
                                                    
                                                    _loc_8 = _loc_5;
                                                    _loc_4 = _loc_4 + _loc_7.x * (_loc_8.y - _loc_6.y);
                                                    _loc_9 = _loc_8.y * _loc_7.x - _loc_8.x * _loc_7.y;
                                                    _loc_3.localCOMx = _loc_3.localCOMx + (_loc_7.x + _loc_8.x) * _loc_9;
                                                    _loc_3.localCOMy = _loc_3.localCOMy + (_loc_7.y + _loc_8.y) * _loc_9;
                                                    _loc_6 = _loc_7;
                                                    _loc_7 = _loc_8;
                                                    _loc_5 = _loc_5.next;
                                                }
                                                _loc_5 = _loc_3.lverts.next;
                                                _loc_8 = _loc_5;
                                                _loc_4 = _loc_4 + _loc_7.x * (_loc_8.y - _loc_6.y);
                                                _loc_9 = _loc_8.y * _loc_7.x - _loc_8.x * _loc_7.y;
                                                _loc_3.localCOMx = _loc_3.localCOMx + (_loc_7.x + _loc_8.x) * _loc_9;
                                                _loc_3.localCOMy = _loc_3.localCOMy + (_loc_7.y + _loc_8.y) * _loc_9;
                                                _loc_6 = _loc_7;
                                                _loc_7 = _loc_8;
                                                _loc_5 = _loc_5.next;
                                                _loc_10 = _loc_5;
                                                _loc_4 = _loc_4 + _loc_7.x * (_loc_10.y - _loc_6.y);
                                                _loc_9 = _loc_10.y * _loc_7.x - _loc_10.x * _loc_7.y;
                                                _loc_3.localCOMx = _loc_3.localCOMx + (_loc_7.x + _loc_10.x) * _loc_9;
                                                _loc_3.localCOMy = _loc_3.localCOMy + (_loc_7.y + _loc_10.y) * _loc_9;
                                                _loc_4 = 1 / (3 * _loc_4);
                                                _loc_9 = _loc_4;
                                                _loc_3.localCOMx = _loc_3.localCOMx * _loc_9;
                                                _loc_3.localCOMy = _loc_3.localCOMy * _loc_9;
                                            }
                                        }
                                        if (_loc_2.wrap_localCOM != null)
                                        {
                                            _loc_2.wrap_localCOM.zpp_inner.x = _loc_2.localCOMx;
                                            _loc_2.wrap_localCOM.zpp_inner.y = _loc_2.localCOMy;
                                        }
                                    }
                                    _loc_11 = _loc_2.body;
                                    if (_loc_11.zip_axis)
                                    {
                                        _loc_11.zip_axis = false;
                                        _loc_11.axisx = Math.sin(_loc_11.rot);
                                        _loc_11.axisy = Math.cos(_loc_11.rot);
                                    }
                                    _loc_2.worldCOMx = _loc_2.body.posx + (_loc_2.body.axisy * _loc_2.localCOMx - _loc_2.body.axisx * _loc_2.localCOMy);
                                    _loc_2.worldCOMy = _loc_2.body.posy + (_loc_2.localCOMx * _loc_2.body.axisx + _loc_2.localCOMy * _loc_2.body.axisy);
                                }
                            }
                            _loc_4 = _loc_2.radius;
                            _loc_9 = _loc_2.radius;
                            _loc_2.aabb.minx = _loc_2.worldCOMx - _loc_4;
                            _loc_2.aabb.miny = _loc_2.worldCOMy - _loc_9;
                            _loc_2.aabb.maxx = _loc_2.worldCOMx + _loc_4;
                            _loc_2.aabb.maxy = _loc_2.worldCOMy + _loc_9;
                        }
                        else
                        {
                            _loc_3 = param1.polygon;
                            if (_loc_3.zip_gverts)
                            {
                                if (_loc_3.body != null)
                                {
                                    _loc_3.zip_gverts = false;
                                    _loc_3.validate_lverts();
                                    _loc_11 = _loc_3.body;
                                    if (_loc_11.zip_axis)
                                    {
                                        _loc_11.zip_axis = false;
                                        _loc_11.axisx = Math.sin(_loc_11.rot);
                                        _loc_11.axisy = Math.cos(_loc_11.rot);
                                    }
                                    _loc_5 = _loc_3.lverts.next;
                                    _loc_6 = _loc_3.gverts.next;
                                    while (_loc_6 != null)
                                    {
                                        
                                        _loc_7 = _loc_6;
                                        _loc_8 = _loc_5;
                                        _loc_5 = _loc_5.next;
                                        _loc_7.x = _loc_3.body.posx + (_loc_3.body.axisy * _loc_8.x - _loc_3.body.axisx * _loc_8.y);
                                        _loc_7.y = _loc_3.body.posy + (_loc_8.x * _loc_3.body.axisx + _loc_8.y * _loc_3.body.axisy);
                                        _loc_6 = _loc_6.next;
                                    }
                                }
                            }
                            if (_loc_3.lverts.next == null)
                            {
                                throw "Error: An empty polygon has no meaningful bounds";
                            }
                            _loc_5 = _loc_3.gverts.next;
                            _loc_3.aabb.minx = _loc_5.x;
                            _loc_3.aabb.miny = _loc_5.y;
                            _loc_3.aabb.maxx = _loc_5.x;
                            _loc_3.aabb.maxy = _loc_5.y;
                            _loc_6 = _loc_3.gverts.next.next;
                            while (_loc_6 != null)
                            {
                                
                                _loc_7 = _loc_6;
                                if (_loc_7.x < _loc_3.aabb.minx)
                                {
                                    _loc_3.aabb.minx = _loc_7.x;
                                }
                                if (_loc_7.x > _loc_3.aabb.maxx)
                                {
                                    _loc_3.aabb.maxx = _loc_7.x;
                                }
                                if (_loc_7.y < _loc_3.aabb.miny)
                                {
                                    _loc_3.aabb.miny = _loc_7.y;
                                }
                                if (_loc_7.y > _loc_3.aabb.maxy)
                                {
                                    _loc_3.aabb.maxy = _loc_7.y;
                                }
                                _loc_6 = _loc_6.next;
                            }
                        }
                    }
                }
            }
            return;
        }// end function

        public function __remove(param1:ZPP_Shape) : void
        {
            var _loc_2:* = param1.sweep;
            if (_loc_2.prev == null)
            {
                list = _loc_2.next;
            }
            else
            {
                _loc_2.prev.next = _loc_2.next;
            }
            if (_loc_2.next != null)
            {
                _loc_2.next.prev = _loc_2.prev;
            }
            param1.sweep = null;
            var _loc_3:* = _loc_2;
            _loc_3.prev = null;
            _loc_3.shape = null;
            _loc_3.aabb = null;
            _loc_3.next = ZPP_SweepData.zpp_pool;
            ZPP_SweepData.zpp_pool = _loc_3;
            return;
        }// end function

        public function __insert(param1:ZPP_Shape) : void
        {
            var _loc_2:* = null as ZPP_SweepData;
            if (ZPP_SweepData.zpp_pool == null)
            {
                _loc_2 = new ZPP_SweepData();
            }
            else
            {
                _loc_2 = ZPP_SweepData.zpp_pool;
                ZPP_SweepData.zpp_pool = _loc_2.next;
                _loc_2.next = null;
            }
            param1.sweep = _loc_2;
            _loc_2.shape = param1;
            _loc_2.aabb = param1.aabb;
            _loc_2.next = list;
            if (list != null)
            {
                list.prev = _loc_2;
            }
            list = _loc_2;
            return;
        }// end function

    }
}
