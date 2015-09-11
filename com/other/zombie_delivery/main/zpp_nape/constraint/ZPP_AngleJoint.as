package zpp_nape.constraint
{
    import flash.*;
    import nape.constraint.*;
    import nape.geom.*;
    import nape.phys.*;
    import nape.space.*;
    import nape.util.*;
    import zpp_nape.phys.*;
    import zpp_nape.space.*;
    import zpp_nape.util.*;

    public class ZPP_AngleJoint extends ZPP_Constraint
    {
        public var stepped:Boolean;
        public var slack:Boolean;
        public var scale:Number;
        public var ratio:Number;
        public var outer_zn:AngleJoint;
        public var kMass:Number;
        public var jointMin:Number;
        public var jointMax:Number;
        public var jMax:Number;
        public var jAcc:Number;
        public var gamma:Number;
        public var equal:Boolean;
        public var bias:Number;
        public var b2:ZPP_Body;
        public var b1:ZPP_Body;

        public function ZPP_AngleJoint() : void
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
            b2 = null;
            b1 = null;
            scale = 0;
            equal = false;
            slack = false;
            jointMax = 0;
            jointMin = 0;
            ratio = 0;
            outer_zn = null;
            ratio = 1;
            jAcc = 0;
            slack = false;
            jMax = 17899999999999994000000000000;
            stepped = false;
            return;
        }// end function

        override public function warmStart() : void
        {
            if (!slack)
            {
                b1.angvel = b1.angvel - scale * b1.iinertia * jAcc;
                b2.angvel = b2.angvel + ratio * scale * b2.iinertia * jAcc;
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
                throw "Error: AngleJoint cannot be simulated with body1 == body2";
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
                throw "Error: AngleJoint must have jointMin <= jointMax";
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

        override public function preStep(param1:Number) : Boolean
        {
            var _loc_4:* = NaN;
            var _loc_5:* = NaN;
            var _loc_6:* = NaN;
            if (pre_dt == -1)
            {
                pre_dt = param1;
            }
            var _loc_2:* = param1 / pre_dt;
            pre_dt = param1;
            stepped = true;
            equal = jointMin == jointMax;
            _loc_4 = ratio * b2.rot - b1.rot;
            if (equal)
            {
                _loc_4 = _loc_4 - jointMax;
                slack = false;
                scale = 1;
            }
            else if (_loc_4 < jointMin)
            {
                _loc_4 = jointMin - _loc_4;
                scale = -1;
                slack = false;
            }
            else if (_loc_4 > jointMax)
            {
                _loc_4 = _loc_4 - jointMax;
                scale = 1;
                slack = false;
            }
            else
            {
                scale = 0;
                _loc_4 = 0;
                slack = true;
            }
            var _loc_3:* = _loc_4;
            if (!slack)
            {
                kMass = b1.sinertia + ratio * ratio * b2.sinertia;
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
            var _loc_2:* = ratio * b2.rot - b1.rot;
            if (equal)
            {
                _loc_2 = _loc_2 - jointMax;
                _loc_1 = false;
                scale = 1;
            }
            else if (_loc_2 < jointMin)
            {
                _loc_2 = jointMin - _loc_2;
                scale = -1;
                _loc_1 = false;
            }
            else if (_loc_2 > jointMax)
            {
                _loc_2 = _loc_2 - jointMax;
                scale = 1;
                _loc_1 = false;
            }
            else
            {
                scale = 0;
                _loc_2 = 0;
                _loc_1 = true;
            }
            return _loc_1;
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
            var _loc_5:* = null as Body;
            var _loc_6:* = NaN;
            var _loc_7:* = NaN;
            var _loc_8:* = NaN;
            var _loc_9:* = NaN;
            var _loc_10:* = NaN;
            var _loc_2:* = outer_zn;
            var _loc_3:* = 10;
            var _loc_4:* = 5 / Math.PI / 2;
            if (_loc_2.zpp_inner_zn.b1 == null)
            {
                _loc_5 = null;
            }
            else
            {
                _loc_5 = _loc_2.zpp_inner_zn.b1.outer;
            }
            if ((_loc_2.zpp_inner_zn.b1 == null ? (null) : (_loc_2.zpp_inner_zn.b1.outer)) != (_loc_5.zpp_inner.space == null ? (null) : (_loc_5.zpp_inner.space.outer)).zpp_inner.__static)
            {
                _loc_6 = _loc_2.zpp_inner_zn.ratio * (_loc_2.zpp_inner_zn.b2 == null ? (null) : (_loc_2.zpp_inner_zn.b2.outer)).zpp_inner.rot - jointMin;
                _loc_7 = _loc_2.zpp_inner_zn.ratio * (_loc_2.zpp_inner_zn.b2 == null ? (null) : (_loc_2.zpp_inner_zn.b2.outer)).zpp_inner.rot - jointMax;
                if (_loc_6 > _loc_7)
                {
                    _loc_8 = _loc_6;
                    _loc_6 = _loc_7;
                    _loc_7 = _loc_8;
                }
                if ((_loc_2.zpp_inner_zn.b1 == null ? (null) : (_loc_2.zpp_inner_zn.b1.outer)).zpp_inner.rot > _loc_6)
                {
                    _loc_9 = (_loc_2.zpp_inner_zn.b1 == null ? (null) : (_loc_2.zpp_inner_zn.b1.outer)).zpp_inner.rot;
                    _loc_10 = _loc_7;
                    if (_loc_9 < _loc_10)
                    {
                        _loc_8 = _loc_9;
                    }
                    else
                    {
                        _loc_8 = _loc_10;
                    }
                    if (_loc_2.zpp_inner_zn.b1 == null)
                    {
                        _loc_5 = null;
                    }
                    else
                    {
                        _loc_5 = _loc_2.zpp_inner_zn.b1.outer;
                    }
                    if (_loc_5.zpp_inner.wrap_pos == null)
                    {
                        _loc_5.zpp_inner.setupPosition();
                    }
                    ZPP_AngleDraw.drawSpiral(param1, _loc_5.zpp_inner.wrap_pos, _loc_6, _loc_8, _loc_3 + (_loc_6 - _loc_6) * _loc_4, _loc_3 + (_loc_8 - _loc_6) * _loc_4, 16776960);
                }
                else
                {
                    if (!stiff)
                    {
                    }
                    if ((_loc_2.zpp_inner_zn.b1 == null ? (null) : (_loc_2.zpp_inner_zn.b1.outer)).zpp_inner.rot < _loc_6)
                    {
                        if (_loc_2.zpp_inner_zn.b1 == null)
                        {
                            _loc_5 = null;
                        }
                        else
                        {
                            _loc_5 = _loc_2.zpp_inner_zn.b1.outer;
                        }
                        if (_loc_5.zpp_inner.wrap_pos == null)
                        {
                            _loc_5.zpp_inner.setupPosition();
                        }
                        ZPP_AngleDraw.drawSpiralSpring(param1, _loc_5.zpp_inner.wrap_pos, (_loc_2.zpp_inner_zn.b1 == null ? (null) : (_loc_2.zpp_inner_zn.b1.outer)).zpp_inner.rot, _loc_6, _loc_3 + ((_loc_2.zpp_inner_zn.b1 == null ? (null) : (_loc_2.zpp_inner_zn.b1.outer)).zpp_inner.rot - _loc_6) * _loc_4, _loc_3 + (_loc_6 - _loc_6) * _loc_4, 16776960);
                    }
                }
                if ((_loc_2.zpp_inner_zn.b1 == null ? (null) : (_loc_2.zpp_inner_zn.b1.outer)).zpp_inner.rot < _loc_7)
                {
                    _loc_9 = (_loc_2.zpp_inner_zn.b1 == null ? (null) : (_loc_2.zpp_inner_zn.b1.outer)).zpp_inner.rot;
                    _loc_10 = _loc_6;
                    if (_loc_9 > _loc_10)
                    {
                        _loc_8 = _loc_9;
                    }
                    else
                    {
                        _loc_8 = _loc_10;
                    }
                    if (_loc_2.zpp_inner_zn.b1 == null)
                    {
                        _loc_5 = null;
                    }
                    else
                    {
                        _loc_5 = _loc_2.zpp_inner_zn.b1.outer;
                    }
                    if (_loc_5.zpp_inner.wrap_pos == null)
                    {
                        _loc_5.zpp_inner.setupPosition();
                    }
                    ZPP_AngleDraw.drawSpiral(param1, _loc_5.zpp_inner.wrap_pos, _loc_8, _loc_7, _loc_3 + (_loc_8 - _loc_6) * _loc_4, _loc_3 + (_loc_7 - _loc_6) * _loc_4, 65535);
                }
                else
                {
                    if (!stiff)
                    {
                    }
                    if ((_loc_2.zpp_inner_zn.b1 == null ? (null) : (_loc_2.zpp_inner_zn.b1.outer)).zpp_inner.rot > _loc_7)
                    {
                        if (_loc_2.zpp_inner_zn.b1 == null)
                        {
                            _loc_5 = null;
                        }
                        else
                        {
                            _loc_5 = _loc_2.zpp_inner_zn.b1.outer;
                        }
                        if (_loc_5.zpp_inner.wrap_pos == null)
                        {
                            _loc_5.zpp_inner.setupPosition();
                        }
                        ZPP_AngleDraw.drawSpiralSpring(param1, _loc_5.zpp_inner.wrap_pos, (_loc_2.zpp_inner_zn.b1 == null ? (null) : (_loc_2.zpp_inner_zn.b1.outer)).zpp_inner.rot, _loc_7, _loc_3 + ((_loc_2.zpp_inner_zn.b1 == null ? (null) : (_loc_2.zpp_inner_zn.b1.outer)).zpp_inner.rot - _loc_6) * _loc_4, _loc_3 + (_loc_7 - _loc_6) * _loc_4, 65535);
                    }
                }
                if (_loc_2.zpp_inner_zn.b1 == null)
                {
                    _loc_5 = null;
                }
                else
                {
                    _loc_5 = _loc_2.zpp_inner_zn.b1.outer;
                }
                if (_loc_5.zpp_inner.wrap_pos == null)
                {
                    _loc_5.zpp_inner.setupPosition();
                }
                ZPP_AngleDraw.indicator(param1, _loc_5.zpp_inner.wrap_pos, (_loc_2.zpp_inner_zn.b1 == null ? (null) : (_loc_2.zpp_inner_zn.b1.outer)).zpp_inner.rot, _loc_3 + ((_loc_2.zpp_inner_zn.b1 == null ? (null) : (_loc_2.zpp_inner_zn.b1.outer)).zpp_inner.rot - _loc_6) * _loc_4, 255);
            }
            if (_loc_2.zpp_inner_zn.b2 == null)
            {
                _loc_5 = null;
            }
            else
            {
                _loc_5 = _loc_2.zpp_inner_zn.b2.outer;
            }
            if ((_loc_2.zpp_inner_zn.b2 == null ? (null) : (_loc_2.zpp_inner_zn.b2.outer)) != (_loc_5.zpp_inner.space == null ? (null) : (_loc_5.zpp_inner.space.outer)).zpp_inner.__static)
            {
                _loc_6 = (jointMin + (_loc_2.zpp_inner_zn.b1 == null ? (null) : (_loc_2.zpp_inner_zn.b1.outer)).zpp_inner.rot) / _loc_2.zpp_inner_zn.ratio;
                _loc_7 = (jointMax + (_loc_2.zpp_inner_zn.b1 == null ? (null) : (_loc_2.zpp_inner_zn.b1.outer)).zpp_inner.rot) / _loc_2.zpp_inner_zn.ratio;
                if (_loc_6 > _loc_7)
                {
                    _loc_8 = _loc_6;
                    _loc_6 = _loc_7;
                    _loc_7 = _loc_8;
                }
                if ((_loc_2.zpp_inner_zn.b2 == null ? (null) : (_loc_2.zpp_inner_zn.b2.outer)).zpp_inner.rot > _loc_6)
                {
                    _loc_9 = (_loc_2.zpp_inner_zn.b2 == null ? (null) : (_loc_2.zpp_inner_zn.b2.outer)).zpp_inner.rot;
                    _loc_10 = _loc_7;
                    if (_loc_9 < _loc_10)
                    {
                        _loc_8 = _loc_9;
                    }
                    else
                    {
                        _loc_8 = _loc_10;
                    }
                    if (_loc_2.zpp_inner_zn.b2 == null)
                    {
                        _loc_5 = null;
                    }
                    else
                    {
                        _loc_5 = _loc_2.zpp_inner_zn.b2.outer;
                    }
                    if (_loc_5.zpp_inner.wrap_pos == null)
                    {
                        _loc_5.zpp_inner.setupPosition();
                    }
                    ZPP_AngleDraw.drawSpiral(param1, _loc_5.zpp_inner.wrap_pos, _loc_6, _loc_8, _loc_3 + (_loc_6 - _loc_6) * _loc_4, _loc_3 + (_loc_8 - _loc_6) * _loc_4, 16776960);
                }
                else
                {
                    if (!stiff)
                    {
                    }
                    if ((_loc_2.zpp_inner_zn.b2 == null ? (null) : (_loc_2.zpp_inner_zn.b2.outer)).zpp_inner.rot < _loc_6)
                    {
                        if (_loc_2.zpp_inner_zn.b2 == null)
                        {
                            _loc_5 = null;
                        }
                        else
                        {
                            _loc_5 = _loc_2.zpp_inner_zn.b2.outer;
                        }
                        if (_loc_5.zpp_inner.wrap_pos == null)
                        {
                            _loc_5.zpp_inner.setupPosition();
                        }
                        ZPP_AngleDraw.drawSpiralSpring(param1, _loc_5.zpp_inner.wrap_pos, (_loc_2.zpp_inner_zn.b2 == null ? (null) : (_loc_2.zpp_inner_zn.b2.outer)).zpp_inner.rot, _loc_6, _loc_3 + ((_loc_2.zpp_inner_zn.b2 == null ? (null) : (_loc_2.zpp_inner_zn.b2.outer)).zpp_inner.rot - _loc_6) * _loc_4, _loc_3 + (_loc_6 - _loc_6) * _loc_4, 16776960);
                    }
                }
                if ((_loc_2.zpp_inner_zn.b2 == null ? (null) : (_loc_2.zpp_inner_zn.b2.outer)).zpp_inner.rot < _loc_7)
                {
                    _loc_9 = (_loc_2.zpp_inner_zn.b2 == null ? (null) : (_loc_2.zpp_inner_zn.b2.outer)).zpp_inner.rot;
                    _loc_10 = _loc_6;
                    if (_loc_9 > _loc_10)
                    {
                        _loc_8 = _loc_9;
                    }
                    else
                    {
                        _loc_8 = _loc_10;
                    }
                    if (_loc_2.zpp_inner_zn.b2 == null)
                    {
                        _loc_5 = null;
                    }
                    else
                    {
                        _loc_5 = _loc_2.zpp_inner_zn.b2.outer;
                    }
                    if (_loc_5.zpp_inner.wrap_pos == null)
                    {
                        _loc_5.zpp_inner.setupPosition();
                    }
                    ZPP_AngleDraw.drawSpiral(param1, _loc_5.zpp_inner.wrap_pos, _loc_8, _loc_7, _loc_3 + (_loc_8 - _loc_6) * _loc_4, _loc_3 + (_loc_7 - _loc_6) * _loc_4, 65535);
                }
                else
                {
                    if (!stiff)
                    {
                    }
                    if ((_loc_2.zpp_inner_zn.b2 == null ? (null) : (_loc_2.zpp_inner_zn.b2.outer)).zpp_inner.rot > _loc_7)
                    {
                        if (_loc_2.zpp_inner_zn.b2 == null)
                        {
                            _loc_5 = null;
                        }
                        else
                        {
                            _loc_5 = _loc_2.zpp_inner_zn.b2.outer;
                        }
                        if (_loc_5.zpp_inner.wrap_pos == null)
                        {
                            _loc_5.zpp_inner.setupPosition();
                        }
                        ZPP_AngleDraw.drawSpiralSpring(param1, _loc_5.zpp_inner.wrap_pos, (_loc_2.zpp_inner_zn.b2 == null ? (null) : (_loc_2.zpp_inner_zn.b2.outer)).zpp_inner.rot, _loc_7, _loc_3 + ((_loc_2.zpp_inner_zn.b2 == null ? (null) : (_loc_2.zpp_inner_zn.b2.outer)).zpp_inner.rot - _loc_6) * _loc_4, _loc_3 + (_loc_7 - _loc_6) * _loc_4, 65535);
                    }
                }
                if (_loc_2.zpp_inner_zn.b2 == null)
                {
                    _loc_5 = null;
                }
                else
                {
                    _loc_5 = _loc_2.zpp_inner_zn.b2.outer;
                }
                if (_loc_5.zpp_inner.wrap_pos == null)
                {
                    _loc_5.zpp_inner.setupPosition();
                }
                ZPP_AngleDraw.indicator(param1, _loc_5.zpp_inner.wrap_pos, (_loc_2.zpp_inner_zn.b2 == null ? (null) : (_loc_2.zpp_inner_zn.b2.outer)).zpp_inner.rot, _loc_3 + ((_loc_2.zpp_inner_zn.b2 == null ? (null) : (_loc_2.zpp_inner_zn.b2.outer)).zpp_inner.rot - _loc_6) * _loc_4, 16711680);
            }
            return;
        }// end function

        override public function copy(param1:Array = undefined, param2:Array = undefined) : Constraint
        {
            var _loc_3:* = null as Body;
            var _loc_4:* = 0;
            var _loc_5:* = null as ZPP_CopyHelper;
            var ret:* = new AngleJoint(null, null, jointMin, jointMax, ratio);
            copyto(ret);
            if (param1 != null)
            {
            }
            if (b1 != null)
            {
                _loc_3 = null;
                _loc_4 = 0;
                while (_loc_4 < param1.length)
                {
                    
                    _loc_5 = param1[_loc_4];
                    _loc_4++;
                    if (_loc_5.id == b1.id)
                    {
                        _loc_3 = _loc_5.bc;
                        break;
                    }
                }
                if (_loc_3 != null)
                {
                    ret.zpp_inner_zn.b1 = _loc_3.zpp_inner;
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
                _loc_3 = null;
                _loc_4 = 0;
                while (_loc_4 < param1.length)
                {
                    
                    _loc_5 = param1[_loc_4];
                    _loc_4++;
                    if (_loc_5.id == b2.id)
                    {
                        _loc_3 = _loc_5.bc;
                        break;
                    }
                }
                if (_loc_3 != null)
                {
                    ret.zpp_inner_zn.b2 = _loc_3.zpp_inner;
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
            slack = false;
            return;
        }// end function

        public function bodyImpulse(param1:ZPP_Body) : Vec3
        {
            if (stepped)
            {
                if (param1 == b1)
                {
                    return Vec3.get(0, 0, (-scale) * jAcc);
                }
                else
                {
                    return Vec3.get(0, 0, ratio * scale * jAcc);
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
            var _loc_1:* = scale * (ratio * (b2.angvel + b2.kinangvel) - b1.angvel - b1.kinangvel);
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
                if (jAcc <= jMax)
                {
                }
            }
            if (jAcc < -jMax)
            {
                return true;
            }
            if (!stiff)
            {
                if (jAcc > jMax)
                {
                    jAcc = jMax;
                }
                else if (jAcc < -jMax)
                {
                    jAcc = -jMax;
                }
            }
            _loc_2 = jAcc - _loc_3;
            b1.angvel = b1.angvel - scale * b1.iinertia * _loc_2;
            b2.angvel = b2.angvel + ratio * scale * b2.iinertia * _loc_2;
            return false;
        }// end function

        override public function applyImpulsePos() : Boolean
        {
            var _loc_2:* = NaN;
            var _loc_3:* = false;
            var _loc_4:* = NaN;
            var _loc_5:* = null as ZPP_Body;
            var _loc_6:* = NaN;
            var _loc_7:* = NaN;
            var _loc_8:* = NaN;
            var _loc_9:* = NaN;
            _loc_4 = ratio * b2.rot - b1.rot;
            if (equal)
            {
                _loc_4 = _loc_4 - jointMax;
                _loc_3 = false;
                scale = 1;
            }
            else if (_loc_4 < jointMin)
            {
                _loc_4 = jointMin - _loc_4;
                scale = -1;
                _loc_3 = false;
            }
            else if (_loc_4 > jointMax)
            {
                _loc_4 = _loc_4 - jointMax;
                scale = 1;
                _loc_3 = false;
            }
            else
            {
                scale = 0;
                _loc_4 = 0;
                _loc_3 = true;
            }
            var _loc_1:* = _loc_4;
            if (!_loc_3)
            {
                if (breakUnderError)
                {
                }
                if (_loc_1 * _loc_1 > maxError * maxError)
                {
                    return true;
                }
                _loc_1 = _loc_1 * 0.5;
                _loc_2 = (-_loc_1) * kMass;
                if (!equal)
                {
                }
                if (_loc_2 < 0)
                {
                    _loc_5 = b1;
                    _loc_4 = (-scale) * _loc_2 * b1.iinertia;
                    _loc_5.rot = _loc_5.rot + _loc_4;
                    if (_loc_4 * _loc_4 > 0.0001)
                    {
                        _loc_5.axisx = Math.sin(_loc_5.rot);
                        _loc_5.axisy = Math.cos(_loc_5.rot);
                    }
                    else
                    {
                        _loc_6 = _loc_4 * _loc_4;
                        _loc_7 = 1 - 0.5 * _loc_6;
                        _loc_8 = 1 - _loc_6 * _loc_6 / 8;
                        _loc_9 = (_loc_7 * _loc_5.axisx + _loc_4 * _loc_5.axisy) * _loc_8;
                        _loc_5.axisy = (_loc_7 * _loc_5.axisy - _loc_4 * _loc_5.axisx) * _loc_8;
                        _loc_5.axisx = _loc_9;
                    }
                    _loc_5 = b2;
                    _loc_4 = ratio * scale * _loc_2 * b2.iinertia;
                    _loc_5.rot = _loc_5.rot + _loc_4;
                    if (_loc_4 * _loc_4 > 0.0001)
                    {
                        _loc_5.axisx = Math.sin(_loc_5.rot);
                        _loc_5.axisy = Math.cos(_loc_5.rot);
                    }
                    else
                    {
                        _loc_6 = _loc_4 * _loc_4;
                        _loc_7 = 1 - 0.5 * _loc_6;
                        _loc_8 = 1 - _loc_6 * _loc_6 / 8;
                        _loc_9 = (_loc_7 * _loc_5.axisx + _loc_4 * _loc_5.axisy) * _loc_8;
                        _loc_5.axisy = (_loc_7 * _loc_5.axisy - _loc_4 * _loc_5.axisx) * _loc_8;
                        _loc_5.axisx = _loc_9;
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
