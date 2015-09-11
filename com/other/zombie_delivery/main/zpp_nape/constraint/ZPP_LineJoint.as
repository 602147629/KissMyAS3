package zpp_nape.constraint
{
    import flash.*;
    import nape.*;
    import nape.constraint.*;
    import nape.geom.*;
    import nape.phys.*;
    import nape.util.*;
    import zpp_nape.geom.*;
    import zpp_nape.phys.*;
    import zpp_nape.space.*;
    import zpp_nape.util.*;

    public class ZPP_LineJoint extends ZPP_Constraint
    {
        public var zip_n:Boolean;
        public var wrap_n:Vec2;
        public var wrap_a2:Vec2;
        public var wrap_a1:Vec2;
        public var stepped:Boolean;
        public var scale:Number;
        public var outer_zn:LineJoint;
        public var nrely:Number;
        public var nrelx:Number;
        public var nlocaly:Number;
        public var nlocalx:Number;
        public var kMassc:Number;
        public var kMassb:Number;
        public var kMassa:Number;
        public var jointMin:Number;
        public var jointMax:Number;
        public var jMax:Number;
        public var jAccy:Number;
        public var jAccx:Number;
        public var gamma:Number;
        public var equal:Boolean;
        public var dot2:Number;
        public var dot1:Number;
        public var cx2:Number;
        public var cx1:Number;
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

        public function ZPP_LineJoint() : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            biasy = 0;
            biasx = 0;
            jAccy = 0;
            jAccx = 0;
            kMassc = 0;
            kMassb = 0;
            kMassa = 0;
            wrap_n = null;
            nrely = 0;
            nrelx = 0;
            nlocaly = 0;
            nlocalx = 0;
            wrap_a2 = null;
            a2rely = 0;
            a2relx = 0;
            a2localy = 0;
            a2localx = 0;
            wrap_a1 = null;
            a1rely = 0;
            a1relx = 0;
            a1localy = 0;
            a1localx = 0;
            cx2 = 0;
            cx1 = 0;
            dot2 = 0;
            dot1 = 0;
            equal = false;
            jointMax = 0;
            jointMin = 0;
            scale = 0;
            outer_zn = null;
            a1localx = 0;
            a1localy = 0;
            a1relx = 0;
            a1rely = 0;
            a2localx = 0;
            a2localy = 0;
            a2relx = 0;
            a2rely = 0;
            nlocalx = 0;
            nlocaly = 0;
            nrelx = 0;
            nrely = 0;
            jAccx = 0;
            jAccy = 0;
            jMax = 17899999999999994000000000000;
            jointMin = -17899999999999994000000000000;
            jointMax = 17899999999999994000000000000;
            stepped = false;
            return;
        }// end function

        override public function warmStart() : void
        {
            var _loc_1:* = scale * nrelx * jAccy - nrely * jAccx;
            var _loc_2:* = nrelx * jAccx + scale * nrely * jAccy;
            var _loc_3:* = b1.imass;
            b1.velx = b1.velx - _loc_1 * _loc_3;
            b1.vely = b1.vely - _loc_2 * _loc_3;
            _loc_3 = b2.imass;
            b2.velx = b2.velx + _loc_1 * _loc_3;
            b2.vely = b2.vely + _loc_2 * _loc_3;
            b1.angvel = b1.angvel + (scale * cx1 * jAccy - dot1 * jAccx) * b1.iinertia;
            b2.angvel = b2.angvel + (dot2 * jAccx - scale * cx2 * jAccy) * b2.iinertia;
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

        public function validate_norm() : void
        {
            var _loc_1:* = NaN;
            var _loc_2:* = NaN;
            var _loc_3:* = NaN;
            if (zip_n)
            {
                zip_n = false;
                _loc_1 = nlocalx * nlocalx + nlocaly * nlocaly;
                _loc_2 = 1 / Math.sqrt(_loc_1);
                _loc_3 = _loc_2;
                nlocalx = nlocalx * _loc_3;
                nlocaly = nlocaly * _loc_3;
            }
            return;
        }// end function

        public function validate_n() : void
        {
            wrap_n.zpp_inner.x = nlocalx;
            wrap_n.zpp_inner.y = nlocaly;
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
                throw "Error: DistanceJoint cannot be simulated with body1 == body2";
            }
            if (b1.space == space)
            {
            }
            if (b2.space != space)
            {
                throw "Error: Constraints must have each body within the same space to which the constraint has been assigned";
            }
            if (jointMin > jointMax)
            {
                throw "Error: DistanceJoint must have jointMin <= jointMax";
            }
            if (nlocalx * nlocalx + nlocaly * nlocaly < Config.epsilon)
            {
                throw "Error: DistanceJoint direction must be non-degenerate";
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

        public function setup_n() : void
        {
            var _loc_4:* = null as Vec2;
            var _loc_5:* = false;
            var _loc_6:* = null as ZPP_Vec2;
            var _loc_1:* = nlocalx;
            var _loc_2:* = nlocaly;
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
            wrap_n = _loc_4;
            wrap_n.zpp_inner._inuse = true;
            wrap_n.zpp_inner._validate = validate_n;
            wrap_n.zpp_inner._invalidate = invalidate_n;
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
            var _loc_7:* = NaN;
            var _loc_8:* = NaN;
            var _loc_9:* = 0;
            var _loc_10:* = 0;
            var _loc_11:* = NaN;
            var _loc_12:* = NaN;
            var _loc_13:* = NaN;
            if (pre_dt == -1)
            {
                pre_dt = param1;
            }
            var _loc_2:* = param1 / pre_dt;
            pre_dt = param1;
            equal = jointMin == jointMax;
            stepped = true;
            validate_norm();
            a1relx = b1.axisy * a1localx - b1.axisx * a1localy;
            a1rely = a1localx * b1.axisx + a1localy * b1.axisy;
            nrelx = b1.axisy * nlocalx - b1.axisx * nlocaly;
            nrely = nlocalx * b1.axisx + nlocaly * b1.axisy;
            a2relx = b2.axisy * a2localx - b2.axisx * a2localy;
            a2rely = a2localx * b2.axisx + a2localy * b2.axisy;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            _loc_3 = b2.posx + a2relx - b1.posx - a1relx;
            _loc_4 = b2.posy + a2rely - b1.posy - a1rely;
            _loc_5 = _loc_4 * nrelx - _loc_3 * nrely;
            _loc_6 = nrelx * _loc_3 + nrely * _loc_4;
            if (equal)
            {
                _loc_6 = _loc_6 - jointMin;
                scale = 1;
            }
            else if (_loc_6 > jointMax)
            {
                _loc_6 = _loc_6 - jointMax;
                scale = 1;
            }
            else if (_loc_6 < jointMin)
            {
                _loc_6 = jointMin - _loc_6;
                scale = -1;
            }
            else
            {
                _loc_6 = 0;
                scale = 0;
            }
            _loc_7 = 0;
            _loc_8 = 0;
            _loc_7 = _loc_3 + a1relx;
            _loc_8 = _loc_4 + a1rely;
            dot1 = nrelx * _loc_7 + nrely * _loc_8;
            cx1 = _loc_8 * nrelx - _loc_7 * nrely;
            dot2 = nrelx * a2relx + nrely * a2rely;
            cx2 = a2rely * nrelx - a2relx * nrely;
            kMassa = b1.smass + b2.smass + dot1 * dot1 * b1.sinertia + dot2 * dot2 * b2.sinertia;
            kMassb = (-scale) * (dot1 * cx1 * b1.sinertia + dot2 * cx2 * b2.sinertia);
            kMassc = scale * scale * (b1.smass + b2.smass + cx1 * cx1 * b1.sinertia + cx2 * cx2 * b2.sinertia);
            _loc_7 = kMassa * kMassc - kMassb * kMassb;
            if (_loc_7 != _loc_7)
            {
                _loc_8 = 0;
                kMassc = _loc_8;
                _loc_8 = _loc_8;
                kMassb = _loc_8;
                kMassa = _loc_8;
                _loc_9 = 3;
            }
            else if (_loc_7 == 0)
            {
                _loc_10 = 0;
                if (kMassa != 0)
                {
                    kMassa = 1 / kMassa;
                }
                else
                {
                    kMassa = 0;
                    _loc_10 = _loc_10 | 1;
                }
                if (kMassc != 0)
                {
                    kMassc = 1 / kMassc;
                }
                else
                {
                    kMassc = 0;
                    _loc_10 = _loc_10 | 2;
                }
                kMassb = 0;
                _loc_9 = _loc_10;
            }
            else
            {
                _loc_7 = 1 / _loc_7;
                _loc_8 = kMassc * _loc_7;
                kMassc = kMassa * _loc_7;
                kMassa = _loc_8;
                kMassb = kMassb * (-_loc_7);
                _loc_9 = 0;
            }
            if ((_loc_9 & 1) != 0)
            {
                jAccx = 0;
            }
            if ((_loc_9 & 2) != 0)
            {
                jAccy = 0;
            }
            if (breakUnderError)
            {
            }
            if (_loc_5 * _loc_5 + _loc_6 * _loc_6 > maxError * maxError)
            {
            }
            if (_loc_11 > _loc_8 * _loc_8)
            {
            }
            _loc_7 = _loc_2;
            jAccx = jAccx * _loc_7;
            jAccy = jAccy * _loc_7;
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

        public function invalidate_n(param1:ZPP_Vec2) : void
        {
            immutable_midstep("Constraint::" + "n");
            nlocalx = param1.x;
            nlocaly = param1.y;
            zip_n = true;
            wake();
            return;
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
            var _loc_6:* = null as ZPP_Vec2;
            var _loc_12:* = null as ZPP_Vec2;
            var _loc_14:* = NaN;
            var _loc_15:* = NaN;
            var _loc_16:* = null as Vec2;
            var _loc_17:* = false;
            var _loc_18:* = null as Vec2;
            var _loc_19:* = false;
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
            if (_loc_2.zpp_inner_zn.wrap_n == null)
            {
                _loc_2.zpp_inner_zn.setup_n();
            }
            var _loc_5:* = (_loc_2.zpp_inner_zn.b1 == null ? (null) : (_loc_2.zpp_inner_zn.b1.outer)).localVectorToWorld(_loc_2.zpp_inner_zn.wrap_n);
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
            _loc_6 = _loc_5.zpp_inner;
            if (_loc_6._validate != null)
            {
                _loc_6._validate();
            }
            if (_loc_5 != null)
            {
            }
            if (_loc_5.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_6 = _loc_5.zpp_inner;
            if (_loc_6._validate != null)
            {
                _loc_6._validate();
            }
            if (_loc_5 != null)
            {
            }
            if (_loc_5.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_6 = _loc_5.zpp_inner;
            if (_loc_6._validate != null)
            {
                _loc_6._validate();
            }
            if (_loc_5 != null)
            {
            }
            if (_loc_5.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_6 = _loc_5.zpp_inner;
            if (_loc_6._validate != null)
            {
                _loc_6._validate();
            }
            _loc_5.muleq(1 / Math.sqrt(_loc_5.zpp_inner.x * _loc_5.zpp_inner.x + _loc_5.zpp_inner.y * _loc_5.zpp_inner.y));
            var _loc_7:* = _loc_2.zpp_inner_zn.jointMin;
            var _loc_8:* = _loc_2.zpp_inner_zn.jointMax;
            if (_loc_7 <= -17899999999999994000000000000)
            {
                _loc_7 = -1000;
            }
            if (_loc_8 >= 17899999999999994000000000000)
            {
                _loc_8 = 1000;
            }
            var _loc_9:* = _loc_4.sub(_loc_3);
            var _loc_10:* = _loc_9.dot(_loc_5);
            if (_loc_9 != null)
            {
            }
            if (_loc_9.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_6 = _loc_9.zpp_inner;
            if (_loc_6._immutable)
            {
                throw "Error: Vec2 is immutable";
            }
            if (_loc_6._isimmutable != null)
            {
                _loc_6._isimmutable();
            }
            if (_loc_9.zpp_inner._inuse)
            {
                throw "Error: This Vec2 is not disposable";
            }
            _loc_6 = _loc_9.zpp_inner;
            _loc_9.zpp_inner.outer = null;
            _loc_9.zpp_inner = null;
            var _loc_11:* = _loc_9;
            _loc_11.zpp_pool = null;
            if (ZPP_PubPool.nextVec2 != null)
            {
                ZPP_PubPool.nextVec2.zpp_pool = _loc_11;
            }
            else
            {
                ZPP_PubPool.poolVec2 = _loc_11;
            }
            ZPP_PubPool.nextVec2 = _loc_11;
            _loc_11.zpp_disp = true;
            _loc_12 = _loc_6;
            if (_loc_12.outer != null)
            {
                _loc_12.outer.zpp_inner = null;
                _loc_12.outer = null;
            }
            _loc_12._isimmutable = null;
            _loc_12._validate = null;
            _loc_12._invalidate = null;
            _loc_12.next = ZPP_Vec2.zpp_pool;
            ZPP_Vec2.zpp_pool = _loc_12;
            _loc_11 = _loc_3.add(_loc_5.mul(_loc_7, true));
            var _loc_13:* = _loc_3.add(_loc_5.mul(_loc_8, true));
            if (_loc_10 > _loc_7)
            {
                _loc_14 = _loc_10;
                _loc_15 = _loc_8;
                param1.drawLine(_loc_11, _loc_3.add(_loc_5.mul(_loc_14 < _loc_15 ? (_loc_14) : (_loc_15), true), true), 16776960);
            }
            if (_loc_10 < _loc_8)
            {
                _loc_14 = _loc_10;
                _loc_15 = _loc_7;
                param1.drawLine(_loc_3.add(_loc_5.mul(_loc_14 > _loc_15 ? (_loc_14) : (_loc_15), true), true), _loc_13, 65535);
            }
            if (!stiff)
            {
                if (_loc_10 < jointMin)
                {
                    _loc_17 = false;
                    if (_loc_11 != null)
                    {
                    }
                    if (_loc_11.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    if (_loc_11.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_6 = _loc_11.zpp_inner;
                    if (_loc_6._validate != null)
                    {
                        _loc_6._validate();
                    }
                    _loc_14 = _loc_11.zpp_inner.x;
                    if (_loc_11.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_6 = _loc_11.zpp_inner;
                    if (_loc_6._validate != null)
                    {
                        _loc_6._validate();
                    }
                    _loc_15 = _loc_11.zpp_inner.y;
                    if (_loc_14 == _loc_14)
                    {
                    }
                    if (_loc_15 != _loc_15)
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
                            _loc_6 = new ZPP_Vec2();
                        }
                        else
                        {
                            _loc_6 = ZPP_Vec2.zpp_pool;
                            ZPP_Vec2.zpp_pool = _loc_6.next;
                            _loc_6.next = null;
                        }
                        _loc_6.weak = false;
                        _loc_6._immutable = _loc_19;
                        _loc_6.x = _loc_14;
                        _loc_6.y = _loc_15;
                        _loc_18.zpp_inner = _loc_6;
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
                        _loc_6 = _loc_18.zpp_inner;
                        if (_loc_6._immutable)
                        {
                            throw "Error: Vec2 is immutable";
                        }
                        if (_loc_6._isimmutable != null)
                        {
                            _loc_6._isimmutable();
                        }
                        if (_loc_14 == _loc_14)
                        {
                        }
                        if (_loc_15 != _loc_15)
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
                        _loc_6 = _loc_18.zpp_inner;
                        if (_loc_6._validate != null)
                        {
                            _loc_6._validate();
                        }
                        if (_loc_18.zpp_inner.x == _loc_14)
                        {
                            if (_loc_18 != null)
                            {
                            }
                            if (_loc_18.zpp_disp)
                            {
                                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                            }
                            _loc_6 = _loc_18.zpp_inner;
                            if (_loc_6._validate != null)
                            {
                                _loc_6._validate();
                            }
                        }
                        if (_loc_18.zpp_inner.y != _loc_15)
                        {
                            _loc_18.zpp_inner.x = _loc_14;
                            _loc_18.zpp_inner.y = _loc_15;
                            _loc_6 = _loc_18.zpp_inner;
                            if (_loc_6._invalidate != null)
                            {
                                _loc_6._invalidate(_loc_6);
                            }
                        }
                    }
                    _loc_18.zpp_inner.weak = _loc_17;
                    _loc_16 = _loc_18;
                }
                else if (_loc_10 > jointMax)
                {
                    _loc_17 = false;
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
                    _loc_6 = _loc_13.zpp_inner;
                    if (_loc_6._validate != null)
                    {
                        _loc_6._validate();
                    }
                    _loc_14 = _loc_13.zpp_inner.x;
                    if (_loc_13.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_6 = _loc_13.zpp_inner;
                    if (_loc_6._validate != null)
                    {
                        _loc_6._validate();
                    }
                    _loc_15 = _loc_13.zpp_inner.y;
                    if (_loc_14 == _loc_14)
                    {
                    }
                    if (_loc_15 != _loc_15)
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
                            _loc_6 = new ZPP_Vec2();
                        }
                        else
                        {
                            _loc_6 = ZPP_Vec2.zpp_pool;
                            ZPP_Vec2.zpp_pool = _loc_6.next;
                            _loc_6.next = null;
                        }
                        _loc_6.weak = false;
                        _loc_6._immutable = _loc_19;
                        _loc_6.x = _loc_14;
                        _loc_6.y = _loc_15;
                        _loc_18.zpp_inner = _loc_6;
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
                        _loc_6 = _loc_18.zpp_inner;
                        if (_loc_6._immutable)
                        {
                            throw "Error: Vec2 is immutable";
                        }
                        if (_loc_6._isimmutable != null)
                        {
                            _loc_6._isimmutable();
                        }
                        if (_loc_14 == _loc_14)
                        {
                        }
                        if (_loc_15 != _loc_15)
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
                        _loc_6 = _loc_18.zpp_inner;
                        if (_loc_6._validate != null)
                        {
                            _loc_6._validate();
                        }
                        if (_loc_18.zpp_inner.x == _loc_14)
                        {
                            if (_loc_18 != null)
                            {
                            }
                            if (_loc_18.zpp_disp)
                            {
                                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                            }
                            _loc_6 = _loc_18.zpp_inner;
                            if (_loc_6._validate != null)
                            {
                                _loc_6._validate();
                            }
                        }
                        if (_loc_18.zpp_inner.y != _loc_15)
                        {
                            _loc_18.zpp_inner.x = _loc_14;
                            _loc_18.zpp_inner.y = _loc_15;
                            _loc_6 = _loc_18.zpp_inner;
                            if (_loc_6._invalidate != null)
                            {
                                _loc_6._invalidate(_loc_6);
                            }
                        }
                    }
                    _loc_18.zpp_inner.weak = _loc_17;
                    _loc_16 = _loc_18;
                }
                else
                {
                    _loc_16 = _loc_3.add(_loc_5.mul(_loc_10, true));
                }
                param1.drawSpring(_loc_16, _loc_4, 16711935);
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
                _loc_18 = _loc_16;
                _loc_18.zpp_pool = null;
                if (ZPP_PubPool.nextVec2 != null)
                {
                    ZPP_PubPool.nextVec2.zpp_pool = _loc_18;
                }
                else
                {
                    ZPP_PubPool.poolVec2 = _loc_18;
                }
                ZPP_PubPool.nextVec2 = _loc_18;
                _loc_18.zpp_disp = true;
                _loc_12 = _loc_6;
                if (_loc_12.outer != null)
                {
                    _loc_12.outer.zpp_inner = null;
                    _loc_12.outer = null;
                }
                _loc_12._isimmutable = null;
                _loc_12._validate = null;
                _loc_12._invalidate = null;
                _loc_12.next = ZPP_Vec2.zpp_pool;
                ZPP_Vec2.zpp_pool = _loc_12;
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
            _loc_6 = _loc_3.zpp_inner;
            if (_loc_6._immutable)
            {
                throw "Error: Vec2 is immutable";
            }
            if (_loc_6._isimmutable != null)
            {
                _loc_6._isimmutable();
            }
            if (_loc_3.zpp_inner._inuse)
            {
                throw "Error: This Vec2 is not disposable";
            }
            _loc_6 = _loc_3.zpp_inner;
            _loc_3.zpp_inner.outer = null;
            _loc_3.zpp_inner = null;
            _loc_16 = _loc_3;
            _loc_16.zpp_pool = null;
            if (ZPP_PubPool.nextVec2 != null)
            {
                ZPP_PubPool.nextVec2.zpp_pool = _loc_16;
            }
            else
            {
                ZPP_PubPool.poolVec2 = _loc_16;
            }
            ZPP_PubPool.nextVec2 = _loc_16;
            _loc_16.zpp_disp = true;
            _loc_12 = _loc_6;
            if (_loc_12.outer != null)
            {
                _loc_12.outer.zpp_inner = null;
                _loc_12.outer = null;
            }
            _loc_12._isimmutable = null;
            _loc_12._validate = null;
            _loc_12._invalidate = null;
            _loc_12.next = ZPP_Vec2.zpp_pool;
            ZPP_Vec2.zpp_pool = _loc_12;
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
            if (_loc_4.zpp_inner._inuse)
            {
                throw "Error: This Vec2 is not disposable";
            }
            _loc_6 = _loc_4.zpp_inner;
            _loc_4.zpp_inner.outer = null;
            _loc_4.zpp_inner = null;
            _loc_16 = _loc_4;
            _loc_16.zpp_pool = null;
            if (ZPP_PubPool.nextVec2 != null)
            {
                ZPP_PubPool.nextVec2.zpp_pool = _loc_16;
            }
            else
            {
                ZPP_PubPool.poolVec2 = _loc_16;
            }
            ZPP_PubPool.nextVec2 = _loc_16;
            _loc_16.zpp_disp = true;
            _loc_12 = _loc_6;
            if (_loc_12.outer != null)
            {
                _loc_12.outer.zpp_inner = null;
                _loc_12.outer = null;
            }
            _loc_12._isimmutable = null;
            _loc_12._validate = null;
            _loc_12._invalidate = null;
            _loc_12.next = ZPP_Vec2.zpp_pool;
            ZPP_Vec2.zpp_pool = _loc_12;
            if (_loc_11 != null)
            {
            }
            if (_loc_11.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_6 = _loc_11.zpp_inner;
            if (_loc_6._immutable)
            {
                throw "Error: Vec2 is immutable";
            }
            if (_loc_6._isimmutable != null)
            {
                _loc_6._isimmutable();
            }
            if (_loc_11.zpp_inner._inuse)
            {
                throw "Error: This Vec2 is not disposable";
            }
            _loc_6 = _loc_11.zpp_inner;
            _loc_11.zpp_inner.outer = null;
            _loc_11.zpp_inner = null;
            _loc_16 = _loc_11;
            _loc_16.zpp_pool = null;
            if (ZPP_PubPool.nextVec2 != null)
            {
                ZPP_PubPool.nextVec2.zpp_pool = _loc_16;
            }
            else
            {
                ZPP_PubPool.poolVec2 = _loc_16;
            }
            ZPP_PubPool.nextVec2 = _loc_16;
            _loc_16.zpp_disp = true;
            _loc_12 = _loc_6;
            if (_loc_12.outer != null)
            {
                _loc_12.outer.zpp_inner = null;
                _loc_12.outer = null;
            }
            _loc_12._isimmutable = null;
            _loc_12._validate = null;
            _loc_12._invalidate = null;
            _loc_12.next = ZPP_Vec2.zpp_pool;
            ZPP_Vec2.zpp_pool = _loc_12;
            if (_loc_13 != null)
            {
            }
            if (_loc_13.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_6 = _loc_13.zpp_inner;
            if (_loc_6._immutable)
            {
                throw "Error: Vec2 is immutable";
            }
            if (_loc_6._isimmutable != null)
            {
                _loc_6._isimmutable();
            }
            if (_loc_13.zpp_inner._inuse)
            {
                throw "Error: This Vec2 is not disposable";
            }
            _loc_6 = _loc_13.zpp_inner;
            _loc_13.zpp_inner.outer = null;
            _loc_13.zpp_inner = null;
            _loc_16 = _loc_13;
            _loc_16.zpp_pool = null;
            if (ZPP_PubPool.nextVec2 != null)
            {
                ZPP_PubPool.nextVec2.zpp_pool = _loc_16;
            }
            else
            {
                ZPP_PubPool.poolVec2 = _loc_16;
            }
            ZPP_PubPool.nextVec2 = _loc_16;
            _loc_16.zpp_disp = true;
            _loc_12 = _loc_6;
            if (_loc_12.outer != null)
            {
                _loc_12.outer.zpp_inner = null;
                _loc_12.outer = null;
            }
            _loc_12._isimmutable = null;
            _loc_12._validate = null;
            _loc_12._invalidate = null;
            _loc_12.next = ZPP_Vec2.zpp_pool;
            ZPP_Vec2.zpp_pool = _loc_12;
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
            _loc_3 = outer_zn;
            if (_loc_3.zpp_inner_zn.wrap_n == null)
            {
                _loc_3.zpp_inner_zn.setup_n();
            }
            var ret:* = new LineJoint(null, null, _loc_3.zpp_inner_zn.wrap_a1, _loc_3.zpp_inner_zn.wrap_a2, _loc_3.zpp_inner_zn.wrap_n, jointMin, jointMax);
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
            pre_dt = -1;
            return;
        }// end function

        public function bodyImpulse(param1:ZPP_Body) : Vec3
        {
            var _loc_2:* = NaN;
            var _loc_3:* = NaN;
            if (stepped)
            {
                _loc_2 = scale * nrelx * jAccy - nrely * jAccx;
                _loc_3 = nrelx * jAccx + scale * nrely * jAccy;
                if (param1 == b1)
                {
                    return Vec3.get(-_loc_2, -_loc_3, scale * cx1 * _loc_3 - dot1 * _loc_2);
                }
                else
                {
                    return Vec3.get(_loc_2, _loc_3, scale * cx1 * _loc_3 - dot1 * _loc_2);
                }
            }
            else
            {
                return Vec3.get(0, 0, 0);
            }
        }// end function

        override public function applyImpulseVel() : Boolean
        {
            var _loc_7:* = NaN;
            var _loc_8:* = NaN;
            var _loc_9:* = NaN;
            var _loc_10:* = 0;
            var _loc_11:* = NaN;
            var _loc_1:* = 0;
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            _loc_3 = b2.velx - b1.velx;
            _loc_4 = b2.vely - b1.vely;
            _loc_3 = _loc_3 + (b2.kinvelx - b1.kinvelx);
            _loc_4 = _loc_4 + (b2.kinvely - b1.kinvely);
            _loc_1 = _loc_4 * nrelx - _loc_3 * nrely + (b2.angvel + b2.kinangvel) * dot2 - (b1.angvel + b1.kinangvel) * dot1;
            _loc_2 = scale * (nrelx * _loc_3 + nrely * _loc_4 - (b2.angvel + b2.kinangvel) * cx2 + (b1.angvel + b1.kinangvel) * cx1);
            _loc_3 = 0;
            _loc_4 = 0;
            _loc_3 = biasx - _loc_1;
            _loc_4 = biasy - _loc_2;
            var _loc_5:* = kMassa * _loc_3 + kMassb * _loc_4;
            _loc_4 = kMassb * _loc_3 + kMassc * _loc_4;
            _loc_3 = _loc_5;
            _loc_5 = gamma;
            _loc_3 = _loc_3 - jAccx * _loc_5;
            _loc_4 = _loc_4 - jAccy * _loc_5;
            _loc_5 = 0;
            var _loc_6:* = 0;
            _loc_5 = jAccx;
            _loc_6 = jAccy;
            _loc_7 = 1;
            jAccx = jAccx + _loc_3 * _loc_7;
            jAccy = jAccy + _loc_4 * _loc_7;
            if (jAccy > 0)
            {
                jAccy = 0;
            }
            if (breakUnderForce)
            {
                if (jAccx * jAccx + jAccy * jAccy > jMax * jMax)
                {
                    return true;
                }
            }
            else if (!stiff)
            {
                _loc_7 = jMax;
                _loc_8 = jAccx * jAccx + jAccy * jAccy;
                if (_loc_8 > _loc_7 * _loc_7)
                {
                    _loc_10 = 1597463007 - (0 >> 1);
                    _loc_11 = 0;
                    _loc_9 = 0 * (_loc_11 * (1.5 - 0.5 * _loc_8 * _loc_11 * _loc_11));
                    jAccx = jAccx * _loc_9;
                    jAccy = jAccy * _loc_9;
                }
            }
            _loc_3 = jAccx - _loc_5;
            _loc_4 = jAccy - _loc_6;
            _loc_5 = scale * nrelx * _loc_4 - nrely * _loc_3;
            _loc_6 = nrelx * _loc_3 + scale * nrely * _loc_4;
            _loc_7 = b1.imass;
            b1.velx = b1.velx - _loc_5 * _loc_7;
            b1.vely = b1.vely - _loc_6 * _loc_7;
            _loc_7 = b2.imass;
            b2.velx = b2.velx + _loc_5 * _loc_7;
            b2.vely = b2.vely + _loc_6 * _loc_7;
            b1.angvel = b1.angvel + (scale * cx1 * _loc_4 - dot1 * _loc_3) * b1.iinertia;
            b2.angvel = b2.angvel + (dot2 * _loc_3 - scale * cx2 * _loc_4) * b2.iinertia;
            return false;
        }// end function

        override public function applyImpulsePos() : Boolean
        {
            var _loc_9:* = NaN;
            var _loc_14:* = NaN;
            var _loc_15:* = NaN;
            var _loc_16:* = NaN;
            var _loc_17:* = NaN;
            var _loc_22:* = NaN;
            var _loc_25:* = NaN;
            var _loc_26:* = NaN;
            var _loc_27:* = NaN;
            var _loc_28:* = NaN;
            var _loc_1:* = 0;
            var _loc_2:* = 0;
            _loc_1 = b1.axisy * nlocalx - b1.axisx * nlocaly;
            _loc_2 = nlocalx * b1.axisx + nlocaly * b1.axisy;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            _loc_3 = b1.axisy * a1localx - b1.axisx * a1localy;
            _loc_4 = a1localx * b1.axisx + a1localy * b1.axisy;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            _loc_5 = b2.axisy * a2localx - b2.axisx * a2localy;
            _loc_6 = a2localx * b2.axisx + a2localy * b2.axisy;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_10:* = 0;
            var _loc_11:* = 0;
            _loc_7 = b2.posx + _loc_5 - b1.posx - _loc_3;
            _loc_8 = b2.posy + _loc_6 - b1.posy - _loc_4;
            _loc_10 = _loc_8 * _loc_1 - _loc_7 * _loc_2;
            _loc_11 = _loc_1 * _loc_7 + _loc_2 * _loc_8;
            if (equal)
            {
                _loc_11 = _loc_11 - jointMin;
                _loc_9 = 1;
            }
            else if (_loc_11 > jointMax)
            {
                _loc_11 = _loc_11 - jointMax;
                _loc_9 = 1;
            }
            else if (_loc_11 < jointMin)
            {
                _loc_11 = jointMin - _loc_11;
                _loc_9 = -1;
            }
            else
            {
                _loc_11 = 0;
                _loc_9 = 0;
            }
            if (breakUnderError)
            {
            }
            if (_loc_10 * _loc_10 + _loc_11 * _loc_11 > maxError * maxError)
            {
                return true;
            }
            if (_loc_10 * _loc_10 + _loc_11 * _loc_11 < Config.constraintLinearSlop * Config.constraintLinearSlop)
            {
                return false;
            }
            var _loc_12:* = 0;
            var _loc_13:* = 0;
            _loc_14 = 0.5;
            _loc_10 = _loc_10 * _loc_14;
            _loc_11 = _loc_11 * _loc_14;
            if (_loc_10 * _loc_10 + _loc_11 * _loc_11 > 6)
            {
                _loc_14 = b1.smass + b2.smass;
                if (_loc_14 > Config.epsilon)
                {
                    _loc_14 = 0.8 / _loc_14;
                    _loc_15 = _loc_14 * (_loc_2 * _loc_10 - _loc_9 * _loc_1 * _loc_11);
                    _loc_16 = _loc_14 * (_loc_1 * _loc_10 * _loc_9 - _loc_2 * _loc_10);
                    _loc_17 = b1.imass;
                    b1.posx = b1.posx - _loc_15 * _loc_17;
                    b1.posy = b1.posy - _loc_16 * _loc_17;
                    _loc_17 = b2.imass;
                    b2.posx = b2.posx + _loc_15 * _loc_17;
                    b2.posy = b2.posy + _loc_16 * _loc_17;
                    _loc_7 = b2.posx + _loc_5 - b1.posx - _loc_3;
                    _loc_8 = b2.posy + _loc_6 - b1.posy - _loc_4;
                    _loc_10 = _loc_8 * _loc_1 - _loc_7 * _loc_2;
                    _loc_11 = _loc_1 * _loc_7 + _loc_2 * _loc_8;
                    if (equal)
                    {
                        _loc_11 = _loc_11 - jointMin;
                        _loc_9 = 1;
                    }
                    else if (_loc_11 > jointMax)
                    {
                        _loc_11 = _loc_11 - jointMax;
                        _loc_9 = 1;
                    }
                    else if (_loc_11 < jointMin)
                    {
                        _loc_11 = jointMin - _loc_11;
                        _loc_9 = -1;
                    }
                    else
                    {
                        _loc_11 = 0;
                        _loc_9 = 0;
                    }
                    _loc_17 = 0.5;
                    _loc_10 = _loc_10 * _loc_17;
                    _loc_11 = _loc_11 * _loc_17;
                }
            }
            var _loc_18:* = 0;
            var _loc_19:* = 0;
            var _loc_20:* = 0;
            var _loc_21:* = 0;
            _loc_22 = 0;
            _loc_21 = _loc_7 + _loc_3;
            _loc_22 = _loc_8 + _loc_4;
            _loc_14 = _loc_1 * _loc_21 + _loc_2 * _loc_22;
            _loc_16 = _loc_22 * _loc_1 - _loc_21 * _loc_2;
            _loc_15 = _loc_1 * _loc_5 + _loc_2 * _loc_6;
            _loc_17 = _loc_6 * _loc_1 - _loc_5 * _loc_2;
            _loc_18 = b1.smass + b2.smass + _loc_14 * _loc_14 * b1.sinertia + _loc_15 * _loc_15 * b2.sinertia;
            _loc_19 = (-_loc_9) * (_loc_14 * _loc_16 * b1.sinertia + _loc_15 * _loc_17 * b2.sinertia);
            _loc_20 = _loc_9 * _loc_9 * (b1.smass + b2.smass + _loc_16 * _loc_16 * b1.sinertia + _loc_17 * _loc_17 * b2.sinertia);
            _loc_12 = -_loc_10;
            _loc_13 = -_loc_11;
            _loc_21 = _loc_18 * _loc_20 - _loc_19 * _loc_19;
            if (_loc_21 != _loc_21)
            {
                _loc_13 = 0;
                _loc_12 = _loc_13;
            }
            else if (_loc_21 == 0)
            {
                if (_loc_18 != 0)
                {
                    _loc_12 = _loc_12 / _loc_18;
                }
                else
                {
                    _loc_12 = 0;
                }
                if (_loc_20 != 0)
                {
                    _loc_13 = _loc_13 / _loc_20;
                }
                else
                {
                    _loc_13 = 0;
                }
            }
            else
            {
                _loc_21 = 1 / _loc_21;
                _loc_22 = _loc_21 * (_loc_20 * _loc_12 - _loc_19 * _loc_13);
                _loc_13 = _loc_21 * (_loc_18 * _loc_13 - _loc_19 * _loc_12);
                _loc_12 = _loc_22;
            }
            if (_loc_13 > 0)
            {
                _loc_13 = 0;
            }
            _loc_21 = _loc_9 * _loc_1 * _loc_13 - _loc_2 * _loc_12;
            _loc_22 = _loc_1 * _loc_12 + _loc_9 * _loc_2 * _loc_13;
            var _loc_23:* = b1.imass;
            b1.posx = b1.posx - _loc_21 * _loc_23;
            b1.posy = b1.posy - _loc_22 * _loc_23;
            _loc_23 = b2.imass;
            b2.posx = b2.posx + _loc_21 * _loc_23;
            b2.posy = b2.posy + _loc_22 * _loc_23;
            var _loc_24:* = b1;
            _loc_23 = (_loc_9 * _loc_16 * _loc_13 - _loc_14 * _loc_12) * b1.iinertia;
            _loc_24.rot = _loc_24.rot + _loc_23;
            if (_loc_23 * _loc_23 > 0.0001)
            {
                _loc_24.axisx = Math.sin(_loc_24.rot);
                _loc_24.axisy = Math.cos(_loc_24.rot);
            }
            else
            {
                _loc_25 = _loc_23 * _loc_23;
                _loc_26 = 1 - 0.5 * _loc_25;
                _loc_27 = 1 - _loc_25 * _loc_25 / 8;
                _loc_28 = (_loc_26 * _loc_24.axisx + _loc_23 * _loc_24.axisy) * _loc_27;
                _loc_24.axisy = (_loc_26 * _loc_24.axisy - _loc_23 * _loc_24.axisx) * _loc_27;
                _loc_24.axisx = _loc_28;
            }
            _loc_24 = b2;
            _loc_23 = (_loc_15 * _loc_12 - _loc_9 * _loc_17 * _loc_13) * b2.iinertia;
            _loc_24.rot = _loc_24.rot + _loc_23;
            if (_loc_23 * _loc_23 > 0.0001)
            {
                _loc_24.axisx = Math.sin(_loc_24.rot);
                _loc_24.axisy = Math.cos(_loc_24.rot);
            }
            else
            {
                _loc_25 = _loc_23 * _loc_23;
                _loc_26 = 1 - 0.5 * _loc_25;
                _loc_27 = 1 - _loc_25 * _loc_25 / 8;
                _loc_28 = (_loc_26 * _loc_24.axisx + _loc_23 * _loc_24.axisy) * _loc_27;
                _loc_24.axisy = (_loc_26 * _loc_24.axisy - _loc_23 * _loc_24.axisx) * _loc_27;
                _loc_24.axisx = _loc_28;
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
