package zpp_nape.dynamics
{
    import flash.*;
    import nape.*;
    import nape.dynamics.*;
    import nape.geom.*;
    import zpp_nape.geom.*;
    import zpp_nape.phys.*;
    import zpp_nape.shape.*;
    import zpp_nape.space.*;
    import zpp_nape.util.*;

    public class ZPP_FluidArbiter extends ZPP_Arbiter
    {
        public var wrap_position:Vec2;
        public var wMass:Number;
        public var vMassc:Number;
        public var vMassb:Number;
        public var vMassa:Number;
        public var r2y:Number;
        public var r2x:Number;
        public var r1y:Number;
        public var r1x:Number;
        public var pre_dt:Number;
        public var overlap:Number;
        public var outer_zn:FluidArbiter;
        public var ny:Number;
        public var nx:Number;
        public var nodrag:Boolean;
        public var next:ZPP_FluidArbiter;
        public var mutable:Boolean;
        public var lgamma:Number;
        public var dampy:Number;
        public var dampx:Number;
        public var centroidy:Number;
        public var centroidx:Number;
        public var buoyy:Number;
        public var buoyx:Number;
        public var agamma:Number;
        public var adamp:Number;
        public static var zpp_pool:ZPP_FluidArbiter;

        public function ZPP_FluidArbiter() : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            pre_dt = 0;
            mutable = false;
            wrap_position = null;
            buoyy = 0;
            buoyx = 0;
            ny = 0;
            nx = 0;
            lgamma = 0;
            dampy = 0;
            dampx = 0;
            vMassc = 0;
            vMassb = 0;
            vMassa = 0;
            agamma = 0;
            adamp = 0;
            wMass = 0;
            nodrag = false;
            r2y = 0;
            r2x = 0;
            r1y = 0;
            r1x = 0;
            overlap = 0;
            centroidy = 0;
            centroidx = 0;
            next = null;
            outer_zn = null;
            type = ZPP_Arbiter.FLUID;
            fluidarb = this;
            buoyx = 0;
            buoyy = 0;
            pre_dt = -1;
            return;
        }// end function

        public function warmStart() : void
        {
            var _loc_1:* = b1.imass;
            b1.velx = b1.velx - dampx * _loc_1;
            b1.vely = b1.vely - dampy * _loc_1;
            _loc_1 = b2.imass;
            b2.velx = b2.velx + dampx * _loc_1;
            b2.vely = b2.vely + dampy * _loc_1;
            b1.angvel = b1.angvel - b1.iinertia * (dampy * r1x - dampx * r1y);
            b2.angvel = b2.angvel + b2.iinertia * (dampy * r2x - dampx * r2y);
            b1.angvel = b1.angvel - adamp * b1.iinertia;
            b2.angvel = b2.angvel + adamp * b2.iinertia;
            return;
        }// end function

        public function retire() : void
        {
            var _loc_1:* = null as ZNPList_ZPP_Arbiter;
            var _loc_2:* = null as ZNPNode_ZPP_Arbiter;
            var _loc_3:* = null as ZNPNode_ZPP_Arbiter;
            var _loc_4:* = false;
            var _loc_5:* = null as ZNPNode_ZPP_Arbiter;
            var _loc_6:* = null as ZNPNode_ZPP_Arbiter;
            var _loc_7:* = null as ZNPNode_ZPP_Arbiter;
            if (!cleared)
            {
                _loc_1 = b1.arbiters;
                _loc_2 = null;
                _loc_3 = _loc_1.head;
                _loc_4 = false;
                while (_loc_3 != null)
                {
                    
                    if (_loc_3.elt == this)
                    {
                        if (_loc_2 == null)
                        {
                            _loc_5 = _loc_1.head;
                            _loc_6 = _loc_5.next;
                            _loc_1.head = _loc_6;
                            if (_loc_1.head == null)
                            {
                                _loc_1.pushmod = true;
                            }
                        }
                        else
                        {
                            _loc_5 = _loc_2.next;
                            _loc_6 = _loc_5.next;
                            _loc_2.next = _loc_6;
                            if (_loc_6 == null)
                            {
                                _loc_1.pushmod = true;
                            }
                        }
                        _loc_7 = _loc_5;
                        _loc_7.elt = null;
                        _loc_7.next = ZNPNode_ZPP_Arbiter.zpp_pool;
                        ZNPNode_ZPP_Arbiter.zpp_pool = _loc_7;
                        _loc_1.modified = true;
                        (_loc_1.length - 1);
                        _loc_1.pushmod = true;
                        _loc_4 = true;
                        break;
                    }
                    _loc_2 = _loc_3;
                    _loc_3 = _loc_3.next;
                }
                _loc_1 = b2.arbiters;
                _loc_2 = null;
                _loc_3 = _loc_1.head;
                _loc_4 = false;
                while (_loc_3 != null)
                {
                    
                    if (_loc_3.elt == this)
                    {
                        if (_loc_2 == null)
                        {
                            _loc_5 = _loc_1.head;
                            _loc_6 = _loc_5.next;
                            _loc_1.head = _loc_6;
                            if (_loc_1.head == null)
                            {
                                _loc_1.pushmod = true;
                            }
                        }
                        else
                        {
                            _loc_5 = _loc_2.next;
                            _loc_6 = _loc_5.next;
                            _loc_2.next = _loc_6;
                            if (_loc_6 == null)
                            {
                                _loc_1.pushmod = true;
                            }
                        }
                        _loc_7 = _loc_5;
                        _loc_7.elt = null;
                        _loc_7.next = ZNPNode_ZPP_Arbiter.zpp_pool;
                        ZNPNode_ZPP_Arbiter.zpp_pool = _loc_7;
                        _loc_1.modified = true;
                        (_loc_1.length - 1);
                        _loc_1.pushmod = true;
                        _loc_4 = true;
                        break;
                    }
                    _loc_2 = _loc_3;
                    _loc_3 = _loc_3.next;
                }
                if (pair != null)
                {
                    pair.arb = null;
                    pair = null;
                }
            }
            var _loc_8:* = null;
            b2 = null;
            b1 = _loc_8;
            active = false;
            intchange = false;
            var _loc_9:* = this;
            _loc_9.next = ZPP_FluidArbiter.zpp_pool;
            ZPP_FluidArbiter.zpp_pool = _loc_9;
            pre_dt = -1;
            return;
        }// end function

        public function preStep(param1:ZPP_Space, param2:Number) : void
        {
            var _loc_10:* = NaN;
            var _loc_11:* = NaN;
            var _loc_12:* = NaN;
            var _loc_13:* = NaN;
            var _loc_14:* = NaN;
            var _loc_15:* = 0;
            var _loc_16:* = NaN;
            var _loc_17:* = null as ZPP_Polygon;
            var _loc_18:* = NaN;
            var _loc_19:* = null as ZNPNode_ZPP_Edge;
            var _loc_20:* = null as ZPP_Edge;
            var _loc_21:* = NaN;
            var _loc_22:* = NaN;
            var _loc_23:* = NaN;
            var _loc_24:* = NaN;
            var _loc_25:* = NaN;
            if (pre_dt == -1)
            {
                pre_dt = param2;
            }
            var _loc_3:* = param2 / pre_dt;
            pre_dt = param2;
            r1x = centroidx - b1.posx;
            r1y = centroidy - b1.posy;
            r2x = centroidx - b2.posx;
            r2y = centroidy - b2.posy;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            if (ws1.fluidEnabled)
            {
            }
            if (ws1.fluidProperties.wrap_gravity != null)
            {
                _loc_4 = ws1.fluidProperties.gravityx;
                _loc_5 = ws1.fluidProperties.gravityy;
            }
            else
            {
                _loc_4 = param1.gravityx;
                _loc_5 = param1.gravityy;
            }
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            if (ws2.fluidEnabled)
            {
            }
            if (ws2.fluidProperties.wrap_gravity != null)
            {
                _loc_6 = ws2.fluidProperties.gravityx;
                _loc_7 = ws2.fluidProperties.gravityy;
            }
            else
            {
                _loc_6 = param1.gravityx;
                _loc_7 = param1.gravityy;
            }
            var _loc_8:* = 0;
            var _loc_9:* = 0;
            if (ws1.fluidEnabled)
            {
            }
            if (ws2.fluidEnabled)
            {
                _loc_10 = overlap * ws1.fluidProperties.density;
                _loc_11 = overlap * ws2.fluidProperties.density;
                if (_loc_10 > _loc_11)
                {
                    _loc_12 = _loc_10 + _loc_11;
                    _loc_8 = _loc_8 - _loc_4 * _loc_12;
                    _loc_9 = _loc_9 - _loc_5 * _loc_12;
                }
                else if (_loc_10 < _loc_11)
                {
                    _loc_12 = _loc_10 + _loc_11;
                    _loc_8 = _loc_8 + _loc_6 * _loc_12;
                    _loc_9 = _loc_9 + _loc_7 * _loc_12;
                }
                else
                {
                    _loc_12 = 0;
                    _loc_13 = 0;
                    _loc_12 = _loc_4 + _loc_6;
                    _loc_13 = _loc_5 + _loc_7;
                    _loc_14 = 0.5;
                    _loc_12 = _loc_12 * _loc_14;
                    _loc_13 = _loc_13 * _loc_14;
                    if (ws1.worldCOMx * _loc_12 + ws1.worldCOMy * _loc_13 > ws2.worldCOMx * _loc_12 + ws2.worldCOMy * _loc_13)
                    {
                        _loc_14 = _loc_10 + _loc_11;
                        _loc_8 = _loc_8 - _loc_12 * _loc_14;
                        _loc_9 = _loc_9 - _loc_13 * _loc_14;
                    }
                    else
                    {
                        _loc_14 = _loc_10 + _loc_11;
                        _loc_8 = _loc_8 + _loc_12 * _loc_14;
                        _loc_9 = _loc_9 + _loc_13 * _loc_14;
                    }
                }
            }
            else if (ws1.fluidEnabled)
            {
                _loc_10 = overlap * ws1.fluidProperties.density;
                _loc_11 = _loc_10;
                _loc_8 = _loc_8 - _loc_4 * _loc_11;
                _loc_9 = _loc_9 - _loc_5 * _loc_11;
            }
            else if (ws2.fluidEnabled)
            {
                _loc_10 = overlap * ws2.fluidProperties.density;
                _loc_11 = _loc_10;
                _loc_8 = _loc_8 + _loc_6 * _loc_11;
                _loc_9 = _loc_9 + _loc_7 * _loc_11;
            }
            _loc_10 = param2;
            _loc_8 = _loc_8 * _loc_10;
            _loc_9 = _loc_9 * _loc_10;
            buoyx = _loc_8;
            buoyy = _loc_9;
            if (b1.type == ZPP_Flags.id_BodyType_DYNAMIC)
            {
                _loc_10 = b1.imass;
                b1.velx = b1.velx - _loc_8 * _loc_10;
                b1.vely = b1.vely - _loc_9 * _loc_10;
                b1.angvel = b1.angvel - (_loc_9 * r1x - _loc_8 * r1y) * b1.iinertia;
            }
            if (b2.type == ZPP_Flags.id_BodyType_DYNAMIC)
            {
                _loc_10 = b2.imass;
                b2.velx = b2.velx + _loc_8 * _loc_10;
                b2.vely = b2.vely + _loc_9 * _loc_10;
                b2.angvel = b2.angvel + (_loc_9 * r2x - _loc_8 * r2y) * b2.iinertia;
            }
            if (ws1.fluidEnabled)
            {
            }
            if (ws1.fluidProperties.viscosity == 0)
            {
                if (ws2.fluidEnabled)
                {
                }
            }
            if (ws2.fluidProperties.viscosity == 0)
            {
                nodrag = true;
                dampx = 0;
                dampy = 0;
                adamp = 0;
            }
            else
            {
                nodrag = false;
                _loc_10 = 0;
                if (ws1.fluidEnabled)
                {
                    ws2.validate_angDrag();
                    _loc_10 = _loc_10 + ws1.fluidProperties.viscosity * ws2.angDrag * overlap / ws2.area;
                }
                if (ws2.fluidEnabled)
                {
                    ws1.validate_angDrag();
                    _loc_10 = _loc_10 + ws2.fluidProperties.viscosity * ws1.angDrag * overlap / ws1.area;
                }
                if (_loc_10 != 0)
                {
                    _loc_11 = b1.sinertia + b2.sinertia;
                    if (_loc_11 != 0)
                    {
                        wMass = 1 / _loc_11;
                    }
                    else
                    {
                        wMass = 0;
                    }
                    _loc_10 = _loc_10 * 0.0004;
                    _loc_13 = 2 * Math.PI * _loc_10;
                    agamma = 1 / (param2 * _loc_13 * (2 + _loc_13 * param2));
                    _loc_14 = 1 / (1 + agamma);
                    _loc_12 = param2 * _loc_13 * _loc_13 * agamma;
                    agamma = agamma * _loc_14;
                    wMass = wMass * _loc_14;
                }
                else
                {
                    wMass = 0;
                    agamma = 0;
                }
                _loc_11 = b2.velx + b2.kinvelx - r2y * (b2.angvel + b2.kinangvel) - (b1.velx + b1.kinvelx - r1y * (b2.angvel + b2.kinangvel));
                _loc_12 = b2.vely + b2.kinvely + r2x * (b2.angvel + b2.kinangvel) - (b1.vely + b1.kinvely + r1x * (b1.angvel + b1.kinangvel));
                if (_loc_11 * _loc_11 + _loc_12 * _loc_12 < Config.epsilon * Config.epsilon)
                {
                }
                else
                {
                    _loc_13 = _loc_11 * _loc_11 + _loc_12 * _loc_12;
                    _loc_15 = 1597463007 - (0 >> 1);
                    _loc_16 = 0;
                    _loc_14 = _loc_16 * (1.5 - 0.5 * _loc_13 * _loc_16 * _loc_16);
                    _loc_16 = _loc_14;
                    _loc_11 = _loc_11 * _loc_16;
                    _loc_12 = _loc_12 * _loc_16;
                    nx = _loc_11;
                    ny = _loc_12;
                }
                _loc_13 = 0;
                if (ws1.fluidEnabled)
                {
                    _loc_14 = (-ws1.fluidProperties.viscosity) * overlap / ws2.area;
                    if (ws2.type == ZPP_Flags.id_ShapeType_CIRCLE)
                    {
                        _loc_13 = _loc_13 - _loc_14 * ws2.circle.radius * Config.fluidLinearDrag / (2 * ws2.circle.radius * Math.PI);
                    }
                    else
                    {
                        _loc_17 = ws2.polygon;
                        _loc_16 = 0;
                        _loc_18 = 0;
                        _loc_19 = _loc_17.edges.head;
                        while (_loc_19 != null)
                        {
                            
                            _loc_20 = _loc_19.elt;
                            _loc_16 = _loc_16 + _loc_20.length;
                            _loc_21 = _loc_14 * _loc_20.length * (_loc_20.gnormx * nx + _loc_20.gnormy * ny);
                            if (_loc_21 > 0)
                            {
                                _loc_21 = _loc_21 * (-Config.fluidVacuumDrag);
                                _loc_21 = _loc_21;
                            }
                            _loc_18 = _loc_18 - _loc_21 * 0.5 * Config.fluidLinearDrag;
                            _loc_19 = _loc_19.next;
                        }
                        _loc_13 = _loc_13 + _loc_18 / _loc_16;
                    }
                }
                if (ws2.fluidEnabled)
                {
                    _loc_14 = (-ws2.fluidProperties.viscosity) * overlap / ws1.area;
                    if (ws1.type == ZPP_Flags.id_ShapeType_CIRCLE)
                    {
                        _loc_13 = _loc_13 - _loc_14 * ws1.circle.radius * Config.fluidLinearDrag / (2 * ws1.circle.radius * Math.PI);
                    }
                    else
                    {
                        _loc_17 = ws1.polygon;
                        _loc_16 = 0;
                        _loc_18 = 0;
                        _loc_19 = _loc_17.edges.head;
                        while (_loc_19 != null)
                        {
                            
                            _loc_20 = _loc_19.elt;
                            _loc_16 = _loc_16 + _loc_20.length;
                            _loc_21 = _loc_14 * _loc_20.length * (_loc_20.gnormx * nx + _loc_20.gnormy * ny);
                            if (_loc_21 > 0)
                            {
                                _loc_21 = _loc_21 * (-Config.fluidVacuumDrag);
                                _loc_21 = _loc_21;
                            }
                            _loc_18 = _loc_18 - _loc_21 * 0.5 * Config.fluidLinearDrag;
                            _loc_19 = _loc_19.next;
                        }
                        _loc_13 = _loc_13 + _loc_18 / _loc_16;
                    }
                }
                if (_loc_13 != 0)
                {
                    _loc_14 = b1.smass + b2.smass;
                    _loc_16 = 0;
                    _loc_18 = 0;
                    _loc_21 = 0;
                    _loc_16 = _loc_14;
                    _loc_18 = 0;
                    _loc_21 = _loc_14;
                    if (b1.sinertia != 0)
                    {
                        _loc_22 = r1x * b1.sinertia;
                        _loc_23 = r1y * b1.sinertia;
                        _loc_16 = _loc_16 + _loc_23 * r1y;
                        _loc_18 = _loc_18 + (-_loc_23) * r1x;
                        _loc_21 = _loc_21 + _loc_22 * r1x;
                    }
                    if (b2.sinertia != 0)
                    {
                        _loc_22 = r2x * b2.sinertia;
                        _loc_23 = r2y * b2.sinertia;
                        _loc_16 = _loc_16 + _loc_23 * r2y;
                        _loc_18 = _loc_18 + (-_loc_23) * r2x;
                        _loc_21 = _loc_21 + _loc_22 * r2x;
                    }
                    _loc_22 = _loc_16 * _loc_21 - _loc_18 * _loc_18;
                    if (_loc_22 != _loc_22)
                    {
                        _loc_21 = 0;
                        _loc_18 = _loc_21;
                        _loc_16 = _loc_18;
                    }
                    else if (_loc_22 == 0)
                    {
                        _loc_15 = 0;
                        if (_loc_16 != 0)
                        {
                            _loc_16 = 1 / _loc_16;
                        }
                        else
                        {
                            _loc_16 = 0;
                            _loc_15 = _loc_15 | 1;
                        }
                        if (_loc_21 != 0)
                        {
                            _loc_21 = 1 / _loc_21;
                        }
                        else
                        {
                            _loc_21 = 0;
                            _loc_15 = _loc_15 | 2;
                        }
                        _loc_18 = 0;
                    }
                    else
                    {
                        _loc_22 = 1 / _loc_22;
                        _loc_23 = _loc_21 * _loc_22;
                        _loc_21 = _loc_16 * _loc_22;
                        _loc_16 = _loc_23;
                        _loc_18 = _loc_18 * (-_loc_22);
                    }
                    vMassa = _loc_16;
                    vMassb = _loc_18;
                    vMassc = _loc_21;
                    _loc_24 = 2 * Math.PI * _loc_13;
                    lgamma = 1 / (param2 * _loc_24 * (2 + _loc_24 * param2));
                    _loc_25 = 1 / (1 + lgamma);
                    _loc_22 = param2 * _loc_24 * _loc_24 * lgamma;
                    lgamma = lgamma * _loc_25;
                    _loc_23 = _loc_25;
                    vMassa = vMassa * _loc_23;
                    vMassb = vMassb * _loc_23;
                    vMassc = vMassc * _loc_23;
                }
                else
                {
                    vMassa = 0;
                    vMassb = 0;
                    vMassc = 0;
                    lgamma = 0;
                }
            }
            _loc_10 = _loc_3;
            dampx = dampx * _loc_10;
            dampy = dampy * _loc_10;
            adamp = adamp * _loc_3;
            return;
        }// end function

        public function position_validate() : void
        {
            if (!active)
            {
                throw "Error: Arbiter not currently in use";
            }
            wrap_position.zpp_inner.x = centroidx;
            wrap_position.zpp_inner.y = centroidy;
            return;
        }// end function

        public function position_invalidate(param1:ZPP_Vec2) : void
        {
            centroidx = param1.x;
            centroidy = param1.y;
            return;
        }// end function

        public function makemutable() : void
        {
            mutable = true;
            if (wrap_position != null)
            {
                wrap_position.zpp_inner._immutable = false;
            }
            return;
        }// end function

        public function makeimmutable() : void
        {
            mutable = false;
            if (wrap_position != null)
            {
                wrap_position.zpp_inner._immutable = true;
            }
            return;
        }// end function

        public function inject(param1:Number, param2:Number, param3:Number) : void
        {
            overlap = param1;
            centroidx = param2;
            centroidy = param3;
            return;
        }// end function

        public function getposition() : void
        {
            var _loc_4:* = null as Vec2;
            var _loc_5:* = false;
            var _loc_6:* = null as ZPP_Vec2;
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
            wrap_position = _loc_4;
            wrap_position.zpp_inner._inuse = true;
            wrap_position.zpp_inner._immutable = !mutable;
            wrap_position.zpp_inner._validate = position_validate;
            wrap_position.zpp_inner._invalidate = position_invalidate;
            return;
        }// end function

        public function free() : void
        {
            return;
        }// end function

        public function assign(param1:ZPP_Shape, param2:ZPP_Shape, param3:int, param4:int) : void
        {
            var _loc_7:* = null as ZNPNode_ZPP_Arbiter;
            b1 = param1.body;
            ws1 = param1;
            b2 = param2.body;
            ws2 = param2;
            id = param3;
            di = param4;
            var _loc_5:* = b1.arbiters;
            if (ZNPNode_ZPP_Arbiter.zpp_pool == null)
            {
                _loc_7 = new ZNPNode_ZPP_Arbiter();
            }
            else
            {
                _loc_7 = ZNPNode_ZPP_Arbiter.zpp_pool;
                ZNPNode_ZPP_Arbiter.zpp_pool = _loc_7.next;
                _loc_7.next = null;
            }
            _loc_7.elt = this;
            var _loc_6:* = _loc_7;
            _loc_6.next = _loc_5.head;
            _loc_5.head = _loc_6;
            _loc_5.modified = true;
            (_loc_5.length + 1);
            _loc_5 = b2.arbiters;
            if (ZNPNode_ZPP_Arbiter.zpp_pool == null)
            {
                _loc_7 = new ZNPNode_ZPP_Arbiter();
            }
            else
            {
                _loc_7 = ZNPNode_ZPP_Arbiter.zpp_pool;
                ZNPNode_ZPP_Arbiter.zpp_pool = _loc_7.next;
                _loc_7.next = null;
            }
            _loc_7.elt = this;
            _loc_6 = _loc_7;
            _loc_6.next = _loc_5.head;
            _loc_5.head = _loc_6;
            _loc_5.modified = true;
            (_loc_5.length + 1);
            active = true;
            present = 0;
            cleared = false;
            sleeping = false;
            fresh = false;
            presentable = false;
            nx = 0;
            ny = 1;
            dampx = 0;
            dampy = 0;
            adamp = 0;
            return;
        }// end function

        public function applyImpulseVel() : void
        {
            var _loc_1:* = NaN;
            var _loc_2:* = NaN;
            var _loc_3:* = NaN;
            var _loc_4:* = NaN;
            var _loc_5:* = NaN;
            if (!nodrag)
            {
                _loc_1 = b1.angvel + b1.kinangvel;
                _loc_2 = b2.angvel + b2.kinangvel;
                _loc_3 = b1.velx + b1.kinvelx - r1y * _loc_1 - (b2.velx + b2.kinvelx - r2y * _loc_2);
                _loc_4 = b1.vely + b1.kinvely + r1x * _loc_1 - (b2.vely + b2.kinvely + r2x * _loc_2);
                _loc_5 = vMassa * _loc_3 + vMassb * _loc_4;
                _loc_4 = vMassb * _loc_3 + vMassc * _loc_4;
                _loc_3 = _loc_5;
                _loc_5 = lgamma;
                _loc_3 = _loc_3 - dampx * _loc_5;
                _loc_4 = _loc_4 - dampy * _loc_5;
                _loc_5 = 1;
                dampx = dampx + _loc_3 * _loc_5;
                dampy = dampy + _loc_4 * _loc_5;
                _loc_5 = b1.imass;
                b1.velx = b1.velx - _loc_3 * _loc_5;
                b1.vely = b1.vely - _loc_4 * _loc_5;
                _loc_5 = b2.imass;
                b2.velx = b2.velx + _loc_3 * _loc_5;
                b2.vely = b2.vely + _loc_4 * _loc_5;
                b1.angvel = b1.angvel - b1.iinertia * (_loc_4 * r1x - _loc_3 * r1y);
                b2.angvel = b2.angvel + b2.iinertia * (_loc_4 * r2x - _loc_3 * r2y);
                _loc_5 = (_loc_1 - _loc_2) * wMass - adamp * agamma;
                adamp = adamp + _loc_5;
                b1.angvel = b1.angvel - _loc_5 * b1.iinertia;
                b2.angvel = b2.angvel + _loc_5 * b2.iinertia;
            }
            return;
        }// end function

        public function alloc() : void
        {
            return;
        }// end function

    }
}
