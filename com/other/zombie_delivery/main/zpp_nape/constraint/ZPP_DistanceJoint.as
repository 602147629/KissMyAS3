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

    public class ZPP_DistanceJoint extends ZPP_Constraint
    {
        public var wrap_a2:Vec2;
        public var wrap_a1:Vec2;
        public var stepped:Boolean;
        public var slack:Boolean;
        public var outer_zn:DistanceJoint;
        public var ny:Number;
        public var nx:Number;
        public var kMass:Number;
        public var jointMin:Number;
        public var jointMax:Number;
        public var jMax:Number;
        public var jAcc:Number;
        public var gamma:Number;
        public var equal:Boolean;
        public var cx2:Number;
        public var cx1:Number;
        public var bias:Number;
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

        public function ZPP_DistanceJoint() : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            stepped = false;
            bias = 0;
            gamma = 0;
            jMax = 0;
            jAcc = 0;
            kMass = 0;
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
            cx2 = 0;
            cx1 = 0;
            ny = 0;
            nx = 0;
            equal = false;
            slack = false;
            jointMax = 0;
            jointMin = 0;
            outer_zn = null;
            a1localx = 0;
            a1localy = 0;
            a1relx = 0;
            a1rely = 0;
            a2localx = 0;
            a2localy = 0;
            a2relx = 0;
            a2rely = 0;
            jAcc = 0;
            jMax = 17899999999999994000000000000;
            stepped = false;
            var _loc_1:* = 0;
            cx2 = 0;
            cx1 = _loc_1;
            return;
        }// end function

        override public function warmStart() : void
        {
            var _loc_1:* = NaN;
            if (!slack)
            {
                _loc_1 = b1.imass * jAcc;
                b1.velx = b1.velx - nx * _loc_1;
                b1.vely = b1.vely - ny * _loc_1;
                _loc_1 = b2.imass * jAcc;
                b2.velx = b2.velx + nx * _loc_1;
                b2.vely = b2.vely + ny * _loc_1;
                b1.angvel = b1.angvel - cx1 * b1.iinertia * jAcc;
                b2.angvel = b2.angvel + cx2 * b2.iinertia * jAcc;
            }
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
                throw "Error: DistanceJoint cannot be simulated null bodies";
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
            var _loc_4:* = NaN;
            var _loc_5:* = 0;
            var _loc_6:* = NaN;
            var _loc_7:* = NaN;
            if (pre_dt == -1)
            {
                pre_dt = param1;
            }
            var _loc_2:* = param1 / pre_dt;
            pre_dt = param1;
            stepped = true;
            equal = jointMin == jointMax;
            a1relx = b1.axisy * a1localx - b1.axisx * a1localy;
            a1rely = a1localx * b1.axisx + a1localy * b1.axisy;
            a2relx = b2.axisy * a2localx - b2.axisx * a2localy;
            a2rely = a2localx * b2.axisx + a2localy * b2.axisy;
            nx = b2.posx + a2relx - (b1.posx + a1relx);
            ny = b2.posy + a2rely - (b1.posy + a1rely);
            _loc_4 = nx * nx + ny * ny;
            if (_loc_4 < Config.epsilon)
            {
                nx = 0;
                ny = 0;
                _loc_4 = 0;
                slack = true;
            }
            else
            {
                if (_loc_4 == 0)
                {
                    _loc_4 = 0;
                }
                else
                {
                    _loc_5 = 1597463007 - (0 >> 1);
                    _loc_6 = 0;
                    _loc_4 = 0 / (_loc_6 * (1.5 - 0.5 * _loc_4 * _loc_6 * _loc_6));
                }
                _loc_6 = 1 / _loc_4;
                nx = nx * _loc_6;
                ny = ny * _loc_6;
                if (equal)
                {
                    _loc_4 = _loc_4 - jointMax;
                    slack = false;
                }
                else if (_loc_4 < jointMin)
                {
                    _loc_4 = jointMin - _loc_4;
                    nx = -nx;
                    ny = -ny;
                    slack = false;
                }
                else if (_loc_4 > jointMax)
                {
                    _loc_4 = _loc_4 - jointMax;
                    slack = false;
                }
                else
                {
                    nx = 0;
                    ny = 0;
                    _loc_4 = 0;
                    slack = true;
                }
            }
            var _loc_3:* = _loc_4;
            if (!slack)
            {
                cx1 = ny * a1relx - nx * a1rely;
                cx2 = ny * a2relx - nx * a2rely;
                kMass = b1.smass + b2.smass + cx1 * cx1 * b1.sinertia + cx2 * cx2 * b2.sinertia;
                if (kMass != 0)
                {
                    kMass = 1 / kMass;
                }
                else
                {
                    jAcc = 0;
                }
                if (!stiff)
                {
                    if (breakUnderError)
                    {
                    }
                    if (_loc_3 * _loc_3 > maxError * maxError)
                    {
                        return true;
                    }
                    _loc_6 = 2 * Math.PI * frequency;
                    gamma = 1 / (param1 * _loc_6 * (2 * damping + _loc_6 * param1));
                    _loc_7 = 1 / (1 + gamma);
                    _loc_4 = param1 * _loc_6 * _loc_6 * gamma;
                    gamma = gamma * _loc_7;
                    kMass = kMass * _loc_7;
                    bias = (-_loc_3) * _loc_4;
                    if (bias < -maxError)
                    {
                        bias = -maxError;
                    }
                    else if (bias > maxError)
                    {
                        bias = maxError;
                    }
                }
                else
                {
                    bias = 0;
                    gamma = 0;
                }
                jAcc = jAcc * _loc_2;
                jMax = maxForce * param1;
            }
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

        public function is_slack() : Boolean
        {
            var _loc_1:* = false;
            var _loc_5:* = 0;
            var _loc_6:* = NaN;
            a1relx = b1.axisy * a1localx - b1.axisx * a1localy;
            a1rely = a1localx * b1.axisx + a1localy * b1.axisy;
            a2relx = b2.axisy * a2localx - b2.axisx * a2localy;
            a2rely = a2localx * b2.axisx + a2localy * b2.axisy;
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            _loc_2 = b2.posx + a2relx - (b1.posx + a1relx);
            _loc_3 = b2.posy + a2rely - (b1.posy + a1rely);
            var _loc_4:* = _loc_2 * _loc_2 + _loc_3 * _loc_3;
            if (_loc_4 < Config.epsilon)
            {
                _loc_2 = 0;
                _loc_3 = 0;
                _loc_4 = 0;
                _loc_1 = true;
            }
            else
            {
                if (_loc_4 == 0)
                {
                    _loc_4 = 0;
                }
                else
                {
                    _loc_5 = 1597463007 - (0 >> 1);
                    _loc_6 = 0;
                    _loc_4 = 0 / (_loc_6 * (1.5 - 0.5 * _loc_4 * _loc_6 * _loc_6));
                }
                _loc_6 = 1 / _loc_4;
                _loc_2 = _loc_2 * _loc_6;
                _loc_3 = _loc_3 * _loc_6;
                if (equal)
                {
                    _loc_4 = _loc_4 - jointMax;
                    _loc_1 = false;
                }
                else if (_loc_4 < jointMin)
                {
                    _loc_4 = jointMin - _loc_4;
                    _loc_2 = -_loc_2;
                    _loc_3 = -_loc_3;
                    _loc_1 = false;
                }
                else if (_loc_4 > jointMax)
                {
                    _loc_4 = _loc_4 - jointMax;
                    _loc_1 = false;
                }
                else
                {
                    _loc_2 = 0;
                    _loc_3 = 0;
                    _loc_4 = 0;
                    _loc_1 = true;
                }
            }
            return _loc_1;
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
            var _loc_7:* = null as ZPP_Vec2;
            var _loc_8:* = null as Vec2;
            var _loc_9:* = null as Vec2;
            var _loc_10:* = null as Vec2;
            var _loc_11:* = null as Vec2;
            var _loc_12:* = null as Vec2;
            var _loc_13:* = null as Vec2;
            var _loc_14:* = null as ZPP_Vec2;
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
            var _loc_5:* = _loc_4.sub(_loc_3);
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
            var _loc_6:* = Math.sqrt(_loc_5.zpp_inner.x * _loc_5.zpp_inner.x + _loc_5.zpp_inner.y * _loc_5.zpp_inner.y);
            if (_loc_6 != 0)
            {
                _loc_5.muleq(1 / _loc_6);
                _loc_8 = _loc_3.add(_loc_4).muleq(0.5);
                _loc_9 = _loc_8.sub(_loc_5.mul(jointMin * 0.5, true));
                _loc_10 = _loc_8.add(_loc_5.mul(jointMin * 0.5, true));
                _loc_11 = _loc_8.sub(_loc_5.mul(jointMax * 0.5, true));
                _loc_12 = _loc_8.add(_loc_5.mul(jointMax * 0.5, true));
                param1.drawLine(_loc_9, _loc_10, 16776960);
                param1.drawLine(_loc_11, _loc_9, 65535);
                param1.drawLine(_loc_12, _loc_10, 65535);
                if (!stiff)
                {
                    if (_loc_6 > jointMax)
                    {
                        param1.drawSpring(_loc_11, _loc_3, 65535);
                        param1.drawSpring(_loc_12, _loc_4, 65535);
                    }
                    else if (_loc_6 < jointMin)
                    {
                        param1.drawSpring(_loc_9, _loc_3, 16776960);
                        param1.drawSpring(_loc_10, _loc_4, 16776960);
                    }
                }
                if (_loc_8 != null)
                {
                }
                if (_loc_8.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_7 = _loc_8.zpp_inner;
                if (_loc_7._immutable)
                {
                    throw "Error: Vec2 is immutable";
                }
                if (_loc_7._isimmutable != null)
                {
                    _loc_7._isimmutable();
                }
                if (_loc_8.zpp_inner._inuse)
                {
                    throw "Error: This Vec2 is not disposable";
                }
                _loc_7 = _loc_8.zpp_inner;
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
                if (_loc_9 != null)
                {
                }
                if (_loc_9.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_7 = _loc_9.zpp_inner;
                if (_loc_7._immutable)
                {
                    throw "Error: Vec2 is immutable";
                }
                if (_loc_7._isimmutable != null)
                {
                    _loc_7._isimmutable();
                }
                if (_loc_9.zpp_inner._inuse)
                {
                    throw "Error: This Vec2 is not disposable";
                }
                _loc_7 = _loc_9.zpp_inner;
                _loc_9.zpp_inner.outer = null;
                _loc_9.zpp_inner = null;
                _loc_13 = _loc_9;
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
                if (_loc_10 != null)
                {
                }
                if (_loc_10.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_7 = _loc_10.zpp_inner;
                if (_loc_7._immutable)
                {
                    throw "Error: Vec2 is immutable";
                }
                if (_loc_7._isimmutable != null)
                {
                    _loc_7._isimmutable();
                }
                if (_loc_10.zpp_inner._inuse)
                {
                    throw "Error: This Vec2 is not disposable";
                }
                _loc_7 = _loc_10.zpp_inner;
                _loc_10.zpp_inner.outer = null;
                _loc_10.zpp_inner = null;
                _loc_13 = _loc_10;
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
                if (_loc_11 != null)
                {
                }
                if (_loc_11.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_7 = _loc_11.zpp_inner;
                if (_loc_7._immutable)
                {
                    throw "Error: Vec2 is immutable";
                }
                if (_loc_7._isimmutable != null)
                {
                    _loc_7._isimmutable();
                }
                if (_loc_11.zpp_inner._inuse)
                {
                    throw "Error: This Vec2 is not disposable";
                }
                _loc_7 = _loc_11.zpp_inner;
                _loc_11.zpp_inner.outer = null;
                _loc_11.zpp_inner = null;
                _loc_13 = _loc_11;
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
                if (_loc_12 != null)
                {
                }
                if (_loc_12.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_7 = _loc_12.zpp_inner;
                if (_loc_7._immutable)
                {
                    throw "Error: Vec2 is immutable";
                }
                if (_loc_7._isimmutable != null)
                {
                    _loc_7._isimmutable();
                }
                if (_loc_12.zpp_inner._inuse)
                {
                    throw "Error: This Vec2 is not disposable";
                }
                _loc_7 = _loc_12.zpp_inner;
                _loc_12.zpp_inner.outer = null;
                _loc_12.zpp_inner = null;
                _loc_13 = _loc_12;
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
            _loc_8 = _loc_3;
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
            _loc_8 = _loc_4;
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
            var ret:* = new DistanceJoint(null, null, _loc_3.zpp_inner_zn.wrap_a1, _loc_3.zpp_inner_zn.wrap_a2, jointMin, jointMax);
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
            jAcc = 0;
            pre_dt = -1;
            return;
        }// end function

        public function bodyImpulse(param1:ZPP_Body) : Vec3
        {
            if (stepped)
            {
                if (param1 == b1)
                {
                    return Vec3.get((-jAcc) * nx, (-jAcc) * ny, (-cx1) * jAcc);
                }
                else
                {
                    return Vec3.get(jAcc * nx, jAcc * ny, cx2 * jAcc);
                }
            }
            else
            {
                return Vec3.get(0, 0, 0);
            }
        }// end function

        override public function applyImpulseVel() : Boolean
        {
            if (slack)
            {
                return false;
            }
            var _loc_1:* = nx * (b2.velx + b2.kinvelx - b1.velx - b1.kinvelx) + ny * (b2.vely + b2.kinvely - b1.vely - b1.kinvely) + (b2.angvel + b2.kinangvel) * cx2 - (b1.angvel + b1.kinangvel) * cx1;
            var _loc_2:* = kMass * (bias - _loc_1) - jAcc * gamma;
            var _loc_3:* = jAcc;
            jAcc = jAcc + _loc_2;
            if (!equal)
            {
            }
            if (jAcc > 0)
            {
                jAcc = 0;
            }
            if (breakUnderForce)
            {
            }
            if (jAcc < -jMax)
            {
                return true;
            }
            if (!stiff)
            {
                if (jAcc < -jMax)
                {
                    jAcc = -jMax;
                }
            }
            _loc_2 = jAcc - _loc_3;
            _loc_3 = b1.imass * _loc_2;
            b1.velx = b1.velx - nx * _loc_3;
            b1.vely = b1.vely - ny * _loc_3;
            _loc_3 = b2.imass * _loc_2;
            b2.velx = b2.velx + nx * _loc_3;
            b2.vely = b2.vely + ny * _loc_3;
            b1.angvel = b1.angvel - cx1 * b1.iinertia * _loc_2;
            b2.angvel = b2.angvel + cx2 * b2.iinertia * _loc_2;
            return false;
        }// end function

        override public function applyImpulsePos() : Boolean
        {
            var _loc_2:* = NaN;
            var _loc_7:* = false;
            var _loc_10:* = NaN;
            var _loc_11:* = 0;
            var _loc_12:* = NaN;
            var _loc_13:* = NaN;
            var _loc_14:* = NaN;
            var _loc_15:* = null as ZPP_Body;
            var _loc_16:* = NaN;
            var _loc_17:* = NaN;
            var _loc_18:* = NaN;
            var _loc_19:* = NaN;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            _loc_3 = b1.axisy * a1localx - b1.axisx * a1localy;
            _loc_4 = a1localx * b1.axisx + a1localy * b1.axisy;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            _loc_5 = b2.axisy * a2localx - b2.axisx * a2localy;
            _loc_6 = a2localx * b2.axisx + a2localy * b2.axisy;
            var _loc_8:* = 0;
            var _loc_9:* = 0;
            _loc_8 = b2.posx + _loc_5 - (b1.posx + _loc_3);
            _loc_9 = b2.posy + _loc_6 - (b1.posy + _loc_4);
            _loc_10 = _loc_8 * _loc_8 + _loc_9 * _loc_9;
            if (_loc_10 < Config.epsilon)
            {
                _loc_8 = 0;
                _loc_9 = 0;
                _loc_10 = 0;
                _loc_7 = true;
            }
            else
            {
                if (_loc_10 == 0)
                {
                    _loc_10 = 0;
                }
                else
                {
                    _loc_11 = 1597463007 - (0 >> 1);
                    _loc_12 = 0;
                    _loc_10 = 0 / (_loc_12 * (1.5 - 0.5 * _loc_10 * _loc_12 * _loc_12));
                }
                _loc_12 = 1 / _loc_10;
                _loc_8 = _loc_8 * _loc_12;
                _loc_9 = _loc_9 * _loc_12;
                if (equal)
                {
                    _loc_10 = _loc_10 - jointMax;
                    _loc_7 = false;
                }
                else if (_loc_10 < jointMin)
                {
                    _loc_10 = jointMin - _loc_10;
                    _loc_8 = -_loc_8;
                    _loc_9 = -_loc_9;
                    _loc_7 = false;
                }
                else if (_loc_10 > jointMax)
                {
                    _loc_10 = _loc_10 - jointMax;
                    _loc_7 = false;
                }
                else
                {
                    _loc_8 = 0;
                    _loc_9 = 0;
                    _loc_10 = 0;
                    _loc_7 = true;
                }
            }
            var _loc_1:* = _loc_10;
            if (!_loc_7)
            {
                if (breakUnderError)
                {
                }
                if (_loc_1 * _loc_1 > maxError * maxError)
                {
                    return true;
                }
                if (_loc_1 * _loc_1 < Config.constraintLinearSlop * Config.constraintLinearSlop)
                {
                    return false;
                }
                _loc_1 = _loc_1 * 0.5;
                if (_loc_1 * _loc_1 > 6)
                {
                    _loc_10 = b1.smass + b2.smass;
                    if (_loc_10 > Config.epsilon)
                    {
                        _loc_10 = 0.75 / _loc_10;
                        _loc_2 = (-_loc_1) * _loc_10;
                        if (!equal)
                        {
                        }
                        if (_loc_2 < 0)
                        {
                            _loc_12 = _loc_2 * b1.imass;
                            b1.posx = b1.posx - _loc_8 * _loc_12;
                            b1.posy = b1.posy - _loc_9 * _loc_12;
                            _loc_12 = _loc_2 * b2.imass;
                            b2.posx = b2.posx + _loc_8 * _loc_12;
                            b2.posy = b2.posy + _loc_9 * _loc_12;
                            _loc_8 = b2.posx + _loc_5 - (b1.posx + _loc_3);
                            _loc_9 = b2.posy + _loc_6 - (b1.posy + _loc_4);
                            _loc_12 = _loc_8 * _loc_8 + _loc_9 * _loc_9;
                            if (_loc_12 < Config.epsilon)
                            {
                                _loc_8 = 0;
                                _loc_9 = 0;
                                _loc_12 = 0;
                                _loc_7 = true;
                            }
                            else
                            {
                                if (_loc_12 == 0)
                                {
                                    _loc_12 = 0;
                                }
                                else
                                {
                                    _loc_11 = 1597463007 - (0 >> 1);
                                    _loc_13 = 0;
                                    _loc_12 = 0 / (_loc_13 * (1.5 - 0.5 * _loc_12 * _loc_13 * _loc_13));
                                }
                                _loc_13 = 1 / _loc_12;
                                _loc_8 = _loc_8 * _loc_13;
                                _loc_9 = _loc_9 * _loc_13;
                                if (equal)
                                {
                                    _loc_12 = _loc_12 - jointMax;
                                    _loc_7 = false;
                                }
                                else if (_loc_12 < jointMin)
                                {
                                    _loc_12 = jointMin - _loc_12;
                                    _loc_8 = -_loc_8;
                                    _loc_9 = -_loc_9;
                                    _loc_7 = false;
                                }
                                else if (_loc_12 > jointMax)
                                {
                                    _loc_12 = _loc_12 - jointMax;
                                    _loc_7 = false;
                                }
                                else
                                {
                                    _loc_8 = 0;
                                    _loc_9 = 0;
                                    _loc_12 = 0;
                                    _loc_7 = true;
                                }
                            }
                            _loc_1 = _loc_12;
                            _loc_1 = _loc_1 * 0.5;
                        }
                    }
                }
                _loc_10 = _loc_9 * _loc_3 - _loc_8 * _loc_4;
                _loc_12 = _loc_9 * _loc_5 - _loc_8 * _loc_6;
                _loc_13 = b1.smass + b2.smass + _loc_10 * _loc_10 * b1.sinertia + _loc_12 * _loc_12 * b2.sinertia;
                if (_loc_13 != 0)
                {
                    _loc_13 = 1 / _loc_13;
                }
                _loc_2 = (-_loc_1) * _loc_13;
                if (!equal)
                {
                }
                if (_loc_2 < 0)
                {
                    _loc_14 = b1.imass * _loc_2;
                    b1.posx = b1.posx - _loc_8 * _loc_14;
                    b1.posy = b1.posy - _loc_9 * _loc_14;
                    _loc_14 = b2.imass * _loc_2;
                    b2.posx = b2.posx + _loc_8 * _loc_14;
                    b2.posy = b2.posy + _loc_9 * _loc_14;
                    _loc_15 = b1;
                    _loc_14 = (-_loc_10) * b1.iinertia * _loc_2;
                    _loc_15.rot = _loc_15.rot + _loc_14;
                    if (_loc_14 * _loc_14 > 0.0001)
                    {
                        _loc_15.axisx = Math.sin(_loc_15.rot);
                        _loc_15.axisy = Math.cos(_loc_15.rot);
                    }
                    else
                    {
                        _loc_16 = _loc_14 * _loc_14;
                        _loc_17 = 1 - 0.5 * _loc_16;
                        _loc_18 = 1 - _loc_16 * _loc_16 / 8;
                        _loc_19 = (_loc_17 * _loc_15.axisx + _loc_14 * _loc_15.axisy) * _loc_18;
                        _loc_15.axisy = (_loc_17 * _loc_15.axisy - _loc_14 * _loc_15.axisx) * _loc_18;
                        _loc_15.axisx = _loc_19;
                    }
                    _loc_15 = b2;
                    _loc_14 = _loc_12 * b2.iinertia * _loc_2;
                    _loc_15.rot = _loc_15.rot + _loc_14;
                    if (_loc_14 * _loc_14 > 0.0001)
                    {
                        _loc_15.axisx = Math.sin(_loc_15.rot);
                        _loc_15.axisy = Math.cos(_loc_15.rot);
                    }
                    else
                    {
                        _loc_16 = _loc_14 * _loc_14;
                        _loc_17 = 1 - 0.5 * _loc_16;
                        _loc_18 = 1 - _loc_16 * _loc_16 / 8;
                        _loc_19 = (_loc_17 * _loc_15.axisx + _loc_14 * _loc_15.axisy) * _loc_18;
                        _loc_15.axisy = (_loc_17 * _loc_15.axisy - _loc_14 * _loc_15.axisx) * _loc_18;
                        _loc_15.axisx = _loc_19;
                    }
                }
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
