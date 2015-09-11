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

    public class ZPP_PulleyJoint extends ZPP_Constraint
    {
        public var wrap_a4:Vec2;
        public var wrap_a3:Vec2;
        public var wrap_a2:Vec2;
        public var wrap_a1:Vec2;
        public var stepped:Boolean;
        public var slack:Boolean;
        public var ratio:Number;
        public var outer_zn:PulleyJoint;
        public var n34y:Number;
        public var n34x:Number;
        public var n12y:Number;
        public var n12x:Number;
        public var kMass:Number;
        public var jointMin:Number;
        public var jointMax:Number;
        public var jMax:Number;
        public var jAcc:Number;
        public var gamma:Number;
        public var equal:Boolean;
        public var cx4:Number;
        public var cx3:Number;
        public var cx2:Number;
        public var cx1:Number;
        public var bias:Number;
        public var b4:ZPP_Body;
        public var b3:ZPP_Body;
        public var b2:ZPP_Body;
        public var b1:ZPP_Body;
        public var a4rely:Number;
        public var a4relx:Number;
        public var a4localy:Number;
        public var a4localx:Number;
        public var a3rely:Number;
        public var a3relx:Number;
        public var a3localy:Number;
        public var a3localx:Number;
        public var a2rely:Number;
        public var a2relx:Number;
        public var a2localy:Number;
        public var a2localx:Number;
        public var a1rely:Number;
        public var a1relx:Number;
        public var a1localy:Number;
        public var a1localx:Number;

        public function ZPP_PulleyJoint() : void
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
            wrap_a4 = null;
            a4rely = 0;
            a4relx = 0;
            a4localy = 0;
            a4localx = 0;
            b4 = null;
            wrap_a3 = null;
            a3rely = 0;
            a3relx = 0;
            a3localy = 0;
            a3localx = 0;
            b3 = null;
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
            cx4 = 0;
            cx3 = 0;
            cx2 = 0;
            cx1 = 0;
            n34y = 0;
            n34x = 0;
            n12y = 0;
            n12x = 0;
            equal = false;
            slack = false;
            jointMax = 0;
            jointMin = 0;
            ratio = 1;
            outer_zn = null;
            a1localx = 0;
            a1localy = 0;
            a1relx = 0;
            a1rely = 0;
            a2localx = 0;
            a2localy = 0;
            a2relx = 0;
            a2rely = 0;
            a3localx = 0;
            a3localy = 0;
            a3relx = 0;
            a3rely = 0;
            a4localx = 0;
            a4localy = 0;
            a4relx = 0;
            a4rely = 0;
            n12x = 1;
            n12y = 0;
            n34x = 1;
            n34y = 0;
            jAcc = 0;
            jMax = 17899999999999994000000000000;
            stepped = false;
            var _loc_1:* = 0;
            cx4 = 0;
            _loc_1 = _loc_1;
            cx3 = _loc_1;
            _loc_1 = _loc_1;
            cx2 = _loc_1;
            cx1 = _loc_1;
            return;
        }// end function

        override public function warmStart() : void
        {
            var _loc_1:* = NaN;
            if (!slack)
            {
                _loc_1 = b1.imass * jAcc;
                b1.velx = b1.velx - n12x * _loc_1;
                b1.vely = b1.vely - n12y * _loc_1;
                _loc_1 = b2.imass * jAcc;
                b2.velx = b2.velx + n12x * _loc_1;
                b2.vely = b2.vely + n12y * _loc_1;
                _loc_1 = b3.imass * jAcc;
                b3.velx = b3.velx - n34x * _loc_1;
                b3.vely = b3.vely - n34y * _loc_1;
                _loc_1 = b4.imass * jAcc;
                b4.velx = b4.velx + n34x * _loc_1;
                b4.vely = b4.vely + n34y * _loc_1;
                b1.angvel = b1.angvel - cx1 * b1.iinertia * jAcc;
                b2.angvel = b2.angvel + cx2 * b2.iinertia * jAcc;
                b3.angvel = b3.angvel - cx3 * b3.iinertia * jAcc;
                b4.angvel = b4.angvel + cx4 * b4.iinertia * jAcc;
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
            if (b3 != null)
            {
            }
            if (b3.type == ZPP_Flags.id_BodyType_DYNAMIC)
            {
                b3.wake();
            }
            if (b4 != null)
            {
            }
            if (b4.type == ZPP_Flags.id_BodyType_DYNAMIC)
            {
                b4.wake();
            }
            return;
        }// end function

        public function validate_a4() : void
        {
            wrap_a4.zpp_inner.x = a4localx;
            wrap_a4.zpp_inner.y = a4localy;
            return;
        }// end function

        public function validate_a3() : void
        {
            wrap_a3.zpp_inner.x = a3localx;
            wrap_a3.zpp_inner.y = a3localy;
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
            if (b2 != null)
            {
            }
            if (b3 != null)
            {
            }
            if (b4 == null)
            {
                throw "Error: PulleyJoint cannot be simulated with null bodies";
            }
            if (b1 != b2)
            {
            }
            if (b3 == b4)
            {
                throw "Error: PulleyJoint cannot have body1==body2 or body3==body4";
            }
            if (b1.space == space)
            {
            }
            if (b2.space == space)
            {
            }
            if (b3.space == space)
            {
            }
            if (b4.space != space)
            {
                throw "Error: Constraints must have each body within the same space to which the constraint has been assigned";
            }
            if (jointMin > jointMax)
            {
                throw "Error: PulleyJoint must have jointMin <= jointMax";
            }
            if (b1.type != ZPP_Flags.id_BodyType_DYNAMIC)
            {
            }
            if (b2.type != ZPP_Flags.id_BodyType_DYNAMIC)
            {
                throw "Error: PulleyJoint cannot have both bodies in a linked pair non-dynamic";
            }
            if (b3.type != ZPP_Flags.id_BodyType_DYNAMIC)
            {
            }
            if (b4.type != ZPP_Flags.id_BodyType_DYNAMIC)
            {
                throw "Error: PulleyJoint cannot have both bodies in a linked pair non-dynamic";
            }
            return;
        }// end function

        public function setup_a4() : void
        {
            var _loc_4:* = null as Vec2;
            var _loc_5:* = false;
            var _loc_6:* = null as ZPP_Vec2;
            var _loc_1:* = a4localx;
            var _loc_2:* = a4localy;
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
            wrap_a4 = _loc_4;
            wrap_a4.zpp_inner._inuse = true;
            wrap_a4.zpp_inner._validate = validate_a4;
            wrap_a4.zpp_inner._invalidate = invalidate_a4;
            return;
        }// end function

        public function setup_a3() : void
        {
            var _loc_4:* = null as Vec2;
            var _loc_5:* = false;
            var _loc_6:* = null as ZPP_Vec2;
            var _loc_1:* = a3localx;
            var _loc_2:* = a3localy;
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
            wrap_a3 = _loc_4;
            wrap_a3.zpp_inner._inuse = true;
            wrap_a3.zpp_inner._validate = validate_a3;
            wrap_a3.zpp_inner._invalidate = invalidate_a3;
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
            var _loc_5:* = NaN;
            var _loc_6:* = NaN;
            var _loc_8:* = NaN;
            var _loc_9:* = NaN;
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
            stepped = true;
            equal = jointMin == jointMax;
            a1relx = b1.axisy * a1localx - b1.axisx * a1localy;
            a1rely = a1localx * b1.axisx + a1localy * b1.axisy;
            a2relx = b2.axisy * a2localx - b2.axisx * a2localy;
            a2rely = a2localx * b2.axisx + a2localy * b2.axisy;
            a3relx = b3.axisy * a3localx - b3.axisx * a3localy;
            a3rely = a3localx * b3.axisx + a3localy * b3.axisy;
            a4relx = b4.axisy * a4localx - b4.axisx * a4localy;
            a4rely = a4localx * b4.axisx + a4localy * b4.axisy;
            _loc_4 = 0;
            _loc_5 = 0;
            _loc_6 = 0;
            var _loc_7:* = 0;
            _loc_4 = b2.posx + a2relx - (b1.posx + a1relx);
            _loc_5 = b2.posy + a2rely - (b1.posy + a1rely);
            _loc_6 = b4.posx + a4relx - (b3.posx + a3relx);
            _loc_7 = b4.posy + a4rely - (b3.posy + a3rely);
            _loc_9 = _loc_4 * _loc_4 + _loc_5 * _loc_5;
            if (_loc_9 == 0)
            {
                _loc_8 = 0;
            }
            else
            {
                _loc_10 = 1597463007 - (0 >> 1);
                _loc_11 = 0;
                _loc_8 = 0 / (_loc_11 * (1.5 - 0.5 * _loc_9 * _loc_11 * _loc_11));
            }
            _loc_11 = _loc_6 * _loc_6 + _loc_7 * _loc_7;
            if (_loc_11 == 0)
            {
                _loc_9 = 0;
            }
            else
            {
                _loc_10 = 1597463007 - (0 >> 1);
                _loc_12 = 0;
                _loc_9 = 0 / (_loc_12 * (1.5 - 0.5 * _loc_11 * _loc_12 * _loc_12));
            }
            if (_loc_8 != 0)
            {
                _loc_11 = 1 / _loc_8;
                n12x = _loc_4 * _loc_11;
                n12y = _loc_5 * _loc_11;
            }
            if (_loc_9 != 0)
            {
                _loc_11 = 1 / _loc_9;
                n34x = _loc_6 * _loc_11;
                n34y = _loc_7 * _loc_11;
                _loc_11 = ratio;
                n34x = n34x * _loc_11;
                n34y = n34y * _loc_11;
            }
            else
            {
                _loc_12 = n34x * n34x + n34y * n34y;
                _loc_11 = 0 / (_loc_12 == 0 ? (_loc_10) : (_loc_10 = 1597463007 - (0 >> 1), _loc_13 = 0, 0 / (_loc_13 * (1.5 - 0.5 * _loc_12 * _loc_13 * _loc_13))));
                n34x = n34x * _loc_11;
                n34y = n34y * _loc_11;
            }
            _loc_11 = _loc_8 + ratio * _loc_9;
            if (equal)
            {
                _loc_11 = _loc_11 - jointMax;
                slack = false;
            }
            else if (_loc_11 < jointMin)
            {
                _loc_11 = jointMin - _loc_11;
                n12x = -n12x;
                n12y = -n12y;
                n34x = -n34x;
                n34y = -n34y;
                slack = false;
            }
            else if (_loc_11 > jointMax)
            {
                _loc_11 = _loc_11 - jointMax;
                slack = false;
            }
            else
            {
                n12x = 0;
                n12y = 0;
                n34x = 0;
                n34y = 0;
                _loc_11 = 0;
                slack = true;
            }
            var _loc_3:* = _loc_11;
            if (!slack)
            {
                cx1 = n12y * a1relx - n12x * a1rely;
                cx2 = n12y * a2relx - n12x * a2rely;
                cx3 = n34y * a3relx - n34x * a3rely;
                cx4 = n34y * a4relx - n34x * a4rely;
                _loc_4 = ratio * ratio;
                _loc_5 = b1.smass + b2.smass + _loc_4 * (b3.smass + b4.smass) + b1.sinertia * cx1 * cx1 + b2.sinertia * cx2 * cx2 + b3.sinertia * cx3 * cx3 + b4.sinertia * cx4 * cx4;
                if (b1 == b4)
                {
                    _loc_5 = _loc_5 - 2 * ((n12x * n34x + n12y * n34y) * b1.smass + cx1 * cx4 * b1.sinertia);
                }
                if (b1 == b3)
                {
                    _loc_5 = _loc_5 + 2 * ((n12x * n34x + n12y * n34y) * b1.smass + cx1 * cx3 * b1.sinertia);
                }
                if (b2 == b3)
                {
                    _loc_5 = _loc_5 - 2 * ((n12x * n34x + n12y * n34y) * b2.smass + cx2 * cx3 * b2.sinertia);
                }
                if (b2 == b4)
                {
                    _loc_5 = _loc_5 + 2 * ((n12x * n34x + n12y * n34y) * b2.smass + cx2 * cx4 * b2.sinertia);
                }
                kMass = _loc_5;
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
                    _loc_5 = 2 * Math.PI * frequency;
                    gamma = 1 / (param1 * _loc_5 * (2 * damping + _loc_5 * param1));
                    _loc_6 = 1 / (1 + gamma);
                    _loc_4 = param1 * _loc_5 * _loc_5 * gamma;
                    gamma = gamma * _loc_6;
                    kMass = kMass * _loc_6;
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
                if (b2.id != param2)
                {
                }
                if (b3.id != param2)
                {
                }
            }
            if (b4.id != param2)
            {
                if (b2.id == param1)
                {
                    if (b3.id != param2)
                    {
                    }
                    if (b4.id != param2)
                    {
                    }
                }
            }
            if (b1.id != param2)
            {
                if (b3.id == param1)
                {
                    if (b4.id != param2)
                    {
                    }
                    if (b1.id != param2)
                    {
                    }
                }
            }
            if (b2.id != param2)
            {
                if (b4.id == param1)
                {
                    if (b1.id != param2)
                    {
                    }
                    if (b2.id != param2)
                    {
                    }
                }
            }
            return b3.id == param2;
        }// end function

        public function is_slack() : Boolean
        {
            var _loc_1:* = false;
            var _loc_10:* = NaN;
            var _loc_11:* = NaN;
            var _loc_12:* = 0;
            var _loc_13:* = NaN;
            var _loc_14:* = NaN;
            var _loc_15:* = NaN;
            a1relx = b1.axisy * a1localx - b1.axisx * a1localy;
            a1rely = a1localx * b1.axisx + a1localy * b1.axisy;
            a2relx = b2.axisy * a2localx - b2.axisx * a2localy;
            a2rely = a2localx * b2.axisx + a2localy * b2.axisy;
            a3relx = b3.axisy * a3localx - b3.axisx * a3localy;
            a3rely = a3localx * b3.axisx + a3localy * b3.axisy;
            a4relx = b4.axisy * a4localx - b4.axisx * a4localy;
            a4rely = a4localx * b4.axisx + a4localy * b4.axisy;
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_9:* = 0;
            _loc_6 = b2.posx + a2relx - (b1.posx + a1relx);
            _loc_7 = b2.posy + a2rely - (b1.posy + a1rely);
            _loc_8 = b4.posx + a4relx - (b3.posx + a3relx);
            _loc_9 = b4.posy + a4rely - (b3.posy + a3rely);
            _loc_11 = _loc_6 * _loc_6 + _loc_7 * _loc_7;
            if (_loc_11 == 0)
            {
                _loc_10 = 0;
            }
            else
            {
                _loc_12 = 1597463007 - (0 >> 1);
                _loc_13 = 0;
                _loc_10 = 0 / (_loc_13 * (1.5 - 0.5 * _loc_11 * _loc_13 * _loc_13));
            }
            _loc_13 = _loc_8 * _loc_8 + _loc_9 * _loc_9;
            if (_loc_13 == 0)
            {
                _loc_11 = 0;
            }
            else
            {
                _loc_12 = 1597463007 - (0 >> 1);
                _loc_14 = 0;
                _loc_11 = 0 / (_loc_14 * (1.5 - 0.5 * _loc_13 * _loc_14 * _loc_14));
            }
            if (_loc_10 != 0)
            {
                _loc_13 = 1 / _loc_10;
                _loc_2 = _loc_6 * _loc_13;
                _loc_3 = _loc_7 * _loc_13;
            }
            if (_loc_11 != 0)
            {
                _loc_13 = 1 / _loc_11;
                _loc_4 = _loc_8 * _loc_13;
                _loc_5 = _loc_9 * _loc_13;
                _loc_13 = ratio;
                _loc_4 = _loc_4 * _loc_13;
                _loc_5 = _loc_5 * _loc_13;
            }
            else
            {
                _loc_14 = _loc_4 * _loc_4 + _loc_5 * _loc_5;
                _loc_13 = 0 / (_loc_14 == 0 ? (_loc_12) : (_loc_12 = 1597463007 - (0 >> 1), _loc_15 = 0, 0 / (_loc_15 * (1.5 - 0.5 * _loc_14 * _loc_15 * _loc_15))));
                _loc_4 = _loc_4 * _loc_13;
                _loc_5 = _loc_5 * _loc_13;
            }
            _loc_13 = _loc_10 + ratio * _loc_11;
            if (equal)
            {
                _loc_13 = _loc_13 - jointMax;
                _loc_1 = false;
            }
            else if (_loc_13 < jointMin)
            {
                _loc_13 = jointMin - _loc_13;
                _loc_2 = -_loc_2;
                _loc_3 = -_loc_3;
                _loc_4 = -_loc_4;
                _loc_5 = -_loc_5;
                _loc_1 = false;
            }
            else if (_loc_13 > jointMax)
            {
                _loc_13 = _loc_13 - jointMax;
                _loc_1 = false;
            }
            else
            {
                _loc_2 = 0;
                _loc_3 = 0;
                _loc_4 = 0;
                _loc_5 = 0;
                _loc_13 = 0;
                _loc_1 = true;
            }
            return _loc_1;
        }// end function

        public function invalidate_a4(param1:ZPP_Vec2) : void
        {
            immutable_midstep("Constraint::" + "a4");
            a4localx = param1.x;
            a4localy = param1.y;
            wake();
            return;
        }// end function

        public function invalidate_a3(param1:ZPP_Vec2) : void
        {
            immutable_midstep("Constraint::" + "a3");
            a3localx = param1.x;
            a3localy = param1.y;
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
            if (b3 != b1)
            {
            }
            if (b3 != b2)
            {
                if (b3 != null)
                {
                    b3.constraints.remove(this);
                }
            }
            if (b4 != b1)
            {
            }
            if (b4 != b2)
            {
            }
            if (b4 != b3)
            {
                if (b4 != null)
                {
                    b4.constraints.remove(this);
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
            if (b3.type == ZPP_Flags.id_BodyType_DYNAMIC)
            {
                if (b3.component == b3.component.parent)
                {
                    _loc_1 = b3.component;
                }
                else
                {
                    _loc_2 = b3.component;
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
            if (b4.type == ZPP_Flags.id_BodyType_DYNAMIC)
            {
                if (b4.component == b4.component.parent)
                {
                    _loc_1 = b4.component;
                }
                else
                {
                    _loc_2 = b4.component;
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

        public function drawLink(param1:Debug, param2:Vec2, param3:Vec2, param4:Vec2, param5:Number, param6:Number, param7:Number, param8:int, param9:int) : void
        {
            var _loc_10:* = null as Vec2;
            var _loc_11:* = NaN;
            var _loc_12:* = NaN;
            var _loc_13:* = null as Vec2;
            var _loc_14:* = null as Vec2;
            var _loc_15:* = null as Vec2;
            var _loc_16:* = null as Vec2;
            var _loc_17:* = null as ZPP_Vec2;
            var _loc_18:* = null as Vec2;
            var _loc_19:* = null as ZPP_Vec2;
            if (param5 != 0)
            {
                param4.muleq(1 / param5);
                _loc_10 = param2.add(param3).muleq(0.5);
                _loc_11 = (jointMin - param6) * param7;
                if (_loc_11 < 0)
                {
                    _loc_11 = 0;
                }
                _loc_12 = (jointMax - param6) * param7;
                if (_loc_12 < 0)
                {
                    _loc_12 = 0;
                }
                _loc_13 = _loc_10.sub(param4.mul(_loc_11 * 0.5, true));
                _loc_14 = _loc_10.add(param4.mul(_loc_11 * 0.5, true));
                _loc_15 = _loc_10.sub(param4.mul(_loc_12 * 0.5, true));
                _loc_16 = _loc_10.add(param4.mul(_loc_12 * 0.5, true));
                param1.drawLine(_loc_13, _loc_14, param8);
                param1.drawLine(_loc_15, _loc_13, param9);
                param1.drawLine(_loc_16, _loc_14, param9);
                if (!stiff)
                {
                    if (param5 > _loc_12)
                    {
                        param1.drawSpring(_loc_15, param2, param9);
                        param1.drawSpring(_loc_16, param3, param9);
                    }
                    else if (param5 < _loc_11)
                    {
                        param1.drawSpring(_loc_13, param2, param8);
                        param1.drawSpring(_loc_14, param3, param8);
                    }
                }
                if (_loc_10 != null)
                {
                }
                if (_loc_10.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_17 = _loc_10.zpp_inner;
                if (_loc_17._immutable)
                {
                    throw "Error: Vec2 is immutable";
                }
                if (_loc_17._isimmutable != null)
                {
                    _loc_17._isimmutable();
                }
                if (_loc_10.zpp_inner._inuse)
                {
                    throw "Error: This Vec2 is not disposable";
                }
                _loc_17 = _loc_10.zpp_inner;
                _loc_10.zpp_inner.outer = null;
                _loc_10.zpp_inner = null;
                _loc_18 = _loc_10;
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
                _loc_19 = _loc_17;
                if (_loc_19.outer != null)
                {
                    _loc_19.outer.zpp_inner = null;
                    _loc_19.outer = null;
                }
                _loc_19._isimmutable = null;
                _loc_19._validate = null;
                _loc_19._invalidate = null;
                _loc_19.next = ZPP_Vec2.zpp_pool;
                ZPP_Vec2.zpp_pool = _loc_19;
                if (_loc_13 != null)
                {
                }
                if (_loc_13.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_17 = _loc_13.zpp_inner;
                if (_loc_17._immutable)
                {
                    throw "Error: Vec2 is immutable";
                }
                if (_loc_17._isimmutable != null)
                {
                    _loc_17._isimmutable();
                }
                if (_loc_13.zpp_inner._inuse)
                {
                    throw "Error: This Vec2 is not disposable";
                }
                _loc_17 = _loc_13.zpp_inner;
                _loc_13.zpp_inner.outer = null;
                _loc_13.zpp_inner = null;
                _loc_18 = _loc_13;
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
                _loc_19 = _loc_17;
                if (_loc_19.outer != null)
                {
                    _loc_19.outer.zpp_inner = null;
                    _loc_19.outer = null;
                }
                _loc_19._isimmutable = null;
                _loc_19._validate = null;
                _loc_19._invalidate = null;
                _loc_19.next = ZPP_Vec2.zpp_pool;
                ZPP_Vec2.zpp_pool = _loc_19;
                if (_loc_14 != null)
                {
                }
                if (_loc_14.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_17 = _loc_14.zpp_inner;
                if (_loc_17._immutable)
                {
                    throw "Error: Vec2 is immutable";
                }
                if (_loc_17._isimmutable != null)
                {
                    _loc_17._isimmutable();
                }
                if (_loc_14.zpp_inner._inuse)
                {
                    throw "Error: This Vec2 is not disposable";
                }
                _loc_17 = _loc_14.zpp_inner;
                _loc_14.zpp_inner.outer = null;
                _loc_14.zpp_inner = null;
                _loc_18 = _loc_14;
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
                _loc_19 = _loc_17;
                if (_loc_19.outer != null)
                {
                    _loc_19.outer.zpp_inner = null;
                    _loc_19.outer = null;
                }
                _loc_19._isimmutable = null;
                _loc_19._validate = null;
                _loc_19._invalidate = null;
                _loc_19.next = ZPP_Vec2.zpp_pool;
                ZPP_Vec2.zpp_pool = _loc_19;
                if (_loc_15 != null)
                {
                }
                if (_loc_15.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_17 = _loc_15.zpp_inner;
                if (_loc_17._immutable)
                {
                    throw "Error: Vec2 is immutable";
                }
                if (_loc_17._isimmutable != null)
                {
                    _loc_17._isimmutable();
                }
                if (_loc_15.zpp_inner._inuse)
                {
                    throw "Error: This Vec2 is not disposable";
                }
                _loc_17 = _loc_15.zpp_inner;
                _loc_15.zpp_inner.outer = null;
                _loc_15.zpp_inner = null;
                _loc_18 = _loc_15;
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
                _loc_19 = _loc_17;
                if (_loc_19.outer != null)
                {
                    _loc_19.outer.zpp_inner = null;
                    _loc_19.outer = null;
                }
                _loc_19._isimmutable = null;
                _loc_19._validate = null;
                _loc_19._invalidate = null;
                _loc_19.next = ZPP_Vec2.zpp_pool;
                ZPP_Vec2.zpp_pool = _loc_19;
                if (_loc_16 != null)
                {
                }
                if (_loc_16.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_17 = _loc_16.zpp_inner;
                if (_loc_17._immutable)
                {
                    throw "Error: Vec2 is immutable";
                }
                if (_loc_17._isimmutable != null)
                {
                    _loc_17._isimmutable();
                }
                if (_loc_16.zpp_inner._inuse)
                {
                    throw "Error: This Vec2 is not disposable";
                }
                _loc_17 = _loc_16.zpp_inner;
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
                _loc_19 = _loc_17;
                if (_loc_19.outer != null)
                {
                    _loc_19.outer.zpp_inner = null;
                    _loc_19.outer = null;
                }
                _loc_19._isimmutable = null;
                _loc_19._validate = null;
                _loc_19._invalidate = null;
                _loc_19.next = ZPP_Vec2.zpp_pool;
                ZPP_Vec2.zpp_pool = _loc_19;
            }
            return;
        }// end function

        override public function draw(param1:Debug) : void
        {
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
            if (_loc_2.zpp_inner_zn.wrap_a3 == null)
            {
                _loc_2.zpp_inner_zn.setup_a3();
            }
            var _loc_5:* = (_loc_2.zpp_inner_zn.b3 == null ? (null) : (_loc_2.zpp_inner_zn.b3.outer)).localPointToWorld(_loc_2.zpp_inner_zn.wrap_a3);
            if (_loc_2.zpp_inner_zn.wrap_a4 == null)
            {
                _loc_2.zpp_inner_zn.setup_a4();
            }
            var _loc_6:* = (_loc_2.zpp_inner_zn.b4 == null ? (null) : (_loc_2.zpp_inner_zn.b4.outer)).localPointToWorld(_loc_2.zpp_inner_zn.wrap_a4);
            var _loc_7:* = _loc_4.sub(_loc_3);
            var _loc_8:* = _loc_6.sub(_loc_5);
            if (_loc_7 != null)
            {
            }
            if (_loc_7.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            if (_loc_7 != null)
            {
            }
            if (_loc_7.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            var _loc_10:* = _loc_7.zpp_inner;
            if (_loc_10._validate != null)
            {
                _loc_10._validate();
            }
            if (_loc_7 != null)
            {
            }
            if (_loc_7.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_10 = _loc_7.zpp_inner;
            if (_loc_10._validate != null)
            {
                _loc_10._validate();
            }
            if (_loc_7 != null)
            {
            }
            if (_loc_7.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_10 = _loc_7.zpp_inner;
            if (_loc_10._validate != null)
            {
                _loc_10._validate();
            }
            if (_loc_7 != null)
            {
            }
            if (_loc_7.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_10 = _loc_7.zpp_inner;
            if (_loc_10._validate != null)
            {
                _loc_10._validate();
            }
            var _loc_9:* = Math.sqrt(_loc_7.zpp_inner.x * _loc_7.zpp_inner.x + _loc_7.zpp_inner.y * _loc_7.zpp_inner.y);
            if (_loc_8 != null)
            {
            }
            if (_loc_8.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            if (_loc_8 != null)
            {
            }
            if (_loc_8.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_10 = _loc_8.zpp_inner;
            if (_loc_10._validate != null)
            {
                _loc_10._validate();
            }
            if (_loc_8 != null)
            {
            }
            if (_loc_8.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_10 = _loc_8.zpp_inner;
            if (_loc_10._validate != null)
            {
                _loc_10._validate();
            }
            if (_loc_8 != null)
            {
            }
            if (_loc_8.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_10 = _loc_8.zpp_inner;
            if (_loc_10._validate != null)
            {
                _loc_10._validate();
            }
            if (_loc_8 != null)
            {
            }
            if (_loc_8.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_10 = _loc_8.zpp_inner;
            if (_loc_10._validate != null)
            {
                _loc_10._validate();
            }
            var _loc_11:* = Math.sqrt(_loc_8.zpp_inner.x * _loc_8.zpp_inner.x + _loc_8.zpp_inner.y * _loc_8.zpp_inner.y);
            drawLink(param1, _loc_3, _loc_4, _loc_7, _loc_9, _loc_11 * ratio, 1, 16776960, 65535);
            drawLink(param1, _loc_5, _loc_6, _loc_8, _loc_11, _loc_9, 1 / ratio, 65535, 16711935);
            param1.drawFilledCircle(_loc_3, 2, 255);
            param1.drawFilledCircle(_loc_4, 2, 16711680);
            param1.drawFilledCircle(_loc_5, 2, 65280);
            param1.drawFilledCircle(_loc_6, 2, 16711935);
            if (_loc_3 != null)
            {
            }
            if (_loc_3.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_10 = _loc_3.zpp_inner;
            if (_loc_10._immutable)
            {
                throw "Error: Vec2 is immutable";
            }
            if (_loc_10._isimmutable != null)
            {
                _loc_10._isimmutable();
            }
            if (_loc_3.zpp_inner._inuse)
            {
                throw "Error: This Vec2 is not disposable";
            }
            _loc_10 = _loc_3.zpp_inner;
            _loc_3.zpp_inner.outer = null;
            _loc_3.zpp_inner = null;
            var _loc_12:* = _loc_3;
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
            var _loc_13:* = _loc_10;
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
            if (_loc_4 != null)
            {
            }
            if (_loc_4.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_10 = _loc_4.zpp_inner;
            if (_loc_10._immutable)
            {
                throw "Error: Vec2 is immutable";
            }
            if (_loc_10._isimmutable != null)
            {
                _loc_10._isimmutable();
            }
            if (_loc_4.zpp_inner._inuse)
            {
                throw "Error: This Vec2 is not disposable";
            }
            _loc_10 = _loc_4.zpp_inner;
            _loc_4.zpp_inner.outer = null;
            _loc_4.zpp_inner = null;
            _loc_12 = _loc_4;
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
            _loc_13 = _loc_10;
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
            if (_loc_5 != null)
            {
            }
            if (_loc_5.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_10 = _loc_5.zpp_inner;
            if (_loc_10._immutable)
            {
                throw "Error: Vec2 is immutable";
            }
            if (_loc_10._isimmutable != null)
            {
                _loc_10._isimmutable();
            }
            if (_loc_5.zpp_inner._inuse)
            {
                throw "Error: This Vec2 is not disposable";
            }
            _loc_10 = _loc_5.zpp_inner;
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
            _loc_13 = _loc_10;
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
            if (_loc_6 != null)
            {
            }
            if (_loc_6.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_10 = _loc_6.zpp_inner;
            if (_loc_10._immutable)
            {
                throw "Error: Vec2 is immutable";
            }
            if (_loc_10._isimmutable != null)
            {
                _loc_10._isimmutable();
            }
            if (_loc_6.zpp_inner._inuse)
            {
                throw "Error: This Vec2 is not disposable";
            }
            _loc_10 = _loc_6.zpp_inner;
            _loc_6.zpp_inner.outer = null;
            _loc_6.zpp_inner = null;
            _loc_12 = _loc_6;
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
            _loc_13 = _loc_10;
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
            if (_loc_7 != null)
            {
            }
            if (_loc_7.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_10 = _loc_7.zpp_inner;
            if (_loc_10._immutable)
            {
                throw "Error: Vec2 is immutable";
            }
            if (_loc_10._isimmutable != null)
            {
                _loc_10._isimmutable();
            }
            if (_loc_7.zpp_inner._inuse)
            {
                throw "Error: This Vec2 is not disposable";
            }
            _loc_10 = _loc_7.zpp_inner;
            _loc_7.zpp_inner.outer = null;
            _loc_7.zpp_inner = null;
            _loc_12 = _loc_7;
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
            _loc_13 = _loc_10;
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
            if (_loc_8 != null)
            {
            }
            if (_loc_8.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_10 = _loc_8.zpp_inner;
            if (_loc_10._immutable)
            {
                throw "Error: Vec2 is immutable";
            }
            if (_loc_10._isimmutable != null)
            {
                _loc_10._isimmutable();
            }
            if (_loc_8.zpp_inner._inuse)
            {
                throw "Error: This Vec2 is not disposable";
            }
            _loc_10 = _loc_8.zpp_inner;
            _loc_8.zpp_inner.outer = null;
            _loc_8.zpp_inner = null;
            _loc_12 = _loc_8;
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
            _loc_13 = _loc_10;
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
            if (_loc_3.zpp_inner_zn.wrap_a3 == null)
            {
                _loc_3.zpp_inner_zn.setup_a3();
            }
            _loc_3 = outer_zn;
            if (_loc_3.zpp_inner_zn.wrap_a4 == null)
            {
                _loc_3.zpp_inner_zn.setup_a4();
            }
            var ret:* = new PulleyJoint(null, null, null, null, _loc_3.zpp_inner_zn.wrap_a1, _loc_3.zpp_inner_zn.wrap_a2, _loc_3.zpp_inner_zn.wrap_a3, _loc_3.zpp_inner_zn.wrap_a4, jointMin, jointMax, ratio);
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
            if (param1 != null)
            {
            }
            if (b3 != null)
            {
                _loc_4 = null;
                _loc_5 = 0;
                while (_loc_5 < param1.length)
                {
                    
                    _loc_6 = param1[_loc_5];
                    _loc_5++;
                    if (_loc_6.id == b3.id)
                    {
                        _loc_4 = _loc_6.bc;
                        break;
                    }
                }
                if (_loc_4 != null)
                {
                    ret.zpp_inner_zn.b3 = _loc_4.zpp_inner;
                }
                else
                {
                    param2.push(ZPP_CopyHelper.todo(b3.id, function (param1:Body) : void
            {
                ret.zpp_inner_zn.b3 = param1.zpp_inner;
                return;
            }// end function
            ));
                }
            }
            if (param1 != null)
            {
            }
            if (b4 != null)
            {
                _loc_4 = null;
                _loc_5 = 0;
                while (_loc_5 < param1.length)
                {
                    
                    _loc_6 = param1[_loc_5];
                    _loc_5++;
                    if (_loc_6.id == b4.id)
                    {
                        _loc_4 = _loc_6.bc;
                        break;
                    }
                }
                if (_loc_4 != null)
                {
                    ret.zpp_inner_zn.b4 = _loc_4.zpp_inner;
                }
                else
                {
                    param2.push(ZPP_CopyHelper.todo(b4.id, function (param1:Body) : void
            {
                ret.zpp_inner_zn.b4 = param1.zpp_inner;
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
            var _loc_2:* = null as Vec3;
            var _loc_3:* = null as Vec3;
            var _loc_4:* = NaN;
            var _loc_5:* = null as ZPP_Vec3;
            if (stepped)
            {
                _loc_2 = Vec3.get();
                if (param1 == b1)
                {
                    _loc_3 = _loc_2;
                    if (_loc_3 != null)
                    {
                    }
                    if (_loc_3.zpp_disp)
                    {
                        throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
                    }
                    _loc_5 = _loc_3.zpp_inner;
                    if (_loc_5._validate != null)
                    {
                        _loc_5._validate();
                    }
                    _loc_4 = _loc_3.zpp_inner.x - jAcc * n12x;
                    if (_loc_3 != null)
                    {
                    }
                    if (_loc_3.zpp_disp)
                    {
                        throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
                    }
                    if (_loc_3.zpp_inner.immutable)
                    {
                        throw "Error: Vec3 is immutable";
                    }
                    _loc_3.zpp_inner.x = _loc_4;
                    if (_loc_3 != null)
                    {
                    }
                    if (_loc_3.zpp_disp)
                    {
                        throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
                    }
                    _loc_5 = _loc_3.zpp_inner;
                    if (_loc_5._validate != null)
                    {
                        _loc_5._validate();
                    }
                    _loc_3 = _loc_2;
                    if (_loc_3 != null)
                    {
                    }
                    if (_loc_3.zpp_disp)
                    {
                        throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
                    }
                    _loc_5 = _loc_3.zpp_inner;
                    if (_loc_5._validate != null)
                    {
                        _loc_5._validate();
                    }
                    _loc_4 = _loc_3.zpp_inner.y - jAcc * n12y;
                    if (_loc_3 != null)
                    {
                    }
                    if (_loc_3.zpp_disp)
                    {
                        throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
                    }
                    if (_loc_3.zpp_inner.immutable)
                    {
                        throw "Error: Vec3 is immutable";
                    }
                    _loc_3.zpp_inner.y = _loc_4;
                    if (_loc_3 != null)
                    {
                    }
                    if (_loc_3.zpp_disp)
                    {
                        throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
                    }
                    _loc_5 = _loc_3.zpp_inner;
                    if (_loc_5._validate != null)
                    {
                        _loc_5._validate();
                    }
                    _loc_3 = _loc_2;
                    if (_loc_3 != null)
                    {
                    }
                    if (_loc_3.zpp_disp)
                    {
                        throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
                    }
                    _loc_5 = _loc_3.zpp_inner;
                    if (_loc_5._validate != null)
                    {
                        _loc_5._validate();
                    }
                    _loc_4 = _loc_3.zpp_inner.z - cx1 * jAcc;
                    if (_loc_3 != null)
                    {
                    }
                    if (_loc_3.zpp_disp)
                    {
                        throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
                    }
                    if (_loc_3.zpp_inner.immutable)
                    {
                        throw "Error: Vec3 is immutable";
                    }
                    _loc_3.zpp_inner.z = _loc_4;
                    if (_loc_3 != null)
                    {
                    }
                    if (_loc_3.zpp_disp)
                    {
                        throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
                    }
                    _loc_5 = _loc_3.zpp_inner;
                    if (_loc_5._validate != null)
                    {
                        _loc_5._validate();
                    }
                }
                if (param1 == b2)
                {
                    _loc_3 = _loc_2;
                    if (_loc_3 != null)
                    {
                    }
                    if (_loc_3.zpp_disp)
                    {
                        throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
                    }
                    _loc_5 = _loc_3.zpp_inner;
                    if (_loc_5._validate != null)
                    {
                        _loc_5._validate();
                    }
                    _loc_4 = _loc_3.zpp_inner.x + jAcc * n12x;
                    if (_loc_3 != null)
                    {
                    }
                    if (_loc_3.zpp_disp)
                    {
                        throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
                    }
                    if (_loc_3.zpp_inner.immutable)
                    {
                        throw "Error: Vec3 is immutable";
                    }
                    _loc_3.zpp_inner.x = _loc_4;
                    if (_loc_3 != null)
                    {
                    }
                    if (_loc_3.zpp_disp)
                    {
                        throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
                    }
                    _loc_5 = _loc_3.zpp_inner;
                    if (_loc_5._validate != null)
                    {
                        _loc_5._validate();
                    }
                    _loc_3 = _loc_2;
                    if (_loc_3 != null)
                    {
                    }
                    if (_loc_3.zpp_disp)
                    {
                        throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
                    }
                    _loc_5 = _loc_3.zpp_inner;
                    if (_loc_5._validate != null)
                    {
                        _loc_5._validate();
                    }
                    _loc_4 = _loc_3.zpp_inner.y + jAcc * n12y;
                    if (_loc_3 != null)
                    {
                    }
                    if (_loc_3.zpp_disp)
                    {
                        throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
                    }
                    if (_loc_3.zpp_inner.immutable)
                    {
                        throw "Error: Vec3 is immutable";
                    }
                    _loc_3.zpp_inner.y = _loc_4;
                    if (_loc_3 != null)
                    {
                    }
                    if (_loc_3.zpp_disp)
                    {
                        throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
                    }
                    _loc_5 = _loc_3.zpp_inner;
                    if (_loc_5._validate != null)
                    {
                        _loc_5._validate();
                    }
                    _loc_3 = _loc_2;
                    if (_loc_3 != null)
                    {
                    }
                    if (_loc_3.zpp_disp)
                    {
                        throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
                    }
                    _loc_5 = _loc_3.zpp_inner;
                    if (_loc_5._validate != null)
                    {
                        _loc_5._validate();
                    }
                    _loc_4 = _loc_3.zpp_inner.z + cx2 * jAcc;
                    if (_loc_3 != null)
                    {
                    }
                    if (_loc_3.zpp_disp)
                    {
                        throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
                    }
                    if (_loc_3.zpp_inner.immutable)
                    {
                        throw "Error: Vec3 is immutable";
                    }
                    _loc_3.zpp_inner.z = _loc_4;
                    if (_loc_3 != null)
                    {
                    }
                    if (_loc_3.zpp_disp)
                    {
                        throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
                    }
                    _loc_5 = _loc_3.zpp_inner;
                    if (_loc_5._validate != null)
                    {
                        _loc_5._validate();
                    }
                }
                if (param1 == b3)
                {
                    _loc_3 = _loc_2;
                    if (_loc_3 != null)
                    {
                    }
                    if (_loc_3.zpp_disp)
                    {
                        throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
                    }
                    _loc_5 = _loc_3.zpp_inner;
                    if (_loc_5._validate != null)
                    {
                        _loc_5._validate();
                    }
                    _loc_4 = _loc_3.zpp_inner.x - jAcc * n34x;
                    if (_loc_3 != null)
                    {
                    }
                    if (_loc_3.zpp_disp)
                    {
                        throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
                    }
                    if (_loc_3.zpp_inner.immutable)
                    {
                        throw "Error: Vec3 is immutable";
                    }
                    _loc_3.zpp_inner.x = _loc_4;
                    if (_loc_3 != null)
                    {
                    }
                    if (_loc_3.zpp_disp)
                    {
                        throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
                    }
                    _loc_5 = _loc_3.zpp_inner;
                    if (_loc_5._validate != null)
                    {
                        _loc_5._validate();
                    }
                    _loc_3 = _loc_2;
                    if (_loc_3 != null)
                    {
                    }
                    if (_loc_3.zpp_disp)
                    {
                        throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
                    }
                    _loc_5 = _loc_3.zpp_inner;
                    if (_loc_5._validate != null)
                    {
                        _loc_5._validate();
                    }
                    _loc_4 = _loc_3.zpp_inner.y - jAcc * n34y;
                    if (_loc_3 != null)
                    {
                    }
                    if (_loc_3.zpp_disp)
                    {
                        throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
                    }
                    if (_loc_3.zpp_inner.immutable)
                    {
                        throw "Error: Vec3 is immutable";
                    }
                    _loc_3.zpp_inner.y = _loc_4;
                    if (_loc_3 != null)
                    {
                    }
                    if (_loc_3.zpp_disp)
                    {
                        throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
                    }
                    _loc_5 = _loc_3.zpp_inner;
                    if (_loc_5._validate != null)
                    {
                        _loc_5._validate();
                    }
                    _loc_3 = _loc_2;
                    if (_loc_3 != null)
                    {
                    }
                    if (_loc_3.zpp_disp)
                    {
                        throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
                    }
                    _loc_5 = _loc_3.zpp_inner;
                    if (_loc_5._validate != null)
                    {
                        _loc_5._validate();
                    }
                    _loc_4 = _loc_3.zpp_inner.z - cx3 * jAcc;
                    if (_loc_3 != null)
                    {
                    }
                    if (_loc_3.zpp_disp)
                    {
                        throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
                    }
                    if (_loc_3.zpp_inner.immutable)
                    {
                        throw "Error: Vec3 is immutable";
                    }
                    _loc_3.zpp_inner.z = _loc_4;
                    if (_loc_3 != null)
                    {
                    }
                    if (_loc_3.zpp_disp)
                    {
                        throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
                    }
                    _loc_5 = _loc_3.zpp_inner;
                    if (_loc_5._validate != null)
                    {
                        _loc_5._validate();
                    }
                }
                if (param1 == b4)
                {
                    _loc_3 = _loc_2;
                    if (_loc_3 != null)
                    {
                    }
                    if (_loc_3.zpp_disp)
                    {
                        throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
                    }
                    _loc_5 = _loc_3.zpp_inner;
                    if (_loc_5._validate != null)
                    {
                        _loc_5._validate();
                    }
                    _loc_4 = _loc_3.zpp_inner.x + jAcc * n34x;
                    if (_loc_3 != null)
                    {
                    }
                    if (_loc_3.zpp_disp)
                    {
                        throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
                    }
                    if (_loc_3.zpp_inner.immutable)
                    {
                        throw "Error: Vec3 is immutable";
                    }
                    _loc_3.zpp_inner.x = _loc_4;
                    if (_loc_3 != null)
                    {
                    }
                    if (_loc_3.zpp_disp)
                    {
                        throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
                    }
                    _loc_5 = _loc_3.zpp_inner;
                    if (_loc_5._validate != null)
                    {
                        _loc_5._validate();
                    }
                    _loc_3 = _loc_2;
                    if (_loc_3 != null)
                    {
                    }
                    if (_loc_3.zpp_disp)
                    {
                        throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
                    }
                    _loc_5 = _loc_3.zpp_inner;
                    if (_loc_5._validate != null)
                    {
                        _loc_5._validate();
                    }
                    _loc_4 = _loc_3.zpp_inner.y + jAcc * n34y;
                    if (_loc_3 != null)
                    {
                    }
                    if (_loc_3.zpp_disp)
                    {
                        throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
                    }
                    if (_loc_3.zpp_inner.immutable)
                    {
                        throw "Error: Vec3 is immutable";
                    }
                    _loc_3.zpp_inner.y = _loc_4;
                    if (_loc_3 != null)
                    {
                    }
                    if (_loc_3.zpp_disp)
                    {
                        throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
                    }
                    _loc_5 = _loc_3.zpp_inner;
                    if (_loc_5._validate != null)
                    {
                        _loc_5._validate();
                    }
                    _loc_3 = _loc_2;
                    if (_loc_3 != null)
                    {
                    }
                    if (_loc_3.zpp_disp)
                    {
                        throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
                    }
                    _loc_5 = _loc_3.zpp_inner;
                    if (_loc_5._validate != null)
                    {
                        _loc_5._validate();
                    }
                    _loc_4 = _loc_3.zpp_inner.z + cx4 * jAcc;
                    if (_loc_3 != null)
                    {
                    }
                    if (_loc_3.zpp_disp)
                    {
                        throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
                    }
                    if (_loc_3.zpp_inner.immutable)
                    {
                        throw "Error: Vec3 is immutable";
                    }
                    _loc_3.zpp_inner.z = _loc_4;
                    if (_loc_3 != null)
                    {
                    }
                    if (_loc_3.zpp_disp)
                    {
                        throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
                    }
                    _loc_5 = _loc_3.zpp_inner;
                    if (_loc_5._validate != null)
                    {
                        _loc_5._validate();
                    }
                }
                return _loc_2;
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
            var _loc_1:* = n12x * (b2.velx + b2.kinvelx - b1.velx - b1.kinvelx) + n12y * (b2.vely + b2.kinvely - b1.vely - b1.kinvely) + n34x * (b4.velx + b4.kinvelx - b3.velx - b3.kinvelx) + n34y * (b4.vely + b4.kinvely - b3.vely - b3.kinvely) + (b2.angvel + b2.kinangvel) * cx2 - (b1.angvel + b1.kinangvel) * cx1 + (b4.angvel + b4.kinangvel) * cx4 - (b3.angvel + b3.kinangvel) * cx3;
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
            b1.velx = b1.velx - n12x * _loc_3;
            b1.vely = b1.vely - n12y * _loc_3;
            _loc_3 = b2.imass * _loc_2;
            b2.velx = b2.velx + n12x * _loc_3;
            b2.vely = b2.vely + n12y * _loc_3;
            _loc_3 = b3.imass * _loc_2;
            b3.velx = b3.velx - n34x * _loc_3;
            b3.vely = b3.vely - n34y * _loc_3;
            _loc_3 = b4.imass * _loc_2;
            b4.velx = b4.velx + n34x * _loc_3;
            b4.vely = b4.vely + n34y * _loc_3;
            b1.angvel = b1.angvel - cx1 * b1.iinertia * _loc_2;
            b2.angvel = b2.angvel + cx2 * b2.iinertia * _loc_2;
            b3.angvel = b3.angvel - cx3 * b3.iinertia * _loc_2;
            b4.angvel = b4.angvel + cx4 * b4.iinertia * _loc_2;
            return false;
        }// end function

        override public function applyImpulsePos() : Boolean
        {
            var _loc_2:* = NaN;
            var _loc_11:* = false;
            var _loc_16:* = NaN;
            var _loc_17:* = NaN;
            var _loc_18:* = NaN;
            var _loc_19:* = NaN;
            var _loc_20:* = NaN;
            var _loc_21:* = NaN;
            var _loc_22:* = 0;
            var _loc_23:* = NaN;
            var _loc_24:* = NaN;
            var _loc_25:* = NaN;
            var _loc_26:* = NaN;
            var _loc_27:* = null as ZPP_Body;
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
            _loc_7 = b3.axisy * a3localx - b3.axisx * a3localy;
            _loc_8 = a3localx * b3.axisx + a3localy * b3.axisy;
            var _loc_9:* = 0;
            var _loc_10:* = 0;
            _loc_9 = b4.axisy * a4localx - b4.axisx * a4localy;
            _loc_10 = a4localx * b4.axisx + a4localy * b4.axisy;
            var _loc_12:* = 0;
            var _loc_13:* = 0;
            var _loc_14:* = 0;
            var _loc_15:* = 0;
            _loc_12 = n12x;
            _loc_13 = n12y;
            _loc_14 = n34x;
            _loc_15 = n34y;
            _loc_16 = 0;
            _loc_17 = 0;
            _loc_18 = 0;
            _loc_19 = 0;
            _loc_16 = b2.posx + _loc_5 - (b1.posx + _loc_3);
            _loc_17 = b2.posy + _loc_6 - (b1.posy + _loc_4);
            _loc_18 = b4.posx + _loc_9 - (b3.posx + _loc_7);
            _loc_19 = b4.posy + _loc_10 - (b3.posy + _loc_8);
            _loc_21 = _loc_16 * _loc_16 + _loc_17 * _loc_17;
            if (_loc_21 == 0)
            {
                _loc_20 = 0;
            }
            else
            {
                _loc_22 = 1597463007 - (0 >> 1);
                _loc_23 = 0;
                _loc_20 = 0 / (_loc_23 * (1.5 - 0.5 * _loc_21 * _loc_23 * _loc_23));
            }
            _loc_23 = _loc_18 * _loc_18 + _loc_19 * _loc_19;
            if (_loc_23 == 0)
            {
                _loc_21 = 0;
            }
            else
            {
                _loc_22 = 1597463007 - (0 >> 1);
                _loc_24 = 0;
                _loc_21 = 0 / (_loc_24 * (1.5 - 0.5 * _loc_23 * _loc_24 * _loc_24));
            }
            if (_loc_20 != 0)
            {
                _loc_23 = 1 / _loc_20;
                _loc_12 = _loc_16 * _loc_23;
                _loc_13 = _loc_17 * _loc_23;
            }
            if (_loc_21 != 0)
            {
                _loc_23 = 1 / _loc_21;
                _loc_14 = _loc_18 * _loc_23;
                _loc_15 = _loc_19 * _loc_23;
                _loc_23 = ratio;
                _loc_14 = _loc_14 * _loc_23;
                _loc_15 = _loc_15 * _loc_23;
            }
            else
            {
                _loc_24 = _loc_14 * _loc_14 + _loc_15 * _loc_15;
                _loc_23 = 0 / (_loc_24 == 0 ? (_loc_22) : (_loc_22 = 1597463007 - (0 >> 1), _loc_25 = 0, 0 / (_loc_25 * (1.5 - 0.5 * _loc_24 * _loc_25 * _loc_25))));
                _loc_14 = _loc_14 * _loc_23;
                _loc_15 = _loc_15 * _loc_23;
            }
            _loc_23 = _loc_20 + ratio * _loc_21;
            if (equal)
            {
                _loc_23 = _loc_23 - jointMax;
                _loc_11 = false;
            }
            else if (_loc_23 < jointMin)
            {
                _loc_23 = jointMin - _loc_23;
                _loc_12 = -_loc_12;
                _loc_13 = -_loc_13;
                _loc_14 = -_loc_14;
                _loc_15 = -_loc_15;
                _loc_11 = false;
            }
            else if (_loc_23 > jointMax)
            {
                _loc_23 = _loc_23 - jointMax;
                _loc_11 = false;
            }
            else
            {
                _loc_12 = 0;
                _loc_13 = 0;
                _loc_14 = 0;
                _loc_15 = 0;
                _loc_23 = 0;
                _loc_11 = true;
            }
            var _loc_1:* = _loc_23;
            if (!_loc_11)
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
                    _loc_16 = b1.smass + b2.smass;
                    if (_loc_16 > Config.epsilon)
                    {
                        _loc_16 = 0.75 / _loc_16;
                        _loc_2 = (-_loc_1) * _loc_16;
                        if (!equal)
                        {
                        }
                        if (_loc_2 < 0)
                        {
                            _loc_17 = _loc_2 * b1.imass;
                            b1.posx = b1.posx - _loc_12 * _loc_17;
                            b1.posy = b1.posy - _loc_13 * _loc_17;
                            _loc_17 = _loc_2 * b2.imass;
                            b2.posx = b2.posx + _loc_12 * _loc_17;
                            b2.posy = b2.posy + _loc_13 * _loc_17;
                            _loc_17 = _loc_2 * b3.imass;
                            b3.posx = b3.posx - _loc_14 * _loc_17;
                            b3.posy = b3.posy - _loc_15 * _loc_17;
                            _loc_17 = _loc_2 * b4.imass;
                            b4.posx = b4.posx + _loc_14 * _loc_17;
                            b4.posy = b4.posy + _loc_15 * _loc_17;
                            _loc_17 = 0;
                            _loc_18 = 0;
                            _loc_19 = 0;
                            _loc_20 = 0;
                            _loc_17 = b2.posx + _loc_5 - (b1.posx + _loc_3);
                            _loc_18 = b2.posy + _loc_6 - (b1.posy + _loc_4);
                            _loc_19 = b4.posx + _loc_9 - (b3.posx + _loc_7);
                            _loc_20 = b4.posy + _loc_10 - (b3.posy + _loc_8);
                            _loc_23 = _loc_17 * _loc_17 + _loc_18 * _loc_18;
                            if (_loc_23 == 0)
                            {
                                _loc_21 = 0;
                            }
                            else
                            {
                                _loc_22 = 1597463007 - (0 >> 1);
                                _loc_24 = 0;
                                _loc_21 = 0 / (_loc_24 * (1.5 - 0.5 * _loc_23 * _loc_24 * _loc_24));
                            }
                            _loc_24 = _loc_19 * _loc_19 + _loc_20 * _loc_20;
                            if (_loc_24 == 0)
                            {
                                _loc_23 = 0;
                            }
                            else
                            {
                                _loc_22 = 1597463007 - (0 >> 1);
                                _loc_25 = 0;
                                _loc_23 = 0 / (_loc_25 * (1.5 - 0.5 * _loc_24 * _loc_25 * _loc_25));
                            }
                            if (_loc_21 != 0)
                            {
                                _loc_24 = 1 / _loc_21;
                                _loc_12 = _loc_17 * _loc_24;
                                _loc_13 = _loc_18 * _loc_24;
                            }
                            if (_loc_23 != 0)
                            {
                                _loc_24 = 1 / _loc_23;
                                _loc_14 = _loc_19 * _loc_24;
                                _loc_15 = _loc_20 * _loc_24;
                                _loc_24 = ratio;
                                _loc_14 = _loc_14 * _loc_24;
                                _loc_15 = _loc_15 * _loc_24;
                            }
                            else
                            {
                                _loc_25 = _loc_14 * _loc_14 + _loc_15 * _loc_15;
                                _loc_24 = 0 / (_loc_25 == 0 ? (_loc_22) : (_loc_22 = 1597463007 - (0 >> 1), _loc_26 = 0, 0 / (_loc_26 * (1.5 - 0.5 * _loc_25 * _loc_26 * _loc_26))));
                                _loc_14 = _loc_14 * _loc_24;
                                _loc_15 = _loc_15 * _loc_24;
                            }
                            _loc_24 = _loc_21 + ratio * _loc_23;
                            if (equal)
                            {
                                _loc_24 = _loc_24 - jointMax;
                                _loc_11 = false;
                            }
                            else if (_loc_24 < jointMin)
                            {
                                _loc_24 = jointMin - _loc_24;
                                _loc_12 = -_loc_12;
                                _loc_13 = -_loc_13;
                                _loc_14 = -_loc_14;
                                _loc_15 = -_loc_15;
                                _loc_11 = false;
                            }
                            else if (_loc_24 > jointMax)
                            {
                                _loc_24 = _loc_24 - jointMax;
                                _loc_11 = false;
                            }
                            else
                            {
                                _loc_12 = 0;
                                _loc_13 = 0;
                                _loc_14 = 0;
                                _loc_15 = 0;
                                _loc_24 = 0;
                                _loc_11 = true;
                            }
                            _loc_1 = _loc_24;
                            _loc_1 = _loc_1 * 0.5;
                        }
                    }
                }
                _loc_16 = _loc_13 * _loc_3 - _loc_12 * _loc_4;
                _loc_17 = _loc_13 * _loc_5 - _loc_12 * _loc_6;
                _loc_18 = _loc_15 * _loc_7 - _loc_14 * _loc_8;
                _loc_19 = _loc_15 * _loc_9 - _loc_14 * _loc_10;
                _loc_21 = ratio * ratio;
                _loc_23 = b1.smass + b2.smass + _loc_21 * (b3.smass + b4.smass) + b1.sinertia * _loc_16 * _loc_16 + b2.sinertia * _loc_17 * _loc_17 + b3.sinertia * _loc_18 * _loc_18 + b4.sinertia * _loc_19 * _loc_19;
                if (b1 == b4)
                {
                    _loc_23 = _loc_23 - 2 * ((_loc_12 * _loc_14 + _loc_13 * _loc_15) * b1.smass + _loc_16 * _loc_19 * b1.sinertia);
                }
                if (b1 == b3)
                {
                    _loc_23 = _loc_23 + 2 * ((_loc_12 * _loc_14 + _loc_13 * _loc_15) * b1.smass + _loc_16 * _loc_18 * b1.sinertia);
                }
                if (b2 == b3)
                {
                    _loc_23 = _loc_23 - 2 * ((_loc_12 * _loc_14 + _loc_13 * _loc_15) * b2.smass + _loc_17 * _loc_18 * b2.sinertia);
                }
                if (b2 == b4)
                {
                    _loc_23 = _loc_23 + 2 * ((_loc_12 * _loc_14 + _loc_13 * _loc_15) * b2.smass + _loc_17 * _loc_19 * b2.sinertia);
                }
                _loc_20 = _loc_23;
                if (_loc_20 != 0)
                {
                    _loc_20 = 1 / _loc_20;
                }
                _loc_2 = (-_loc_1) * _loc_20;
                if (!equal)
                {
                }
                if (_loc_2 < 0)
                {
                    _loc_21 = b1.imass * _loc_2;
                    b1.posx = b1.posx - _loc_12 * _loc_21;
                    b1.posy = b1.posy - _loc_13 * _loc_21;
                    _loc_21 = b2.imass * _loc_2;
                    b2.posx = b2.posx + _loc_12 * _loc_21;
                    b2.posy = b2.posy + _loc_13 * _loc_21;
                    _loc_21 = b3.imass * _loc_2;
                    b3.posx = b3.posx - _loc_14 * _loc_21;
                    b3.posy = b3.posy - _loc_15 * _loc_21;
                    _loc_21 = b4.imass * _loc_2;
                    b4.posx = b4.posx + _loc_14 * _loc_21;
                    b4.posy = b4.posy + _loc_15 * _loc_21;
                    _loc_27 = b1;
                    _loc_21 = (-_loc_16) * b1.iinertia * _loc_2;
                    _loc_27.rot = _loc_27.rot + _loc_21;
                    if (_loc_21 * _loc_21 > 0.0001)
                    {
                        _loc_27.axisx = Math.sin(_loc_27.rot);
                        _loc_27.axisy = Math.cos(_loc_27.rot);
                    }
                    else
                    {
                        _loc_23 = _loc_21 * _loc_21;
                        _loc_24 = 1 - 0.5 * _loc_23;
                        _loc_25 = 1 - _loc_23 * _loc_23 / 8;
                        _loc_26 = (_loc_24 * _loc_27.axisx + _loc_21 * _loc_27.axisy) * _loc_25;
                        _loc_27.axisy = (_loc_24 * _loc_27.axisy - _loc_21 * _loc_27.axisx) * _loc_25;
                        _loc_27.axisx = _loc_26;
                    }
                    _loc_27 = b2;
                    _loc_21 = _loc_17 * b2.iinertia * _loc_2;
                    _loc_27.rot = _loc_27.rot + _loc_21;
                    if (_loc_21 * _loc_21 > 0.0001)
                    {
                        _loc_27.axisx = Math.sin(_loc_27.rot);
                        _loc_27.axisy = Math.cos(_loc_27.rot);
                    }
                    else
                    {
                        _loc_23 = _loc_21 * _loc_21;
                        _loc_24 = 1 - 0.5 * _loc_23;
                        _loc_25 = 1 - _loc_23 * _loc_23 / 8;
                        _loc_26 = (_loc_24 * _loc_27.axisx + _loc_21 * _loc_27.axisy) * _loc_25;
                        _loc_27.axisy = (_loc_24 * _loc_27.axisy - _loc_21 * _loc_27.axisx) * _loc_25;
                        _loc_27.axisx = _loc_26;
                    }
                    _loc_27 = b3;
                    _loc_21 = (-_loc_18) * b3.iinertia * _loc_2;
                    _loc_27.rot = _loc_27.rot + _loc_21;
                    if (_loc_21 * _loc_21 > 0.0001)
                    {
                        _loc_27.axisx = Math.sin(_loc_27.rot);
                        _loc_27.axisy = Math.cos(_loc_27.rot);
                    }
                    else
                    {
                        _loc_23 = _loc_21 * _loc_21;
                        _loc_24 = 1 - 0.5 * _loc_23;
                        _loc_25 = 1 - _loc_23 * _loc_23 / 8;
                        _loc_26 = (_loc_24 * _loc_27.axisx + _loc_21 * _loc_27.axisy) * _loc_25;
                        _loc_27.axisy = (_loc_24 * _loc_27.axisy - _loc_21 * _loc_27.axisx) * _loc_25;
                        _loc_27.axisx = _loc_26;
                    }
                    _loc_27 = b4;
                    _loc_21 = _loc_19 * b4.iinertia * _loc_2;
                    _loc_27.rot = _loc_27.rot + _loc_21;
                    if (_loc_21 * _loc_21 > 0.0001)
                    {
                        _loc_27.axisx = Math.sin(_loc_27.rot);
                        _loc_27.axisy = Math.cos(_loc_27.rot);
                    }
                    else
                    {
                        _loc_23 = _loc_21 * _loc_21;
                        _loc_24 = 1 - 0.5 * _loc_23;
                        _loc_25 = 1 - _loc_23 * _loc_23 / 8;
                        _loc_26 = (_loc_24 * _loc_27.axisx + _loc_21 * _loc_27.axisy) * _loc_25;
                        _loc_27.axisy = (_loc_24 * _loc_27.axisy - _loc_21 * _loc_27.axisx) * _loc_25;
                        _loc_27.axisx = _loc_26;
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
            if (b3 != b1)
            {
            }
            if (b3 != b2)
            {
                if (b3 != null)
                {
                    b3.constraints.add(this);
                }
            }
            if (b4 != b1)
            {
            }
            if (b4 != b2)
            {
            }
            if (b4 != b3)
            {
                if (b4 != null)
                {
                    b4.constraints.add(this);
                }
            }
            return;
        }// end function

    }
}
