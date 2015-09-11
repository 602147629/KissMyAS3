package zpp_nape.util
{
    import flash.*;
    import flash.display.*;
    import flash.geom.*;
    import flash.system.*;
    import flash.utils.*;
    import nape.dynamics.*;
    import nape.geom.*;
    import nape.phys.*;
    import nape.shape.*;
    import nape.space.*;
    import nape.util.*;
    import zpp_nape.constraint.*;
    import zpp_nape.dynamics.*;
    import zpp_nape.geom.*;
    import zpp_nape.phys.*;
    import zpp_nape.shape.*;
    import zpp_nape.space.*;

    public class ZPP_BitmapDebug extends ZPP_Debug
    {
        public var transp:Boolean;
        public var shapeList:ShapeList;
        public var rect:Rectangle;
        public var peny:int;
        public var penx:int;
        public var outer_zn:BitmapDebug;
        public var filledXs:Array;
        public var filledVertices:Array;
        public var compoundstack:ZNPList_ZPP_Compound;
        public var colour:int;
        public var bytes:ByteArray;
        public var bodyList:BodyList;
        public var bitmap:Bitmap;
        public var bit:BitmapData;
        public var bgbytes:ByteArray;

        public function ZPP_BitmapDebug(param1:int = 0, param2:int = 0, param3:int = 0, param4:Boolean = false) : void
        {
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            if (Boot.skip_constructor)
            {
                return;
            }
            bodyList = null;
            shapeList = null;
            compoundstack = null;
            colour = 0;
            peny = 0;
            penx = 0;
            transp = false;
            bgbytes = null;
            bytes = null;
            bit = null;
            rect = null;
            bitmap = null;
            outer_zn = null;
            super(param1, param2);
            transp = param4;
            filledVertices = [];
            filledXs = [];
            bytes = new ByteArray();
            bytes.length = param1 * param2 << 2;
            bytes.endian = Endian.LITTLE_ENDIAN;
            bit = new BitmapData(param1, param2, param4, param4 ? (0) : (param3));
            rect = bit.rect;
            bgbytes = new ByteArray();
            bgbytes.length = bytes.length;
            bgbytes.endian = Endian.LITTLE_ENDIAN;
            setbg(param3);
            if (param4)
            {
                ApplicationDomain.currentDomain.domainMemory = bgbytes;
                _loc_5 = 0;
                _loc_6 = bytes.length >> 3;
                while (_loc_5 < _loc_6)
                {
                    
                    _loc_5++;
                    _loc_7 = _loc_5;
                }
                ApplicationDomain.currentDomain.domainMemory = bytes;
            }
            bitmap = new Bitmap(bit, PixelSnapping.NEVER, false);
            isbmp = true;
            d_bmp = this;
            return;
        }// end function

        public function setpixel(param1:int, param2:int, param3:int) : void
        {
            if (param1 >= 0)
            {
            }
            if (param1 < width)
            {
            }
            if (param2 >= 0)
            {
            }
            if (param2 < height)
            {
            }
            return;
        }// end function

        public function setpix(param1:int, param2:int) : void
        {
            return;
        }// end function

        public function setbg(param1:int) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            sup_setbg(param1);
            if (!transp)
            {
                bgbytes.position = 0;
                ApplicationDomain.currentDomain.domainMemory = bgbytes;
                _loc_2 = 0;
                _loc_3 = bytes.length >> 2;
                while (_loc_2 < _loc_3)
                {
                    
                    _loc_2++;
                    _loc_4 = _loc_2;
                }
                ApplicationDomain.currentDomain.domainMemory = bytes;
            }
            return;
        }// end function

        public function prepare() : void
        {
            ApplicationDomain.currentDomain.domainMemory = bytes;
            return;
        }// end function

        public function index(param1:int, param2:int) : int
        {
            return param2 * width + param1;
        }// end function

        public function flush() : void
        {
            bit.lock();
            bytes.position = 0;
            bit.setPixels(rect, bytes);
            bit.unlock();
            return;
        }// end function

        public function draw_space(param1:ZPP_Space, param2:ZPP_Mat23, param3:Number, param4:Boolean) : void
        {
            var _loc_5:* = null as BodyList;
            var _loc_6:* = null as BodyList;
            var _loc_7:* = null as Body;
            var _loc_8:* = null as ShapeList;
            var _loc_9:* = null as ShapeList;
            var _loc_10:* = null as Shape;
            var _loc_11:* = null as ZNPNode_ZPP_Body;
            var _loc_12:* = null as ZPP_Body;
            var _loc_13:* = null as ZNPNode_ZPP_Compound;
            var _loc_14:* = null as ZPP_Compound;
            var _loc_15:* = null as ZPP_Compound;
            var _loc_16:* = null as ArbiterIterator;
            var _loc_17:* = null as Space;
            var _loc_18:* = null as ZPP_SpaceArbiterList;
            var _loc_19:* = null as Arbiter;
            var _loc_20:* = 0;
            var _loc_21:* = null as ZNPNode_ZPP_Constraint;
            var _loc_22:* = null as ZPP_Constraint;
            if (outer.cullingEnabled)
            {
                if (outer.drawBodies)
                {
                    if (outer.drawBodyDetail)
                    {
                        _loc_6 = param1.bphase.bodiesInAABB(iport, false, false, null, bodyList);
                        bodyList = _loc_6;
                        _loc_5 = _loc_6;
                        while (_loc_5.zpp_inner.inner.head != null)
                        {
                            
                            _loc_7 = _loc_5.shift();
                            if (_loc_7.debugDraw)
                            {
                                draw_body(_loc_7.zpp_inner, param2, param3, param4);
                            }
                        }
                    }
                    else
                    {
                        _loc_9 = param1.bphase.shapesInAABB(iport, false, false, null, shapeList);
                        shapeList = _loc_9;
                        _loc_8 = _loc_9;
                        while (_loc_8.zpp_inner.inner.head != null)
                        {
                            
                            _loc_10 = _loc_8.shift();
                            if ((_loc_10.zpp_inner.body != null ? (_loc_10.zpp_inner.body.outer) : (null)).debugDraw)
                            {
                                draw_shape(_loc_10.zpp_inner, param2, param3, param4);
                            }
                        }
                    }
                }
            }
            else if (outer.drawBodies)
            {
                if (compoundstack == null)
                {
                    compoundstack = new ZNPList_ZPP_Compound();
                }
                _loc_11 = param1.bodies.head;
                while (_loc_11 != null)
                {
                    
                    _loc_12 = _loc_11.elt;
                    if (_loc_12.outer.debugDraw)
                    {
                        draw_body(_loc_12, param2, param3, param4);
                    }
                    _loc_11 = _loc_11.next;
                }
                _loc_13 = param1.compounds.head;
                while (_loc_13 != null)
                {
                    
                    _loc_14 = _loc_13.elt;
                    compoundstack.add(_loc_14);
                    _loc_13 = _loc_13.next;
                }
                while (compoundstack.head != null)
                {
                    
                    _loc_14 = compoundstack.pop_unsafe();
                    _loc_11 = _loc_14.bodies.head;
                    while (_loc_11 != null)
                    {
                        
                        _loc_12 = _loc_11.elt;
                        if (_loc_12.outer.debugDraw)
                        {
                            draw_body(_loc_12, param2, param3, param4);
                        }
                        _loc_11 = _loc_11.next;
                    }
                    _loc_13 = _loc_14.compounds.head;
                    while (_loc_13 != null)
                    {
                        
                        _loc_15 = _loc_13.elt;
                        compoundstack.add(_loc_15);
                        _loc_13 = _loc_13.next;
                    }
                }
            }
            if (!outer.drawCollisionArbiters)
            {
            }
            if (!outer.drawFluidArbiters)
            {
            }
            if (outer.drawSensorArbiters)
            {
                _loc_17 = param1.outer;
                if (_loc_17.zpp_inner.wrap_arbiters == null)
                {
                    _loc_18 = new ZPP_SpaceArbiterList();
                    _loc_18.space = _loc_17.zpp_inner;
                    _loc_17.zpp_inner.wrap_arbiters = _loc_18;
                }
                _loc_16 = _loc_17.zpp_inner.wrap_arbiters.iterator();
                do
                {
                    
                    _loc_16.zpp_critical = false;
                    _loc_20 = _loc_16.zpp_i;
                    (_loc_16.zpp_i + 1);
                    _loc_19 = _loc_16.zpp_inner.at(_loc_20);
                    draw_arbiter(_loc_19.zpp_inner, param2, param3, param4);
                    _loc_16.zpp_inner.zpp_inner.valmod();
                    _loc_20 = _loc_16.zpp_inner.zpp_gl();
                    _loc_16.zpp_critical = true;
                }while (_loc_16.zpp_i < _loc_20 ? (true) : (_loc_16.zpp_next = ArbiterIterator.zpp_pool, ArbiterIterator.zpp_pool = _loc_16, _loc_16.zpp_inner = null, false))
            }
            if (outer.drawConstraints)
            {
                if (compoundstack == null)
                {
                    compoundstack = new ZNPList_ZPP_Compound();
                }
                _loc_21 = param1.constraints.head;
                while (_loc_21 != null)
                {
                    
                    _loc_22 = _loc_21.elt;
                    if (_loc_22.active)
                    {
                    }
                    if (_loc_22.outer.debugDraw)
                    {
                        _loc_22.draw(outer);
                    }
                    _loc_21 = _loc_21.next;
                }
                _loc_13 = param1.compounds.head;
                while (_loc_13 != null)
                {
                    
                    _loc_14 = _loc_13.elt;
                    compoundstack.add(_loc_14);
                    _loc_13 = _loc_13.next;
                }
                while (compoundstack.head != null)
                {
                    
                    _loc_14 = compoundstack.pop_unsafe();
                    _loc_21 = _loc_14.constraints.head;
                    while (_loc_21 != null)
                    {
                        
                        _loc_22 = _loc_21.elt;
                        if (_loc_22.active)
                        {
                        }
                        if (_loc_22.outer.debugDraw)
                        {
                            _loc_22.draw(outer);
                        }
                        _loc_21 = _loc_21.next;
                    }
                    _loc_13 = _loc_14.compounds.head;
                    while (_loc_13 != null)
                    {
                        
                        _loc_15 = _loc_13.elt;
                        compoundstack.add(_loc_15);
                        _loc_13 = _loc_13.next;
                    }
                }
            }
            return;
        }// end function

        public function draw_shape(param1:ZPP_Shape, param2:ZPP_Mat23, param3:Number, param4:Boolean) : void
        {
            var _loc_6:* = 0;
            var _loc_7:* = NaN;
            var _loc_8:* = NaN;
            var _loc_9:* = NaN;
            var _loc_11:* = 0;
            var _loc_12:* = null as Body;
            var _loc_13:* = 0;
            var _loc_14:* = 0;
            var _loc_15:* = 0;
            var _loc_16:* = 0;
            var _loc_17:* = null as ZPP_Circle;
            var _loc_18:* = null as ZPP_Polygon;
            var _loc_19:* = null as ZPP_Vec2;
            var _loc_20:* = null as ZPP_Vec2;
            var _loc_21:* = null as ZPP_Vec2;
            var _loc_22:* = null as ZPP_Vec2;
            var _loc_23:* = null as ZPP_Vec2;
            var _loc_24:* = null as ZPP_Body;
            var _loc_25:* = NaN;
            var _loc_26:* = NaN;
            var _loc_27:* = NaN;
            var _loc_28:* = NaN;
            var _loc_29:* = null as ZPP_Polygon;
            var _loc_30:* = null as ZPP_Vec2;
            var _loc_31:* = null as ZPP_AABB;
            var _loc_32:* = NaN;
            var _loc_33:* = NaN;
            if (outer.colour == null)
            {
                _loc_6 = 16777215 * Math.exp((-param1.id % 500) / 1500);
            }
            else
            {
                _loc_6 = outer.colour(param1.id);
            }
            _loc_7 = ((_loc_6 & 16711680) >> 16) * 0.7;
            _loc_8 = ((_loc_6 & 65280) >> 8) * 0.7;
            _loc_9 = (_loc_6 & 255) * 0.7;
            var _loc_5:* = -16777216 | _loc_7 << 16 | _loc_8 << 8 | _loc_9;
            var _loc_10:* = param1.body;
            if (_loc_10 != null)
            {
                if (outer.colour == null)
                {
                    _loc_11 = 16777215 * Math.exp((-_loc_10.id % 500) / 1500);
                }
                else
                {
                    _loc_11 = outer.colour(_loc_10.id);
                }
                _loc_7 = ((_loc_11 & 16711680) >> 16) * 0.7;
                _loc_8 = ((_loc_11 & 65280) >> 8) * 0.7;
                _loc_9 = (_loc_11 & 255) * 0.7;
                if (_loc_10.space != null)
                {
                    _loc_12 = _loc_10.outer;
                    if (_loc_12.zpp_inner.space == null)
                    {
                        throw "Error: isSleeping makes no sense if the object is not contained within a Space";
                    }
                }
                if (_loc_12.zpp_inner.component.sleeping)
                {
                    _loc_7 = 0.4 * _loc_7 + 0.6 * bg_r;
                    _loc_8 = 0.4 * _loc_8 + 0.6 * bg_g;
                    _loc_9 = 0.4 * _loc_9 + 0.6 * bg_b;
                }
                _loc_6 = -16777216 | _loc_7 << 16 | _loc_8 << 8 | _loc_9;
                _loc_11 = _loc_5;
                _loc_13 = _loc_6;
                _loc_7 = 0.2;
                _loc_14 = (_loc_11 >> 16 & 255) * _loc_7 + (_loc_13 >> 16 & 255) * (1 - _loc_7);
                _loc_15 = (_loc_11 >> 8 & 255) * _loc_7 + (_loc_13 >> 8 & 255) * (1 - _loc_7);
                _loc_16 = (_loc_11 & 255) * _loc_7 + (_loc_13 & 255) * (1 - _loc_7);
                _loc_5 = -16777216 | _loc_14 << 16 | _loc_15 << 8 | _loc_16;
                colour = _loc_5;
                if (param1.type == ZPP_Flags.id_ShapeType_CIRCLE)
                {
                    _loc_17 = param1.circle;
                    if (_loc_17.zip_worldCOM)
                    {
                        if (_loc_17.body != null)
                        {
                            _loc_17.zip_worldCOM = false;
                            if (_loc_17.zip_localCOM)
                            {
                                _loc_17.zip_localCOM = false;
                                if (_loc_17.type == ZPP_Flags.id_ShapeType_POLYGON)
                                {
                                    _loc_18 = _loc_17.polygon;
                                    if (_loc_18.lverts.next == null)
                                    {
                                        throw "Error: An empty polygon has no meaningful localCOM";
                                    }
                                    if (_loc_18.lverts.next.next == null)
                                    {
                                        _loc_18.localCOMx = _loc_18.lverts.next.x;
                                        _loc_18.localCOMy = _loc_18.lverts.next.y;
                                    }
                                    else if (_loc_18.lverts.next.next.next == null)
                                    {
                                        _loc_18.localCOMx = _loc_18.lverts.next.x;
                                        _loc_18.localCOMy = _loc_18.lverts.next.y;
                                        _loc_7 = 1;
                                        _loc_18.localCOMx = _loc_18.localCOMx + _loc_18.lverts.next.next.x * _loc_7;
                                        _loc_18.localCOMy = _loc_18.localCOMy + _loc_18.lverts.next.next.y * _loc_7;
                                        _loc_7 = 0.5;
                                        _loc_18.localCOMx = _loc_18.localCOMx * _loc_7;
                                        _loc_18.localCOMy = _loc_18.localCOMy * _loc_7;
                                    }
                                    else
                                    {
                                        _loc_18.localCOMx = 0;
                                        _loc_18.localCOMy = 0;
                                        _loc_7 = 0;
                                        _loc_19 = _loc_18.lverts.next;
                                        _loc_20 = _loc_19;
                                        _loc_19 = _loc_19.next;
                                        _loc_21 = _loc_19;
                                        _loc_19 = _loc_19.next;
                                        while (_loc_19 != null)
                                        {
                                            
                                            _loc_22 = _loc_19;
                                            _loc_7 = _loc_7 + _loc_21.x * (_loc_22.y - _loc_20.y);
                                            _loc_8 = _loc_22.y * _loc_21.x - _loc_22.x * _loc_21.y;
                                            _loc_18.localCOMx = _loc_18.localCOMx + (_loc_21.x + _loc_22.x) * _loc_8;
                                            _loc_18.localCOMy = _loc_18.localCOMy + (_loc_21.y + _loc_22.y) * _loc_8;
                                            _loc_20 = _loc_21;
                                            _loc_21 = _loc_22;
                                            _loc_19 = _loc_19.next;
                                        }
                                        _loc_19 = _loc_18.lverts.next;
                                        _loc_22 = _loc_19;
                                        _loc_7 = _loc_7 + _loc_21.x * (_loc_22.y - _loc_20.y);
                                        _loc_8 = _loc_22.y * _loc_21.x - _loc_22.x * _loc_21.y;
                                        _loc_18.localCOMx = _loc_18.localCOMx + (_loc_21.x + _loc_22.x) * _loc_8;
                                        _loc_18.localCOMy = _loc_18.localCOMy + (_loc_21.y + _loc_22.y) * _loc_8;
                                        _loc_20 = _loc_21;
                                        _loc_21 = _loc_22;
                                        _loc_19 = _loc_19.next;
                                        _loc_23 = _loc_19;
                                        _loc_7 = _loc_7 + _loc_21.x * (_loc_23.y - _loc_20.y);
                                        _loc_8 = _loc_23.y * _loc_21.x - _loc_23.x * _loc_21.y;
                                        _loc_18.localCOMx = _loc_18.localCOMx + (_loc_21.x + _loc_23.x) * _loc_8;
                                        _loc_18.localCOMy = _loc_18.localCOMy + (_loc_21.y + _loc_23.y) * _loc_8;
                                        _loc_7 = 1 / (3 * _loc_7);
                                        _loc_8 = _loc_7;
                                        _loc_18.localCOMx = _loc_18.localCOMx * _loc_8;
                                        _loc_18.localCOMy = _loc_18.localCOMy * _loc_8;
                                    }
                                }
                                if (_loc_17.wrap_localCOM != null)
                                {
                                    _loc_17.wrap_localCOM.zpp_inner.x = _loc_17.localCOMx;
                                    _loc_17.wrap_localCOM.zpp_inner.y = _loc_17.localCOMy;
                                }
                            }
                            _loc_24 = _loc_17.body;
                            if (_loc_24.zip_axis)
                            {
                                _loc_24.zip_axis = false;
                                _loc_24.axisx = Math.sin(_loc_24.rot);
                                _loc_24.axisy = Math.cos(_loc_24.rot);
                            }
                            _loc_17.worldCOMx = _loc_17.body.posx + (_loc_17.body.axisy * _loc_17.localCOMx - _loc_17.body.axisx * _loc_17.localCOMy);
                            _loc_17.worldCOMy = _loc_17.body.posy + (_loc_17.localCOMx * _loc_17.body.axisx + _loc_17.localCOMy * _loc_17.body.axisy);
                        }
                    }
                    _loc_7 = _loc_17.worldCOMx;
                    _loc_8 = _loc_17.worldCOMy;
                    if (!param4)
                    {
                        _loc_9 = param2.a * _loc_7 + param2.b * _loc_8 + param2.tx;
                        _loc_8 = param2.c * _loc_7 + param2.d * _loc_8 + param2.ty;
                        _loc_7 = _loc_9;
                    }
                    penx = _loc_7 + 0.5;
                    peny = _loc_8 + 0.5;
                    __circle(penx, peny, _loc_17.radius * param3 + 0.5, colour);
                    if (outer.drawShapeAngleIndicators)
                    {
                        _loc_9 = _loc_17.worldCOMx + 0.3 * _loc_17.radius * _loc_10.axisy;
                        _loc_25 = _loc_17.worldCOMy + 0.3 * _loc_17.radius * _loc_10.axisx;
                        _loc_26 = _loc_17.worldCOMx + _loc_17.radius * _loc_10.axisy;
                        _loc_27 = _loc_17.worldCOMy + _loc_17.radius * _loc_10.axisx;
                        if (!param4)
                        {
                            _loc_28 = param2.a * _loc_9 + param2.b * _loc_25 + param2.tx;
                            _loc_25 = param2.c * _loc_9 + param2.d * _loc_25 + param2.ty;
                            _loc_9 = _loc_28;
                        }
                        if (!param4)
                        {
                            _loc_28 = param2.a * _loc_26 + param2.b * _loc_27 + param2.tx;
                            _loc_27 = param2.c * _loc_26 + param2.d * _loc_27 + param2.ty;
                            _loc_26 = _loc_28;
                        }
                        penx = _loc_9 + 0.5;
                        peny = _loc_25 + 0.5;
                        _loc_11 = _loc_26 + 0.5;
                        _loc_13 = _loc_27 + 0.5;
                        __line(penx, peny, _loc_11, _loc_13, colour);
                        penx = _loc_11;
                        peny = _loc_13;
                    }
                }
                else
                {
                    _loc_18 = param1.polygon;
                    if (_loc_18.zip_gverts)
                    {
                        if (_loc_18.body != null)
                        {
                            _loc_18.zip_gverts = false;
                            _loc_18.validate_lverts();
                            _loc_24 = _loc_18.body;
                            if (_loc_24.zip_axis)
                            {
                                _loc_24.zip_axis = false;
                                _loc_24.axisx = Math.sin(_loc_24.rot);
                                _loc_24.axisy = Math.cos(_loc_24.rot);
                            }
                            _loc_19 = _loc_18.lverts.next;
                            _loc_20 = _loc_18.gverts.next;
                            while (_loc_20 != null)
                            {
                                
                                _loc_21 = _loc_20;
                                _loc_22 = _loc_19;
                                _loc_19 = _loc_19.next;
                                _loc_21.x = _loc_18.body.posx + (_loc_18.body.axisy * _loc_22.x - _loc_18.body.axisx * _loc_22.y);
                                _loc_21.y = _loc_18.body.posy + (_loc_22.x * _loc_18.body.axisx + _loc_22.y * _loc_18.body.axisy);
                                _loc_20 = _loc_20.next;
                            }
                        }
                    }
                    _loc_19 = _loc_18.gverts.next;
                    _loc_7 = _loc_19.x;
                    _loc_8 = _loc_19.y;
                    if (!param4)
                    {
                        _loc_9 = param2.a * _loc_7 + param2.b * _loc_8 + param2.tx;
                        _loc_8 = param2.c * _loc_7 + param2.d * _loc_8 + param2.ty;
                        _loc_7 = _loc_9;
                    }
                    penx = _loc_7 + 0.5;
                    peny = _loc_8 + 0.5;
                    _loc_9 = _loc_7;
                    _loc_25 = _loc_8;
                    _loc_20 = _loc_18.gverts.next.next;
                    while (_loc_20 != null)
                    {
                        
                        _loc_21 = _loc_20;
                        _loc_7 = _loc_21.x;
                        _loc_8 = _loc_21.y;
                        if (!param4)
                        {
                            _loc_26 = param2.a * _loc_7 + param2.b * _loc_8 + param2.tx;
                            _loc_8 = param2.c * _loc_7 + param2.d * _loc_8 + param2.ty;
                            _loc_7 = _loc_26;
                        }
                        _loc_11 = _loc_7 + 0.5;
                        _loc_13 = _loc_8 + 0.5;
                        __line(penx, peny, _loc_11, _loc_13, colour);
                        penx = _loc_11;
                        peny = _loc_13;
                        _loc_20 = _loc_20.next;
                    }
                    _loc_11 = _loc_9 + 0.5;
                    _loc_13 = _loc_25 + 0.5;
                    __line(penx, peny, _loc_11, _loc_13, colour);
                    penx = _loc_11;
                    peny = _loc_13;
                    if (outer.drawShapeAngleIndicators)
                    {
                        if (_loc_18.zip_worldCOM)
                        {
                            if (_loc_18.body != null)
                            {
                                _loc_18.zip_worldCOM = false;
                                if (_loc_18.zip_localCOM)
                                {
                                    _loc_18.zip_localCOM = false;
                                    if (_loc_18.type == ZPP_Flags.id_ShapeType_POLYGON)
                                    {
                                        _loc_29 = _loc_18.polygon;
                                        if (_loc_29.lverts.next == null)
                                        {
                                            throw "Error: An empty polygon has no meaningful localCOM";
                                        }
                                        if (_loc_29.lverts.next.next == null)
                                        {
                                            _loc_29.localCOMx = _loc_29.lverts.next.x;
                                            _loc_29.localCOMy = _loc_29.lverts.next.y;
                                        }
                                        else if (_loc_29.lverts.next.next.next == null)
                                        {
                                            _loc_29.localCOMx = _loc_29.lverts.next.x;
                                            _loc_29.localCOMy = _loc_29.lverts.next.y;
                                            _loc_26 = 1;
                                            _loc_29.localCOMx = _loc_29.localCOMx + _loc_29.lverts.next.next.x * _loc_26;
                                            _loc_29.localCOMy = _loc_29.localCOMy + _loc_29.lverts.next.next.y * _loc_26;
                                            _loc_26 = 0.5;
                                            _loc_29.localCOMx = _loc_29.localCOMx * _loc_26;
                                            _loc_29.localCOMy = _loc_29.localCOMy * _loc_26;
                                        }
                                        else
                                        {
                                            _loc_29.localCOMx = 0;
                                            _loc_29.localCOMy = 0;
                                            _loc_26 = 0;
                                            _loc_20 = _loc_29.lverts.next;
                                            _loc_21 = _loc_20;
                                            _loc_20 = _loc_20.next;
                                            _loc_22 = _loc_20;
                                            _loc_20 = _loc_20.next;
                                            while (_loc_20 != null)
                                            {
                                                
                                                _loc_23 = _loc_20;
                                                _loc_26 = _loc_26 + _loc_22.x * (_loc_23.y - _loc_21.y);
                                                _loc_27 = _loc_23.y * _loc_22.x - _loc_23.x * _loc_22.y;
                                                _loc_29.localCOMx = _loc_29.localCOMx + (_loc_22.x + _loc_23.x) * _loc_27;
                                                _loc_29.localCOMy = _loc_29.localCOMy + (_loc_22.y + _loc_23.y) * _loc_27;
                                                _loc_21 = _loc_22;
                                                _loc_22 = _loc_23;
                                                _loc_20 = _loc_20.next;
                                            }
                                            _loc_20 = _loc_29.lverts.next;
                                            _loc_23 = _loc_20;
                                            _loc_26 = _loc_26 + _loc_22.x * (_loc_23.y - _loc_21.y);
                                            _loc_27 = _loc_23.y * _loc_22.x - _loc_23.x * _loc_22.y;
                                            _loc_29.localCOMx = _loc_29.localCOMx + (_loc_22.x + _loc_23.x) * _loc_27;
                                            _loc_29.localCOMy = _loc_29.localCOMy + (_loc_22.y + _loc_23.y) * _loc_27;
                                            _loc_21 = _loc_22;
                                            _loc_22 = _loc_23;
                                            _loc_20 = _loc_20.next;
                                            _loc_30 = _loc_20;
                                            _loc_26 = _loc_26 + _loc_22.x * (_loc_30.y - _loc_21.y);
                                            _loc_27 = _loc_30.y * _loc_22.x - _loc_30.x * _loc_22.y;
                                            _loc_29.localCOMx = _loc_29.localCOMx + (_loc_22.x + _loc_30.x) * _loc_27;
                                            _loc_29.localCOMy = _loc_29.localCOMy + (_loc_22.y + _loc_30.y) * _loc_27;
                                            _loc_26 = 1 / (3 * _loc_26);
                                            _loc_27 = _loc_26;
                                            _loc_29.localCOMx = _loc_29.localCOMx * _loc_27;
                                            _loc_29.localCOMy = _loc_29.localCOMy * _loc_27;
                                        }
                                    }
                                    if (_loc_18.wrap_localCOM != null)
                                    {
                                        _loc_18.wrap_localCOM.zpp_inner.x = _loc_18.localCOMx;
                                        _loc_18.wrap_localCOM.zpp_inner.y = _loc_18.localCOMy;
                                    }
                                }
                                _loc_24 = _loc_18.body;
                                if (_loc_24.zip_axis)
                                {
                                    _loc_24.zip_axis = false;
                                    _loc_24.axisx = Math.sin(_loc_24.rot);
                                    _loc_24.axisy = Math.cos(_loc_24.rot);
                                }
                                _loc_18.worldCOMx = _loc_18.body.posx + (_loc_18.body.axisy * _loc_18.localCOMx - _loc_18.body.axisx * _loc_18.localCOMy);
                                _loc_18.worldCOMy = _loc_18.body.posy + (_loc_18.localCOMx * _loc_18.body.axisx + _loc_18.localCOMy * _loc_18.body.axisy);
                            }
                        }
                        if (param4)
                        {
                            _loc_7 = _loc_18.worldCOMx;
                            _loc_8 = _loc_18.worldCOMy;
                        }
                        else
                        {
                            _loc_7 = param2.a * _loc_18.worldCOMx + param2.b * _loc_18.worldCOMy + param2.tx;
                            _loc_8 = param2.c * _loc_18.worldCOMx + param2.d * _loc_18.worldCOMy + param2.ty;
                        }
                        penx = _loc_7 + 0.5;
                        peny = _loc_8 + 0.5;
                        _loc_11 = _loc_9 + 0.5;
                        _loc_13 = _loc_25 + 0.5;
                        __line(penx, peny, _loc_11, _loc_13, colour);
                        penx = _loc_11;
                        peny = _loc_13;
                    }
                }
                if (outer.drawShapeDetail)
                {
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
                                    _loc_18 = param1.polygon;
                                    if (_loc_18.lverts.next == null)
                                    {
                                        throw "Error: An empty polygon has no meaningful localCOM";
                                    }
                                    if (_loc_18.lverts.next.next == null)
                                    {
                                        _loc_18.localCOMx = _loc_18.lverts.next.x;
                                        _loc_18.localCOMy = _loc_18.lverts.next.y;
                                    }
                                    else if (_loc_18.lverts.next.next.next == null)
                                    {
                                        _loc_18.localCOMx = _loc_18.lverts.next.x;
                                        _loc_18.localCOMy = _loc_18.lverts.next.y;
                                        _loc_7 = 1;
                                        _loc_18.localCOMx = _loc_18.localCOMx + _loc_18.lverts.next.next.x * _loc_7;
                                        _loc_18.localCOMy = _loc_18.localCOMy + _loc_18.lverts.next.next.y * _loc_7;
                                        _loc_7 = 0.5;
                                        _loc_18.localCOMx = _loc_18.localCOMx * _loc_7;
                                        _loc_18.localCOMy = _loc_18.localCOMy * _loc_7;
                                    }
                                    else
                                    {
                                        _loc_18.localCOMx = 0;
                                        _loc_18.localCOMy = 0;
                                        _loc_7 = 0;
                                        _loc_19 = _loc_18.lverts.next;
                                        _loc_20 = _loc_19;
                                        _loc_19 = _loc_19.next;
                                        _loc_21 = _loc_19;
                                        _loc_19 = _loc_19.next;
                                        while (_loc_19 != null)
                                        {
                                            
                                            _loc_22 = _loc_19;
                                            _loc_7 = _loc_7 + _loc_21.x * (_loc_22.y - _loc_20.y);
                                            _loc_8 = _loc_22.y * _loc_21.x - _loc_22.x * _loc_21.y;
                                            _loc_18.localCOMx = _loc_18.localCOMx + (_loc_21.x + _loc_22.x) * _loc_8;
                                            _loc_18.localCOMy = _loc_18.localCOMy + (_loc_21.y + _loc_22.y) * _loc_8;
                                            _loc_20 = _loc_21;
                                            _loc_21 = _loc_22;
                                            _loc_19 = _loc_19.next;
                                        }
                                        _loc_19 = _loc_18.lverts.next;
                                        _loc_22 = _loc_19;
                                        _loc_7 = _loc_7 + _loc_21.x * (_loc_22.y - _loc_20.y);
                                        _loc_8 = _loc_22.y * _loc_21.x - _loc_22.x * _loc_21.y;
                                        _loc_18.localCOMx = _loc_18.localCOMx + (_loc_21.x + _loc_22.x) * _loc_8;
                                        _loc_18.localCOMy = _loc_18.localCOMy + (_loc_21.y + _loc_22.y) * _loc_8;
                                        _loc_20 = _loc_21;
                                        _loc_21 = _loc_22;
                                        _loc_19 = _loc_19.next;
                                        _loc_23 = _loc_19;
                                        _loc_7 = _loc_7 + _loc_21.x * (_loc_23.y - _loc_20.y);
                                        _loc_8 = _loc_23.y * _loc_21.x - _loc_23.x * _loc_21.y;
                                        _loc_18.localCOMx = _loc_18.localCOMx + (_loc_21.x + _loc_23.x) * _loc_8;
                                        _loc_18.localCOMy = _loc_18.localCOMy + (_loc_21.y + _loc_23.y) * _loc_8;
                                        _loc_7 = 1 / (3 * _loc_7);
                                        _loc_8 = _loc_7;
                                        _loc_18.localCOMx = _loc_18.localCOMx * _loc_8;
                                        _loc_18.localCOMy = _loc_18.localCOMy * _loc_8;
                                    }
                                }
                                if (param1.wrap_localCOM != null)
                                {
                                    param1.wrap_localCOM.zpp_inner.x = param1.localCOMx;
                                    param1.wrap_localCOM.zpp_inner.y = param1.localCOMy;
                                }
                            }
                            _loc_24 = param1.body;
                            if (_loc_24.zip_axis)
                            {
                                _loc_24.zip_axis = false;
                                _loc_24.axisx = Math.sin(_loc_24.rot);
                                _loc_24.axisy = Math.cos(_loc_24.rot);
                            }
                            param1.worldCOMx = param1.body.posx + (param1.body.axisy * param1.localCOMx - param1.body.axisx * param1.localCOMy);
                            param1.worldCOMy = param1.body.posy + (param1.localCOMx * param1.body.axisx + param1.localCOMy * param1.body.axisy);
                        }
                    }
                    _loc_11 = _loc_5;
                    _loc_13 = 16711680;
                    _loc_7 = 0.8;
                    _loc_14 = (_loc_11 >> 16 & 255) * _loc_7 + (_loc_13 >> 16 & 255) * (1 - _loc_7);
                    _loc_15 = (_loc_11 >> 8 & 255) * _loc_7 + (_loc_13 >> 8 & 255) * (1 - _loc_7);
                    _loc_16 = (_loc_11 & 255) * _loc_7 + (_loc_13 & 255) * (1 - _loc_7);
                    colour = -16777216 | _loc_14 << 16 | _loc_15 << 8 | _loc_16;
                    _loc_7 = 0;
                    _loc_8 = 0;
                    if (param4)
                    {
                        _loc_7 = param1.worldCOMx;
                        _loc_8 = param1.worldCOMy;
                    }
                    else
                    {
                        _loc_7 = param2.a * param1.worldCOMx + param2.b * param1.worldCOMy + param2.tx;
                        _loc_8 = param2.c * param1.worldCOMx + param2.d * param1.worldCOMy + param2.ty;
                    }
                    penx = _loc_7 + 0.5;
                    peny = _loc_8 + 0.5;
                    __circle(penx, peny, 1.5, colour);
                    if (param1.zip_aabb)
                    {
                        if (param1.body != null)
                        {
                            param1.zip_aabb = false;
                            if (param1.type == ZPP_Flags.id_ShapeType_CIRCLE)
                            {
                                _loc_17 = param1.circle;
                                if (_loc_17.zip_worldCOM)
                                {
                                    if (_loc_17.body != null)
                                    {
                                        _loc_17.zip_worldCOM = false;
                                        if (_loc_17.zip_localCOM)
                                        {
                                            _loc_17.zip_localCOM = false;
                                            if (_loc_17.type == ZPP_Flags.id_ShapeType_POLYGON)
                                            {
                                                _loc_18 = _loc_17.polygon;
                                                if (_loc_18.lverts.next == null)
                                                {
                                                    throw "Error: An empty polygon has no meaningful localCOM";
                                                }
                                                if (_loc_18.lverts.next.next == null)
                                                {
                                                    _loc_18.localCOMx = _loc_18.lverts.next.x;
                                                    _loc_18.localCOMy = _loc_18.lverts.next.y;
                                                }
                                                else if (_loc_18.lverts.next.next.next == null)
                                                {
                                                    _loc_18.localCOMx = _loc_18.lverts.next.x;
                                                    _loc_18.localCOMy = _loc_18.lverts.next.y;
                                                    _loc_9 = 1;
                                                    _loc_18.localCOMx = _loc_18.localCOMx + _loc_18.lverts.next.next.x * _loc_9;
                                                    _loc_18.localCOMy = _loc_18.localCOMy + _loc_18.lverts.next.next.y * _loc_9;
                                                    _loc_9 = 0.5;
                                                    _loc_18.localCOMx = _loc_18.localCOMx * _loc_9;
                                                    _loc_18.localCOMy = _loc_18.localCOMy * _loc_9;
                                                }
                                                else
                                                {
                                                    _loc_18.localCOMx = 0;
                                                    _loc_18.localCOMy = 0;
                                                    _loc_9 = 0;
                                                    _loc_19 = _loc_18.lverts.next;
                                                    _loc_20 = _loc_19;
                                                    _loc_19 = _loc_19.next;
                                                    _loc_21 = _loc_19;
                                                    _loc_19 = _loc_19.next;
                                                    while (_loc_19 != null)
                                                    {
                                                        
                                                        _loc_22 = _loc_19;
                                                        _loc_9 = _loc_9 + _loc_21.x * (_loc_22.y - _loc_20.y);
                                                        _loc_25 = _loc_22.y * _loc_21.x - _loc_22.x * _loc_21.y;
                                                        _loc_18.localCOMx = _loc_18.localCOMx + (_loc_21.x + _loc_22.x) * _loc_25;
                                                        _loc_18.localCOMy = _loc_18.localCOMy + (_loc_21.y + _loc_22.y) * _loc_25;
                                                        _loc_20 = _loc_21;
                                                        _loc_21 = _loc_22;
                                                        _loc_19 = _loc_19.next;
                                                    }
                                                    _loc_19 = _loc_18.lverts.next;
                                                    _loc_22 = _loc_19;
                                                    _loc_9 = _loc_9 + _loc_21.x * (_loc_22.y - _loc_20.y);
                                                    _loc_25 = _loc_22.y * _loc_21.x - _loc_22.x * _loc_21.y;
                                                    _loc_18.localCOMx = _loc_18.localCOMx + (_loc_21.x + _loc_22.x) * _loc_25;
                                                    _loc_18.localCOMy = _loc_18.localCOMy + (_loc_21.y + _loc_22.y) * _loc_25;
                                                    _loc_20 = _loc_21;
                                                    _loc_21 = _loc_22;
                                                    _loc_19 = _loc_19.next;
                                                    _loc_23 = _loc_19;
                                                    _loc_9 = _loc_9 + _loc_21.x * (_loc_23.y - _loc_20.y);
                                                    _loc_25 = _loc_23.y * _loc_21.x - _loc_23.x * _loc_21.y;
                                                    _loc_18.localCOMx = _loc_18.localCOMx + (_loc_21.x + _loc_23.x) * _loc_25;
                                                    _loc_18.localCOMy = _loc_18.localCOMy + (_loc_21.y + _loc_23.y) * _loc_25;
                                                    _loc_9 = 1 / (3 * _loc_9);
                                                    _loc_25 = _loc_9;
                                                    _loc_18.localCOMx = _loc_18.localCOMx * _loc_25;
                                                    _loc_18.localCOMy = _loc_18.localCOMy * _loc_25;
                                                }
                                            }
                                            if (_loc_17.wrap_localCOM != null)
                                            {
                                                _loc_17.wrap_localCOM.zpp_inner.x = _loc_17.localCOMx;
                                                _loc_17.wrap_localCOM.zpp_inner.y = _loc_17.localCOMy;
                                            }
                                        }
                                        _loc_24 = _loc_17.body;
                                        if (_loc_24.zip_axis)
                                        {
                                            _loc_24.zip_axis = false;
                                            _loc_24.axisx = Math.sin(_loc_24.rot);
                                            _loc_24.axisy = Math.cos(_loc_24.rot);
                                        }
                                        _loc_17.worldCOMx = _loc_17.body.posx + (_loc_17.body.axisy * _loc_17.localCOMx - _loc_17.body.axisx * _loc_17.localCOMy);
                                        _loc_17.worldCOMy = _loc_17.body.posy + (_loc_17.localCOMx * _loc_17.body.axisx + _loc_17.localCOMy * _loc_17.body.axisy);
                                    }
                                }
                                _loc_9 = _loc_17.radius;
                                _loc_25 = _loc_17.radius;
                                _loc_17.aabb.minx = _loc_17.worldCOMx - _loc_9;
                                _loc_17.aabb.miny = _loc_17.worldCOMy - _loc_25;
                                _loc_17.aabb.maxx = _loc_17.worldCOMx + _loc_9;
                                _loc_17.aabb.maxy = _loc_17.worldCOMy + _loc_25;
                            }
                            else
                            {
                                _loc_18 = param1.polygon;
                                if (_loc_18.zip_gverts)
                                {
                                    if (_loc_18.body != null)
                                    {
                                        _loc_18.zip_gverts = false;
                                        _loc_18.validate_lverts();
                                        _loc_24 = _loc_18.body;
                                        if (_loc_24.zip_axis)
                                        {
                                            _loc_24.zip_axis = false;
                                            _loc_24.axisx = Math.sin(_loc_24.rot);
                                            _loc_24.axisy = Math.cos(_loc_24.rot);
                                        }
                                        _loc_19 = _loc_18.lverts.next;
                                        _loc_20 = _loc_18.gverts.next;
                                        while (_loc_20 != null)
                                        {
                                            
                                            _loc_21 = _loc_20;
                                            _loc_22 = _loc_19;
                                            _loc_19 = _loc_19.next;
                                            _loc_21.x = _loc_18.body.posx + (_loc_18.body.axisy * _loc_22.x - _loc_18.body.axisx * _loc_22.y);
                                            _loc_21.y = _loc_18.body.posy + (_loc_22.x * _loc_18.body.axisx + _loc_22.y * _loc_18.body.axisy);
                                            _loc_20 = _loc_20.next;
                                        }
                                    }
                                }
                                if (_loc_18.lverts.next == null)
                                {
                                    throw "Error: An empty polygon has no meaningful bounds";
                                }
                                _loc_19 = _loc_18.gverts.next;
                                _loc_18.aabb.minx = _loc_19.x;
                                _loc_18.aabb.miny = _loc_19.y;
                                _loc_18.aabb.maxx = _loc_19.x;
                                _loc_18.aabb.maxy = _loc_19.y;
                                _loc_20 = _loc_18.gverts.next.next;
                                while (_loc_20 != null)
                                {
                                    
                                    _loc_21 = _loc_20;
                                    if (_loc_21.x < _loc_18.aabb.minx)
                                    {
                                        _loc_18.aabb.minx = _loc_21.x;
                                    }
                                    if (_loc_21.x > _loc_18.aabb.maxx)
                                    {
                                        _loc_18.aabb.maxx = _loc_21.x;
                                    }
                                    if (_loc_21.y < _loc_18.aabb.miny)
                                    {
                                        _loc_18.aabb.miny = _loc_21.y;
                                    }
                                    if (_loc_21.y > _loc_18.aabb.maxy)
                                    {
                                        _loc_18.aabb.maxy = _loc_21.y;
                                    }
                                    _loc_20 = _loc_20.next;
                                }
                            }
                        }
                    }
                    if (param4)
                    {
                        __aabb(param1.aabb, colour);
                    }
                    else
                    {
                        _loc_9 = 0;
                        _loc_25 = 0;
                        _loc_9 = param2.a * param1.aabb.minx + param2.b * param1.aabb.miny + param2.tx;
                        _loc_25 = param2.c * param1.aabb.minx + param2.d * param1.aabb.miny + param2.ty;
                        _loc_31 = param1.aabb;
                        _loc_26 = _loc_31.maxx - _loc_31.minx;
                        _loc_27 = 0;
                        _loc_28 = param2.a * _loc_26 + param2.b * _loc_27;
                        _loc_27 = param2.c * _loc_26 + param2.d * _loc_27;
                        _loc_26 = _loc_28;
                        _loc_28 = 0;
                        _loc_31 = param1.aabb;
                        _loc_32 = _loc_31.maxy - _loc_31.miny;
                        _loc_33 = param2.a * _loc_28 + param2.b * _loc_32;
                        _loc_32 = param2.c * _loc_28 + param2.d * _loc_32;
                        _loc_28 = _loc_33;
                        penx = _loc_9 + 0.5;
                        peny = _loc_25 + 0.5;
                        _loc_11 = _loc_9 + _loc_26 + 0.5;
                        _loc_13 = _loc_25 + _loc_27 + 0.5;
                        __line(penx, peny, _loc_11, _loc_13, colour);
                        penx = _loc_11;
                        peny = _loc_13;
                        _loc_11 = _loc_9 + _loc_26 + _loc_28 + 0.5;
                        _loc_13 = _loc_25 + _loc_27 + _loc_32 + 0.5;
                        __line(penx, peny, _loc_11, _loc_13, colour);
                        penx = _loc_11;
                        peny = _loc_13;
                        _loc_11 = _loc_9 + _loc_28 + 0.5;
                        _loc_13 = _loc_25 + _loc_32 + 0.5;
                        __line(penx, peny, _loc_11, _loc_13, colour);
                        penx = _loc_11;
                        peny = _loc_13;
                        _loc_11 = _loc_9 + 0.5;
                        _loc_13 = _loc_25 + 0.5;
                        __line(penx, peny, _loc_11, _loc_13, colour);
                        penx = _loc_11;
                        peny = _loc_13;
                    }
                }
            }
            return;
        }// end function

        public function draw_compound(param1:ZPP_Compound, param2:ZPP_Mat23, param3:Number, param4:Boolean) : void
        {
            var _loc_6:* = null as ZPP_Compound;
            var _loc_8:* = null as ZPP_Body;
            var _loc_10:* = null as ZPP_Constraint;
            var _loc_5:* = param1.compounds.head;
            while (_loc_5 != null)
            {
                
                _loc_6 = _loc_5.elt;
                draw_compound(_loc_6, param2, param3, param4);
                _loc_5 = _loc_5.next;
            }
            var _loc_7:* = param1.bodies.head;
            while (_loc_7 != null)
            {
                
                _loc_8 = _loc_7.elt;
                if (_loc_8.outer.debugDraw)
                {
                    draw_body(_loc_8, param2, param3, param4);
                }
                _loc_7 = _loc_7.next;
            }
            var _loc_9:* = param1.constraints.head;
            while (_loc_9 != null)
            {
                
                _loc_10 = _loc_9.elt;
                if (_loc_10.active)
                {
                }
                if (_loc_10.outer.debugDraw)
                {
                    _loc_10.draw(outer);
                }
                _loc_9 = _loc_9.next;
            }
            return;
        }// end function

        public function draw_body(param1:ZPP_Body, param2:ZPP_Mat23, param3:Number, param4:Boolean) : void
        {
            var _loc_5:* = null as ZNPNode_ZPP_Shape;
            var _loc_6:* = null as ZPP_Shape;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_9:* = NaN;
            var _loc_10:* = NaN;
            var _loc_11:* = NaN;
            var _loc_12:* = null as Body;
            var _loc_13:* = 0;
            var _loc_14:* = 0;
            var _loc_15:* = 0;
            var _loc_16:* = 0;
            var _loc_17:* = NaN;
            var _loc_18:* = null as ZPP_Circle;
            var _loc_19:* = null as ZPP_Polygon;
            var _loc_20:* = NaN;
            var _loc_21:* = null as ZPP_Vec2;
            var _loc_22:* = null as ZPP_Vec2;
            var _loc_23:* = null as ZPP_Vec2;
            var _loc_24:* = null as ZPP_Vec2;
            var _loc_25:* = NaN;
            var _loc_26:* = null as ZPP_Vec2;
            var _loc_27:* = null as ZPP_Body;
            var _loc_28:* = null as ZPP_AABB;
            var _loc_29:* = null as ZPP_AABB;
            var _loc_30:* = NaN;
            var _loc_31:* = NaN;
            var _loc_32:* = NaN;
            var _loc_33:* = NaN;
            var _loc_34:* = NaN;
            _loc_5 = param1.shapes.head;
            while (_loc_5 != null)
            {
                
                _loc_6 = _loc_5.elt;
                draw_shape(_loc_6, param2, param3, param4);
                _loc_5 = _loc_5.next;
            }
            if (outer.drawBodyDetail)
            {
                if (outer.colour == null)
                {
                    _loc_8 = 16777215 * Math.exp((-param1.id % 500) / 1500);
                }
                else
                {
                    _loc_8 = outer.colour(param1.id);
                }
                _loc_9 = ((_loc_8 & 16711680) >> 16) * 0.7;
                _loc_10 = ((_loc_8 & 65280) >> 8) * 0.7;
                _loc_11 = (_loc_8 & 255) * 0.7;
                if (param1.space != null)
                {
                    _loc_12 = param1.outer;
                    if (_loc_12.zpp_inner.space == null)
                    {
                        throw "Error: isSleeping makes no sense if the object is not contained within a Space";
                    }
                }
                if (_loc_12.zpp_inner.component.sleeping)
                {
                    _loc_9 = 0.4 * _loc_9 + 0.6 * bg_r;
                    _loc_10 = 0.4 * _loc_10 + 0.6 * bg_g;
                    _loc_11 = 0.4 * _loc_11 + 0.6 * bg_b;
                }
                _loc_7 = -16777216 | _loc_9 << 16 | _loc_10 << 8 | _loc_11;
                _loc_8 = _loc_7;
                _loc_13 = 16711680;
                _loc_9 = 0.8;
                _loc_14 = (_loc_8 >> 16 & 255) * _loc_9 + (_loc_13 >> 16 & 255) * (1 - _loc_9);
                _loc_15 = (_loc_8 >> 8 & 255) * _loc_9 + (_loc_13 >> 8 & 255) * (1 - _loc_9);
                _loc_16 = (_loc_8 & 255) * _loc_9 + (_loc_13 & 255) * (1 - _loc_9);
                colour = -16777216 | _loc_14 << 16 | _loc_15 << 8 | _loc_16;
                _loc_9 = 0;
                _loc_10 = 0;
                _loc_11 = 0;
                _loc_17 = 0;
                if (param1.shapes.head != null)
                {
                    param1.validate_worldCOM();
                    if (param4)
                    {
                        _loc_9 = param1.worldCOMx;
                        _loc_10 = param1.worldCOMy;
                    }
                    else
                    {
                        _loc_9 = param2.a * param1.worldCOMx + param2.b * param1.worldCOMy + param2.tx;
                        _loc_10 = param2.c * param1.worldCOMx + param2.d * param1.worldCOMy + param2.ty;
                    }
                    penx = _loc_9 + 0.5;
                    peny = _loc_10 + 0.5;
                    __circle(penx, peny, 1.5, colour);
                    if (param1.shapes.head == null)
                    {
                        throw "Error: Body bounds only makes sense if it contains shapes";
                    }
                    if (param1.zip_aabb)
                    {
                        param1.zip_aabb = false;
                        param1.aabb.minx = 17899999999999994000000000000;
                        param1.aabb.miny = 17899999999999994000000000000;
                        param1.aabb.maxx = -17899999999999994000000000000;
                        param1.aabb.maxy = -17899999999999994000000000000;
                        _loc_5 = param1.shapes.head;
                        while (_loc_5 != null)
                        {
                            
                            _loc_6 = _loc_5.elt;
                            if (_loc_6.zip_aabb)
                            {
                                if (_loc_6.body != null)
                                {
                                    _loc_6.zip_aabb = false;
                                    if (_loc_6.type == ZPP_Flags.id_ShapeType_CIRCLE)
                                    {
                                        _loc_18 = _loc_6.circle;
                                        if (_loc_18.zip_worldCOM)
                                        {
                                            if (_loc_18.body != null)
                                            {
                                                _loc_18.zip_worldCOM = false;
                                                if (_loc_18.zip_localCOM)
                                                {
                                                    _loc_18.zip_localCOM = false;
                                                    if (_loc_18.type == ZPP_Flags.id_ShapeType_POLYGON)
                                                    {
                                                        _loc_19 = _loc_18.polygon;
                                                        if (_loc_19.lverts.next == null)
                                                        {
                                                            throw "Error: An empty polygon has no meaningful localCOM";
                                                        }
                                                        if (_loc_19.lverts.next.next == null)
                                                        {
                                                            _loc_19.localCOMx = _loc_19.lverts.next.x;
                                                            _loc_19.localCOMy = _loc_19.lverts.next.y;
                                                        }
                                                        else if (_loc_19.lverts.next.next.next == null)
                                                        {
                                                            _loc_19.localCOMx = _loc_19.lverts.next.x;
                                                            _loc_19.localCOMy = _loc_19.lverts.next.y;
                                                            _loc_20 = 1;
                                                            _loc_19.localCOMx = _loc_19.localCOMx + _loc_19.lverts.next.next.x * _loc_20;
                                                            _loc_19.localCOMy = _loc_19.localCOMy + _loc_19.lverts.next.next.y * _loc_20;
                                                            _loc_20 = 0.5;
                                                            _loc_19.localCOMx = _loc_19.localCOMx * _loc_20;
                                                            _loc_19.localCOMy = _loc_19.localCOMy * _loc_20;
                                                        }
                                                        else
                                                        {
                                                            _loc_19.localCOMx = 0;
                                                            _loc_19.localCOMy = 0;
                                                            _loc_20 = 0;
                                                            _loc_21 = _loc_19.lverts.next;
                                                            _loc_22 = _loc_21;
                                                            _loc_21 = _loc_21.next;
                                                            _loc_23 = _loc_21;
                                                            _loc_21 = _loc_21.next;
                                                            while (_loc_21 != null)
                                                            {
                                                                
                                                                _loc_24 = _loc_21;
                                                                _loc_20 = _loc_20 + _loc_23.x * (_loc_24.y - _loc_22.y);
                                                                _loc_25 = _loc_24.y * _loc_23.x - _loc_24.x * _loc_23.y;
                                                                _loc_19.localCOMx = _loc_19.localCOMx + (_loc_23.x + _loc_24.x) * _loc_25;
                                                                _loc_19.localCOMy = _loc_19.localCOMy + (_loc_23.y + _loc_24.y) * _loc_25;
                                                                _loc_22 = _loc_23;
                                                                _loc_23 = _loc_24;
                                                                _loc_21 = _loc_21.next;
                                                            }
                                                            _loc_21 = _loc_19.lverts.next;
                                                            _loc_24 = _loc_21;
                                                            _loc_20 = _loc_20 + _loc_23.x * (_loc_24.y - _loc_22.y);
                                                            _loc_25 = _loc_24.y * _loc_23.x - _loc_24.x * _loc_23.y;
                                                            _loc_19.localCOMx = _loc_19.localCOMx + (_loc_23.x + _loc_24.x) * _loc_25;
                                                            _loc_19.localCOMy = _loc_19.localCOMy + (_loc_23.y + _loc_24.y) * _loc_25;
                                                            _loc_22 = _loc_23;
                                                            _loc_23 = _loc_24;
                                                            _loc_21 = _loc_21.next;
                                                            _loc_26 = _loc_21;
                                                            _loc_20 = _loc_20 + _loc_23.x * (_loc_26.y - _loc_22.y);
                                                            _loc_25 = _loc_26.y * _loc_23.x - _loc_26.x * _loc_23.y;
                                                            _loc_19.localCOMx = _loc_19.localCOMx + (_loc_23.x + _loc_26.x) * _loc_25;
                                                            _loc_19.localCOMy = _loc_19.localCOMy + (_loc_23.y + _loc_26.y) * _loc_25;
                                                            _loc_20 = 1 / (3 * _loc_20);
                                                            _loc_25 = _loc_20;
                                                            _loc_19.localCOMx = _loc_19.localCOMx * _loc_25;
                                                            _loc_19.localCOMy = _loc_19.localCOMy * _loc_25;
                                                        }
                                                    }
                                                    if (_loc_18.wrap_localCOM != null)
                                                    {
                                                        _loc_18.wrap_localCOM.zpp_inner.x = _loc_18.localCOMx;
                                                        _loc_18.wrap_localCOM.zpp_inner.y = _loc_18.localCOMy;
                                                    }
                                                }
                                                _loc_27 = _loc_18.body;
                                                if (_loc_27.zip_axis)
                                                {
                                                    _loc_27.zip_axis = false;
                                                    _loc_27.axisx = Math.sin(_loc_27.rot);
                                                    _loc_27.axisy = Math.cos(_loc_27.rot);
                                                }
                                                _loc_18.worldCOMx = _loc_18.body.posx + (_loc_18.body.axisy * _loc_18.localCOMx - _loc_18.body.axisx * _loc_18.localCOMy);
                                                _loc_18.worldCOMy = _loc_18.body.posy + (_loc_18.localCOMx * _loc_18.body.axisx + _loc_18.localCOMy * _loc_18.body.axisy);
                                            }
                                        }
                                        _loc_20 = _loc_18.radius;
                                        _loc_25 = _loc_18.radius;
                                        _loc_18.aabb.minx = _loc_18.worldCOMx - _loc_20;
                                        _loc_18.aabb.miny = _loc_18.worldCOMy - _loc_25;
                                        _loc_18.aabb.maxx = _loc_18.worldCOMx + _loc_20;
                                        _loc_18.aabb.maxy = _loc_18.worldCOMy + _loc_25;
                                    }
                                    else
                                    {
                                        _loc_19 = _loc_6.polygon;
                                        if (_loc_19.zip_gverts)
                                        {
                                            if (_loc_19.body != null)
                                            {
                                                _loc_19.zip_gverts = false;
                                                _loc_19.validate_lverts();
                                                _loc_27 = _loc_19.body;
                                                if (_loc_27.zip_axis)
                                                {
                                                    _loc_27.zip_axis = false;
                                                    _loc_27.axisx = Math.sin(_loc_27.rot);
                                                    _loc_27.axisy = Math.cos(_loc_27.rot);
                                                }
                                                _loc_21 = _loc_19.lverts.next;
                                                _loc_22 = _loc_19.gverts.next;
                                                while (_loc_22 != null)
                                                {
                                                    
                                                    _loc_23 = _loc_22;
                                                    _loc_24 = _loc_21;
                                                    _loc_21 = _loc_21.next;
                                                    _loc_23.x = _loc_19.body.posx + (_loc_19.body.axisy * _loc_24.x - _loc_19.body.axisx * _loc_24.y);
                                                    _loc_23.y = _loc_19.body.posy + (_loc_24.x * _loc_19.body.axisx + _loc_24.y * _loc_19.body.axisy);
                                                    _loc_22 = _loc_22.next;
                                                }
                                            }
                                        }
                                        if (_loc_19.lverts.next == null)
                                        {
                                            throw "Error: An empty polygon has no meaningful bounds";
                                        }
                                        _loc_21 = _loc_19.gverts.next;
                                        _loc_19.aabb.minx = _loc_21.x;
                                        _loc_19.aabb.miny = _loc_21.y;
                                        _loc_19.aabb.maxx = _loc_21.x;
                                        _loc_19.aabb.maxy = _loc_21.y;
                                        _loc_22 = _loc_19.gverts.next.next;
                                        while (_loc_22 != null)
                                        {
                                            
                                            _loc_23 = _loc_22;
                                            if (_loc_23.x < _loc_19.aabb.minx)
                                            {
                                                _loc_19.aabb.minx = _loc_23.x;
                                            }
                                            if (_loc_23.x > _loc_19.aabb.maxx)
                                            {
                                                _loc_19.aabb.maxx = _loc_23.x;
                                            }
                                            if (_loc_23.y < _loc_19.aabb.miny)
                                            {
                                                _loc_19.aabb.miny = _loc_23.y;
                                            }
                                            if (_loc_23.y > _loc_19.aabb.maxy)
                                            {
                                                _loc_19.aabb.maxy = _loc_23.y;
                                            }
                                            _loc_22 = _loc_22.next;
                                        }
                                    }
                                }
                            }
                            _loc_28 = param1.aabb;
                            _loc_29 = _loc_6.aabb;
                            if (_loc_29.minx < _loc_28.minx)
                            {
                                _loc_28.minx = _loc_29.minx;
                            }
                            if (_loc_29.maxx > _loc_28.maxx)
                            {
                                _loc_28.maxx = _loc_29.maxx;
                            }
                            if (_loc_29.miny < _loc_28.miny)
                            {
                                _loc_28.miny = _loc_29.miny;
                            }
                            if (_loc_29.maxy > _loc_28.maxy)
                            {
                                _loc_28.maxy = _loc_29.maxy;
                            }
                            _loc_5 = _loc_5.next;
                        }
                    }
                    if (param4)
                    {
                        __aabb(param1.aabb, colour);
                    }
                    else
                    {
                        _loc_20 = 0;
                        _loc_25 = 0;
                        _loc_20 = param2.a * param1.aabb.minx + param2.b * param1.aabb.miny + param2.tx;
                        _loc_25 = param2.c * param1.aabb.minx + param2.d * param1.aabb.miny + param2.ty;
                        _loc_28 = param1.aabb;
                        _loc_30 = _loc_28.maxx - _loc_28.minx;
                        _loc_31 = 0;
                        _loc_32 = param2.a * _loc_30 + param2.b * _loc_31;
                        _loc_31 = param2.c * _loc_30 + param2.d * _loc_31;
                        _loc_30 = _loc_32;
                        _loc_32 = 0;
                        _loc_28 = param1.aabb;
                        _loc_33 = _loc_28.maxy - _loc_28.miny;
                        _loc_34 = param2.a * _loc_32 + param2.b * _loc_33;
                        _loc_33 = param2.c * _loc_32 + param2.d * _loc_33;
                        _loc_32 = _loc_34;
                        penx = _loc_20 + 0.5;
                        peny = _loc_25 + 0.5;
                        _loc_8 = _loc_20 + _loc_30 + 0.5;
                        _loc_13 = _loc_25 + _loc_31 + 0.5;
                        __line(penx, peny, _loc_8, _loc_13, colour);
                        penx = _loc_8;
                        peny = _loc_13;
                        _loc_8 = _loc_20 + _loc_30 + _loc_32 + 0.5;
                        _loc_13 = _loc_25 + _loc_31 + _loc_33 + 0.5;
                        __line(penx, peny, _loc_8, _loc_13, colour);
                        penx = _loc_8;
                        peny = _loc_13;
                        _loc_8 = _loc_20 + _loc_32 + 0.5;
                        _loc_13 = _loc_25 + _loc_33 + 0.5;
                        __line(penx, peny, _loc_8, _loc_13, colour);
                        penx = _loc_8;
                        peny = _loc_13;
                        _loc_8 = _loc_20 + 0.5;
                        _loc_13 = _loc_25 + 0.5;
                        __line(penx, peny, _loc_8, _loc_13, colour);
                        penx = _loc_8;
                        peny = _loc_13;
                    }
                }
                if (param4)
                {
                    _loc_11 = param1.pre_posx;
                    _loc_17 = param1.pre_posy;
                }
                else
                {
                    _loc_11 = param2.a * param1.pre_posx + param2.b * param1.pre_posy + param2.tx;
                    _loc_17 = param2.c * param1.pre_posx + param2.d * param1.pre_posy + param2.ty;
                }
                if (param4)
                {
                    _loc_9 = param1.posx;
                    _loc_10 = param1.posy;
                }
                else
                {
                    _loc_9 = param2.a * param1.posx + param2.b * param1.posy + param2.tx;
                    _loc_10 = param2.c * param1.posx + param2.d * param1.posy + param2.ty;
                }
                penx = _loc_11 + 0.5;
                peny = _loc_17 + 0.5;
                _loc_8 = _loc_9 + 0.5;
                _loc_13 = _loc_10 + 0.5;
                __line(penx, peny, _loc_8, _loc_13, colour);
                penx = _loc_8;
                peny = _loc_13;
                penx = _loc_9 + 0.5;
                peny = _loc_10 + 0.5;
                __circle(penx, peny, 1.5, colour);
            }
            return;
        }// end function

        public function draw_arbiter(param1:ZPP_Arbiter, param2:ZPP_Mat23, param3:Number, param4:Boolean) : void
        {
            var _loc_7:* = null as Arbiter;
            var _loc_8:* = 0;
            var _loc_9:* = 0;
            var _loc_10:* = NaN;
            var _loc_11:* = 0;
            var _loc_12:* = 0;
            var _loc_13:* = 0;
            var _loc_14:* = null as Vec2;
            var _loc_15:* = null as Shape;
            var _loc_16:* = NaN;
            var _loc_17:* = false;
            var _loc_18:* = null as Vec2;
            var _loc_19:* = false;
            var _loc_20:* = null as ZPP_Vec2;
            var _loc_21:* = null as FluidArbiter;
            var _loc_22:* = null as CollisionArbiter;
            var _loc_23:* = null as ContactList;
            var _loc_24:* = null as ZPP_Contact;
            var _loc_25:* = null as ZPP_Contact;
            var _loc_26:* = null as Contact;
            var _loc_27:* = null as Vec2;
            var _loc_28:* = NaN;
            var _loc_29:* = NaN;
            var _loc_30:* = NaN;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            if (param1.outer.zpp_inner.type == ZPP_Arbiter.SENSOR)
            {
                if (outer.drawSensorArbiters)
                {
                    _loc_7 = param1.outer;
                    _loc_8 = 65280;
                    _loc_9 = ~bg_col;
                    _loc_10 = 0.7;
                    _loc_11 = (_loc_8 >> 16 & 255) * _loc_10 + (_loc_9 >> 16 & 255) * (1 - _loc_10);
                    _loc_12 = (_loc_8 >> 8 & 255) * _loc_10 + (_loc_9 >> 8 & 255) * (1 - _loc_10);
                    _loc_13 = (_loc_8 & 255) * _loc_10 + (_loc_9 & 255) * (1 - _loc_10);
                    colour = -16777216 | _loc_11 << 16 | _loc_12 << 8 | _loc_13;
                    if (param4)
                    {
                        if (!_loc_7.zpp_inner.active)
                        {
                            throw "Error: Arbiter not currently in use";
                        }
                        if (_loc_7.zpp_inner.ws1.id > _loc_7.zpp_inner.ws2.id)
                        {
                            _loc_15 = _loc_7.zpp_inner.ws2.outer;
                        }
                        else
                        {
                            _loc_15 = _loc_7.zpp_inner.ws1.outer;
                        }
                        if (_loc_15.zpp_inner.wrap_worldCOM == null)
                        {
                            _loc_10 = _loc_15.zpp_inner.worldCOMx;
                            _loc_16 = _loc_15.zpp_inner.worldCOMy;
                            _loc_17 = false;
                            if (_loc_10 == _loc_10)
                            {
                            }
                            if (_loc_16 != _loc_16)
                            {
                                throw "Error: Vec2 components cannot be NaN";
                            }
                            if (ZPP_PubPool.poolVec2 == null)
                            {
                                _loc_18 = new Vec2();
                            }
                            else
                            {
                                _loc_18 = ZPP_PubPool.poolVec2;
                                ZPP_PubPool.poolVec2 = _loc_18.zpp_pool;
                                _loc_18.zpp_pool = null;
                                _loc_18.zpp_disp = false;
                                if (_loc_18 == ZPP_PubPool.nextVec2)
                                {
                                    ZPP_PubPool.nextVec2 = null;
                                }
                            }
                            if (_loc_18.zpp_inner == null)
                            {
                                _loc_19 = false;
                                if (ZPP_Vec2.zpp_pool == null)
                                {
                                    _loc_20 = new ZPP_Vec2();
                                }
                                else
                                {
                                    _loc_20 = ZPP_Vec2.zpp_pool;
                                    ZPP_Vec2.zpp_pool = _loc_20.next;
                                    _loc_20.next = null;
                                }
                                _loc_20.weak = false;
                                _loc_20._immutable = _loc_19;
                                _loc_20.x = _loc_10;
                                _loc_20.y = _loc_16;
                                _loc_18.zpp_inner = _loc_20;
                                _loc_18.zpp_inner.outer = _loc_18;
                            }
                            else
                            {
                                if (_loc_18 != null)
                                {
                                }
                                if (_loc_18.zpp_disp)
                                {
                                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                                }
                                _loc_20 = _loc_18.zpp_inner;
                                if (_loc_20._immutable)
                                {
                                    throw "Error: Vec2 is immutable";
                                }
                                if (_loc_20._isimmutable != null)
                                {
                                    _loc_20._isimmutable();
                                }
                                if (_loc_10 == _loc_10)
                                {
                                }
                                if (_loc_16 != _loc_16)
                                {
                                    throw "Error: Vec2 components cannot be NaN";
                                }
                                if (_loc_18 != null)
                                {
                                }
                                if (_loc_18.zpp_disp)
                                {
                                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                                }
                                _loc_20 = _loc_18.zpp_inner;
                                if (_loc_20._validate != null)
                                {
                                    _loc_20._validate();
                                }
                                if (_loc_18.zpp_inner.x == _loc_10)
                                {
                                    if (_loc_18 != null)
                                    {
                                    }
                                    if (_loc_18.zpp_disp)
                                    {
                                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                                    }
                                    _loc_20 = _loc_18.zpp_inner;
                                    if (_loc_20._validate != null)
                                    {
                                        _loc_20._validate();
                                    }
                                }
                                if (_loc_18.zpp_inner.y != _loc_16)
                                {
                                    _loc_18.zpp_inner.x = _loc_10;
                                    _loc_18.zpp_inner.y = _loc_16;
                                    _loc_20 = _loc_18.zpp_inner;
                                    if (_loc_20._invalidate != null)
                                    {
                                        _loc_20._invalidate(_loc_20);
                                    }
                                }
                            }
                            _loc_18.zpp_inner.weak = _loc_17;
                            _loc_15.zpp_inner.wrap_worldCOM = _loc_18;
                            _loc_15.zpp_inner.wrap_worldCOM.zpp_inner._inuse = true;
                            _loc_15.zpp_inner.wrap_worldCOM.zpp_inner._immutable = true;
                            _loc_15.zpp_inner.wrap_worldCOM.zpp_inner._validate = _loc_15.zpp_inner.getworldCOM;
                        }
                        _loc_14 = _loc_15.zpp_inner.wrap_worldCOM;
                        if (_loc_14 != null)
                        {
                        }
                        if (_loc_14.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_20 = _loc_14.zpp_inner;
                        if (_loc_20._validate != null)
                        {
                            _loc_20._validate();
                        }
                        _loc_5 = _loc_14.zpp_inner.x;
                        if (!_loc_7.zpp_inner.active)
                        {
                            throw "Error: Arbiter not currently in use";
                        }
                        if (_loc_7.zpp_inner.ws1.id > _loc_7.zpp_inner.ws2.id)
                        {
                            _loc_15 = _loc_7.zpp_inner.ws2.outer;
                        }
                        else
                        {
                            _loc_15 = _loc_7.zpp_inner.ws1.outer;
                        }
                        if (_loc_15.zpp_inner.wrap_worldCOM == null)
                        {
                            _loc_10 = _loc_15.zpp_inner.worldCOMx;
                            _loc_16 = _loc_15.zpp_inner.worldCOMy;
                            _loc_17 = false;
                            if (_loc_10 == _loc_10)
                            {
                            }
                            if (_loc_16 != _loc_16)
                            {
                                throw "Error: Vec2 components cannot be NaN";
                            }
                            if (ZPP_PubPool.poolVec2 == null)
                            {
                                _loc_18 = new Vec2();
                            }
                            else
                            {
                                _loc_18 = ZPP_PubPool.poolVec2;
                                ZPP_PubPool.poolVec2 = _loc_18.zpp_pool;
                                _loc_18.zpp_pool = null;
                                _loc_18.zpp_disp = false;
                                if (_loc_18 == ZPP_PubPool.nextVec2)
                                {
                                    ZPP_PubPool.nextVec2 = null;
                                }
                            }
                            if (_loc_18.zpp_inner == null)
                            {
                                _loc_19 = false;
                                if (ZPP_Vec2.zpp_pool == null)
                                {
                                    _loc_20 = new ZPP_Vec2();
                                }
                                else
                                {
                                    _loc_20 = ZPP_Vec2.zpp_pool;
                                    ZPP_Vec2.zpp_pool = _loc_20.next;
                                    _loc_20.next = null;
                                }
                                _loc_20.weak = false;
                                _loc_20._immutable = _loc_19;
                                _loc_20.x = _loc_10;
                                _loc_20.y = _loc_16;
                                _loc_18.zpp_inner = _loc_20;
                                _loc_18.zpp_inner.outer = _loc_18;
                            }
                            else
                            {
                                if (_loc_18 != null)
                                {
                                }
                                if (_loc_18.zpp_disp)
                                {
                                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                                }
                                _loc_20 = _loc_18.zpp_inner;
                                if (_loc_20._immutable)
                                {
                                    throw "Error: Vec2 is immutable";
                                }
                                if (_loc_20._isimmutable != null)
                                {
                                    _loc_20._isimmutable();
                                }
                                if (_loc_10 == _loc_10)
                                {
                                }
                                if (_loc_16 != _loc_16)
                                {
                                    throw "Error: Vec2 components cannot be NaN";
                                }
                                if (_loc_18 != null)
                                {
                                }
                                if (_loc_18.zpp_disp)
                                {
                                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                                }
                                _loc_20 = _loc_18.zpp_inner;
                                if (_loc_20._validate != null)
                                {
                                    _loc_20._validate();
                                }
                                if (_loc_18.zpp_inner.x == _loc_10)
                                {
                                    if (_loc_18 != null)
                                    {
                                    }
                                    if (_loc_18.zpp_disp)
                                    {
                                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                                    }
                                    _loc_20 = _loc_18.zpp_inner;
                                    if (_loc_20._validate != null)
                                    {
                                        _loc_20._validate();
                                    }
                                }
                                if (_loc_18.zpp_inner.y != _loc_16)
                                {
                                    _loc_18.zpp_inner.x = _loc_10;
                                    _loc_18.zpp_inner.y = _loc_16;
                                    _loc_20 = _loc_18.zpp_inner;
                                    if (_loc_20._invalidate != null)
                                    {
                                        _loc_20._invalidate(_loc_20);
                                    }
                                }
                            }
                            _loc_18.zpp_inner.weak = _loc_17;
                            _loc_15.zpp_inner.wrap_worldCOM = _loc_18;
                            _loc_15.zpp_inner.wrap_worldCOM.zpp_inner._inuse = true;
                            _loc_15.zpp_inner.wrap_worldCOM.zpp_inner._immutable = true;
                            _loc_15.zpp_inner.wrap_worldCOM.zpp_inner._validate = _loc_15.zpp_inner.getworldCOM;
                        }
                        _loc_14 = _loc_15.zpp_inner.wrap_worldCOM;
                        if (_loc_14 != null)
                        {
                        }
                        if (_loc_14.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_20 = _loc_14.zpp_inner;
                        if (_loc_20._validate != null)
                        {
                            _loc_20._validate();
                        }
                        _loc_6 = _loc_14.zpp_inner.y;
                    }
                    else
                    {
                        if (!_loc_7.zpp_inner.active)
                        {
                            throw "Error: Arbiter not currently in use";
                        }
                        if (_loc_7.zpp_inner.ws1.id > _loc_7.zpp_inner.ws2.id)
                        {
                            _loc_15 = _loc_7.zpp_inner.ws2.outer;
                        }
                        else
                        {
                            _loc_15 = _loc_7.zpp_inner.ws1.outer;
                        }
                        if (_loc_15.zpp_inner.wrap_worldCOM == null)
                        {
                            _loc_10 = _loc_15.zpp_inner.worldCOMx;
                            _loc_16 = _loc_15.zpp_inner.worldCOMy;
                            _loc_17 = false;
                            if (_loc_10 == _loc_10)
                            {
                            }
                            if (_loc_16 != _loc_16)
                            {
                                throw "Error: Vec2 components cannot be NaN";
                            }
                            if (ZPP_PubPool.poolVec2 == null)
                            {
                                _loc_18 = new Vec2();
                            }
                            else
                            {
                                _loc_18 = ZPP_PubPool.poolVec2;
                                ZPP_PubPool.poolVec2 = _loc_18.zpp_pool;
                                _loc_18.zpp_pool = null;
                                _loc_18.zpp_disp = false;
                                if (_loc_18 == ZPP_PubPool.nextVec2)
                                {
                                    ZPP_PubPool.nextVec2 = null;
                                }
                            }
                            if (_loc_18.zpp_inner == null)
                            {
                                _loc_19 = false;
                                if (ZPP_Vec2.zpp_pool == null)
                                {
                                    _loc_20 = new ZPP_Vec2();
                                }
                                else
                                {
                                    _loc_20 = ZPP_Vec2.zpp_pool;
                                    ZPP_Vec2.zpp_pool = _loc_20.next;
                                    _loc_20.next = null;
                                }
                                _loc_20.weak = false;
                                _loc_20._immutable = _loc_19;
                                _loc_20.x = _loc_10;
                                _loc_20.y = _loc_16;
                                _loc_18.zpp_inner = _loc_20;
                                _loc_18.zpp_inner.outer = _loc_18;
                            }
                            else
                            {
                                if (_loc_18 != null)
                                {
                                }
                                if (_loc_18.zpp_disp)
                                {
                                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                                }
                                _loc_20 = _loc_18.zpp_inner;
                                if (_loc_20._immutable)
                                {
                                    throw "Error: Vec2 is immutable";
                                }
                                if (_loc_20._isimmutable != null)
                                {
                                    _loc_20._isimmutable();
                                }
                                if (_loc_10 == _loc_10)
                                {
                                }
                                if (_loc_16 != _loc_16)
                                {
                                    throw "Error: Vec2 components cannot be NaN";
                                }
                                if (_loc_18 != null)
                                {
                                }
                                if (_loc_18.zpp_disp)
                                {
                                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                                }
                                _loc_20 = _loc_18.zpp_inner;
                                if (_loc_20._validate != null)
                                {
                                    _loc_20._validate();
                                }
                                if (_loc_18.zpp_inner.x == _loc_10)
                                {
                                    if (_loc_18 != null)
                                    {
                                    }
                                    if (_loc_18.zpp_disp)
                                    {
                                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                                    }
                                    _loc_20 = _loc_18.zpp_inner;
                                    if (_loc_20._validate != null)
                                    {
                                        _loc_20._validate();
                                    }
                                }
                                if (_loc_18.zpp_inner.y != _loc_16)
                                {
                                    _loc_18.zpp_inner.x = _loc_10;
                                    _loc_18.zpp_inner.y = _loc_16;
                                    _loc_20 = _loc_18.zpp_inner;
                                    if (_loc_20._invalidate != null)
                                    {
                                        _loc_20._invalidate(_loc_20);
                                    }
                                }
                            }
                            _loc_18.zpp_inner.weak = _loc_17;
                            _loc_15.zpp_inner.wrap_worldCOM = _loc_18;
                            _loc_15.zpp_inner.wrap_worldCOM.zpp_inner._inuse = true;
                            _loc_15.zpp_inner.wrap_worldCOM.zpp_inner._immutable = true;
                            _loc_15.zpp_inner.wrap_worldCOM.zpp_inner._validate = _loc_15.zpp_inner.getworldCOM;
                        }
                        _loc_14 = _loc_15.zpp_inner.wrap_worldCOM;
                        if (_loc_14 != null)
                        {
                        }
                        if (_loc_14.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_20 = _loc_14.zpp_inner;
                        if (_loc_20._validate != null)
                        {
                            _loc_20._validate();
                        }
                        if (!_loc_7.zpp_inner.active)
                        {
                            throw "Error: Arbiter not currently in use";
                        }
                        if (_loc_7.zpp_inner.ws1.id > _loc_7.zpp_inner.ws2.id)
                        {
                            _loc_15 = _loc_7.zpp_inner.ws2.outer;
                        }
                        else
                        {
                            _loc_15 = _loc_7.zpp_inner.ws1.outer;
                        }
                        if (_loc_15.zpp_inner.wrap_worldCOM == null)
                        {
                            _loc_10 = _loc_15.zpp_inner.worldCOMx;
                            _loc_16 = _loc_15.zpp_inner.worldCOMy;
                            _loc_17 = false;
                            if (_loc_10 == _loc_10)
                            {
                            }
                            if (_loc_16 != _loc_16)
                            {
                                throw "Error: Vec2 components cannot be NaN";
                            }
                            if (ZPP_PubPool.poolVec2 == null)
                            {
                                _loc_18 = new Vec2();
                            }
                            else
                            {
                                _loc_18 = ZPP_PubPool.poolVec2;
                                ZPP_PubPool.poolVec2 = _loc_18.zpp_pool;
                                _loc_18.zpp_pool = null;
                                _loc_18.zpp_disp = false;
                                if (_loc_18 == ZPP_PubPool.nextVec2)
                                {
                                    ZPP_PubPool.nextVec2 = null;
                                }
                            }
                            if (_loc_18.zpp_inner == null)
                            {
                                _loc_19 = false;
                                if (ZPP_Vec2.zpp_pool == null)
                                {
                                    _loc_20 = new ZPP_Vec2();
                                }
                                else
                                {
                                    _loc_20 = ZPP_Vec2.zpp_pool;
                                    ZPP_Vec2.zpp_pool = _loc_20.next;
                                    _loc_20.next = null;
                                }
                                _loc_20.weak = false;
                                _loc_20._immutable = _loc_19;
                                _loc_20.x = _loc_10;
                                _loc_20.y = _loc_16;
                                _loc_18.zpp_inner = _loc_20;
                                _loc_18.zpp_inner.outer = _loc_18;
                            }
                            else
                            {
                                if (_loc_18 != null)
                                {
                                }
                                if (_loc_18.zpp_disp)
                                {
                                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                                }
                                _loc_20 = _loc_18.zpp_inner;
                                if (_loc_20._immutable)
                                {
                                    throw "Error: Vec2 is immutable";
                                }
                                if (_loc_20._isimmutable != null)
                                {
                                    _loc_20._isimmutable();
                                }
                                if (_loc_10 == _loc_10)
                                {
                                }
                                if (_loc_16 != _loc_16)
                                {
                                    throw "Error: Vec2 components cannot be NaN";
                                }
                                if (_loc_18 != null)
                                {
                                }
                                if (_loc_18.zpp_disp)
                                {
                                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                                }
                                _loc_20 = _loc_18.zpp_inner;
                                if (_loc_20._validate != null)
                                {
                                    _loc_20._validate();
                                }
                                if (_loc_18.zpp_inner.x == _loc_10)
                                {
                                    if (_loc_18 != null)
                                    {
                                    }
                                    if (_loc_18.zpp_disp)
                                    {
                                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                                    }
                                    _loc_20 = _loc_18.zpp_inner;
                                    if (_loc_20._validate != null)
                                    {
                                        _loc_20._validate();
                                    }
                                }
                                if (_loc_18.zpp_inner.y != _loc_16)
                                {
                                    _loc_18.zpp_inner.x = _loc_10;
                                    _loc_18.zpp_inner.y = _loc_16;
                                    _loc_20 = _loc_18.zpp_inner;
                                    if (_loc_20._invalidate != null)
                                    {
                                        _loc_20._invalidate(_loc_20);
                                    }
                                }
                            }
                            _loc_18.zpp_inner.weak = _loc_17;
                            _loc_15.zpp_inner.wrap_worldCOM = _loc_18;
                            _loc_15.zpp_inner.wrap_worldCOM.zpp_inner._inuse = true;
                            _loc_15.zpp_inner.wrap_worldCOM.zpp_inner._immutable = true;
                            _loc_15.zpp_inner.wrap_worldCOM.zpp_inner._validate = _loc_15.zpp_inner.getworldCOM;
                        }
                        _loc_14 = _loc_15.zpp_inner.wrap_worldCOM;
                        if (_loc_14 != null)
                        {
                        }
                        if (_loc_14.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_20 = _loc_14.zpp_inner;
                        if (_loc_20._validate != null)
                        {
                            _loc_20._validate();
                        }
                        _loc_5 = param2.a * _loc_14.zpp_inner.x + param2.b * _loc_14.zpp_inner.y + param2.tx;
                        if (!_loc_7.zpp_inner.active)
                        {
                            throw "Error: Arbiter not currently in use";
                        }
                        if (_loc_7.zpp_inner.ws1.id > _loc_7.zpp_inner.ws2.id)
                        {
                            _loc_15 = _loc_7.zpp_inner.ws2.outer;
                        }
                        else
                        {
                            _loc_15 = _loc_7.zpp_inner.ws1.outer;
                        }
                        if (_loc_15.zpp_inner.wrap_worldCOM == null)
                        {
                            _loc_10 = _loc_15.zpp_inner.worldCOMx;
                            _loc_16 = _loc_15.zpp_inner.worldCOMy;
                            _loc_17 = false;
                            if (_loc_10 == _loc_10)
                            {
                            }
                            if (_loc_16 != _loc_16)
                            {
                                throw "Error: Vec2 components cannot be NaN";
                            }
                            if (ZPP_PubPool.poolVec2 == null)
                            {
                                _loc_18 = new Vec2();
                            }
                            else
                            {
                                _loc_18 = ZPP_PubPool.poolVec2;
                                ZPP_PubPool.poolVec2 = _loc_18.zpp_pool;
                                _loc_18.zpp_pool = null;
                                _loc_18.zpp_disp = false;
                                if (_loc_18 == ZPP_PubPool.nextVec2)
                                {
                                    ZPP_PubPool.nextVec2 = null;
                                }
                            }
                            if (_loc_18.zpp_inner == null)
                            {
                                _loc_19 = false;
                                if (ZPP_Vec2.zpp_pool == null)
                                {
                                    _loc_20 = new ZPP_Vec2();
                                }
                                else
                                {
                                    _loc_20 = ZPP_Vec2.zpp_pool;
                                    ZPP_Vec2.zpp_pool = _loc_20.next;
                                    _loc_20.next = null;
                                }
                                _loc_20.weak = false;
                                _loc_20._immutable = _loc_19;
                                _loc_20.x = _loc_10;
                                _loc_20.y = _loc_16;
                                _loc_18.zpp_inner = _loc_20;
                                _loc_18.zpp_inner.outer = _loc_18;
                            }
                            else
                            {
                                if (_loc_18 != null)
                                {
                                }
                                if (_loc_18.zpp_disp)
                                {
                                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                                }
                                _loc_20 = _loc_18.zpp_inner;
                                if (_loc_20._immutable)
                                {
                                    throw "Error: Vec2 is immutable";
                                }
                                if (_loc_20._isimmutable != null)
                                {
                                    _loc_20._isimmutable();
                                }
                                if (_loc_10 == _loc_10)
                                {
                                }
                                if (_loc_16 != _loc_16)
                                {
                                    throw "Error: Vec2 components cannot be NaN";
                                }
                                if (_loc_18 != null)
                                {
                                }
                                if (_loc_18.zpp_disp)
                                {
                                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                                }
                                _loc_20 = _loc_18.zpp_inner;
                                if (_loc_20._validate != null)
                                {
                                    _loc_20._validate();
                                }
                                if (_loc_18.zpp_inner.x == _loc_10)
                                {
                                    if (_loc_18 != null)
                                    {
                                    }
                                    if (_loc_18.zpp_disp)
                                    {
                                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                                    }
                                    _loc_20 = _loc_18.zpp_inner;
                                    if (_loc_20._validate != null)
                                    {
                                        _loc_20._validate();
                                    }
                                }
                                if (_loc_18.zpp_inner.y != _loc_16)
                                {
                                    _loc_18.zpp_inner.x = _loc_10;
                                    _loc_18.zpp_inner.y = _loc_16;
                                    _loc_20 = _loc_18.zpp_inner;
                                    if (_loc_20._invalidate != null)
                                    {
                                        _loc_20._invalidate(_loc_20);
                                    }
                                }
                            }
                            _loc_18.zpp_inner.weak = _loc_17;
                            _loc_15.zpp_inner.wrap_worldCOM = _loc_18;
                            _loc_15.zpp_inner.wrap_worldCOM.zpp_inner._inuse = true;
                            _loc_15.zpp_inner.wrap_worldCOM.zpp_inner._immutable = true;
                            _loc_15.zpp_inner.wrap_worldCOM.zpp_inner._validate = _loc_15.zpp_inner.getworldCOM;
                        }
                        _loc_14 = _loc_15.zpp_inner.wrap_worldCOM;
                        if (_loc_14 != null)
                        {
                        }
                        if (_loc_14.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_20 = _loc_14.zpp_inner;
                        if (_loc_20._validate != null)
                        {
                            _loc_20._validate();
                        }
                        if (!_loc_7.zpp_inner.active)
                        {
                            throw "Error: Arbiter not currently in use";
                        }
                        if (_loc_7.zpp_inner.ws1.id > _loc_7.zpp_inner.ws2.id)
                        {
                            _loc_15 = _loc_7.zpp_inner.ws2.outer;
                        }
                        else
                        {
                            _loc_15 = _loc_7.zpp_inner.ws1.outer;
                        }
                        if (_loc_15.zpp_inner.wrap_worldCOM == null)
                        {
                            _loc_10 = _loc_15.zpp_inner.worldCOMx;
                            _loc_16 = _loc_15.zpp_inner.worldCOMy;
                            _loc_17 = false;
                            if (_loc_10 == _loc_10)
                            {
                            }
                            if (_loc_16 != _loc_16)
                            {
                                throw "Error: Vec2 components cannot be NaN";
                            }
                            if (ZPP_PubPool.poolVec2 == null)
                            {
                                _loc_18 = new Vec2();
                            }
                            else
                            {
                                _loc_18 = ZPP_PubPool.poolVec2;
                                ZPP_PubPool.poolVec2 = _loc_18.zpp_pool;
                                _loc_18.zpp_pool = null;
                                _loc_18.zpp_disp = false;
                                if (_loc_18 == ZPP_PubPool.nextVec2)
                                {
                                    ZPP_PubPool.nextVec2 = null;
                                }
                            }
                            if (_loc_18.zpp_inner == null)
                            {
                                _loc_19 = false;
                                if (ZPP_Vec2.zpp_pool == null)
                                {
                                    _loc_20 = new ZPP_Vec2();
                                }
                                else
                                {
                                    _loc_20 = ZPP_Vec2.zpp_pool;
                                    ZPP_Vec2.zpp_pool = _loc_20.next;
                                    _loc_20.next = null;
                                }
                                _loc_20.weak = false;
                                _loc_20._immutable = _loc_19;
                                _loc_20.x = _loc_10;
                                _loc_20.y = _loc_16;
                                _loc_18.zpp_inner = _loc_20;
                                _loc_18.zpp_inner.outer = _loc_18;
                            }
                            else
                            {
                                if (_loc_18 != null)
                                {
                                }
                                if (_loc_18.zpp_disp)
                                {
                                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                                }
                                _loc_20 = _loc_18.zpp_inner;
                                if (_loc_20._immutable)
                                {
                                    throw "Error: Vec2 is immutable";
                                }
                                if (_loc_20._isimmutable != null)
                                {
                                    _loc_20._isimmutable();
                                }
                                if (_loc_10 == _loc_10)
                                {
                                }
                                if (_loc_16 != _loc_16)
                                {
                                    throw "Error: Vec2 components cannot be NaN";
                                }
                                if (_loc_18 != null)
                                {
                                }
                                if (_loc_18.zpp_disp)
                                {
                                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                                }
                                _loc_20 = _loc_18.zpp_inner;
                                if (_loc_20._validate != null)
                                {
                                    _loc_20._validate();
                                }
                                if (_loc_18.zpp_inner.x == _loc_10)
                                {
                                    if (_loc_18 != null)
                                    {
                                    }
                                    if (_loc_18.zpp_disp)
                                    {
                                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                                    }
                                    _loc_20 = _loc_18.zpp_inner;
                                    if (_loc_20._validate != null)
                                    {
                                        _loc_20._validate();
                                    }
                                }
                                if (_loc_18.zpp_inner.y != _loc_16)
                                {
                                    _loc_18.zpp_inner.x = _loc_10;
                                    _loc_18.zpp_inner.y = _loc_16;
                                    _loc_20 = _loc_18.zpp_inner;
                                    if (_loc_20._invalidate != null)
                                    {
                                        _loc_20._invalidate(_loc_20);
                                    }
                                }
                            }
                            _loc_18.zpp_inner.weak = _loc_17;
                            _loc_15.zpp_inner.wrap_worldCOM = _loc_18;
                            _loc_15.zpp_inner.wrap_worldCOM.zpp_inner._inuse = true;
                            _loc_15.zpp_inner.wrap_worldCOM.zpp_inner._immutable = true;
                            _loc_15.zpp_inner.wrap_worldCOM.zpp_inner._validate = _loc_15.zpp_inner.getworldCOM;
                        }
                        _loc_14 = _loc_15.zpp_inner.wrap_worldCOM;
                        if (_loc_14 != null)
                        {
                        }
                        if (_loc_14.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_20 = _loc_14.zpp_inner;
                        if (_loc_20._validate != null)
                        {
                            _loc_20._validate();
                        }
                        _loc_6 = param2.c * _loc_14.zpp_inner.x + param2.d * _loc_14.zpp_inner.y + param2.ty;
                    }
                    penx = _loc_5 + 0.5;
                    peny = _loc_6 + 0.5;
                    if (param4)
                    {
                        if (!_loc_7.zpp_inner.active)
                        {
                            throw "Error: Arbiter not currently in use";
                        }
                        if (_loc_7.zpp_inner.ws1.id > _loc_7.zpp_inner.ws2.id)
                        {
                            _loc_15 = _loc_7.zpp_inner.ws1.outer;
                        }
                        else
                        {
                            _loc_15 = _loc_7.zpp_inner.ws2.outer;
                        }
                        if (_loc_15.zpp_inner.wrap_worldCOM == null)
                        {
                            _loc_10 = _loc_15.zpp_inner.worldCOMx;
                            _loc_16 = _loc_15.zpp_inner.worldCOMy;
                            _loc_17 = false;
                            if (_loc_10 == _loc_10)
                            {
                            }
                            if (_loc_16 != _loc_16)
                            {
                                throw "Error: Vec2 components cannot be NaN";
                            }
                            if (ZPP_PubPool.poolVec2 == null)
                            {
                                _loc_18 = new Vec2();
                            }
                            else
                            {
                                _loc_18 = ZPP_PubPool.poolVec2;
                                ZPP_PubPool.poolVec2 = _loc_18.zpp_pool;
                                _loc_18.zpp_pool = null;
                                _loc_18.zpp_disp = false;
                                if (_loc_18 == ZPP_PubPool.nextVec2)
                                {
                                    ZPP_PubPool.nextVec2 = null;
                                }
                            }
                            if (_loc_18.zpp_inner == null)
                            {
                                _loc_19 = false;
                                if (ZPP_Vec2.zpp_pool == null)
                                {
                                    _loc_20 = new ZPP_Vec2();
                                }
                                else
                                {
                                    _loc_20 = ZPP_Vec2.zpp_pool;
                                    ZPP_Vec2.zpp_pool = _loc_20.next;
                                    _loc_20.next = null;
                                }
                                _loc_20.weak = false;
                                _loc_20._immutable = _loc_19;
                                _loc_20.x = _loc_10;
                                _loc_20.y = _loc_16;
                                _loc_18.zpp_inner = _loc_20;
                                _loc_18.zpp_inner.outer = _loc_18;
                            }
                            else
                            {
                                if (_loc_18 != null)
                                {
                                }
                                if (_loc_18.zpp_disp)
                                {
                                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                                }
                                _loc_20 = _loc_18.zpp_inner;
                                if (_loc_20._immutable)
                                {
                                    throw "Error: Vec2 is immutable";
                                }
                                if (_loc_20._isimmutable != null)
                                {
                                    _loc_20._isimmutable();
                                }
                                if (_loc_10 == _loc_10)
                                {
                                }
                                if (_loc_16 != _loc_16)
                                {
                                    throw "Error: Vec2 components cannot be NaN";
                                }
                                if (_loc_18 != null)
                                {
                                }
                                if (_loc_18.zpp_disp)
                                {
                                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                                }
                                _loc_20 = _loc_18.zpp_inner;
                                if (_loc_20._validate != null)
                                {
                                    _loc_20._validate();
                                }
                                if (_loc_18.zpp_inner.x == _loc_10)
                                {
                                    if (_loc_18 != null)
                                    {
                                    }
                                    if (_loc_18.zpp_disp)
                                    {
                                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                                    }
                                    _loc_20 = _loc_18.zpp_inner;
                                    if (_loc_20._validate != null)
                                    {
                                        _loc_20._validate();
                                    }
                                }
                                if (_loc_18.zpp_inner.y != _loc_16)
                                {
                                    _loc_18.zpp_inner.x = _loc_10;
                                    _loc_18.zpp_inner.y = _loc_16;
                                    _loc_20 = _loc_18.zpp_inner;
                                    if (_loc_20._invalidate != null)
                                    {
                                        _loc_20._invalidate(_loc_20);
                                    }
                                }
                            }
                            _loc_18.zpp_inner.weak = _loc_17;
                            _loc_15.zpp_inner.wrap_worldCOM = _loc_18;
                            _loc_15.zpp_inner.wrap_worldCOM.zpp_inner._inuse = true;
                            _loc_15.zpp_inner.wrap_worldCOM.zpp_inner._immutable = true;
                            _loc_15.zpp_inner.wrap_worldCOM.zpp_inner._validate = _loc_15.zpp_inner.getworldCOM;
                        }
                        _loc_14 = _loc_15.zpp_inner.wrap_worldCOM;
                        if (_loc_14 != null)
                        {
                        }
                        if (_loc_14.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_20 = _loc_14.zpp_inner;
                        if (_loc_20._validate != null)
                        {
                            _loc_20._validate();
                        }
                        _loc_5 = _loc_14.zpp_inner.x;
                        if (!_loc_7.zpp_inner.active)
                        {
                            throw "Error: Arbiter not currently in use";
                        }
                        if (_loc_7.zpp_inner.ws1.id > _loc_7.zpp_inner.ws2.id)
                        {
                            _loc_15 = _loc_7.zpp_inner.ws1.outer;
                        }
                        else
                        {
                            _loc_15 = _loc_7.zpp_inner.ws2.outer;
                        }
                        if (_loc_15.zpp_inner.wrap_worldCOM == null)
                        {
                            _loc_10 = _loc_15.zpp_inner.worldCOMx;
                            _loc_16 = _loc_15.zpp_inner.worldCOMy;
                            _loc_17 = false;
                            if (_loc_10 == _loc_10)
                            {
                            }
                            if (_loc_16 != _loc_16)
                            {
                                throw "Error: Vec2 components cannot be NaN";
                            }
                            if (ZPP_PubPool.poolVec2 == null)
                            {
                                _loc_18 = new Vec2();
                            }
                            else
                            {
                                _loc_18 = ZPP_PubPool.poolVec2;
                                ZPP_PubPool.poolVec2 = _loc_18.zpp_pool;
                                _loc_18.zpp_pool = null;
                                _loc_18.zpp_disp = false;
                                if (_loc_18 == ZPP_PubPool.nextVec2)
                                {
                                    ZPP_PubPool.nextVec2 = null;
                                }
                            }
                            if (_loc_18.zpp_inner == null)
                            {
                                _loc_19 = false;
                                if (ZPP_Vec2.zpp_pool == null)
                                {
                                    _loc_20 = new ZPP_Vec2();
                                }
                                else
                                {
                                    _loc_20 = ZPP_Vec2.zpp_pool;
                                    ZPP_Vec2.zpp_pool = _loc_20.next;
                                    _loc_20.next = null;
                                }
                                _loc_20.weak = false;
                                _loc_20._immutable = _loc_19;
                                _loc_20.x = _loc_10;
                                _loc_20.y = _loc_16;
                                _loc_18.zpp_inner = _loc_20;
                                _loc_18.zpp_inner.outer = _loc_18;
                            }
                            else
                            {
                                if (_loc_18 != null)
                                {
                                }
                                if (_loc_18.zpp_disp)
                                {
                                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                                }
                                _loc_20 = _loc_18.zpp_inner;
                                if (_loc_20._immutable)
                                {
                                    throw "Error: Vec2 is immutable";
                                }
                                if (_loc_20._isimmutable != null)
                                {
                                    _loc_20._isimmutable();
                                }
                                if (_loc_10 == _loc_10)
                                {
                                }
                                if (_loc_16 != _loc_16)
                                {
                                    throw "Error: Vec2 components cannot be NaN";
                                }
                                if (_loc_18 != null)
                                {
                                }
                                if (_loc_18.zpp_disp)
                                {
                                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                                }
                                _loc_20 = _loc_18.zpp_inner;
                                if (_loc_20._validate != null)
                                {
                                    _loc_20._validate();
                                }
                                if (_loc_18.zpp_inner.x == _loc_10)
                                {
                                    if (_loc_18 != null)
                                    {
                                    }
                                    if (_loc_18.zpp_disp)
                                    {
                                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                                    }
                                    _loc_20 = _loc_18.zpp_inner;
                                    if (_loc_20._validate != null)
                                    {
                                        _loc_20._validate();
                                    }
                                }
                                if (_loc_18.zpp_inner.y != _loc_16)
                                {
                                    _loc_18.zpp_inner.x = _loc_10;
                                    _loc_18.zpp_inner.y = _loc_16;
                                    _loc_20 = _loc_18.zpp_inner;
                                    if (_loc_20._invalidate != null)
                                    {
                                        _loc_20._invalidate(_loc_20);
                                    }
                                }
                            }
                            _loc_18.zpp_inner.weak = _loc_17;
                            _loc_15.zpp_inner.wrap_worldCOM = _loc_18;
                            _loc_15.zpp_inner.wrap_worldCOM.zpp_inner._inuse = true;
                            _loc_15.zpp_inner.wrap_worldCOM.zpp_inner._immutable = true;
                            _loc_15.zpp_inner.wrap_worldCOM.zpp_inner._validate = _loc_15.zpp_inner.getworldCOM;
                        }
                        _loc_14 = _loc_15.zpp_inner.wrap_worldCOM;
                        if (_loc_14 != null)
                        {
                        }
                        if (_loc_14.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_20 = _loc_14.zpp_inner;
                        if (_loc_20._validate != null)
                        {
                            _loc_20._validate();
                        }
                        _loc_6 = _loc_14.zpp_inner.y;
                    }
                    else
                    {
                        if (!_loc_7.zpp_inner.active)
                        {
                            throw "Error: Arbiter not currently in use";
                        }
                        if (_loc_7.zpp_inner.ws1.id > _loc_7.zpp_inner.ws2.id)
                        {
                            _loc_15 = _loc_7.zpp_inner.ws1.outer;
                        }
                        else
                        {
                            _loc_15 = _loc_7.zpp_inner.ws2.outer;
                        }
                        if (_loc_15.zpp_inner.wrap_worldCOM == null)
                        {
                            _loc_10 = _loc_15.zpp_inner.worldCOMx;
                            _loc_16 = _loc_15.zpp_inner.worldCOMy;
                            _loc_17 = false;
                            if (_loc_10 == _loc_10)
                            {
                            }
                            if (_loc_16 != _loc_16)
                            {
                                throw "Error: Vec2 components cannot be NaN";
                            }
                            if (ZPP_PubPool.poolVec2 == null)
                            {
                                _loc_18 = new Vec2();
                            }
                            else
                            {
                                _loc_18 = ZPP_PubPool.poolVec2;
                                ZPP_PubPool.poolVec2 = _loc_18.zpp_pool;
                                _loc_18.zpp_pool = null;
                                _loc_18.zpp_disp = false;
                                if (_loc_18 == ZPP_PubPool.nextVec2)
                                {
                                    ZPP_PubPool.nextVec2 = null;
                                }
                            }
                            if (_loc_18.zpp_inner == null)
                            {
                                _loc_19 = false;
                                if (ZPP_Vec2.zpp_pool == null)
                                {
                                    _loc_20 = new ZPP_Vec2();
                                }
                                else
                                {
                                    _loc_20 = ZPP_Vec2.zpp_pool;
                                    ZPP_Vec2.zpp_pool = _loc_20.next;
                                    _loc_20.next = null;
                                }
                                _loc_20.weak = false;
                                _loc_20._immutable = _loc_19;
                                _loc_20.x = _loc_10;
                                _loc_20.y = _loc_16;
                                _loc_18.zpp_inner = _loc_20;
                                _loc_18.zpp_inner.outer = _loc_18;
                            }
                            else
                            {
                                if (_loc_18 != null)
                                {
                                }
                                if (_loc_18.zpp_disp)
                                {
                                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                                }
                                _loc_20 = _loc_18.zpp_inner;
                                if (_loc_20._immutable)
                                {
                                    throw "Error: Vec2 is immutable";
                                }
                                if (_loc_20._isimmutable != null)
                                {
                                    _loc_20._isimmutable();
                                }
                                if (_loc_10 == _loc_10)
                                {
                                }
                                if (_loc_16 != _loc_16)
                                {
                                    throw "Error: Vec2 components cannot be NaN";
                                }
                                if (_loc_18 != null)
                                {
                                }
                                if (_loc_18.zpp_disp)
                                {
                                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                                }
                                _loc_20 = _loc_18.zpp_inner;
                                if (_loc_20._validate != null)
                                {
                                    _loc_20._validate();
                                }
                                if (_loc_18.zpp_inner.x == _loc_10)
                                {
                                    if (_loc_18 != null)
                                    {
                                    }
                                    if (_loc_18.zpp_disp)
                                    {
                                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                                    }
                                    _loc_20 = _loc_18.zpp_inner;
                                    if (_loc_20._validate != null)
                                    {
                                        _loc_20._validate();
                                    }
                                }
                                if (_loc_18.zpp_inner.y != _loc_16)
                                {
                                    _loc_18.zpp_inner.x = _loc_10;
                                    _loc_18.zpp_inner.y = _loc_16;
                                    _loc_20 = _loc_18.zpp_inner;
                                    if (_loc_20._invalidate != null)
                                    {
                                        _loc_20._invalidate(_loc_20);
                                    }
                                }
                            }
                            _loc_18.zpp_inner.weak = _loc_17;
                            _loc_15.zpp_inner.wrap_worldCOM = _loc_18;
                            _loc_15.zpp_inner.wrap_worldCOM.zpp_inner._inuse = true;
                            _loc_15.zpp_inner.wrap_worldCOM.zpp_inner._immutable = true;
                            _loc_15.zpp_inner.wrap_worldCOM.zpp_inner._validate = _loc_15.zpp_inner.getworldCOM;
                        }
                        _loc_14 = _loc_15.zpp_inner.wrap_worldCOM;
                        if (_loc_14 != null)
                        {
                        }
                        if (_loc_14.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_20 = _loc_14.zpp_inner;
                        if (_loc_20._validate != null)
                        {
                            _loc_20._validate();
                        }
                        if (!_loc_7.zpp_inner.active)
                        {
                            throw "Error: Arbiter not currently in use";
                        }
                        if (_loc_7.zpp_inner.ws1.id > _loc_7.zpp_inner.ws2.id)
                        {
                            _loc_15 = _loc_7.zpp_inner.ws1.outer;
                        }
                        else
                        {
                            _loc_15 = _loc_7.zpp_inner.ws2.outer;
                        }
                        if (_loc_15.zpp_inner.wrap_worldCOM == null)
                        {
                            _loc_10 = _loc_15.zpp_inner.worldCOMx;
                            _loc_16 = _loc_15.zpp_inner.worldCOMy;
                            _loc_17 = false;
                            if (_loc_10 == _loc_10)
                            {
                            }
                            if (_loc_16 != _loc_16)
                            {
                                throw "Error: Vec2 components cannot be NaN";
                            }
                            if (ZPP_PubPool.poolVec2 == null)
                            {
                                _loc_18 = new Vec2();
                            }
                            else
                            {
                                _loc_18 = ZPP_PubPool.poolVec2;
                                ZPP_PubPool.poolVec2 = _loc_18.zpp_pool;
                                _loc_18.zpp_pool = null;
                                _loc_18.zpp_disp = false;
                                if (_loc_18 == ZPP_PubPool.nextVec2)
                                {
                                    ZPP_PubPool.nextVec2 = null;
                                }
                            }
                            if (_loc_18.zpp_inner == null)
                            {
                                _loc_19 = false;
                                if (ZPP_Vec2.zpp_pool == null)
                                {
                                    _loc_20 = new ZPP_Vec2();
                                }
                                else
                                {
                                    _loc_20 = ZPP_Vec2.zpp_pool;
                                    ZPP_Vec2.zpp_pool = _loc_20.next;
                                    _loc_20.next = null;
                                }
                                _loc_20.weak = false;
                                _loc_20._immutable = _loc_19;
                                _loc_20.x = _loc_10;
                                _loc_20.y = _loc_16;
                                _loc_18.zpp_inner = _loc_20;
                                _loc_18.zpp_inner.outer = _loc_18;
                            }
                            else
                            {
                                if (_loc_18 != null)
                                {
                                }
                                if (_loc_18.zpp_disp)
                                {
                                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                                }
                                _loc_20 = _loc_18.zpp_inner;
                                if (_loc_20._immutable)
                                {
                                    throw "Error: Vec2 is immutable";
                                }
                                if (_loc_20._isimmutable != null)
                                {
                                    _loc_20._isimmutable();
                                }
                                if (_loc_10 == _loc_10)
                                {
                                }
                                if (_loc_16 != _loc_16)
                                {
                                    throw "Error: Vec2 components cannot be NaN";
                                }
                                if (_loc_18 != null)
                                {
                                }
                                if (_loc_18.zpp_disp)
                                {
                                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                                }
                                _loc_20 = _loc_18.zpp_inner;
                                if (_loc_20._validate != null)
                                {
                                    _loc_20._validate();
                                }
                                if (_loc_18.zpp_inner.x == _loc_10)
                                {
                                    if (_loc_18 != null)
                                    {
                                    }
                                    if (_loc_18.zpp_disp)
                                    {
                                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                                    }
                                    _loc_20 = _loc_18.zpp_inner;
                                    if (_loc_20._validate != null)
                                    {
                                        _loc_20._validate();
                                    }
                                }
                                if (_loc_18.zpp_inner.y != _loc_16)
                                {
                                    _loc_18.zpp_inner.x = _loc_10;
                                    _loc_18.zpp_inner.y = _loc_16;
                                    _loc_20 = _loc_18.zpp_inner;
                                    if (_loc_20._invalidate != null)
                                    {
                                        _loc_20._invalidate(_loc_20);
                                    }
                                }
                            }
                            _loc_18.zpp_inner.weak = _loc_17;
                            _loc_15.zpp_inner.wrap_worldCOM = _loc_18;
                            _loc_15.zpp_inner.wrap_worldCOM.zpp_inner._inuse = true;
                            _loc_15.zpp_inner.wrap_worldCOM.zpp_inner._immutable = true;
                            _loc_15.zpp_inner.wrap_worldCOM.zpp_inner._validate = _loc_15.zpp_inner.getworldCOM;
                        }
                        _loc_14 = _loc_15.zpp_inner.wrap_worldCOM;
                        if (_loc_14 != null)
                        {
                        }
                        if (_loc_14.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_20 = _loc_14.zpp_inner;
                        if (_loc_20._validate != null)
                        {
                            _loc_20._validate();
                        }
                        _loc_5 = param2.a * _loc_14.zpp_inner.x + param2.b * _loc_14.zpp_inner.y + param2.tx;
                        if (!_loc_7.zpp_inner.active)
                        {
                            throw "Error: Arbiter not currently in use";
                        }
                        if (_loc_7.zpp_inner.ws1.id > _loc_7.zpp_inner.ws2.id)
                        {
                            _loc_15 = _loc_7.zpp_inner.ws1.outer;
                        }
                        else
                        {
                            _loc_15 = _loc_7.zpp_inner.ws2.outer;
                        }
                        if (_loc_15.zpp_inner.wrap_worldCOM == null)
                        {
                            _loc_10 = _loc_15.zpp_inner.worldCOMx;
                            _loc_16 = _loc_15.zpp_inner.worldCOMy;
                            _loc_17 = false;
                            if (_loc_10 == _loc_10)
                            {
                            }
                            if (_loc_16 != _loc_16)
                            {
                                throw "Error: Vec2 components cannot be NaN";
                            }
                            if (ZPP_PubPool.poolVec2 == null)
                            {
                                _loc_18 = new Vec2();
                            }
                            else
                            {
                                _loc_18 = ZPP_PubPool.poolVec2;
                                ZPP_PubPool.poolVec2 = _loc_18.zpp_pool;
                                _loc_18.zpp_pool = null;
                                _loc_18.zpp_disp = false;
                                if (_loc_18 == ZPP_PubPool.nextVec2)
                                {
                                    ZPP_PubPool.nextVec2 = null;
                                }
                            }
                            if (_loc_18.zpp_inner == null)
                            {
                                _loc_19 = false;
                                if (ZPP_Vec2.zpp_pool == null)
                                {
                                    _loc_20 = new ZPP_Vec2();
                                }
                                else
                                {
                                    _loc_20 = ZPP_Vec2.zpp_pool;
                                    ZPP_Vec2.zpp_pool = _loc_20.next;
                                    _loc_20.next = null;
                                }
                                _loc_20.weak = false;
                                _loc_20._immutable = _loc_19;
                                _loc_20.x = _loc_10;
                                _loc_20.y = _loc_16;
                                _loc_18.zpp_inner = _loc_20;
                                _loc_18.zpp_inner.outer = _loc_18;
                            }
                            else
                            {
                                if (_loc_18 != null)
                                {
                                }
                                if (_loc_18.zpp_disp)
                                {
                                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                                }
                                _loc_20 = _loc_18.zpp_inner;
                                if (_loc_20._immutable)
                                {
                                    throw "Error: Vec2 is immutable";
                                }
                                if (_loc_20._isimmutable != null)
                                {
                                    _loc_20._isimmutable();
                                }
                                if (_loc_10 == _loc_10)
                                {
                                }
                                if (_loc_16 != _loc_16)
                                {
                                    throw "Error: Vec2 components cannot be NaN";
                                }
                                if (_loc_18 != null)
                                {
                                }
                                if (_loc_18.zpp_disp)
                                {
                                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                                }
                                _loc_20 = _loc_18.zpp_inner;
                                if (_loc_20._validate != null)
                                {
                                    _loc_20._validate();
                                }
                                if (_loc_18.zpp_inner.x == _loc_10)
                                {
                                    if (_loc_18 != null)
                                    {
                                    }
                                    if (_loc_18.zpp_disp)
                                    {
                                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                                    }
                                    _loc_20 = _loc_18.zpp_inner;
                                    if (_loc_20._validate != null)
                                    {
                                        _loc_20._validate();
                                    }
                                }
                                if (_loc_18.zpp_inner.y != _loc_16)
                                {
                                    _loc_18.zpp_inner.x = _loc_10;
                                    _loc_18.zpp_inner.y = _loc_16;
                                    _loc_20 = _loc_18.zpp_inner;
                                    if (_loc_20._invalidate != null)
                                    {
                                        _loc_20._invalidate(_loc_20);
                                    }
                                }
                            }
                            _loc_18.zpp_inner.weak = _loc_17;
                            _loc_15.zpp_inner.wrap_worldCOM = _loc_18;
                            _loc_15.zpp_inner.wrap_worldCOM.zpp_inner._inuse = true;
                            _loc_15.zpp_inner.wrap_worldCOM.zpp_inner._immutable = true;
                            _loc_15.zpp_inner.wrap_worldCOM.zpp_inner._validate = _loc_15.zpp_inner.getworldCOM;
                        }
                        _loc_14 = _loc_15.zpp_inner.wrap_worldCOM;
                        if (_loc_14 != null)
                        {
                        }
                        if (_loc_14.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_20 = _loc_14.zpp_inner;
                        if (_loc_20._validate != null)
                        {
                            _loc_20._validate();
                        }
                        if (!_loc_7.zpp_inner.active)
                        {
                            throw "Error: Arbiter not currently in use";
                        }
                        if (_loc_7.zpp_inner.ws1.id > _loc_7.zpp_inner.ws2.id)
                        {
                            _loc_15 = _loc_7.zpp_inner.ws1.outer;
                        }
                        else
                        {
                            _loc_15 = _loc_7.zpp_inner.ws2.outer;
                        }
                        if (_loc_15.zpp_inner.wrap_worldCOM == null)
                        {
                            _loc_10 = _loc_15.zpp_inner.worldCOMx;
                            _loc_16 = _loc_15.zpp_inner.worldCOMy;
                            _loc_17 = false;
                            if (_loc_10 == _loc_10)
                            {
                            }
                            if (_loc_16 != _loc_16)
                            {
                                throw "Error: Vec2 components cannot be NaN";
                            }
                            if (ZPP_PubPool.poolVec2 == null)
                            {
                                _loc_18 = new Vec2();
                            }
                            else
                            {
                                _loc_18 = ZPP_PubPool.poolVec2;
                                ZPP_PubPool.poolVec2 = _loc_18.zpp_pool;
                                _loc_18.zpp_pool = null;
                                _loc_18.zpp_disp = false;
                                if (_loc_18 == ZPP_PubPool.nextVec2)
                                {
                                    ZPP_PubPool.nextVec2 = null;
                                }
                            }
                            if (_loc_18.zpp_inner == null)
                            {
                                _loc_19 = false;
                                if (ZPP_Vec2.zpp_pool == null)
                                {
                                    _loc_20 = new ZPP_Vec2();
                                }
                                else
                                {
                                    _loc_20 = ZPP_Vec2.zpp_pool;
                                    ZPP_Vec2.zpp_pool = _loc_20.next;
                                    _loc_20.next = null;
                                }
                                _loc_20.weak = false;
                                _loc_20._immutable = _loc_19;
                                _loc_20.x = _loc_10;
                                _loc_20.y = _loc_16;
                                _loc_18.zpp_inner = _loc_20;
                                _loc_18.zpp_inner.outer = _loc_18;
                            }
                            else
                            {
                                if (_loc_18 != null)
                                {
                                }
                                if (_loc_18.zpp_disp)
                                {
                                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                                }
                                _loc_20 = _loc_18.zpp_inner;
                                if (_loc_20._immutable)
                                {
                                    throw "Error: Vec2 is immutable";
                                }
                                if (_loc_20._isimmutable != null)
                                {
                                    _loc_20._isimmutable();
                                }
                                if (_loc_10 == _loc_10)
                                {
                                }
                                if (_loc_16 != _loc_16)
                                {
                                    throw "Error: Vec2 components cannot be NaN";
                                }
                                if (_loc_18 != null)
                                {
                                }
                                if (_loc_18.zpp_disp)
                                {
                                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                                }
                                _loc_20 = _loc_18.zpp_inner;
                                if (_loc_20._validate != null)
                                {
                                    _loc_20._validate();
                                }
                                if (_loc_18.zpp_inner.x == _loc_10)
                                {
                                    if (_loc_18 != null)
                                    {
                                    }
                                    if (_loc_18.zpp_disp)
                                    {
                                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                                    }
                                    _loc_20 = _loc_18.zpp_inner;
                                    if (_loc_20._validate != null)
                                    {
                                        _loc_20._validate();
                                    }
                                }
                                if (_loc_18.zpp_inner.y != _loc_16)
                                {
                                    _loc_18.zpp_inner.x = _loc_10;
                                    _loc_18.zpp_inner.y = _loc_16;
                                    _loc_20 = _loc_18.zpp_inner;
                                    if (_loc_20._invalidate != null)
                                    {
                                        _loc_20._invalidate(_loc_20);
                                    }
                                }
                            }
                            _loc_18.zpp_inner.weak = _loc_17;
                            _loc_15.zpp_inner.wrap_worldCOM = _loc_18;
                            _loc_15.zpp_inner.wrap_worldCOM.zpp_inner._inuse = true;
                            _loc_15.zpp_inner.wrap_worldCOM.zpp_inner._immutable = true;
                            _loc_15.zpp_inner.wrap_worldCOM.zpp_inner._validate = _loc_15.zpp_inner.getworldCOM;
                        }
                        _loc_14 = _loc_15.zpp_inner.wrap_worldCOM;
                        if (_loc_14 != null)
                        {
                        }
                        if (_loc_14.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_20 = _loc_14.zpp_inner;
                        if (_loc_20._validate != null)
                        {
                            _loc_20._validate();
                        }
                        _loc_6 = param2.c * _loc_14.zpp_inner.x + param2.d * _loc_14.zpp_inner.y + param2.ty;
                    }
                    _loc_8 = _loc_5 + 0.5;
                    _loc_9 = _loc_6 + 0.5;
                    __line(penx, peny, _loc_8, _loc_9, colour);
                    penx = _loc_8;
                    peny = _loc_9;
                }
            }
            else if (param1.outer.zpp_inner.type == ZPP_Arbiter.FLUID)
            {
                if (outer.drawFluidArbiters)
                {
                    _loc_7 = param1.outer;
                    if (_loc_7.zpp_inner.type == ZPP_Arbiter.FLUID)
                    {
                        _loc_21 = _loc_7.zpp_inner.fluidarb.outer_zn;
                    }
                    else
                    {
                        _loc_21 = null;
                    }
                    _loc_8 = 255;
                    _loc_9 = ~bg_col;
                    _loc_10 = 0.7;
                    _loc_11 = (_loc_8 >> 16 & 255) * _loc_10 + (_loc_9 >> 16 & 255) * (1 - _loc_10);
                    _loc_12 = (_loc_8 >> 8 & 255) * _loc_10 + (_loc_9 >> 8 & 255) * (1 - _loc_10);
                    _loc_13 = (_loc_8 & 255) * _loc_10 + (_loc_9 & 255) * (1 - _loc_10);
                    colour = -16777216 | _loc_11 << 16 | _loc_12 << 8 | _loc_13;
                    if (param4)
                    {
                        if (!_loc_21.zpp_inner.active)
                        {
                            throw "Error: Arbiter not currently in use";
                        }
                        if (_loc_21.zpp_inner.fluidarb.wrap_position == null)
                        {
                            _loc_21.zpp_inner.fluidarb.getposition();
                        }
                        _loc_14 = _loc_21.zpp_inner.fluidarb.wrap_position;
                        if (_loc_14 != null)
                        {
                        }
                        if (_loc_14.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_20 = _loc_14.zpp_inner;
                        if (_loc_20._validate != null)
                        {
                            _loc_20._validate();
                        }
                        _loc_5 = _loc_14.zpp_inner.x;
                        if (!_loc_21.zpp_inner.active)
                        {
                            throw "Error: Arbiter not currently in use";
                        }
                        if (_loc_21.zpp_inner.fluidarb.wrap_position == null)
                        {
                            _loc_21.zpp_inner.fluidarb.getposition();
                        }
                        _loc_14 = _loc_21.zpp_inner.fluidarb.wrap_position;
                        if (_loc_14 != null)
                        {
                        }
                        if (_loc_14.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_20 = _loc_14.zpp_inner;
                        if (_loc_20._validate != null)
                        {
                            _loc_20._validate();
                        }
                        _loc_6 = _loc_14.zpp_inner.y;
                    }
                    else
                    {
                        if (!_loc_21.zpp_inner.active)
                        {
                            throw "Error: Arbiter not currently in use";
                        }
                        if (_loc_21.zpp_inner.fluidarb.wrap_position == null)
                        {
                            _loc_21.zpp_inner.fluidarb.getposition();
                        }
                        _loc_14 = _loc_21.zpp_inner.fluidarb.wrap_position;
                        if (_loc_14 != null)
                        {
                        }
                        if (_loc_14.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_20 = _loc_14.zpp_inner;
                        if (_loc_20._validate != null)
                        {
                            _loc_20._validate();
                        }
                        if (!_loc_21.zpp_inner.active)
                        {
                            throw "Error: Arbiter not currently in use";
                        }
                        if (_loc_21.zpp_inner.fluidarb.wrap_position == null)
                        {
                            _loc_21.zpp_inner.fluidarb.getposition();
                        }
                        _loc_14 = _loc_21.zpp_inner.fluidarb.wrap_position;
                        if (_loc_14 != null)
                        {
                        }
                        if (_loc_14.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_20 = _loc_14.zpp_inner;
                        if (_loc_20._validate != null)
                        {
                            _loc_20._validate();
                        }
                        _loc_5 = param2.a * _loc_14.zpp_inner.x + param2.b * _loc_14.zpp_inner.y + param2.tx;
                        if (!_loc_21.zpp_inner.active)
                        {
                            throw "Error: Arbiter not currently in use";
                        }
                        if (_loc_21.zpp_inner.fluidarb.wrap_position == null)
                        {
                            _loc_21.zpp_inner.fluidarb.getposition();
                        }
                        _loc_14 = _loc_21.zpp_inner.fluidarb.wrap_position;
                        if (_loc_14 != null)
                        {
                        }
                        if (_loc_14.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_20 = _loc_14.zpp_inner;
                        if (_loc_20._validate != null)
                        {
                            _loc_20._validate();
                        }
                        if (!_loc_21.zpp_inner.active)
                        {
                            throw "Error: Arbiter not currently in use";
                        }
                        if (_loc_21.zpp_inner.fluidarb.wrap_position == null)
                        {
                            _loc_21.zpp_inner.fluidarb.getposition();
                        }
                        _loc_14 = _loc_21.zpp_inner.fluidarb.wrap_position;
                        if (_loc_14 != null)
                        {
                        }
                        if (_loc_14.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_20 = _loc_14.zpp_inner;
                        if (_loc_20._validate != null)
                        {
                            _loc_20._validate();
                        }
                        _loc_6 = param2.c * _loc_14.zpp_inner.x + param2.d * _loc_14.zpp_inner.y + param2.ty;
                    }
                    penx = _loc_5 + 0.5;
                    peny = _loc_6 + 0.5;
                    __circle(penx, peny, 1.25, colour);
                }
            }
            else if (outer.drawCollisionArbiters)
            {
                _loc_7 = param1.outer;
                if (_loc_7.zpp_inner.type == ZPP_Arbiter.COL)
                {
                    _loc_22 = _loc_7.zpp_inner.colarb.outer_zn;
                }
                else
                {
                    _loc_22 = null;
                }
                if (!_loc_22.zpp_inner.active)
                {
                    throw "Error: Arbiter not currently in use";
                }
                if (_loc_22.zpp_inner.colarb.wrap_contacts == null)
                {
                    _loc_22.zpp_inner.colarb.setupcontacts();
                }
                _loc_23 = _loc_22.zpp_inner.colarb.wrap_contacts;
                _loc_23.zpp_inner.valmod();
                if (_loc_23.zpp_inner.zip_length)
                {
                    _loc_23.zpp_inner.zip_length = false;
                    _loc_23.zpp_inner.user_length = 0;
                    _loc_24 = _loc_23.zpp_inner.inner.next;
                    while (_loc_24 != null)
                    {
                        
                        _loc_25 = _loc_24;
                        if (_loc_25.active)
                        {
                        }
                        if (_loc_25.arbiter.active)
                        {
                            (_loc_23.zpp_inner.user_length + 1);
                        }
                        _loc_24 = _loc_24.next;
                    }
                }
                if (_loc_23.zpp_inner.user_length != 0)
                {
                    _loc_10 = 0;
                    _loc_16 = 0;
                    if (!_loc_22.zpp_inner.active)
                    {
                        throw "Error: Arbiter not currently in use";
                    }
                    if (_loc_22.zpp_inner.colarb.wrap_contacts == null)
                    {
                        _loc_22.zpp_inner.colarb.setupcontacts();
                    }
                    _loc_23 = _loc_22.zpp_inner.colarb.wrap_contacts;
                    _loc_23.zpp_inner.valmod();
                    if (_loc_23.zpp_inner.zip_length)
                    {
                        _loc_23.zpp_inner.zip_length = false;
                        _loc_23.zpp_inner.user_length = 0;
                        _loc_24 = _loc_23.zpp_inner.inner.next;
                        while (_loc_24 != null)
                        {
                            
                            _loc_25 = _loc_24;
                            if (_loc_25.active)
                            {
                            }
                            if (_loc_25.arbiter.active)
                            {
                                (_loc_23.zpp_inner.user_length + 1);
                            }
                            _loc_24 = _loc_24.next;
                        }
                    }
                    if (_loc_23.zpp_inner.user_length == 2)
                    {
                        if (!_loc_22.zpp_inner.active)
                        {
                            throw "Error: Arbiter not currently in use";
                        }
                        if (_loc_22.zpp_inner.colarb.wrap_contacts == null)
                        {
                            _loc_22.zpp_inner.colarb.setupcontacts();
                        }
                        _loc_26 = _loc_22.zpp_inner.colarb.wrap_contacts.at(0);
                        if (_loc_26.zpp_inner.inactiveme())
                        {
                            throw "Error: Contact not currently in use";
                        }
                        if (_loc_26.zpp_inner.wrap_position == null)
                        {
                            _loc_26.zpp_inner.getposition();
                        }
                        _loc_14 = _loc_26.zpp_inner.wrap_position;
                        if (!_loc_22.zpp_inner.active)
                        {
                            throw "Error: Arbiter not currently in use";
                        }
                        if (_loc_22.zpp_inner.colarb.wrap_contacts == null)
                        {
                            _loc_22.zpp_inner.colarb.setupcontacts();
                        }
                        _loc_26 = _loc_22.zpp_inner.colarb.wrap_contacts.at(1);
                        if (_loc_26.zpp_inner.inactiveme())
                        {
                            throw "Error: Contact not currently in use";
                        }
                        if (_loc_26.zpp_inner.wrap_position == null)
                        {
                            _loc_26.zpp_inner.getposition();
                        }
                        _loc_18 = _loc_26.zpp_inner.wrap_position;
                        if (!_loc_22.zpp_inner.active)
                        {
                            throw "Error: Arbiter not currently in use";
                        }
                        if (_loc_22.zpp_inner.colarb.wrap_normal == null)
                        {
                            _loc_22.zpp_inner.colarb.getnormal();
                        }
                        _loc_27 = _loc_22.zpp_inner.colarb.wrap_normal;
                        _loc_28 = 0.661438;
                        _loc_29 = 0.75;
                        if (_loc_27 != null)
                        {
                        }
                        if (_loc_27.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_20 = _loc_27.zpp_inner;
                        if (_loc_20._validate != null)
                        {
                            _loc_20._validate();
                        }
                        if (_loc_14 != null)
                        {
                        }
                        if (_loc_14.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_20 = _loc_14.zpp_inner;
                        if (_loc_20._validate != null)
                        {
                            _loc_20._validate();
                        }
                        if (_loc_27 != null)
                        {
                        }
                        if (_loc_27.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_20 = _loc_27.zpp_inner;
                        if (_loc_20._validate != null)
                        {
                            _loc_20._validate();
                        }
                        if (_loc_14 != null)
                        {
                        }
                        if (_loc_14.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_20 = _loc_14.zpp_inner;
                        if (_loc_20._validate != null)
                        {
                            _loc_20._validate();
                        }
                        if (_loc_27 != null)
                        {
                        }
                        if (_loc_27.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_20 = _loc_27.zpp_inner;
                        if (_loc_20._validate != null)
                        {
                            _loc_20._validate();
                        }
                        if (_loc_18 != null)
                        {
                        }
                        if (_loc_18.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_20 = _loc_18.zpp_inner;
                        if (_loc_20._validate != null)
                        {
                            _loc_20._validate();
                        }
                        if (_loc_27 != null)
                        {
                        }
                        if (_loc_27.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_20 = _loc_27.zpp_inner;
                        if (_loc_20._validate != null)
                        {
                            _loc_20._validate();
                        }
                        if (_loc_18 != null)
                        {
                        }
                        if (_loc_18.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_20 = _loc_18.zpp_inner;
                        if (_loc_20._validate != null)
                        {
                            _loc_20._validate();
                        }
                        if (_loc_27.zpp_inner.y * _loc_14.zpp_inner.x - _loc_27.zpp_inner.x * _loc_14.zpp_inner.y < _loc_27.zpp_inner.y * _loc_18.zpp_inner.x - _loc_27.zpp_inner.x * _loc_18.zpp_inner.y)
                        {
                            _loc_28 = -_loc_28;
                            _loc_29 = -_loc_29;
                        }
                        _loc_8 = 255;
                        _loc_9 = ~bg_col;
                        _loc_30 = 0.7;
                        _loc_11 = (_loc_8 >> 16 & 255) * _loc_30 + (_loc_9 >> 16 & 255) * (1 - _loc_30);
                        _loc_12 = (_loc_8 >> 8 & 255) * _loc_30 + (_loc_9 >> 8 & 255) * (1 - _loc_30);
                        _loc_13 = (_loc_8 & 255) * _loc_30 + (_loc_9 & 255) * (1 - _loc_30);
                        colour = -16777216 | _loc_11 << 16 | _loc_12 << 8 | _loc_13;
                        if (_loc_14 != null)
                        {
                        }
                        if (_loc_14.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_20 = _loc_14.zpp_inner;
                        if (_loc_20._validate != null)
                        {
                            _loc_20._validate();
                        }
                        if (_loc_27 != null)
                        {
                        }
                        if (_loc_27.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_20 = _loc_27.zpp_inner;
                        if (_loc_20._validate != null)
                        {
                            _loc_20._validate();
                        }
                        if (_loc_27 != null)
                        {
                        }
                        if (_loc_27.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_20 = _loc_27.zpp_inner;
                        if (_loc_20._validate != null)
                        {
                            _loc_20._validate();
                        }
                        _loc_5 = _loc_14.zpp_inner.x + _loc_27.zpp_inner.x * _loc_29 - _loc_27.zpp_inner.y * _loc_28;
                        if (_loc_14 != null)
                        {
                        }
                        if (_loc_14.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_20 = _loc_14.zpp_inner;
                        if (_loc_20._validate != null)
                        {
                            _loc_20._validate();
                        }
                        if (_loc_27 != null)
                        {
                        }
                        if (_loc_27.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_20 = _loc_27.zpp_inner;
                        if (_loc_20._validate != null)
                        {
                            _loc_20._validate();
                        }
                        if (_loc_27 != null)
                        {
                        }
                        if (_loc_27.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_20 = _loc_27.zpp_inner;
                        if (_loc_20._validate != null)
                        {
                            _loc_20._validate();
                        }
                        _loc_6 = _loc_14.zpp_inner.y + _loc_27.zpp_inner.y * _loc_29 + _loc_27.zpp_inner.x * _loc_28;
                        if (!param4)
                        {
                            _loc_30 = param2.a * _loc_5 + param2.b * _loc_6 + param2.tx;
                            _loc_6 = param2.c * _loc_5 + param2.d * _loc_6 + param2.ty;
                            _loc_5 = _loc_30;
                        }
                        penx = _loc_5 + 0.5;
                        peny = _loc_6 + 0.5;
                        if (_loc_18 != null)
                        {
                        }
                        if (_loc_18.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_20 = _loc_18.zpp_inner;
                        if (_loc_20._validate != null)
                        {
                            _loc_20._validate();
                        }
                        if (_loc_27 != null)
                        {
                        }
                        if (_loc_27.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_20 = _loc_27.zpp_inner;
                        if (_loc_20._validate != null)
                        {
                            _loc_20._validate();
                        }
                        if (_loc_27 != null)
                        {
                        }
                        if (_loc_27.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_20 = _loc_27.zpp_inner;
                        if (_loc_20._validate != null)
                        {
                            _loc_20._validate();
                        }
                        _loc_5 = _loc_18.zpp_inner.x + _loc_27.zpp_inner.x * _loc_29 + _loc_27.zpp_inner.y * _loc_28;
                        if (_loc_18 != null)
                        {
                        }
                        if (_loc_18.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_20 = _loc_18.zpp_inner;
                        if (_loc_20._validate != null)
                        {
                            _loc_20._validate();
                        }
                        if (_loc_27 != null)
                        {
                        }
                        if (_loc_27.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_20 = _loc_27.zpp_inner;
                        if (_loc_20._validate != null)
                        {
                            _loc_20._validate();
                        }
                        if (_loc_27 != null)
                        {
                        }
                        if (_loc_27.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_20 = _loc_27.zpp_inner;
                        if (_loc_20._validate != null)
                        {
                            _loc_20._validate();
                        }
                        _loc_6 = _loc_18.zpp_inner.y + _loc_27.zpp_inner.y * _loc_29 - _loc_27.zpp_inner.x * _loc_28;
                        if (!param4)
                        {
                            _loc_30 = param2.a * _loc_5 + param2.b * _loc_6 + param2.tx;
                            _loc_6 = param2.c * _loc_5 + param2.d * _loc_6 + param2.ty;
                            _loc_5 = _loc_30;
                        }
                        _loc_8 = _loc_5 + 0.5;
                        _loc_9 = _loc_6 + 0.5;
                        __line(penx, peny, _loc_8, _loc_9, colour);
                        penx = _loc_8;
                        peny = _loc_9;
                        _loc_8 = 16711680;
                        _loc_9 = ~bg_col;
                        _loc_30 = 0.7;
                        _loc_11 = (_loc_8 >> 16 & 255) * _loc_30 + (_loc_9 >> 16 & 255) * (1 - _loc_30);
                        _loc_12 = (_loc_8 >> 8 & 255) * _loc_30 + (_loc_9 >> 8 & 255) * (1 - _loc_30);
                        _loc_13 = (_loc_8 & 255) * _loc_30 + (_loc_9 & 255) * (1 - _loc_30);
                        colour = -16777216 | _loc_11 << 16 | _loc_12 << 8 | _loc_13;
                        if (_loc_14 != null)
                        {
                        }
                        if (_loc_14.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_20 = _loc_14.zpp_inner;
                        if (_loc_20._validate != null)
                        {
                            _loc_20._validate();
                        }
                        if (_loc_27 != null)
                        {
                        }
                        if (_loc_27.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_20 = _loc_27.zpp_inner;
                        if (_loc_20._validate != null)
                        {
                            _loc_20._validate();
                        }
                        if (_loc_27 != null)
                        {
                        }
                        if (_loc_27.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_20 = _loc_27.zpp_inner;
                        if (_loc_20._validate != null)
                        {
                            _loc_20._validate();
                        }
                        _loc_5 = _loc_14.zpp_inner.x - _loc_27.zpp_inner.x * _loc_29 - _loc_27.zpp_inner.y * _loc_28;
                        if (_loc_14 != null)
                        {
                        }
                        if (_loc_14.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_20 = _loc_14.zpp_inner;
                        if (_loc_20._validate != null)
                        {
                            _loc_20._validate();
                        }
                        if (_loc_27 != null)
                        {
                        }
                        if (_loc_27.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_20 = _loc_27.zpp_inner;
                        if (_loc_20._validate != null)
                        {
                            _loc_20._validate();
                        }
                        if (_loc_27 != null)
                        {
                        }
                        if (_loc_27.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_20 = _loc_27.zpp_inner;
                        if (_loc_20._validate != null)
                        {
                            _loc_20._validate();
                        }
                        _loc_6 = _loc_14.zpp_inner.y - _loc_27.zpp_inner.y * _loc_29 + _loc_27.zpp_inner.x * _loc_28;
                        if (!param4)
                        {
                            _loc_30 = param2.a * _loc_5 + param2.b * _loc_6 + param2.tx;
                            _loc_6 = param2.c * _loc_5 + param2.d * _loc_6 + param2.ty;
                            _loc_5 = _loc_30;
                        }
                        penx = _loc_5 + 0.5;
                        peny = _loc_6 + 0.5;
                        if (_loc_18 != null)
                        {
                        }
                        if (_loc_18.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_20 = _loc_18.zpp_inner;
                        if (_loc_20._validate != null)
                        {
                            _loc_20._validate();
                        }
                        if (_loc_27 != null)
                        {
                        }
                        if (_loc_27.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_20 = _loc_27.zpp_inner;
                        if (_loc_20._validate != null)
                        {
                            _loc_20._validate();
                        }
                        if (_loc_27 != null)
                        {
                        }
                        if (_loc_27.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_20 = _loc_27.zpp_inner;
                        if (_loc_20._validate != null)
                        {
                            _loc_20._validate();
                        }
                        _loc_5 = _loc_18.zpp_inner.x - _loc_27.zpp_inner.x * _loc_29 + _loc_27.zpp_inner.y * _loc_28;
                        if (_loc_18 != null)
                        {
                        }
                        if (_loc_18.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_20 = _loc_18.zpp_inner;
                        if (_loc_20._validate != null)
                        {
                            _loc_20._validate();
                        }
                        if (_loc_27 != null)
                        {
                        }
                        if (_loc_27.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_20 = _loc_27.zpp_inner;
                        if (_loc_20._validate != null)
                        {
                            _loc_20._validate();
                        }
                        if (_loc_27 != null)
                        {
                        }
                        if (_loc_27.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_20 = _loc_27.zpp_inner;
                        if (_loc_20._validate != null)
                        {
                            _loc_20._validate();
                        }
                        _loc_6 = _loc_18.zpp_inner.y - _loc_27.zpp_inner.y * _loc_29 - _loc_27.zpp_inner.x * _loc_28;
                        if (!param4)
                        {
                            _loc_30 = param2.a * _loc_5 + param2.b * _loc_6 + param2.tx;
                            _loc_6 = param2.c * _loc_5 + param2.d * _loc_6 + param2.ty;
                            _loc_5 = _loc_30;
                        }
                        _loc_8 = _loc_5 + 0.5;
                        _loc_9 = _loc_6 + 0.5;
                        __line(penx, peny, _loc_8, _loc_9, colour);
                        penx = _loc_8;
                        peny = _loc_9;
                        if (_loc_14 != null)
                        {
                        }
                        if (_loc_14.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_20 = _loc_14.zpp_inner;
                        if (_loc_20._validate != null)
                        {
                            _loc_20._validate();
                        }
                        if (_loc_18 != null)
                        {
                        }
                        if (_loc_18.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_20 = _loc_18.zpp_inner;
                        if (_loc_20._validate != null)
                        {
                            _loc_20._validate();
                        }
                        _loc_10 = 0.5 * (_loc_14.zpp_inner.x + _loc_18.zpp_inner.x);
                        if (_loc_14 != null)
                        {
                        }
                        if (_loc_14.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_20 = _loc_14.zpp_inner;
                        if (_loc_20._validate != null)
                        {
                            _loc_20._validate();
                        }
                        if (_loc_18 != null)
                        {
                        }
                        if (_loc_18.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_20 = _loc_18.zpp_inner;
                        if (_loc_20._validate != null)
                        {
                            _loc_20._validate();
                        }
                        _loc_16 = 0.5 * (_loc_14.zpp_inner.y + _loc_18.zpp_inner.y);
                        if (!param4)
                        {
                            _loc_30 = param2.a * _loc_10 + param2.b * _loc_16 + param2.tx;
                            _loc_16 = param2.c * _loc_10 + param2.d * _loc_16 + param2.ty;
                            _loc_10 = _loc_30;
                        }
                    }
                    else
                    {
                        if (!_loc_22.zpp_inner.active)
                        {
                            throw "Error: Arbiter not currently in use";
                        }
                        if (_loc_22.zpp_inner.colarb.wrap_contacts == null)
                        {
                            _loc_22.zpp_inner.colarb.setupcontacts();
                        }
                        _loc_26 = _loc_22.zpp_inner.colarb.wrap_contacts.at(0);
                        if (_loc_26.zpp_inner.inactiveme())
                        {
                            throw "Error: Contact not currently in use";
                        }
                        if (_loc_26.zpp_inner.wrap_position == null)
                        {
                            _loc_26.zpp_inner.getposition();
                        }
                        _loc_14 = _loc_26.zpp_inner.wrap_position;
                        if (_loc_14 != null)
                        {
                        }
                        if (_loc_14.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_20 = _loc_14.zpp_inner;
                        if (_loc_20._validate != null)
                        {
                            _loc_20._validate();
                        }
                        _loc_10 = _loc_14.zpp_inner.x;
                        if (!_loc_22.zpp_inner.active)
                        {
                            throw "Error: Arbiter not currently in use";
                        }
                        if (_loc_22.zpp_inner.colarb.wrap_contacts == null)
                        {
                            _loc_22.zpp_inner.colarb.setupcontacts();
                        }
                        _loc_26 = _loc_22.zpp_inner.colarb.wrap_contacts.at(0);
                        if (_loc_26.zpp_inner.inactiveme())
                        {
                            throw "Error: Contact not currently in use";
                        }
                        if (_loc_26.zpp_inner.wrap_position == null)
                        {
                            _loc_26.zpp_inner.getposition();
                        }
                        _loc_14 = _loc_26.zpp_inner.wrap_position;
                        if (_loc_14 != null)
                        {
                        }
                        if (_loc_14.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_20 = _loc_14.zpp_inner;
                        if (_loc_20._validate != null)
                        {
                            _loc_20._validate();
                        }
                        _loc_16 = _loc_14.zpp_inner.y;
                        if (!param4)
                        {
                            _loc_28 = param2.a * _loc_10 + param2.b * _loc_16 + param2.tx;
                            _loc_16 = param2.c * _loc_10 + param2.d * _loc_16 + param2.ty;
                            _loc_10 = _loc_28;
                        }
                        _loc_8 = 16711935;
                        _loc_9 = ~bg_col;
                        _loc_28 = 0.7;
                        _loc_11 = (_loc_8 >> 16 & 255) * _loc_28 + (_loc_9 >> 16 & 255) * (1 - _loc_28);
                        _loc_12 = (_loc_8 >> 8 & 255) * _loc_28 + (_loc_9 >> 8 & 255) * (1 - _loc_28);
                        _loc_13 = (_loc_8 & 255) * _loc_28 + (_loc_9 & 255) * (1 - _loc_28);
                        colour = -16777216 | _loc_11 << 16 | _loc_12 << 8 | _loc_13;
                        penx = _loc_10 + 0.5;
                        peny = _loc_16 + 0.5;
                        __circle(penx, peny, 1.5, colour);
                    }
                    _loc_8 = ~bg_col;
                    _loc_9 = bg_col;
                    _loc_28 = 0.7;
                    _loc_11 = (_loc_8 >> 16 & 255) * _loc_28 + (_loc_9 >> 16 & 255) * (1 - _loc_28);
                    _loc_12 = (_loc_8 >> 8 & 255) * _loc_28 + (_loc_9 >> 8 & 255) * (1 - _loc_28);
                    _loc_13 = (_loc_8 & 255) * _loc_28 + (_loc_9 & 255) * (1 - _loc_28);
                    colour = -16777216 | _loc_11 << 16 | _loc_12 << 8 | _loc_13;
                    penx = _loc_10 + 0.5;
                    peny = _loc_16 + 0.5;
                    if (!_loc_22.zpp_inner.active)
                    {
                        throw "Error: Arbiter not currently in use";
                    }
                    if (_loc_22.zpp_inner.colarb.wrap_normal == null)
                    {
                        _loc_22.zpp_inner.colarb.getnormal();
                    }
                    _loc_14 = _loc_22.zpp_inner.colarb.wrap_normal;
                    if (_loc_14 != null)
                    {
                    }
                    if (_loc_14.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_20 = _loc_14.zpp_inner;
                    if (_loc_20._validate != null)
                    {
                        _loc_20._validate();
                    }
                    _loc_5 = _loc_14.zpp_inner.x * 5;
                    if (!_loc_22.zpp_inner.active)
                    {
                        throw "Error: Arbiter not currently in use";
                    }
                    if (_loc_22.zpp_inner.colarb.wrap_normal == null)
                    {
                        _loc_22.zpp_inner.colarb.getnormal();
                    }
                    _loc_14 = _loc_22.zpp_inner.colarb.wrap_normal;
                    if (_loc_14 != null)
                    {
                    }
                    if (_loc_14.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_20 = _loc_14.zpp_inner;
                    if (_loc_20._validate != null)
                    {
                        _loc_20._validate();
                    }
                    _loc_6 = _loc_14.zpp_inner.y * 5;
                    if (!param4)
                    {
                        _loc_28 = param2.a * _loc_5 + param2.b * _loc_6;
                        _loc_6 = param2.c * _loc_5 + param2.d * _loc_6;
                        _loc_5 = _loc_28;
                    }
                    _loc_8 = _loc_10 + _loc_5 + 0.5;
                    _loc_9 = _loc_16 + _loc_6 + 0.5;
                    __line(penx, peny, _loc_8, _loc_9, colour);
                    penx = _loc_8;
                    peny = _loc_9;
                }
            }
            return;
        }// end function

        public function clear() : void
        {
            bytes.position = 0;
            bgbytes.position = 0;
            bytes.writeBytes(bgbytes);
            return;
        }// end function

        public function __tri(param1:Vec2, param2:Vec2, param3:Vec2, param4:int) : void
        {
            var _loc_6:* = NaN;
            var _loc_7:* = null as ZPP_Vec2;
            var _loc_13:* = null as Vec2;
            var _loc_14:* = null as ZPP_Vec2;
            var _loc_15:* = 0;
            var _loc_16:* = 0;
            var _loc_17:* = 0;
            var _loc_18:* = 0;
            var _loc_19:* = NaN;
            var _loc_20:* = 0;
            var _loc_21:* = 0;
            var _loc_22:* = 0;
            var _loc_23:* = 0;
            var _loc_24:* = 0;
            var _loc_25:* = 0;
            if (!xnull)
            {
                param1 = xform.outer.transform(param1);
                param2 = xform.outer.transform(param2);
                param3 = xform.outer.transform(param3);
            }
            if (param1 != null)
            {
            }
            if (param1.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_7 = param1.zpp_inner;
            if (_loc_7._validate != null)
            {
                _loc_7._validate();
            }
            _loc_6 = param1.zpp_inner.x;
            var _loc_5:* = _loc_6 + 0.5;
            if (param1 != null)
            {
            }
            if (param1.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_7 = param1.zpp_inner;
            if (_loc_7._validate != null)
            {
                _loc_7._validate();
            }
            _loc_6 = param1.zpp_inner.y;
            var _loc_8:* = _loc_6 + 0.5;
            if (param2 != null)
            {
            }
            if (param2.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_7 = param2.zpp_inner;
            if (_loc_7._validate != null)
            {
                _loc_7._validate();
            }
            _loc_6 = param2.zpp_inner.x;
            var _loc_9:* = _loc_6 + 0.5;
            if (param2 != null)
            {
            }
            if (param2.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_7 = param2.zpp_inner;
            if (_loc_7._validate != null)
            {
                _loc_7._validate();
            }
            _loc_6 = param2.zpp_inner.y;
            var _loc_10:* = _loc_6 + 0.5;
            if (param3 != null)
            {
            }
            if (param3.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_7 = param3.zpp_inner;
            if (_loc_7._validate != null)
            {
                _loc_7._validate();
            }
            _loc_6 = param3.zpp_inner.x;
            var _loc_11:* = _loc_6 + 0.5;
            if (param3 != null)
            {
            }
            if (param3.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_7 = param3.zpp_inner;
            if (_loc_7._validate != null)
            {
                _loc_7._validate();
            }
            _loc_6 = param3.zpp_inner.y;
            var _loc_12:* = _loc_6 + 0.5;
            if (!xnull)
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
                _loc_13 = param1;
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
                _loc_14 = _loc_7;
                if (_loc_14.outer != null)
                {
                    _loc_14.outer.zpp_inner = null;
                    _loc_14.outer = null;
                }
                _loc_14._isimmutable = null;
                _loc_14._validate = null;
                _loc_14._invalidate = null;
                _loc_14.next = ZPP_Vec2.zpp_pool;
                ZPP_Vec2.zpp_pool = _loc_14;
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
                _loc_13 = param2;
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
                _loc_14 = _loc_7;
                if (_loc_14.outer != null)
                {
                    _loc_14.outer.zpp_inner = null;
                    _loc_14.outer = null;
                }
                _loc_14._isimmutable = null;
                _loc_14._validate = null;
                _loc_14._invalidate = null;
                _loc_14.next = ZPP_Vec2.zpp_pool;
                ZPP_Vec2.zpp_pool = _loc_14;
                if (param3 != null)
                {
                }
                if (param3.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_7 = param3.zpp_inner;
                if (_loc_7._immutable)
                {
                    throw "Error: Vec2 is immutable";
                }
                if (_loc_7._isimmutable != null)
                {
                    _loc_7._isimmutable();
                }
                if (param3.zpp_inner._inuse)
                {
                    throw "Error: This Vec2 is not disposable";
                }
                _loc_7 = param3.zpp_inner;
                param3.zpp_inner.outer = null;
                param3.zpp_inner = null;
                _loc_13 = param3;
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
                _loc_14 = _loc_7;
                if (_loc_14.outer != null)
                {
                    _loc_14.outer.zpp_inner = null;
                    _loc_14.outer = null;
                }
                _loc_14._isimmutable = null;
                _loc_14._validate = null;
                _loc_14._invalidate = null;
                _loc_14.next = ZPP_Vec2.zpp_pool;
                ZPP_Vec2.zpp_pool = _loc_14;
            }
            if (_loc_10 < _loc_8)
            {
                _loc_15 = _loc_5;
                _loc_5 = _loc_9;
                _loc_9 = _loc_15;
                _loc_15 = _loc_8;
                _loc_8 = _loc_10;
                _loc_10 = _loc_15;
            }
            if (_loc_12 < _loc_8)
            {
                _loc_15 = _loc_5;
                _loc_16 = _loc_9;
                _loc_5 = _loc_11;
                _loc_9 = _loc_15;
                _loc_11 = _loc_16;
                _loc_17 = _loc_8;
                _loc_18 = _loc_10;
                _loc_8 = _loc_12;
                _loc_10 = _loc_17;
                _loc_12 = _loc_18;
            }
            else if (_loc_12 < _loc_10)
            {
                _loc_15 = _loc_9;
                _loc_9 = _loc_11;
                _loc_11 = _loc_15;
                _loc_15 = _loc_10;
                _loc_10 = _loc_12;
                _loc_12 = _loc_15;
            }
            if (_loc_8 != _loc_12)
            {
                if (_loc_5 == _loc_9)
                {
                }
            }
            if (_loc_9 != _loc_11)
            {
                if ((_loc_5 - _loc_11) * (_loc_10 - _loc_12) - (_loc_8 - _loc_12) * (_loc_9 - _loc_11) < 0)
                {
                    _loc_6 = (_loc_11 - _loc_5) / (_loc_12 - _loc_8);
                    if (_loc_8 != _loc_10)
                    {
                        _loc_19 = (_loc_9 - _loc_5) / (_loc_10 - _loc_8);
                        _loc_15 = _loc_8;
                        _loc_16 = _loc_10;
                        if (_loc_15 < 0)
                        {
                            _loc_15 = 0;
                        }
                        if (_loc_16 >= height)
                        {
                            _loc_16 = height - 1;
                        }
                        _loc_17 = _loc_15;
                        while (_loc_17 < _loc_16)
                        {
                            
                            _loc_17++;
                            _loc_18 = _loc_17;
                            _loc_20 = _loc_18 - _loc_8;
                            _loc_21 = _loc_5 + _loc_20 * _loc_19 + 0.5;
                            _loc_22 = _loc_5 + _loc_20 * _loc_6 + 0.5;
                            if (_loc_21 < 0)
                            {
                                _loc_21 = 0;
                            }
                            if (_loc_22 >= width)
                            {
                                _loc_22 = width - 1;
                            }
                            _loc_23 = _loc_21;
                            _loc_24 = _loc_22 + 1;
                            while (_loc_23 < _loc_24)
                            {
                                
                                _loc_23++;
                                _loc_25 = _loc_23;
                                if (_loc_25 >= 0)
                                {
                                }
                                if (_loc_25 < width)
                                {
                                }
                                if (_loc_18 >= 0)
                                {
                                }
                                if (_loc_18 < height)
                                {
                                }
                            }
                        }
                    }
                    if (_loc_10 != _loc_12)
                    {
                        _loc_19 = (_loc_11 - _loc_9) / (_loc_12 - _loc_10);
                        _loc_15 = _loc_10;
                        _loc_16 = _loc_12;
                        if (_loc_15 < 0)
                        {
                            _loc_15 = 0;
                        }
                        if (_loc_16 >= height)
                        {
                            _loc_16 = height - 1;
                        }
                        _loc_17 = _loc_15;
                        _loc_18 = _loc_16 + 1;
                        while (_loc_17 < _loc_18)
                        {
                            
                            _loc_17++;
                            _loc_20 = _loc_17;
                            _loc_21 = _loc_9 + (_loc_20 - _loc_10) * _loc_19 + 0.5;
                            _loc_22 = _loc_5 + (_loc_20 - _loc_8) * _loc_6 + 0.5;
                            if (_loc_21 < 0)
                            {
                                _loc_21 = 0;
                            }
                            if (_loc_22 >= width)
                            {
                                _loc_22 = width - 1;
                            }
                            _loc_23 = _loc_21;
                            _loc_24 = _loc_22 + 1;
                            while (_loc_23 < _loc_24)
                            {
                                
                                _loc_23++;
                                _loc_25 = _loc_23;
                                if (_loc_25 >= 0)
                                {
                                }
                                if (_loc_25 < width)
                                {
                                }
                                if (_loc_20 >= 0)
                                {
                                }
                                if (_loc_20 < height)
                                {
                                }
                            }
                        }
                    }
                }
                else
                {
                    _loc_6 = (_loc_11 - _loc_5) / (_loc_12 - _loc_8);
                    if (_loc_8 != _loc_10)
                    {
                        _loc_19 = (_loc_9 - _loc_5) / (_loc_10 - _loc_8);
                        _loc_15 = _loc_8;
                        _loc_16 = _loc_10;
                        if (_loc_15 < 0)
                        {
                            _loc_15 = 0;
                        }
                        if (_loc_16 >= height)
                        {
                            _loc_16 = height - 1;
                        }
                        _loc_17 = _loc_15;
                        while (_loc_17 < _loc_16)
                        {
                            
                            _loc_17++;
                            _loc_18 = _loc_17;
                            _loc_20 = _loc_18 - _loc_8;
                            _loc_21 = _loc_5 + _loc_20 * _loc_19 + 0.5;
                            _loc_22 = _loc_5 + _loc_20 * _loc_6 + 0.5;
                            if (_loc_22 < 0)
                            {
                                _loc_22 = 0;
                            }
                            if (_loc_21 >= width)
                            {
                                _loc_21 = width - 1;
                            }
                            _loc_23 = _loc_22;
                            _loc_24 = _loc_21 + 1;
                            while (_loc_23 < _loc_24)
                            {
                                
                                _loc_23++;
                                _loc_25 = _loc_23;
                                if (_loc_25 >= 0)
                                {
                                }
                                if (_loc_25 < width)
                                {
                                }
                                if (_loc_18 >= 0)
                                {
                                }
                                if (_loc_18 < height)
                                {
                                }
                            }
                        }
                    }
                    if (_loc_10 != _loc_12)
                    {
                        _loc_19 = (_loc_11 - _loc_9) / (_loc_12 - _loc_10);
                        _loc_15 = _loc_10;
                        _loc_16 = _loc_12;
                        if (_loc_15 < 0)
                        {
                            _loc_15 = 0;
                        }
                        if (_loc_16 >= height)
                        {
                            _loc_16 = height - 1;
                        }
                        _loc_17 = _loc_15;
                        _loc_18 = _loc_16 + 1;
                        while (_loc_17 < _loc_18)
                        {
                            
                            _loc_17++;
                            _loc_20 = _loc_17;
                            _loc_21 = _loc_9 + (_loc_20 - _loc_10) * _loc_19 + 0.5;
                            _loc_22 = _loc_5 + (_loc_20 - _loc_8) * _loc_6 + 0.5;
                            if (_loc_22 < 0)
                            {
                                _loc_22 = 0;
                            }
                            if (_loc_21 >= width)
                            {
                                _loc_21 = width - 1;
                            }
                            _loc_23 = _loc_22;
                            _loc_24 = _loc_21 + 1;
                            while (_loc_23 < _loc_24)
                            {
                                
                                _loc_23++;
                                _loc_25 = _loc_23;
                                if (_loc_25 >= 0)
                                {
                                }
                                if (_loc_25 < width)
                                {
                                }
                                if (_loc_20 >= 0)
                                {
                                }
                                if (_loc_20 < height)
                                {
                                }
                            }
                        }
                    }
                }
            }
            return;
        }// end function

        public function __round(param1:Number) : int
        {
            return param1 + 0.5;
        }// end function

        public function __line(param1:int, param2:int, param3:int, param4:int, param5:int) : void
        {
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_9:* = 0;
            var _loc_10:* = 0;
            var _loc_11:* = 0;
            if (param1 < param3)
            {
                _loc_6 = param3 - param1;
                if (param2 < param4)
                {
                    _loc_7 = param4 - param2;
                    _loc_8 = width;
                    _loc_9 = _loc_6 - _loc_7;
                    _loc_10 = param2 * width + param1;
                    while (true)
                    {
                        
                        if (param1 >= 0)
                        {
                        }
                        if (param1 < width)
                        {
                        }
                        if (param2 >= 0)
                        {
                        }
                        if (param2 < height)
                        {
                        }
                        if (param1 == param3)
                        {
                        }
                        if (param2 == param4)
                        {
                            break;
                        }
                        _loc_11 = _loc_9 << 1;
                        if (_loc_11 > -_loc_7)
                        {
                            _loc_9 = _loc_9 - _loc_7;
                            param1++;
                            _loc_10++;
                        }
                        if (_loc_11 < _loc_6)
                        {
                            _loc_9 = _loc_9 + _loc_6;
                            param2++;
                            _loc_10 = _loc_10 + _loc_8;
                        }
                    }
                }
                else
                {
                    _loc_7 = param2 - param4;
                    _loc_8 = -width;
                    _loc_9 = _loc_6 - _loc_7;
                    _loc_10 = param2 * width + param1;
                    while (true)
                    {
                        
                        if (param1 >= 0)
                        {
                        }
                        if (param1 < width)
                        {
                        }
                        if (param2 >= 0)
                        {
                        }
                        if (param2 < height)
                        {
                        }
                        if (param1 == param3)
                        {
                        }
                        if (param2 == param4)
                        {
                            break;
                        }
                        _loc_11 = _loc_9 << 1;
                        if (_loc_11 > -_loc_7)
                        {
                            _loc_9 = _loc_9 - _loc_7;
                            param1++;
                            _loc_10++;
                        }
                        if (_loc_11 < _loc_6)
                        {
                            _loc_9 = _loc_9 + _loc_6;
                            param2--;
                            _loc_10 = _loc_10 + _loc_8;
                        }
                    }
                }
            }
            else
            {
                _loc_6 = param1 - param3;
                if (param2 < param4)
                {
                    _loc_7 = param4 - param2;
                    _loc_8 = width;
                    _loc_9 = _loc_6 - _loc_7;
                    _loc_10 = param2 * width + param1;
                    while (true)
                    {
                        
                        if (param1 >= 0)
                        {
                        }
                        if (param1 < width)
                        {
                        }
                        if (param2 >= 0)
                        {
                        }
                        if (param2 < height)
                        {
                        }
                        if (param1 == param3)
                        {
                        }
                        if (param2 == param4)
                        {
                            break;
                        }
                        _loc_11 = _loc_9 << 1;
                        if (_loc_11 > -_loc_7)
                        {
                            _loc_9 = _loc_9 - _loc_7;
                            param1--;
                            _loc_10--;
                        }
                        if (_loc_11 < _loc_6)
                        {
                            _loc_9 = _loc_9 + _loc_6;
                            param2++;
                            _loc_10 = _loc_10 + _loc_8;
                        }
                    }
                }
                else
                {
                    _loc_7 = param2 - param4;
                    _loc_8 = -width;
                    _loc_9 = _loc_6 - _loc_7;
                    _loc_10 = param2 * width + param1;
                    while (true)
                    {
                        
                        if (param1 >= 0)
                        {
                        }
                        if (param1 < width)
                        {
                        }
                        if (param2 >= 0)
                        {
                        }
                        if (param2 < height)
                        {
                        }
                        if (param1 == param3)
                        {
                        }
                        if (param2 == param4)
                        {
                            break;
                        }
                        _loc_11 = _loc_9 << 1;
                        if (_loc_11 > -_loc_7)
                        {
                            _loc_9 = _loc_9 - _loc_7;
                            param1--;
                            _loc_10--;
                        }
                        if (_loc_11 < _loc_6)
                        {
                            _loc_9 = _loc_9 + _loc_6;
                            param2--;
                            _loc_10 = _loc_10 + _loc_8;
                        }
                    }
                }
            }
            return;
        }// end function

        public function __fcircle(param1:int, param2:int, param3:int, param4:int) : void
        {
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_9:* = 0;
            var _loc_10:* = 0;
            var _loc_11:* = 0;
            if (param1 >= 0)
            {
            }
            if (param1 < width)
            {
            }
            if (param2 >= 0)
            {
            }
            if (param2 < height)
            {
            }
            if (param1 >= 0)
            {
            }
            if (param1 < width)
            {
            }
            if (_loc_5 >= 0)
            {
            }
            if (_loc_5 < height)
            {
            }
            if (param1 >= 0)
            {
            }
            if (param1 < width)
            {
            }
            if (_loc_5 >= 0)
            {
            }
            if (_loc_5 < height)
            {
            }
            if (_loc_5 >= 0)
            {
            }
            if (_loc_5 < width)
            {
            }
            if (param2 >= 0)
            {
            }
            if (param2 < height)
            {
            }
            if (_loc_5 >= 0)
            {
            }
            if (_loc_5 < width)
            {
            }
            if (param2 >= 0)
            {
            }
            if (param2 < height)
            {
            }
            if (_loc_5 >= 0)
            {
            }
            if (_loc_5 < width)
            {
            }
            if (_loc_6 >= 0)
            {
            }
            if (_loc_6 < height)
            {
            }
            if (_loc_5 >= 0)
            {
            }
            if (_loc_5 < width)
            {
            }
            if (_loc_6 >= 0)
            {
            }
            if (_loc_6 < height)
            {
            }
            if (_loc_5 >= 0)
            {
            }
            if (_loc_5 < width)
            {
            }
            if (_loc_6 >= 0)
            {
            }
            if (_loc_6 < height)
            {
            }
            if (_loc_5 >= 0)
            {
            }
            if (_loc_5 < width)
            {
            }
            if (_loc_6 >= 0)
            {
            }
            if (_loc_6 < height)
            {
            }
            while (_loc_6 >= _loc_5)
            {
                while (_loc_8 < _loc_9)
                {
                    if (_loc_10 >= 0)
                    {
                    }
                    if (_loc_10 < width)
                    {
                    }
                    if (_loc_11 >= 0)
                    {
                    }
                    if (_loc_11 < height)
                    {
                    }
                    if (_loc_10 >= 0)
                    {
                    }
                    if (_loc_10 < width)
                    {
                    }
                    if (_loc_11 >= 0)
                    {
                    }
                    if (_loc_11 < height)
                    {
                    }
                }
                while (_loc_8 < _loc_9)
                {
                    if (_loc_10 >= 0)
                    {
                    }
                    if (_loc_10 < width)
                    {
                    }
                    if (_loc_11 >= 0)
                    {
                    }
                    if (_loc_11 < height)
                    {
                    }
                    if (_loc_10 >= 0)
                    {
                    }
                    if (_loc_10 < width)
                    {
                    }
                    if (_loc_11 >= 0)
                    {
                    }
                    if (_loc_11 < height)
                    {
                    }
                }
                if (_loc_7 < 0)
                {
                    continue;
                }
            }
            return;
        }// end function

        public function __curve(param1:Vec2, param2:Vec2, param3:Vec2, param4:int) : void
        {
            var _loc_6:* = null as ZPP_Vec2;
            var _loc_10:* = NaN;
            var _loc_11:* = NaN;
            var _loc_12:* = null as Vec2;
            var _loc_13:* = false;
            var _loc_14:* = null as Vec2;
            var _loc_15:* = false;
            var _loc_16:* = null as Vec2;
            var _loc_17:* = null as Vec2;
            var _loc_18:* = null as ZPP_Vec2;
            if (param1 != null)
            {
            }
            if (param1.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_6 = param1.zpp_inner;
            if (_loc_6._validate != null)
            {
                _loc_6._validate();
            }
            if (param2 != null)
            {
            }
            if (param2.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_6 = param2.zpp_inner;
            if (_loc_6._validate != null)
            {
                _loc_6._validate();
            }
            if (param3 != null)
            {
            }
            if (param3.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_6 = param3.zpp_inner;
            if (_loc_6._validate != null)
            {
                _loc_6._validate();
            }
            var _loc_5:* = 0.25 * (param1.zpp_inner.x + 2 * param2.zpp_inner.x + param3.zpp_inner.x);
            if (param1 != null)
            {
            }
            if (param1.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_6 = param1.zpp_inner;
            if (_loc_6._validate != null)
            {
                _loc_6._validate();
            }
            if (param2 != null)
            {
            }
            if (param2.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_6 = param2.zpp_inner;
            if (_loc_6._validate != null)
            {
                _loc_6._validate();
            }
            if (param3 != null)
            {
            }
            if (param3.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_6 = param3.zpp_inner;
            if (_loc_6._validate != null)
            {
                _loc_6._validate();
            }
            var _loc_7:* = 0.25 * (param1.zpp_inner.y + 2 * param2.zpp_inner.y + param3.zpp_inner.y);
            if (param1 != null)
            {
            }
            if (param1.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_6 = param1.zpp_inner;
            if (_loc_6._validate != null)
            {
                _loc_6._validate();
            }
            if (param3 != null)
            {
            }
            if (param3.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_6 = param3.zpp_inner;
            if (_loc_6._validate != null)
            {
                _loc_6._validate();
            }
            var _loc_8:* = 0.5 * (param1.zpp_inner.x + param3.zpp_inner.x);
            if (param1 != null)
            {
            }
            if (param1.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_6 = param1.zpp_inner;
            if (_loc_6._validate != null)
            {
                _loc_6._validate();
            }
            if (param3 != null)
            {
            }
            if (param3.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_6 = param3.zpp_inner;
            if (_loc_6._validate != null)
            {
                _loc_6._validate();
            }
            var _loc_9:* = 0.5 * (param1.zpp_inner.y + param3.zpp_inner.y);
            _loc_10 = 0;
            _loc_11 = 0;
            _loc_10 = _loc_5 - _loc_8;
            _loc_11 = _loc_7 - _loc_9;
            if (_loc_10 * _loc_10 + _loc_11 * _loc_11 < 0.3)
            {
                if (param1 != null)
                {
                }
                if (param1.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_6 = param1.zpp_inner;
                if (_loc_6._validate != null)
                {
                    _loc_6._validate();
                }
                if (param1 != null)
                {
                }
                if (param1.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_6 = param1.zpp_inner;
                if (_loc_6._validate != null)
                {
                    _loc_6._validate();
                }
                if (param3 != null)
                {
                }
                if (param3.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_6 = param3.zpp_inner;
                if (_loc_6._validate != null)
                {
                    _loc_6._validate();
                }
                if (param3 != null)
                {
                }
                if (param3.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_6 = param3.zpp_inner;
                if (_loc_6._validate != null)
                {
                    _loc_6._validate();
                }
                __line(param1.zpp_inner.x + 0.5, param1.zpp_inner.y + 0.5, param3.zpp_inner.x + 0.5, param3.zpp_inner.y + 0.5, param4);
            }
            else
            {
                if (param1 != null)
                {
                }
                if (param1.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_6 = param1.zpp_inner;
                if (_loc_6._validate != null)
                {
                    _loc_6._validate();
                }
                if (param2 != null)
                {
                }
                if (param2.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_6 = param2.zpp_inner;
                if (_loc_6._validate != null)
                {
                    _loc_6._validate();
                }
                _loc_10 = 0.5 * (param1.zpp_inner.x + param2.zpp_inner.x);
                if (param1 != null)
                {
                }
                if (param1.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_6 = param1.zpp_inner;
                if (_loc_6._validate != null)
                {
                    _loc_6._validate();
                }
                if (param2 != null)
                {
                }
                if (param2.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_6 = param2.zpp_inner;
                if (_loc_6._validate != null)
                {
                    _loc_6._validate();
                }
                _loc_11 = 0.5 * (param1.zpp_inner.y + param2.zpp_inner.y);
                _loc_13 = false;
                if (_loc_10 == _loc_10)
                {
                }
                if (_loc_11 != _loc_11)
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
                        _loc_6 = new ZPP_Vec2();
                    }
                    else
                    {
                        _loc_6 = ZPP_Vec2.zpp_pool;
                        ZPP_Vec2.zpp_pool = _loc_6.next;
                        _loc_6.next = null;
                    }
                    _loc_6.weak = false;
                    _loc_6._immutable = _loc_15;
                    _loc_6.x = _loc_10;
                    _loc_6.y = _loc_11;
                    _loc_14.zpp_inner = _loc_6;
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
                    _loc_6 = _loc_14.zpp_inner;
                    if (_loc_6._immutable)
                    {
                        throw "Error: Vec2 is immutable";
                    }
                    if (_loc_6._isimmutable != null)
                    {
                        _loc_6._isimmutable();
                    }
                    if (_loc_10 == _loc_10)
                    {
                    }
                    if (_loc_11 != _loc_11)
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
                    _loc_6 = _loc_14.zpp_inner;
                    if (_loc_6._validate != null)
                    {
                        _loc_6._validate();
                    }
                    if (_loc_14.zpp_inner.x == _loc_10)
                    {
                        if (_loc_14 != null)
                        {
                        }
                        if (_loc_14.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_6 = _loc_14.zpp_inner;
                        if (_loc_6._validate != null)
                        {
                            _loc_6._validate();
                        }
                    }
                    if (_loc_14.zpp_inner.y != _loc_11)
                    {
                        _loc_14.zpp_inner.x = _loc_10;
                        _loc_14.zpp_inner.y = _loc_11;
                        _loc_6 = _loc_14.zpp_inner;
                        if (_loc_6._invalidate != null)
                        {
                            _loc_6._invalidate(_loc_6);
                        }
                    }
                }
                _loc_14.zpp_inner.weak = _loc_13;
                _loc_12 = _loc_14;
                if (param3 != null)
                {
                }
                if (param3.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_6 = param3.zpp_inner;
                if (_loc_6._validate != null)
                {
                    _loc_6._validate();
                }
                if (param2 != null)
                {
                }
                if (param2.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_6 = param2.zpp_inner;
                if (_loc_6._validate != null)
                {
                    _loc_6._validate();
                }
                _loc_10 = 0.5 * (param3.zpp_inner.x + param2.zpp_inner.x);
                if (param3 != null)
                {
                }
                if (param3.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_6 = param3.zpp_inner;
                if (_loc_6._validate != null)
                {
                    _loc_6._validate();
                }
                if (param2 != null)
                {
                }
                if (param2.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_6 = param2.zpp_inner;
                if (_loc_6._validate != null)
                {
                    _loc_6._validate();
                }
                _loc_11 = 0.5 * (param3.zpp_inner.y + param2.zpp_inner.y);
                _loc_13 = false;
                if (_loc_10 == _loc_10)
                {
                }
                if (_loc_11 != _loc_11)
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
                    _loc_15 = false;
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
                    _loc_6._immutable = _loc_15;
                    _loc_6.x = _loc_10;
                    _loc_6.y = _loc_11;
                    _loc_16.zpp_inner = _loc_6;
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
                    _loc_6 = _loc_16.zpp_inner;
                    if (_loc_6._immutable)
                    {
                        throw "Error: Vec2 is immutable";
                    }
                    if (_loc_6._isimmutable != null)
                    {
                        _loc_6._isimmutable();
                    }
                    if (_loc_10 == _loc_10)
                    {
                    }
                    if (_loc_11 != _loc_11)
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
                    _loc_6 = _loc_16.zpp_inner;
                    if (_loc_6._validate != null)
                    {
                        _loc_6._validate();
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
                        _loc_6 = _loc_16.zpp_inner;
                        if (_loc_6._validate != null)
                        {
                            _loc_6._validate();
                        }
                    }
                    if (_loc_16.zpp_inner.y != _loc_11)
                    {
                        _loc_16.zpp_inner.x = _loc_10;
                        _loc_16.zpp_inner.y = _loc_11;
                        _loc_6 = _loc_16.zpp_inner;
                        if (_loc_6._invalidate != null)
                        {
                            _loc_6._invalidate(_loc_6);
                        }
                    }
                }
                _loc_16.zpp_inner.weak = _loc_13;
                _loc_14 = _loc_16;
                if (_loc_12 != null)
                {
                }
                if (_loc_12.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_6 = _loc_12.zpp_inner;
                if (_loc_6._validate != null)
                {
                    _loc_6._validate();
                }
                if (_loc_14 != null)
                {
                }
                if (_loc_14.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_6 = _loc_14.zpp_inner;
                if (_loc_6._validate != null)
                {
                    _loc_6._validate();
                }
                _loc_10 = 0.5 * (_loc_12.zpp_inner.x + _loc_14.zpp_inner.x);
                if (_loc_12 != null)
                {
                }
                if (_loc_12.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_6 = _loc_12.zpp_inner;
                if (_loc_6._validate != null)
                {
                    _loc_6._validate();
                }
                if (_loc_14 != null)
                {
                }
                if (_loc_14.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_6 = _loc_14.zpp_inner;
                if (_loc_6._validate != null)
                {
                    _loc_6._validate();
                }
                _loc_11 = 0.5 * (_loc_12.zpp_inner.y + _loc_14.zpp_inner.y);
                _loc_13 = false;
                if (_loc_10 == _loc_10)
                {
                }
                if (_loc_11 != _loc_11)
                {
                    throw "Error: Vec2 components cannot be NaN";
                }
                if (ZPP_PubPool.poolVec2 == null)
                {
                    _loc_17 = new Vec2();
                }
                else
                {
                    _loc_17 = ZPP_PubPool.poolVec2;
                    ZPP_PubPool.poolVec2 = _loc_17.zpp_pool;
                    _loc_17.zpp_pool = null;
                    _loc_17.zpp_disp = false;
                    if (_loc_17 == ZPP_PubPool.nextVec2)
                    {
                        ZPP_PubPool.nextVec2 = null;
                    }
                }
                if (_loc_17.zpp_inner == null)
                {
                    _loc_15 = false;
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
                    _loc_6._immutable = _loc_15;
                    _loc_6.x = _loc_10;
                    _loc_6.y = _loc_11;
                    _loc_17.zpp_inner = _loc_6;
                    _loc_17.zpp_inner.outer = _loc_17;
                }
                else
                {
                    if (_loc_17 != null)
                    {
                    }
                    if (_loc_17.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_6 = _loc_17.zpp_inner;
                    if (_loc_6._immutable)
                    {
                        throw "Error: Vec2 is immutable";
                    }
                    if (_loc_6._isimmutable != null)
                    {
                        _loc_6._isimmutable();
                    }
                    if (_loc_10 == _loc_10)
                    {
                    }
                    if (_loc_11 != _loc_11)
                    {
                        throw "Error: Vec2 components cannot be NaN";
                    }
                    if (_loc_17 != null)
                    {
                    }
                    if (_loc_17.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_6 = _loc_17.zpp_inner;
                    if (_loc_6._validate != null)
                    {
                        _loc_6._validate();
                    }
                    if (_loc_17.zpp_inner.x == _loc_10)
                    {
                        if (_loc_17 != null)
                        {
                        }
                        if (_loc_17.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_6 = _loc_17.zpp_inner;
                        if (_loc_6._validate != null)
                        {
                            _loc_6._validate();
                        }
                    }
                    if (_loc_17.zpp_inner.y != _loc_11)
                    {
                        _loc_17.zpp_inner.x = _loc_10;
                        _loc_17.zpp_inner.y = _loc_11;
                        _loc_6 = _loc_17.zpp_inner;
                        if (_loc_6._invalidate != null)
                        {
                            _loc_6._invalidate(_loc_6);
                        }
                    }
                }
                _loc_17.zpp_inner.weak = _loc_13;
                _loc_16 = _loc_17;
                __curve(param1, _loc_12, _loc_16, param4);
                if (_loc_12 != null)
                {
                }
                if (_loc_12.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_6 = _loc_12.zpp_inner;
                if (_loc_6._immutable)
                {
                    throw "Error: Vec2 is immutable";
                }
                if (_loc_6._isimmutable != null)
                {
                    _loc_6._isimmutable();
                }
                if (_loc_12.zpp_inner._inuse)
                {
                    throw "Error: This Vec2 is not disposable";
                }
                _loc_6 = _loc_12.zpp_inner;
                _loc_12.zpp_inner.outer = null;
                _loc_12.zpp_inner = null;
                _loc_17 = _loc_12;
                _loc_17.zpp_pool = null;
                if (ZPP_PubPool.nextVec2 != null)
                {
                    ZPP_PubPool.nextVec2.zpp_pool = _loc_17;
                }
                else
                {
                    ZPP_PubPool.poolVec2 = _loc_17;
                }
                ZPP_PubPool.nextVec2 = _loc_17;
                _loc_17.zpp_disp = true;
                _loc_18 = _loc_6;
                if (_loc_18.outer != null)
                {
                    _loc_18.outer.zpp_inner = null;
                    _loc_18.outer = null;
                }
                _loc_18._isimmutable = null;
                _loc_18._validate = null;
                _loc_18._invalidate = null;
                _loc_18.next = ZPP_Vec2.zpp_pool;
                ZPP_Vec2.zpp_pool = _loc_18;
                __curve(param3, _loc_14, _loc_16, param4);
                if (_loc_14 != null)
                {
                }
                if (_loc_14.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_6 = _loc_14.zpp_inner;
                if (_loc_6._immutable)
                {
                    throw "Error: Vec2 is immutable";
                }
                if (_loc_6._isimmutable != null)
                {
                    _loc_6._isimmutable();
                }
                if (_loc_14.zpp_inner._inuse)
                {
                    throw "Error: This Vec2 is not disposable";
                }
                _loc_6 = _loc_14.zpp_inner;
                _loc_14.zpp_inner.outer = null;
                _loc_14.zpp_inner = null;
                _loc_17 = _loc_14;
                _loc_17.zpp_pool = null;
                if (ZPP_PubPool.nextVec2 != null)
                {
                    ZPP_PubPool.nextVec2.zpp_pool = _loc_17;
                }
                else
                {
                    ZPP_PubPool.poolVec2 = _loc_17;
                }
                ZPP_PubPool.nextVec2 = _loc_17;
                _loc_17.zpp_disp = true;
                _loc_18 = _loc_6;
                if (_loc_18.outer != null)
                {
                    _loc_18.outer.zpp_inner = null;
                    _loc_18.outer = null;
                }
                _loc_18._isimmutable = null;
                _loc_18._validate = null;
                _loc_18._invalidate = null;
                _loc_18.next = ZPP_Vec2.zpp_pool;
                ZPP_Vec2.zpp_pool = _loc_18;
                if (_loc_16 != null)
                {
                }
                if (_loc_16.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_6 = _loc_16.zpp_inner;
                if (_loc_6._immutable)
                {
                    throw "Error: Vec2 is immutable";
                }
                if (_loc_6._isimmutable != null)
                {
                    _loc_6._isimmutable();
                }
                if (_loc_16.zpp_inner._inuse)
                {
                    throw "Error: This Vec2 is not disposable";
                }
                _loc_6 = _loc_16.zpp_inner;
                _loc_16.zpp_inner.outer = null;
                _loc_16.zpp_inner = null;
                _loc_17 = _loc_16;
                _loc_17.zpp_pool = null;
                if (ZPP_PubPool.nextVec2 != null)
                {
                    ZPP_PubPool.nextVec2.zpp_pool = _loc_17;
                }
                else
                {
                    ZPP_PubPool.poolVec2 = _loc_17;
                }
                ZPP_PubPool.nextVec2 = _loc_17;
                _loc_17.zpp_disp = true;
                _loc_18 = _loc_6;
                if (_loc_18.outer != null)
                {
                    _loc_18.outer.zpp_inner = null;
                    _loc_18.outer = null;
                }
                _loc_18._isimmutable = null;
                _loc_18._validate = null;
                _loc_18._invalidate = null;
                _loc_18.next = ZPP_Vec2.zpp_pool;
                ZPP_Vec2.zpp_pool = _loc_18;
            }
            return;
        }// end function

        public function __circle(param1:int, param2:int, param3:int, param4:int) : void
        {
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_9:* = 0;
            if (param1 >= 0)
            {
            }
            if (param1 < width)
            {
            }
            if (param2 >= 0)
            {
            }
            if (param2 < height)
            {
            }
            if (param1 >= 0)
            {
            }
            if (param1 < width)
            {
            }
            if (_loc_5 >= 0)
            {
            }
            if (_loc_5 < height)
            {
            }
            if (param1 >= 0)
            {
            }
            if (param1 < width)
            {
            }
            if (_loc_5 >= 0)
            {
            }
            if (_loc_5 < height)
            {
            }
            if (_loc_5 >= 0)
            {
            }
            if (_loc_5 < width)
            {
            }
            if (param2 >= 0)
            {
            }
            if (param2 < height)
            {
            }
            if (_loc_5 >= 0)
            {
            }
            if (_loc_5 < width)
            {
            }
            if (param2 >= 0)
            {
            }
            if (param2 < height)
            {
            }
            if (_loc_5 >= 0)
            {
            }
            if (_loc_5 < width)
            {
            }
            if (_loc_6 >= 0)
            {
            }
            if (_loc_6 < height)
            {
            }
            if (_loc_5 >= 0)
            {
            }
            if (_loc_5 < width)
            {
            }
            if (_loc_6 >= 0)
            {
            }
            if (_loc_6 < height)
            {
            }
            if (_loc_5 >= 0)
            {
            }
            if (_loc_5 < width)
            {
            }
            if (_loc_6 >= 0)
            {
            }
            if (_loc_6 < height)
            {
            }
            if (_loc_5 >= 0)
            {
            }
            if (_loc_5 < width)
            {
            }
            if (_loc_6 >= 0)
            {
            }
            if (_loc_6 < height)
            {
            }
            while (_loc_6 >= _loc_5)
            {
                if (_loc_8 >= 0)
                {
                }
                if (_loc_8 < width)
                {
                }
                if (_loc_9 >= 0)
                {
                }
                if (_loc_9 < height)
                {
                }
                if (_loc_8 >= 0)
                {
                }
                if (_loc_8 < width)
                {
                }
                if (_loc_9 >= 0)
                {
                }
                if (_loc_9 < height)
                {
                }
                if (_loc_8 >= 0)
                {
                }
                if (_loc_8 < width)
                {
                }
                if (_loc_9 >= 0)
                {
                }
                if (_loc_9 < height)
                {
                }
                if (_loc_8 >= 0)
                {
                }
                if (_loc_8 < width)
                {
                }
                if (_loc_9 >= 0)
                {
                }
                if (_loc_9 < height)
                {
                }
                if (_loc_8 >= 0)
                {
                }
                if (_loc_8 < width)
                {
                }
                if (_loc_9 >= 0)
                {
                }
                if (_loc_9 < height)
                {
                }
                if (_loc_8 >= 0)
                {
                }
                if (_loc_8 < width)
                {
                }
                if (_loc_9 >= 0)
                {
                }
                if (_loc_9 < height)
                {
                }
                if (_loc_8 >= 0)
                {
                }
                if (_loc_8 < width)
                {
                }
                if (_loc_9 >= 0)
                {
                }
                if (_loc_9 < height)
                {
                }
                if (_loc_8 >= 0)
                {
                }
                if (_loc_8 < width)
                {
                }
                if (_loc_9 >= 0)
                {
                }
                if (_loc_9 < height)
                {
                }
                if (_loc_7 < 0)
                {
                    continue;
                }
            }
            return;
        }// end function

        public function __box(param1:int, param2:int, param3:int, param4:int, param5:int) : void
        {
            param5 = param5 | -16777216;
            __line(param1, param2, param1, param4, param5);
            __line(param1, param4, param3, param4, param5);
            __line(param3, param4, param3, param2, param5);
            __line(param3, param2, param1, param2, param5);
            return;
        }// end function

        public function __aabb(param1:ZPP_AABB, param2:int) : void
        {
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_9:* = 0;
            var _loc_10:* = 0;
            param2 = param2 | -16777216;
            var _loc_3:* = param1.minx > -17899999999999994000000000000;
            var _loc_4:* = param1.maxx < 17899999999999994000000000000;
            var _loc_5:* = param1.miny > -17899999999999994000000000000;
            var _loc_6:* = param1.maxy < 17899999999999994000000000000;
            if (_loc_3)
            {
                _loc_7 = param1.minx + 0.5;
            }
            else
            {
                _loc_7 = 0;
            }
            if (_loc_4)
            {
                _loc_8 = param1.maxx + 0.5;
            }
            else
            {
                _loc_8 = width;
            }
            if (_loc_5)
            {
                _loc_9 = param1.miny + 0.5;
            }
            else
            {
                _loc_9 = 0;
            }
            if (_loc_6)
            {
                _loc_10 = param1.maxy + 0.5;
            }
            else
            {
                _loc_10 = height;
            }
            if (_loc_3)
            {
                __line(_loc_7, _loc_9, _loc_7, _loc_10, param2);
            }
            if (_loc_4)
            {
                __line(_loc_8, _loc_9, _loc_8, _loc_10, param2);
            }
            if (_loc_5)
            {
                __line(_loc_7, _loc_9, _loc_8, _loc_9, param2);
            }
            if (_loc_6)
            {
                __line(_loc_7, _loc_10, _loc_8, _loc_10, param2);
            }
            return;
        }// end function

    }
}
