package zpp_nape.constraint
{
    import flash.*;
    import nape.*;
    import nape.constraint.*;
    import nape.geom.*;
    import nape.phys.*;
    import nape.space.*;
    import nape.util.*;
    import zpp_nape.geom.*;
    import zpp_nape.phys.*;
    import zpp_nape.space.*;
    import zpp_nape.util.*;

    public class ZPP_WeldJoint extends ZPP_Constraint
    {
        public var wrap_a2:Vec2;
        public var wrap_a1:Vec2;
        public var stepped:Boolean;
        public var phase:Number;
        public var outer_zn:WeldJoint;
        public var kMassf:Number;
        public var kMasse:Number;
        public var kMassd:Number;
        public var kMassc:Number;
        public var kMassb:Number;
        public var kMassa:Number;
        public var jMax:Number;
        public var jAccz:Number;
        public var jAccy:Number;
        public var jAccx:Number;
        public var gamma:Number;
        public var biasz:Number;
        public var biasy:Number;
        public var biasx:Number;
        public var b2:ZPP_Body;
        public var b1:ZPP_Body;
        public var a2rely:Number;
        public var a2relx:Number;
        public var a2localy:Number;
        public var a2localx:Number;
        public var a1rely:Number;
        public var a1relx:Number;
        public var a1localy:Number;
        public var a1localx:Number;

        public function ZPP_WeldJoint() : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            stepped = false;
            biasz = 0;
            biasy = 0;
            biasx = 0;
            gamma = 0;
            jMax = 0;
            jAccz = 0;
            jAccy = 0;
            jAccx = 0;
            kMassf = 0;
            kMasse = 0;
            kMassc = 0;
            kMassd = 0;
            kMassb = 0;
            kMassa = 0;
            phase = 0;
            wrap_a2 = null;
            a2rely = 0;
            a2relx = 0;
            a2localy = 0;
            a2localx = 0;
            b2 = null;
            wrap_a1 = null;
            a1rely = 0;
            a1relx = 0;
            a1localy = 0;
            a1localx = 0;
            b1 = null;
            outer_zn = null;
            phase = 0;
            jAccx = 0;
            jAccy = 0;
            jAccz = 0;
            jMax = 17899999999999994000000000000;
            stepped = false;
            a1localx = 0;
            a1localy = 0;
            a1relx = 0;
            a1rely = 0;
            a2localx = 0;
            a2localy = 0;
            a2relx = 0;
            a2rely = 0;
            return;
        }// end function

        override public function warmStart() : void
        {
            var _loc_1:* = b1.imass;
            b1.velx = b1.velx - jAccx * _loc_1;
            b1.vely = b1.vely - jAccy * _loc_1;
            _loc_1 = b2.imass;
            b2.velx = b2.velx + jAccx * _loc_1;
            b2.vely = b2.vely + jAccy * _loc_1;
            b1.angvel = b1.angvel - (jAccy * a1relx - jAccx * a1rely + jAccz) * b1.iinertia;
            b2.angvel = b2.angvel + (jAccy * a2relx - jAccx * a2rely + jAccz) * b2.iinertia;
            return;
        }// end function

        override public function wake_connected() : void
        {
            if (b1 != null)
            {
            }
            if (b1.type == ZPP_Flags.id_BodyType_DYNAMIC)
            {
                b1.wake();
            }
            if (b2 != null)
            {
            }
            if (b2.type == ZPP_Flags.id_BodyType_DYNAMIC)
            {
                b2.wake();
            }
            return;
        }// end function

        public function validate_a2() : void
        {
            wrap_a2.zpp_inner.x = a2localx;
            wrap_a2.zpp_inner.y = a2localy;
            return;
        }// end function

        public function validate_a1() : void
        {
            wrap_a1.zpp_inner.x = a1localx;
            wrap_a1.zpp_inner.y = a1localy;
            return;
        }// end function

        override public function validate() : void
        {
            if (b1 != null)
            {
            }
            if (b2 == null)
            {
                throw "Error: AngleJoint cannot be simulated null bodies";
            }
            if (b1 == b2)
            {
                throw "Error: WeldJoint cannot be simulated with body1 == body2";
            }
            if (b1.space == space)
            {
            }
            if (b2.space != space)
            {
                throw "Error: Constraints must have each body within the same space to which the constraint has been assigned";
            }
            if (b1.type != ZPP_Flags.id_BodyType_DYNAMIC)
            {
            }
            if (b2.type != ZPP_Flags.id_BodyType_DYNAMIC)
            {
                throw "Error: Constraints cannot have both bodies non-dynamic";
            }
            return;
        }// end function

        public function setup_a2() : void
        {
            var _loc_4:* = null as Vec2;
            var _loc_5:* = false;
            var _loc_6:* = null as ZPP_Vec2;
            var _loc_1:* = a2localx;
            var _loc_2:* = a2localy;
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
            wrap_a2 = _loc_4;
            wrap_a2.zpp_inner._inuse = true;
            wrap_a2.zpp_inner._validate = validate_a2;
            wrap_a2.zpp_inner._invalidate = invalidate_a2;
            return;
        }// end function

        public function setup_a1() : void
        {
            var _loc_4:* = null as Vec2;
            var _loc_5:* = false;
            var _loc_6:* = null as ZPP_Vec2;
            var _loc_1:* = a1localx;
            var _loc_2:* = a1localy;
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
            wrap_a1 = _loc_4;
            wrap_a1.zpp_inner._inuse = true;
            wrap_a1.zpp_inner._validate = validate_a1;
            wrap_a1.zpp_inner._invalidate = invalidate_a1;
            return;
        }// end function

        override public function preStep(param1:Number) : Boolean
        {
            var _loc_3:* = NaN;
            var _loc_4:* = NaN;
            var _loc_5:* = NaN;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = NaN;
            var _loc_9:* = NaN;
            var _loc_10:* = NaN;
            var _loc_11:* = NaN;
            if (pre_dt == -1)
            {
                pre_dt = param1;
            }
            var _loc_2:* = param1 / pre_dt;
            pre_dt = param1;
            stepped = true;
            a1relx = b1.axisy * a1localx - b1.axisx * a1localy;
            a1rely = a1localx * b1.axisx + a1localy * b1.axisy;
            a2relx = b2.axisy * a2localx - b2.axisx * a2localy;
            a2rely = a2localx * b2.axisx + a2localy * b2.axisy;
            _loc_3 = b1.smass + b2.smass;
            kMassa = _loc_3;
            kMassb = 0;
            kMassd = _loc_3;
            kMassc = 0;
            kMasse = 0;
            kMassf = 0;
            if (b1.sinertia != 0)
            {
                _loc_4 = a1relx * b1.sinertia;
                _loc_5 = a1rely * b1.sinertia;
                kMassa = kMassa + _loc_5 * a1rely;
                kMassb = kMassb + (-_loc_5) * a1relx;
                kMassd = kMassd + _loc_4 * a1relx;
                kMassc = kMassc + (-_loc_5);
                kMasse = kMasse + _loc_4;
                kMassf = kMassf + b1.sinertia;
            }
            if (b2.sinertia != 0)
            {
                _loc_4 = a2relx * b2.sinertia;
                _loc_5 = a2rely * b2.sinertia;
                kMassa = kMassa + _loc_5 * a2rely;
                kMassb = kMassb + (-_loc_5) * a2relx;
                kMassd = kMassd + _loc_4 * a2relx;
                kMassc = kMassc + (-_loc_5);
                kMasse = kMasse + _loc_4;
                kMassf = kMassf + b2.sinertia;
            }
            _loc_3 = kMassa * (kMassd * kMassf - kMasse * kMasse) + kMassb * (kMassc * kMasse - kMassb * kMassf) + kMassc * (kMassb * kMasse - kMassc * kMassd);
            if (_loc_3 != _loc_3)
            {
                kMassa = 0;
                kMassb = 0;
                kMassd = 0;
                kMassc = 0;
                kMasse = 0;
                kMassf = 0;
                _loc_6 = 7;
            }
            else if (_loc_3 == 0)
            {
                _loc_7 = 0;
                if (kMassa != 0)
                {
                    kMassa = 1 / kMassa;
                }
                else
                {
                    kMassa = 0;
                    _loc_7 = _loc_7 | 1;
                }
                if (kMassd != 0)
                {
                    kMassd = 1 / kMassd;
                }
                else
                {
                    kMassd = 0;
                    _loc_7 = _loc_7 | 2;
                }
                if (kMassf != 0)
                {
                    kMassf = 1 / kMassf;
                }
                else
                {
                    kMassf = 0;
                    _loc_7 = _loc_7 | 4;
                }
                _loc_4 = 0;
                kMasse = _loc_4;
                _loc_4 = _loc_4;
                kMassc = _loc_4;
                kMassb = _loc_4;
                _loc_6 = _loc_7;
            }
            else
            {
                _loc_3 = 1 / _loc_3;
                _loc_4 = _loc_3 * (kMassd * kMassf - kMasse * kMasse);
                _loc_5 = _loc_3 * (kMasse * kMassc - kMassb * kMassf);
                _loc_8 = _loc_3 * (kMassa * kMassf - kMassc * kMassc);
                _loc_9 = _loc_3 * (kMassb * kMasse - kMassc * kMassd);
                _loc_10 = _loc_3 * (kMassb * kMassc - kMassa * kMasse);
                _loc_11 = _loc_3 * (kMassa * kMassd - kMassb * kMassb);
                kMassa = _loc_4;
                kMassb = _loc_5;
                kMassd = _loc_8;
                kMassc = _loc_9;
                kMasse = _loc_10;
                kMassf = _loc_11;
                _loc_6 = 0;
            }
            if ((_loc_6 & 1) != 0)
            {
                jAccx = 0;
            }
            if ((_loc_6 & 2) != 0)
            {
                jAccy = 0;
            }
            if ((_loc_6 & 4) != 0)
            {
                jAccz = 0;
            }
            if (breakUnderError)
            {
            }
            if (biasx * biasx + biasy * biasy + biasz * biasz > maxError * maxError)
            {
            }
            if (_loc_5 > _loc_4 * _loc_4)
            {
            }
            _loc_3 = _loc_2;
            _loc_4 = _loc_3;
            jAccx = jAccx * _loc_4;
            jAccy = jAccy * _loc_4;
            jAccz = jAccz * _loc_3;
            jMax = maxForce * param1;
            return false;
        }// end function

        override public function pair_exists(param1:int, param2:int) : Boolean
        {
            if (b1.id == param1)
            {
            }
            if (b2.id != param2)
            {
                if (b1.id == param2)
                {
                }
            }
            return b2.id == param1;
        }// end function

        public function invalidate_a2(param1:ZPP_Vec2) : void
        {
            immutable_midstep("Constraint::" + "a2");
            a2localx = param1.x;
            a2localy = param1.y;
            wake();
            return;
        }// end function

        public function invalidate_a1(param1:ZPP_Vec2) : void
        {
            immutable_midstep("Constraint::" + "a1");
            a1localx = param1.x;
            a1localy = param1.y;
            wake();
            return;
        }// end function

        override public function inactiveBodies() : void
        {
            if (b1 != null)
            {
                b1.constraints.remove(this);
            }
            if (b2 != b1)
            {
                if (b2 != null)
                {
                    b2.constraints.remove(this);
                }
            }
            return;
        }// end function

        override public function forest() : void
        {
            var _loc_1:* = null as ZPP_Component;
            var _loc_2:* = null as ZPP_Component;
            var _loc_3:* = null as ZPP_Component;
            var _loc_4:* = null as ZPP_Component;
            var _loc_5:* = null as ZPP_Component;
            if (b1.type == ZPP_Flags.id_BodyType_DYNAMIC)
            {
                if (b1.component == b1.component.parent)
                {
                    _loc_1 = b1.component;
                }
                else
                {
                    _loc_2 = b1.component;
                    _loc_3 = null;
                    while (_loc_2 != _loc_2.parent)
                    {
                        
                        _loc_4 = _loc_2.parent;
                        _loc_2.parent = _loc_3;
                        _loc_3 = _loc_2;
                        _loc_2 = _loc_4;
                    }
                    while (_loc_3 != null)
                    {
                        
                        _loc_4 = _loc_3.parent;
                        _loc_3.parent = _loc_2;
                        _loc_3 = _loc_4;
                    }
                    _loc_1 = _loc_2;
                }
                if (component == component.parent)
                {
                    _loc_2 = component;
                }
                else
                {
                    _loc_3 = component;
                    _loc_4 = null;
                    while (_loc_3 != _loc_3.parent)
                    {
                        
                        _loc_5 = _loc_3.parent;
                        _loc_3.parent = _loc_4;
                        _loc_4 = _loc_3;
                        _loc_3 = _loc_5;
                    }
                    while (_loc_4 != null)
                    {
                        
                        _loc_5 = _loc_4.parent;
                        _loc_4.parent = _loc_3;
                        _loc_4 = _loc_5;
                    }
                    _loc_2 = _loc_3;
                }
                if (_loc_1 != _loc_2)
                {
                    if (_loc_1.rank < _loc_2.rank)
                    {
                        _loc_1.parent = _loc_2;
                    }
                    else if (_loc_1.rank > _loc_2.rank)
                    {
                        _loc_2.parent = _loc_1;
                    }
                    else
                    {
                        _loc_2.parent = _loc_1;
                        (_loc_1.rank + 1);
                    }
                }
            }
            if (b2.type == ZPP_Flags.id_BodyType_DYNAMIC)
            {
                if (b2.component == b2.component.parent)
                {
                    _loc_1 = b2.component;
                }
                else
                {
                    _loc_2 = b2.component;
                    _loc_3 = null;
                    while (_loc_2 != _loc_2.parent)
                    {
                        
                        _loc_4 = _loc_2.parent;
                        _loc_2.parent = _loc_3;
                        _loc_3 = _loc_2;
                        _loc_2 = _loc_4;
                    }
                    while (_loc_3 != null)
                    {
                        
                        _loc_4 = _loc_3.parent;
                        _loc_3.parent = _loc_2;
                        _loc_3 = _loc_4;
                    }
                    _loc_1 = _loc_2;
                }
                if (component == component.parent)
                {
                    _loc_2 = component;
                }
                else
                {
                    _loc_3 = component;
                    _loc_4 = null;
                    while (_loc_3 != _loc_3.parent)
                    {
                        
                        _loc_5 = _loc_3.parent;
                        _loc_3.parent = _loc_4;
                        _loc_4 = _loc_3;
                        _loc_3 = _loc_5;
                    }
                    while (_loc_4 != null)
                    {
                        
                        _loc_5 = _loc_4.parent;
                        _loc_4.parent = _loc_3;
                        _loc_4 = _loc_5;
                    }
                    _loc_2 = _loc_3;
                }
                if (_loc_1 != _loc_2)
                {
                    if (_loc_1.rank < _loc_2.rank)
                    {
                        _loc_1.parent = _loc_2;
                    }
                    else if (_loc_1.rank > _loc_2.rank)
                    {
                        _loc_2.parent = _loc_1;
                    }
                    else
                    {
                        _loc_2.parent = _loc_1;
                        (_loc_1.rank + 1);
                    }
                }
            }
            return;
        }// end function

        override public function draw(param1:Debug) : void
        {
            var _loc_5:* = null as Vec2;
            var _loc_6:* = NaN;
            var _loc_7:* = null as ZPP_Vec2;
            var _loc_8:* = null as Vec2;
            var _loc_9:* = null as ZPP_Vec2;
            var _loc_10:* = 0;
            var _loc_11:* = NaN;
            var _loc_12:* = null as Body;
            var _loc_13:* = NaN;
            var _loc_14:* = NaN;
            var _loc_15:* = NaN;
            var _loc_2:* = outer_zn;
            if (_loc_2.zpp_inner_zn.wrap_a1 == null)
            {
                _loc_2.zpp_inner_zn.setup_a1();
            }
            var _loc_3:* = (_loc_2.zpp_inner_zn.b1 == null ? (null) : (_loc_2.zpp_inner_zn.b1.outer)).localPointToWorld(_loc_2.zpp_inner_zn.wrap_a1);
            if (_loc_2.zpp_inner_zn.wrap_a2 == null)
            {
                _loc_2.zpp_inner_zn.setup_a2();
            }
            var _loc_4:* = (_loc_2.zpp_inner_zn.b2 == null ? (null) : (_loc_2.zpp_inner_zn.b2.outer)).localPointToWorld(_loc_2.zpp_inner_zn.wrap_a2);
            if (!stiff)
            {
                _loc_5 = _loc_4.sub(_loc_3);
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
                _loc_7 = _loc_5.zpp_inner;
                if (_loc_7._validate != null)
                {
                    _loc_7._validate();
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
                _loc_6 = Math.sqrt(_loc_5.zpp_inner.x * _loc_5.zpp_inner.x + _loc_5.zpp_inner.y * _loc_5.zpp_inner.y);
                if (_loc_6 != 0)
                {
                    param1.drawSpring(_loc_3, _loc_4, 16711935);
                }
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
                if (_loc_5.zpp_inner._inuse)
                {
                    throw "Error: This Vec2 is not disposable";
                }
                _loc_7 = _loc_5.zpp_inner;
                _loc_5.zpp_inner.outer = null;
                _loc_5.zpp_inner = null;
                _loc_8 = _loc_5;
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
                _loc_10 = 10;
                _loc_11 = 5 / Math.PI / 2;
                if (_loc_2.zpp_inner_zn.b1 == null)
                {
                    _loc_12 = null;
                }
                else
                {
                    _loc_12 = _loc_2.zpp_inner_zn.b1.outer;
                }
                if ((_loc_2.zpp_inner_zn.b1 == null ? (null) : (_loc_2.zpp_inner_zn.b1.outer)) != (_loc_12.zpp_inner.space == null ? (null) : (_loc_12.zpp_inner.space.outer)).zpp_inner.__static)
                {
                    _loc_13 = (_loc_2.zpp_inner_zn.b2 == null ? (null) : (_loc_2.zpp_inner_zn.b2.outer)).zpp_inner.rot - _loc_2.zpp_inner_zn.phase;
                    _loc_14 = (_loc_2.zpp_inner_zn.b1 == null ? (null) : (_loc_2.zpp_inner_zn.b1.outer)).zpp_inner.rot;
                    if (_loc_14 > _loc_13)
                    {
                        _loc_15 = _loc_14;
                        _loc_14 = _loc_13;
                        _loc_13 = _loc_15;
                    }
                    if (_loc_2.zpp_inner_zn.b1 == null)
                    {
                        _loc_12 = null;
                    }
                    else
                    {
                        _loc_12 = _loc_2.zpp_inner_zn.b1.outer;
                    }
                    if (_loc_12.zpp_inner.wrap_pos == null)
                    {
                        _loc_12.zpp_inner.setupPosition();
                    }
                    ZPP_AngleDraw.drawSpiralSpring(param1, _loc_12.zpp_inner.wrap_pos, _loc_14, _loc_13, _loc_10 + (_loc_14 - _loc_14) * _loc_11, _loc_10 + (_loc_13 - _loc_14) * _loc_11, 16711808);
                    if (_loc_2.zpp_inner_zn.b1 == null)
                    {
                        _loc_12 = null;
                    }
                    else
                    {
                        _loc_12 = _loc_2.zpp_inner_zn.b1.outer;
                    }
                    if (_loc_12.zpp_inner.wrap_pos == null)
                    {
                        _loc_12.zpp_inner.setupPosition();
                    }
                    ZPP_AngleDraw.indicator(param1, _loc_12.zpp_inner.wrap_pos, (_loc_2.zpp_inner_zn.b1 == null ? (null) : (_loc_2.zpp_inner_zn.b1.outer)).zpp_inner.rot, _loc_10 + ((_loc_2.zpp_inner_zn.b1 == null ? (null) : (_loc_2.zpp_inner_zn.b1.outer)).zpp_inner.rot - _loc_14) * _loc_11, 16711808);
                }
                if (_loc_2.zpp_inner_zn.b2 == null)
                {
                    _loc_12 = null;
                }
                else
                {
                    _loc_12 = _loc_2.zpp_inner_zn.b2.outer;
                }
                if ((_loc_2.zpp_inner_zn.b2 == null ? (null) : (_loc_2.zpp_inner_zn.b2.outer)) != (_loc_12.zpp_inner.space == null ? (null) : (_loc_12.zpp_inner.space.outer)).zpp_inner.__static)
                {
                    _loc_13 = _loc_2.zpp_inner_zn.phase + (_loc_2.zpp_inner_zn.b1 == null ? (null) : (_loc_2.zpp_inner_zn.b1.outer)).zpp_inner.rot;
                    _loc_14 = (_loc_2.zpp_inner_zn.b2 == null ? (null) : (_loc_2.zpp_inner_zn.b2.outer)).zpp_inner.rot;
                    if (_loc_14 > _loc_13)
                    {
                        _loc_15 = _loc_14;
                        _loc_14 = _loc_13;
                        _loc_13 = _loc_15;
                    }
                    if (_loc_2.zpp_inner_zn.b2 == null)
                    {
                        _loc_12 = null;
                    }
                    else
                    {
                        _loc_12 = _loc_2.zpp_inner_zn.b2.outer;
                    }
                    if (_loc_12.zpp_inner.wrap_pos == null)
                    {
                        _loc_12.zpp_inner.setupPosition();
                    }
                    ZPP_AngleDraw.drawSpiralSpring(param1, _loc_12.zpp_inner.wrap_pos, _loc_14, _loc_13, _loc_10 + (_loc_14 - _loc_14) * _loc_11, _loc_10 + (_loc_13 - _loc_14) * _loc_11, 8388863);
                    if (_loc_2.zpp_inner_zn.b2 == null)
                    {
                        _loc_12 = null;
                    }
                    else
                    {
                        _loc_12 = _loc_2.zpp_inner_zn.b2.outer;
                    }
                    if (_loc_12.zpp_inner.wrap_pos == null)
                    {
                        _loc_12.zpp_inner.setupPosition();
                    }
                    ZPP_AngleDraw.indicator(param1, _loc_12.zpp_inner.wrap_pos, (_loc_2.zpp_inner_zn.b2 == null ? (null) : (_loc_2.zpp_inner_zn.b2.outer)).zpp_inner.rot, _loc_10 + ((_loc_2.zpp_inner_zn.b2 == null ? (null) : (_loc_2.zpp_inner_zn.b2.outer)).zpp_inner.rot - _loc_14) * _loc_11, 8388863);
                }
            }
            param1.drawFilledCircle(_loc_3, 2, 255);
            param1.drawFilledCircle(_loc_4, 2, 16711680);
            if (_loc_3 != null)
            {
            }
            if (_loc_3.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_7 = _loc_3.zpp_inner;
            if (_loc_7._immutable)
            {
                throw "Error: Vec2 is immutable";
            }
            if (_loc_7._isimmutable != null)
            {
                _loc_7._isimmutable();
            }
            if (_loc_3.zpp_inner._inuse)
            {
                throw "Error: This Vec2 is not disposable";
            }
            _loc_7 = _loc_3.zpp_inner;
            _loc_3.zpp_inner.outer = null;
            _loc_3.zpp_inner = null;
            _loc_5 = _loc_3;
            _loc_5.zpp_pool = null;
            if (ZPP_PubPool.nextVec2 != null)
            {
                ZPP_PubPool.nextVec2.zpp_pool = _loc_5;
            }
            else
            {
                ZPP_PubPool.poolVec2 = _loc_5;
            }
            ZPP_PubPool.nextVec2 = _loc_5;
            _loc_5.zpp_disp = true;
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
            if (_loc_4 != null)
            {
            }
            if (_loc_4.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_7 = _loc_4.zpp_inner;
            if (_loc_7._immutable)
            {
                throw "Error: Vec2 is immutable";
            }
            if (_loc_7._isimmutable != null)
            {
                _loc_7._isimmutable();
            }
            if (_loc_4.zpp_inner._inuse)
            {
                throw "Error: This Vec2 is not disposable";
            }
            _loc_7 = _loc_4.zpp_inner;
            _loc_4.zpp_inner.outer = null;
            _loc_4.zpp_inner = null;
            _loc_5 = _loc_4;
            _loc_5.zpp_pool = null;
            if (ZPP_PubPool.nextVec2 != null)
            {
                ZPP_PubPool.nextVec2.zpp_pool = _loc_5;
            }
            else
            {
                ZPP_PubPool.poolVec2 = _loc_5;
            }
            ZPP_PubPool.nextVec2 = _loc_5;
            _loc_5.zpp_disp = true;
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
            return;
        }// end function

        override public function copy(param1:Array = undefined, param2:Array = undefined) : Constraint
        {
            var _loc_4:* = null as Body;
            var _loc_5:* = 0;
            var _loc_6:* = null as ZPP_CopyHelper;
            var _loc_3:* = outer_zn;
            if (_loc_3.zpp_inner_zn.wrap_a1 == null)
            {
                _loc_3.zpp_inner_zn.setup_a1();
            }
            _loc_3 = outer_zn;
            if (_loc_3.zpp_inner_zn.wrap_a2 == null)
            {
                _loc_3.zpp_inner_zn.setup_a2();
            }
            var ret:* = new PivotJoint(null, null, _loc_3.zpp_inner_zn.wrap_a1, _loc_3.zpp_inner_zn.wrap_a2);
            copyto(ret);
            if (param1 != null)
            {
            }
            if (b1 != null)
            {
                _loc_4 = null;
                _loc_5 = 0;
                while (_loc_5 < param1.length)
                {
                    
                    _loc_6 = param1[_loc_5];
                    _loc_5++;
                    if (_loc_6.id == b1.id)
                    {
                        _loc_4 = _loc_6.bc;
                        break;
                    }
                }
                if (_loc_4 != null)
                {
                    ret.zpp_inner_zn.b1 = _loc_4.zpp_inner;
                }
                else
                {
                    param2.push(ZPP_CopyHelper.todo(b1.id, function (param1:Body) : void
            {
                ret.zpp_inner_zn.b1 = param1.zpp_inner;
                return;
            }// end function
            ));
                }
            }
            if (param1 != null)
            {
            }
            if (b2 != null)
            {
                _loc_4 = null;
                _loc_5 = 0;
                while (_loc_5 < param1.length)
                {
                    
                    _loc_6 = param1[_loc_5];
                    _loc_5++;
                    if (_loc_6.id == b2.id)
                    {
                        _loc_4 = _loc_6.bc;
                        break;
                    }
                }
                if (_loc_4 != null)
                {
                    ret.zpp_inner_zn.b2 = _loc_4.zpp_inner;
                }
                else
                {
                    param2.push(ZPP_CopyHelper.todo(b2.id, function (param1:Body) : void
            {
                ret.zpp_inner_zn.b2 = param1.zpp_inner;
                return;
            }// end function
            ));
                }
            }
            return ret;
        }// end function

        override public function clearcache() : void
        {
            jAccx = 0;
            jAccy = 0;
            jAccz = 0;
            pre_dt = -1;
            return;
        }// end function

        public function bodyImpulse(param1:ZPP_Body) : Vec3
        {
            if (stepped)
            {
                if (param1 == b1)
                {
                    return Vec3.get(-jAccx, -jAccy, -(jAccy * a1relx - jAccx * a1rely + jAccz));
                }
                else
                {
                    return Vec3.get(jAccx, jAccy, jAccy * a2relx - jAccx * a2rely + jAccz);
                }
            }
            else
            {
                return Vec3.get(0, 0, 0);
            }
        }// end function

        override public function applyImpulseVel() : Boolean
        {
            var _loc_10:* = 0;
            var _loc_12:* = NaN;
            var _loc_13:* = NaN;
            var _loc_14:* = NaN;
            var _loc_15:* = NaN;
            var _loc_1:* = 0;
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            _loc_1 = b2.velx + b2.kinvelx - a2rely * (b2.angvel + b2.kinangvel) - (b1.velx + b1.kinvelx - a1rely * (b1.angvel + b1.kinangvel));
            _loc_2 = b2.vely + b2.kinvely + a2relx * (b2.angvel + b2.kinangvel) - (b1.vely + b1.kinvely + a1relx * (b1.angvel + b1.kinangvel));
            _loc_3 = b2.angvel + b2.kinangvel - b1.angvel - b1.kinangvel;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            _loc_4 = biasx - _loc_1;
            _loc_5 = biasy - _loc_2;
            _loc_6 = biasz - _loc_3;
            var _loc_7:* = kMassa * _loc_4 + kMassb * _loc_5 + kMassc * _loc_6;
            var _loc_8:* = kMassb * _loc_4 + kMassd * _loc_5 + kMasse * _loc_6;
            _loc_6 = kMassc * _loc_4 + kMasse * _loc_5 + kMassf * _loc_6;
            _loc_4 = _loc_7;
            _loc_5 = _loc_8;
            _loc_7 = gamma;
            _loc_8 = _loc_7;
            _loc_4 = _loc_4 - jAccx * _loc_8;
            _loc_5 = _loc_5 - jAccy * _loc_8;
            _loc_6 = _loc_6 - jAccz * _loc_7;
            _loc_7 = 0;
            _loc_8 = 0;
            var _loc_9:* = 0;
            _loc_7 = jAccx;
            _loc_8 = jAccy;
            _loc_9 = jAccz;
            _loc_10 = 1;
            var _loc_11:* = _loc_10;
            jAccx = jAccx + _loc_4 * _loc_11;
            jAccy = jAccy + _loc_5 * _loc_11;
            jAccz = jAccz + _loc_6 * _loc_10;
            if (breakUnderForce)
            {
                if (jAccx * jAccx + jAccy * jAccy + jAccz * jAccz > jMax * jMax)
                {
                    return true;
                }
            }
            else if (!stiff)
            {
                _loc_12 = jMax;
                _loc_13 = jAccx * jAccx + jAccy * jAccy + jAccz * jAccz;
                if (_loc_13 > _loc_12 * _loc_12)
                {
                    _loc_10 = 1597463007 - (0 >> 1);
                    _loc_15 = 0;
                    _loc_14 = 0 * (_loc_15 * (1.5 - 0.5 * _loc_13 * _loc_15 * _loc_15));
                    _loc_15 = _loc_14;
                    jAccx = jAccx * _loc_15;
                    jAccy = jAccy * _loc_15;
                    jAccz = jAccz * _loc_14;
                }
            }
            _loc_4 = jAccx - _loc_7;
            _loc_5 = jAccy - _loc_8;
            _loc_6 = jAccz - _loc_9;
            _loc_7 = b1.imass;
            b1.velx = b1.velx - _loc_4 * _loc_7;
            b1.vely = b1.vely - _loc_5 * _loc_7;
            _loc_7 = b2.imass;
            b2.velx = b2.velx + _loc_4 * _loc_7;
            b2.vely = b2.vely + _loc_5 * _loc_7;
            b1.angvel = b1.angvel - (_loc_5 * a1relx - _loc_4 * a1rely + _loc_6) * b1.iinertia;
            b2.angvel = b2.angvel + (_loc_5 * a2relx - _loc_4 * a2rely + _loc_6) * b2.iinertia;
            return false;
        }// end function

        override public function applyImpulsePos() : Boolean
        {
            var _loc_12:* = NaN;
            var _loc_13:* = NaN;
            var _loc_14:* = 0;
            var _loc_15:* = NaN;
            var _loc_16:* = 0;
            var _loc_17:* = NaN;
            var _loc_21:* = NaN;
            var _loc_22:* = NaN;
            var _loc_23:* = NaN;
            var _loc_24:* = NaN;
            var _loc_25:* = NaN;
            var _loc_1:* = 0;
            var _loc_2:* = 0;
            _loc_1 = b1.axisy * a1localx - b1.axisx * a1localy;
            _loc_2 = a1localx * b1.axisx + a1localy * b1.axisy;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            _loc_3 = b2.axisy * a2localx - b2.axisx * a2localy;
            _loc_4 = a2localx * b2.axisx + a2localy * b2.axisy;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            _loc_5 = b2.posx + _loc_3 - (b1.posx + _loc_1);
            _loc_6 = b2.posy + _loc_4 - (b1.posy + _loc_2);
            _loc_7 = b2.rot - b1.rot - phase;
            var _loc_8:* = 0;
            var _loc_9:* = 0;
            var _loc_10:* = 0;
            if (breakUnderError)
            {
            }
            if (_loc_5 * _loc_5 + _loc_6 * _loc_6 + _loc_7 * _loc_7 > maxError * maxError)
            {
                return true;
            }
            var _loc_11:* = true;
            if (_loc_5 * _loc_5 + _loc_6 * _loc_6 < Config.constraintLinearSlop * Config.constraintLinearSlop)
            {
                _loc_11 = false;
                _loc_5 = 0;
                _loc_6 = 0;
            }
            _loc_12 = Config.constraintAngularSlop;
            if (_loc_7 * _loc_7 < _loc_12 * _loc_12)
            {
                if (!_loc_11)
                {
                    return false;
                }
                else
                {
                    _loc_7 = 0;
                }
            }
            _loc_12 = 0.5;
            _loc_13 = _loc_12;
            _loc_5 = _loc_5 * _loc_13;
            _loc_6 = _loc_6 * _loc_13;
            _loc_7 = _loc_7 * _loc_12;
            if (_loc_5 * _loc_5 + _loc_6 * _loc_6 > 6)
            {
                _loc_12 = b1.smass + b2.smass;
                if (_loc_12 > Config.epsilon)
                {
                    _loc_12 = 0.75 / _loc_12;
                    _loc_8 = (-_loc_5) * _loc_12;
                    _loc_9 = (-_loc_6) * _loc_12;
                    _loc_14 = 20;
                    _loc_13 = _loc_8 * _loc_8 + _loc_9 * _loc_9;
                    if (_loc_13 > _loc_14 * _loc_14)
                    {
                        _loc_16 = 1597463007 - (0 >> 1);
                        _loc_17 = 0;
                        _loc_15 = 0 * (_loc_17 * (1.5 - 0.5 * _loc_13 * _loc_17 * _loc_17));
                        _loc_8 = _loc_8 * _loc_15;
                        _loc_9 = _loc_9 * _loc_15;
                    }
                    _loc_13 = b1.imass;
                    b1.posx = b1.posx - _loc_8 * _loc_13;
                    b1.posy = b1.posy - _loc_9 * _loc_13;
                    _loc_13 = b2.imass;
                    b2.posx = b2.posx + _loc_8 * _loc_13;
                    b2.posy = b2.posy + _loc_9 * _loc_13;
                    _loc_5 = b2.posx + _loc_3 - (b1.posx + _loc_1);
                    _loc_6 = b2.posy + _loc_4 - (b1.posy + _loc_2);
                    _loc_7 = b2.rot - b1.rot - phase;
                    _loc_13 = 0.5;
                    _loc_15 = _loc_13;
                    _loc_5 = _loc_5 * _loc_15;
                    _loc_6 = _loc_6 * _loc_15;
                    _loc_7 = _loc_7 * _loc_13;
                }
            }
            _loc_12 = 0;
            _loc_13 = 0;
            _loc_15 = 0;
            _loc_17 = 0;
            var _loc_18:* = 0;
            var _loc_19:* = 0;
            var _loc_20:* = b1.smass + b2.smass;
            _loc_12 = _loc_20;
            _loc_13 = 0;
            _loc_15 = _loc_20;
            _loc_17 = 0;
            _loc_18 = 0;
            _loc_19 = 0;
            if (b1.sinertia != 0)
            {
                _loc_21 = _loc_1 * b1.sinertia;
                _loc_22 = _loc_2 * b1.sinertia;
                _loc_12 = _loc_12 + _loc_22 * _loc_2;
                _loc_13 = _loc_13 + (-_loc_22) * _loc_1;
                _loc_15 = _loc_15 + _loc_21 * _loc_1;
                _loc_17 = _loc_17 + (-_loc_22);
                _loc_18 = _loc_18 + _loc_21;
                _loc_19 = _loc_19 + b1.sinertia;
            }
            if (b2.sinertia != 0)
            {
                _loc_21 = _loc_3 * b2.sinertia;
                _loc_22 = _loc_4 * b2.sinertia;
                _loc_12 = _loc_12 + _loc_22 * _loc_4;
                _loc_13 = _loc_13 + (-_loc_22) * _loc_3;
                _loc_15 = _loc_15 + _loc_21 * _loc_3;
                _loc_17 = _loc_17 + (-_loc_22);
                _loc_18 = _loc_18 + _loc_21;
                _loc_19 = _loc_19 + b2.sinertia;
            }
            _loc_8 = -_loc_5;
            _loc_9 = -_loc_6;
            _loc_10 = -_loc_7;
            _loc_14 = 6;
            _loc_20 = _loc_8 * _loc_8 + _loc_9 * _loc_9;
            if (_loc_20 > _loc_14 * _loc_14)
            {
                _loc_16 = 1597463007 - (0 >> 1);
                _loc_22 = 0;
                _loc_21 = 0 * (_loc_22 * (1.5 - 0.5 * _loc_20 * _loc_22 * _loc_22));
                _loc_8 = _loc_8 * _loc_21;
                _loc_9 = _loc_9 * _loc_21;
            }
            _loc_20 = -0.25;
            if (_loc_10 < _loc_20)
            {
            }
            else if (_loc_10 > 0.25)
            {
            }
            else
            {
            }
            _loc_20 = _loc_12 * (_loc_15 * _loc_19 - _loc_18 * _loc_18) + _loc_13 * (_loc_17 * _loc_18 - _loc_13 * _loc_19) + _loc_17 * (_loc_13 * _loc_18 - _loc_17 * _loc_15);
            if (_loc_20 != _loc_20)
            {
                _loc_10 = 0;
                _loc_9 = _loc_10;
                _loc_8 = _loc_9;
            }
            else if (_loc_20 == 0)
            {
                if (_loc_12 != 0)
                {
                    _loc_8 = _loc_8 / _loc_12;
                }
                else
                {
                    _loc_8 = 0;
                }
                if (_loc_15 != 0)
                {
                    _loc_9 = _loc_9 / _loc_15;
                }
                else
                {
                    _loc_9 = 0;
                }
                if (_loc_19 != 0)
                {
                    _loc_10 = _loc_10 / _loc_19;
                }
                else
                {
                    _loc_10 = 0;
                }
            }
            else
            {
                _loc_20 = 1 / _loc_20;
                _loc_21 = _loc_18 * _loc_17 - _loc_13 * _loc_19;
                _loc_22 = _loc_13 * _loc_18 - _loc_17 * _loc_15;
                _loc_23 = _loc_13 * _loc_17 - _loc_12 * _loc_18;
                _loc_24 = _loc_20 * (_loc_8 * (_loc_15 * _loc_19 - _loc_18 * _loc_18) + _loc_9 * _loc_21 + _loc_10 * _loc_22);
                _loc_25 = _loc_20 * (_loc_8 * _loc_21 + _loc_9 * (_loc_12 * _loc_19 - _loc_17 * _loc_17) + _loc_10 * _loc_23);
                _loc_10 = _loc_20 * (_loc_8 * _loc_22 + _loc_9 * _loc_23 + _loc_10 * (_loc_12 * _loc_15 - _loc_13 * _loc_13));
                _loc_8 = _loc_24;
                _loc_9 = _loc_25;
            }
            _loc_20 = b1.imass;
            b1.posx = b1.posx - _loc_8 * _loc_20;
            b1.posy = b1.posy - _loc_9 * _loc_20;
            _loc_20 = b2.imass;
            b2.posx = b2.posx + _loc_8 * _loc_20;
            b2.posy = b2.posy + _loc_9 * _loc_20;
            var _loc_26:* = b1;
            _loc_20 = (-(_loc_9 * _loc_1 - _loc_8 * _loc_2 + _loc_10)) * b1.iinertia;
            _loc_26.rot = _loc_26.rot + _loc_20;
            if (_loc_20 * _loc_20 > 0.0001)
            {
                _loc_26.axisx = Math.sin(_loc_26.rot);
                _loc_26.axisy = Math.cos(_loc_26.rot);
            }
            else
            {
                _loc_21 = _loc_20 * _loc_20;
                _loc_22 = 1 - 0.5 * _loc_21;
                _loc_23 = 1 - _loc_21 * _loc_21 / 8;
                _loc_24 = (_loc_22 * _loc_26.axisx + _loc_20 * _loc_26.axisy) * _loc_23;
                _loc_26.axisy = (_loc_22 * _loc_26.axisy - _loc_20 * _loc_26.axisx) * _loc_23;
                _loc_26.axisx = _loc_24;
            }
            _loc_26 = b2;
            _loc_20 = (_loc_9 * _loc_3 - _loc_8 * _loc_4 + _loc_10) * b2.iinertia;
            _loc_26.rot = _loc_26.rot + _loc_20;
            if (_loc_20 * _loc_20 > 0.0001)
            {
                _loc_26.axisx = Math.sin(_loc_26.rot);
                _loc_26.axisy = Math.cos(_loc_26.rot);
            }
            else
            {
                _loc_21 = _loc_20 * _loc_20;
                _loc_22 = 1 - 0.5 * _loc_21;
                _loc_23 = 1 - _loc_21 * _loc_21 / 8;
                _loc_24 = (_loc_22 * _loc_26.axisx + _loc_20 * _loc_26.axisy) * _loc_23;
                _loc_26.axisy = (_loc_22 * _loc_26.axisy - _loc_20 * _loc_26.axisx) * _loc_23;
                _loc_26.axisx = _loc_24;
            }
            return false;
        }// end function

        override public function activeBodies() : void
        {
            if (b1 != null)
            {
                b1.constraints.add(this);
            }
            if (b2 != b1)
            {
                if (b2 != null)
                {
                    b2.constraints.add(this);
                }
            }
            return;
        }// end function

    }
}
