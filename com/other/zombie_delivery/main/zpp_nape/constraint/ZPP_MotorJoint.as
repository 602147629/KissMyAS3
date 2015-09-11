package zpp_nape.constraint
{
    import flash.*;
    import nape.constraint.*;
    import nape.geom.*;
    import nape.phys.*;
    import zpp_nape.phys.*;
    import zpp_nape.space.*;
    import zpp_nape.util.*;

    public class ZPP_MotorJoint extends ZPP_Constraint
    {
        public var stepped:Boolean;
        public var ratio:Number;
        public var rate:Number;
        public var outer_zn:MotorJoint;
        public var kMass:Number;
        public var jMax:Number;
        public var jAcc:Number;
        public var b2:ZPP_Body;
        public var b1:ZPP_Body;

        public function ZPP_MotorJoint() : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            stepped = false;
            jMax = 0;
            jAcc = 0;
            kMass = 0;
            b2 = null;
            b1 = null;
            rate = 0;
            ratio = 0;
            outer_zn = null;
            jAcc = 0;
            stepped = false;
            __velocity = true;
            return;
        }// end function

        override public function warmStart() : void
        {
            b1.angvel = b1.angvel - b1.iinertia * jAcc;
            b2.angvel = b2.angvel + ratio * b2.iinertia * jAcc;
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
                throw "Error: MotorJoint cannot be simulated with body1 == body2";
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

        override public function preStep(param1:Number) : Boolean
        {
            if (pre_dt == -1)
            {
                pre_dt = param1;
            }
            var _loc_2:* = param1 / pre_dt;
            pre_dt = param1;
            stepped = true;
            kMass = b1.sinertia + ratio * ratio * b2.sinertia;
            kMass = 1 / kMass;
            jAcc = jAcc * _loc_2;
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

        override public function copy(param1:Array = undefined, param2:Array = undefined) : Constraint
        {
            var _loc_3:* = null as Body;
            var _loc_4:* = 0;
            var _loc_5:* = null as ZPP_CopyHelper;
            var ret:* = new MotorJoint(null, null, rate, ratio);
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
            return;
        }// end function

        public function bodyImpulse(param1:ZPP_Body) : Vec3
        {
            if (stepped)
            {
                if (param1 == b1)
                {
                    return Vec3.get(0, 0, -jAcc);
                }
                else
                {
                    return Vec3.get(0, 0, ratio * jAcc);
                }
            }
            else
            {
                return Vec3.get(0, 0, 0);
            }
        }// end function

        override public function applyImpulseVel() : Boolean
        {
            var _loc_1:* = ratio * (b2.angvel + b2.kinangvel) - b1.angvel - b1.kinangvel - rate;
            var _loc_2:* = (-kMass) * _loc_1;
            var _loc_3:* = jAcc;
            jAcc = jAcc + _loc_2;
            if (breakUnderForce)
            {
                if (jAcc <= jMax)
                {
                }
                if (jAcc < -jMax)
                {
                    return true;
                }
            }
            else if (jAcc < -jMax)
            {
                jAcc = -jMax;
            }
            else if (jAcc > jMax)
            {
                jAcc = jMax;
            }
            _loc_2 = jAcc - _loc_3;
            b1.angvel = b1.angvel - b1.iinertia * _loc_2;
            b2.angvel = b2.angvel + ratio * b2.iinertia * _loc_2;
            return false;
        }// end function

        override public function applyImpulsePos() : Boolean
        {
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
