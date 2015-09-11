package zpp_nape.constraint
{
    import __AS3__.vec.*;
    import flash.*;
    import nape.*;
    import nape.constraint.*;
    import nape.geom.*;
    import nape.util.*;
    import zpp_nape.geom.*;
    import zpp_nape.phys.*;
    import zpp_nape.space.*;
    import zpp_nape.util.*;

    public class ZPP_UserConstraint extends ZPP_Constraint
    {
        public var y:Vector.<Number>;
        public var velonly:Boolean;
        public var vec3:Vec3;
        public var stepped:Boolean;
        public var soft:Number;
        public var outer_zn:UserConstraint;
        public var jOld:Vector.<Number>;
        public var jMax:Number;
        public var jAcc:Vector.<Number>;
        public var gamma:Number;
        public var dim:int;
        public var bodies:Vector.<ZPP_UserBody>;
        public var bias:Vector.<Number>;
        public var L:Vector.<Number>;
        public var Keff:Vector.<Number>;
        public var J:Vector.<Number>;

        public function ZPP_UserConstraint(param1:int = 0, param2:Boolean = false) : void
        {
            var _loc_4:* = 0;
            var _loc_5:* = NaN;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            if (Boot.skip_constructor)
            {
                return;
            }
            jOld = null;
            J = null;
            vec3 = null;
            Keff = null;
            jMax = 0;
            velonly = false;
            gamma = 0;
            soft = 0;
            y = null;
            L = null;
            stepped = false;
            bias = null;
            jAcc = null;
            dim = 0;
            bodies = null;
            outer_zn = null;
            bodies = new Vector.<ZPP_UserBody>;
            dim = param1;
            velonly = param2;
            jAcc = new Vector.<Number>(param1, true);
            bias = new Vector.<Number>(param1, true);
            L = new Vector.<Number>(param1 * param1, true);
            J = new Vector.<Number>(param1, true);
            jOld = new Vector.<Number>(param1, true);
            y = new Vector.<Number>(param1, true);
            Keff = new Vector.<Number>(param1 * (param1 + 1) >>> 1, true);
            vec3 = Vec3.get(0, 0, 0);
            var _loc_3:* = 0;
            while (_loc_3 < param1)
            {
                
                _loc_3++;
                _loc_4 = _loc_3;
                _loc_5 = 0;
                y[_loc_4] = _loc_5;
                _loc_5 = _loc_5;
                jOld[_loc_4] = _loc_5;
                _loc_5 = _loc_5;
                J[_loc_4] = _loc_5;
                _loc_5 = _loc_5;
                bias[_loc_4] = _loc_5;
                jAcc[_loc_4] = _loc_5;
                _loc_6 = 0;
                while (_loc_6 < param1)
                {
                    
                    _loc_6++;
                    _loc_7 = _loc_6;
                    L[_loc_4 * param1 + _loc_7] = 0;
                }
            }
            stepped = false;
            return;
        }// end function

        override public function warmStart() : void
        {
            var _loc_3:* = null as ZPP_UserBody;
            var _loc_4:* = null as ZPP_Body;
            var _loc_5:* = NaN;
            var _loc_6:* = null as Vec3;
            var _loc_7:* = null as ZPP_Vec3;
            var _loc_1:* = 0;
            var _loc_2:* = bodies;
            while (_loc_1 < _loc_2.length)
            {
                
                _loc_3 = _loc_2[_loc_1];
                _loc_1++;
                _loc_4 = _loc_3.body;
                outer_zn.__impulse(jAcc, _loc_4.outer, vec3);
                _loc_5 = _loc_4.imass;
                _loc_6 = vec3;
                if (_loc_6 != null)
                {
                }
                if (_loc_6.zpp_disp)
                {
                    throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
                }
                _loc_7 = _loc_6.zpp_inner;
                if (_loc_7._validate != null)
                {
                    _loc_7._validate();
                }
                _loc_4.velx = _loc_4.velx + _loc_6.zpp_inner.x * _loc_5;
                _loc_6 = vec3;
                if (_loc_6 != null)
                {
                }
                if (_loc_6.zpp_disp)
                {
                    throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
                }
                _loc_7 = _loc_6.zpp_inner;
                if (_loc_7._validate != null)
                {
                    _loc_7._validate();
                }
                _loc_4.vely = _loc_4.vely + _loc_6.zpp_inner.y * _loc_5;
                _loc_6 = vec3;
                if (_loc_6 != null)
                {
                }
                if (_loc_6.zpp_disp)
                {
                    throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
                }
                _loc_7 = _loc_6.zpp_inner;
                if (_loc_7._validate != null)
                {
                    _loc_7._validate();
                }
                _loc_4.angvel = _loc_4.angvel + _loc_6.zpp_inner.z * _loc_4.iinertia;
            }
            return;
        }// end function

        override public function wake_connected() : void
        {
            var _loc_3:* = null as ZPP_UserBody;
            var _loc_1:* = 0;
            var _loc_2:* = bodies;
            while (_loc_1 < _loc_2.length)
            {
                
                _loc_3 = _loc_2[_loc_1];
                _loc_1++;
                if (_loc_3.body.type == ZPP_Flags.id_BodyType_DYNAMIC)
                {
                    _loc_3.body.wake();
                }
            }
            return;
        }// end function

        override public function validate() : void
        {
            var _loc_3:* = null as ZPP_UserBody;
            var _loc_1:* = 0;
            var _loc_2:* = bodies;
            while (_loc_1 < _loc_2.length)
            {
                
                _loc_3 = _loc_2[_loc_1];
                _loc_1++;
                if (_loc_3.body.space != space)
                {
                    throw "Error: Constraints must have each body within the same sapce to which the constraint has been assigned";
                }
            }
            outer_zn.__validate();
            return;
        }// end function

        public function transform(param1:Vector.<Number>, param2:Vector.<Number>) : void
        {
            var _loc_5:* = 0;
            var _loc_6:* = NaN;
            var _loc_7:* = NaN;
            var _loc_8:* = 0;
            var _loc_9:* = 0;
            var _loc_10:* = 0;
            var _loc_11:* = 0;
            var _loc_3:* = 0;
            var _loc_4:* = dim;
            while (_loc_3 < _loc_4)
            {
                
                _loc_3++;
                _loc_5 = _loc_3;
                _loc_6 = param2[_loc_5];
                _loc_7 = param1[_loc_5 * dim + _loc_5];
                if (_loc_7 != 0)
                {
                    _loc_8 = 0;
                    while (_loc_8 < _loc_5)
                    {
                        
                        _loc_8++;
                        _loc_9 = _loc_8;
                        _loc_6 = _loc_6 - param1[_loc_5 * dim + _loc_9] * y[_loc_9];
                    }
                    y[_loc_5] = _loc_6 / _loc_7;
                    continue;
                }
                y[_loc_5] = 0;
            }
            _loc_3 = 0;
            _loc_4 = dim;
            while (_loc_3 < _loc_4)
            {
                
                _loc_3++;
                _loc_5 = _loc_3;
                _loc_8 = (dim - 1) - _loc_5;
                _loc_6 = param1[_loc_8 * dim + _loc_8];
                if (_loc_6 != 0)
                {
                    _loc_7 = y[_loc_8];
                    _loc_9 = _loc_8 + 1;
                    _loc_10 = dim;
                    while (_loc_9 < _loc_10)
                    {
                        
                        _loc_9++;
                        _loc_11 = _loc_9;
                        _loc_7 = _loc_7 - param1[_loc_11 * dim + _loc_8] * param2[_loc_11];
                    }
                    param2[_loc_8] = _loc_7 / _loc_6;
                    continue;
                }
                param2[_loc_8] = 0;
            }
            return;
        }// end function

        public function solve(param1:Vector.<Number>) : Vector.<Number>
        {
            var _loc_5:* = 0;
            var _loc_6:* = NaN;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_9:* = 0;
            var _loc_10:* = NaN;
            var _loc_11:* = NaN;
            var _loc_12:* = 0;
            var _loc_13:* = 0;
            var _loc_14:* = 0;
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_4:* = dim;
            while (_loc_3 < _loc_4)
            {
                
                _loc_3++;
                _loc_5 = _loc_3;
                _loc_6 = 0;
                _loc_7 = 0;
                _loc_8 = _loc_5 - 1;
                while (_loc_7 < _loc_8)
                {
                    
                    _loc_7++;
                    _loc_9 = _loc_7;
                    _loc_6 = _loc_6 + L[_loc_5 * dim + _loc_9] * L[_loc_5 * dim + _loc_9];
                }
                _loc_2++;
                _loc_10 = Math.sqrt(param1[_loc_2] - _loc_6);
                L[_loc_5 * dim + _loc_5] = _loc_10;
                if (_loc_10 != 0)
                {
                    _loc_10 = 1 / _loc_10;
                    _loc_7 = _loc_5 + 1;
                    _loc_8 = dim;
                    while (_loc_7 < _loc_8)
                    {
                        
                        _loc_7++;
                        _loc_9 = _loc_7;
                        _loc_11 = 0;
                        _loc_12 = 0;
                        _loc_13 = _loc_5 - 1;
                        while (_loc_12 < _loc_13)
                        {
                            
                            _loc_12++;
                            _loc_14 = _loc_12;
                            _loc_11 = _loc_11 + L[_loc_9 * dim + _loc_14] * L[_loc_5 * dim + _loc_14];
                        }
                        _loc_2++;
                        L[_loc_9 * dim + _loc_5] = _loc_10 * (param1[_loc_2] - _loc_11);
                    }
                    continue;
                }
                _loc_7 = _loc_5 + 1;
                _loc_8 = dim;
                while (_loc_7 < _loc_8)
                {
                    
                    _loc_7++;
                    _loc_9 = _loc_7;
                    L[_loc_9 * dim + _loc_5] = 0;
                }
                _loc_2 = _loc_2 + (dim - _loc_5 - 1);
            }
            return L;
        }// end function

        public function remBody(param1:ZPP_Body) : Boolean
        {
            var _loc_5:* = null as ZPP_UserBody;
            var _loc_2:* = null;
            var _loc_3:* = bodies.length;
            var _loc_4:* = 0;
            while (_loc_4 < _loc_3)
            {
                
                _loc_5 = bodies[_loc_4];
                if (_loc_5.body == param1)
                {
                    (_loc_5.cnt - 1);
                    if (_loc_5.cnt == 0)
                    {
                        if (_loc_3 > 0)
                        {
                            bodies[_loc_4] = bodies[(_loc_3 - 1)];
                        }
                        bodies.pop();
                        if (active)
                        {
                        }
                        if (space != null)
                        {
                            if (param1 != null)
                            {
                                param1.constraints.remove(this);
                            }
                        }
                    }
                    _loc_2 = _loc_5;
                    break;
                }
                _loc_4++;
            }
            return _loc_2 != null;
        }// end function

        override public function preStep(param1:Number) : Boolean
        {
            var _loc_3:* = NaN;
            var _loc_4:* = NaN;
            var _loc_5:* = NaN;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_9:* = null as Vector.<Number>;
            if (pre_dt == -1)
            {
                pre_dt = param1;
            }
            var _loc_2:* = param1 / pre_dt;
            pre_dt = param1;
            stepped = true;
            outer_zn.__prepare();
            outer_zn.__eff_mass(Keff);
            L = solve(Keff);
            if (!stiff)
            {
            }
            if (!velonly)
            {
                _loc_4 = 2 * Math.PI * frequency;
                gamma = 1 / (param1 * _loc_4 * (2 * damping + _loc_4 * param1));
                _loc_5 = 1 / (1 + gamma);
                _loc_3 = param1 * _loc_4 * _loc_4 * gamma;
                gamma = gamma * _loc_5;
                soft = _loc_5;
                outer_zn.__position(bias);
                if (breakUnderError)
                {
                }
                if (lsq(bias) > maxError * maxError)
                {
                    return true;
                }
                _loc_6 = 0;
                _loc_7 = dim;
                while (_loc_6 < _loc_7)
                {
                    
                    _loc_6++;
                    _loc_8 = _loc_6;
                    _loc_9 = bias;
                    _loc_9[_loc_8] = _loc_9[_loc_8] * (-_loc_3);
                }
                _clamp(bias, maxError);
            }
            else
            {
                _loc_6 = 0;
                _loc_7 = dim;
                while (_loc_6 < _loc_7)
                {
                    
                    _loc_6++;
                    _loc_8 = _loc_6;
                    bias[_loc_8] = 0;
                }
                gamma = 0;
                soft = 1;
            }
            _loc_6 = 0;
            _loc_7 = dim;
            while (_loc_6 < _loc_7)
            {
                
                _loc_6++;
                _loc_8 = _loc_6;
                _loc_9 = jAcc;
                _loc_9[_loc_8] = _loc_9[_loc_8] * _loc_2;
            }
            jMax = maxForce * param1;
            return false;
        }// end function

        override public function pair_exists(param1:int, param2:int) : Boolean
        {
            var _loc_6:* = 0;
            var _loc_7:* = null as ZPP_Body;
            var _loc_8:* = 0;
            var _loc_9:* = 0;
            var _loc_10:* = null as ZPP_Body;
            var _loc_3:* = false;
            var _loc_4:* = bodies.length;
            var _loc_5:* = 0;
            while (_loc_5 < _loc_4)
            {
                
                _loc_5++;
                _loc_6 = _loc_5;
                _loc_7 = bodies[_loc_6].body;
                _loc_8 = _loc_6 + 1;
                while (_loc_8 < _loc_4)
                {
                    
                    _loc_8++;
                    _loc_9 = _loc_8;
                    _loc_10 = bodies[_loc_9].body;
                    if (_loc_7.id == param1)
                    {
                    }
                    if (_loc_10.id != param2)
                    {
                        if (_loc_7.id == param2)
                        {
                        }
                    }
                    if (_loc_10.id == param1)
                    {
                        _loc_3 = true;
                        break;
                    }
                }
                if (_loc_3)
                {
                    break;
                }
            }
            return _loc_3;
        }// end function

        public function lsq(param1:Vector.<Number>) : Number
        {
            var _loc_5:* = 0;
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_4:* = dim;
            while (_loc_3 < _loc_4)
            {
                
                _loc_3++;
                _loc_5 = _loc_3;
                _loc_2 = _loc_2 + param1[_loc_5] * param1[_loc_5];
            }
            return _loc_2;
        }// end function

        override public function inactiveBodies() : void
        {
            var _loc_3:* = null as ZPP_UserBody;
            var _loc_1:* = 0;
            var _loc_2:* = bodies;
            while (_loc_1 < _loc_2.length)
            {
                
                _loc_3 = _loc_2[_loc_1];
                _loc_1++;
                if (_loc_3.body != null)
                {
                    _loc_3.body.constraints.remove(this);
                }
            }
            return;
        }// end function

        override public function forest() : void
        {
            var _loc_3:* = null as ZPP_UserBody;
            var _loc_4:* = null as ZPP_Component;
            var _loc_5:* = null as ZPP_Component;
            var _loc_6:* = null as ZPP_Component;
            var _loc_7:* = null as ZPP_Component;
            var _loc_8:* = null as ZPP_Component;
            var _loc_1:* = 0;
            var _loc_2:* = bodies;
            while (_loc_1 < _loc_2.length)
            {
                
                _loc_3 = _loc_2[_loc_1];
                _loc_1++;
                if (_loc_3.body.type == ZPP_Flags.id_BodyType_DYNAMIC)
                {
                    if (_loc_3.body.component == _loc_3.body.component.parent)
                    {
                        _loc_4 = _loc_3.body.component;
                    }
                    else
                    {
                        _loc_5 = _loc_3.body.component;
                        _loc_6 = null;
                        while (_loc_5 != _loc_5.parent)
                        {
                            
                            _loc_7 = _loc_5.parent;
                            _loc_5.parent = _loc_6;
                            _loc_6 = _loc_5;
                            _loc_5 = _loc_7;
                        }
                        while (_loc_6 != null)
                        {
                            
                            _loc_7 = _loc_6.parent;
                            _loc_6.parent = _loc_5;
                            _loc_6 = _loc_7;
                        }
                        _loc_4 = _loc_5;
                    }
                    if (component == component.parent)
                    {
                        _loc_5 = component;
                    }
                    else
                    {
                        _loc_6 = component;
                        _loc_7 = null;
                        while (_loc_6 != _loc_6.parent)
                        {
                            
                            _loc_8 = _loc_6.parent;
                            _loc_6.parent = _loc_7;
                            _loc_7 = _loc_6;
                            _loc_6 = _loc_8;
                        }
                        while (_loc_7 != null)
                        {
                            
                            _loc_8 = _loc_7.parent;
                            _loc_7.parent = _loc_6;
                            _loc_7 = _loc_8;
                        }
                        _loc_5 = _loc_6;
                    }
                    if (_loc_4 != _loc_5)
                    {
                        if (_loc_4.rank < _loc_5.rank)
                        {
                            _loc_4.parent = _loc_5;
                            continue;
                        }
                        if (_loc_4.rank > _loc_5.rank)
                        {
                            _loc_5.parent = _loc_4;
                            continue;
                        }
                        _loc_5.parent = _loc_4;
                        (_loc_4.rank + 1);
                    }
                }
            }
            return;
        }// end function

        override public function draw(param1:Debug) : void
        {
            outer_zn.__draw(param1);
            return;
        }// end function

        override public function copy(param1:Array = undefined, param2:Array = undefined) : Constraint
        {
            var _loc_3:* = outer_zn.__copy();
            copyto(_loc_3);
            throw "not done yet";
            return _loc_3;
        }// end function

        override public function clearcache() : void
        {
            var _loc_3:* = 0;
            var _loc_1:* = 0;
            var _loc_2:* = dim;
            while (_loc_1 < _loc_2)
            {
                
                _loc_1++;
                _loc_3 = _loc_1;
                jAcc[_loc_3] = 0;
            }
            pre_dt = -1;
            return;
        }// end function

        override public function broken() : void
        {
            outer_zn.__broken();
            return;
        }// end function

        public function bodyImpulse(param1:ZPP_Body) : Vec3
        {
            var _loc_4:* = 0;
            var _loc_2:* = 0;
            var _loc_3:* = dim;
            while (_loc_2 < _loc_3)
            {
                
                _loc_2++;
                _loc_4 = _loc_2;
                J[_loc_4] = jAcc[_loc_4];
            }
            var _loc_5:* = Vec3.get(0, 0, 0);
            if (stepped)
            {
                outer_zn.__impulse(J, param1.outer, _loc_5);
            }
            return _loc_5;
        }// end function

        public function bindVec2_invalidate(param1:ZPP_Vec2) : void
        {
            outer_zn.__invalidate();
            return;
        }// end function

        override public function applyImpulseVel() : Boolean
        {
            var _loc_3:* = 0;
            var _loc_4:* = null as Vector.<Number>;
            var _loc_5:* = NaN;
            var _loc_7:* = null as ZPP_UserBody;
            var _loc_8:* = null as ZPP_Body;
            var _loc_9:* = null as Vec3;
            var _loc_10:* = null as ZPP_Vec3;
            outer_zn.__velocity(J);
            var _loc_1:* = 0;
            var _loc_2:* = dim;
            while (_loc_1 < _loc_2)
            {
                
                _loc_1++;
                _loc_3 = _loc_1;
                J[_loc_3] = bias[_loc_3] - J[_loc_3];
            }
            transform(L, J);
            _loc_1 = 0;
            _loc_2 = dim;
            while (_loc_1 < _loc_2)
            {
                
                _loc_1++;
                _loc_3 = _loc_1;
                jOld[_loc_3] = jAcc[_loc_3];
                _loc_4 = jAcc;
                _loc_5 = J[_loc_3] * soft - jAcc[_loc_3] * gamma;
                J[_loc_3] = _loc_5;
                _loc_4[_loc_3] = _loc_4[_loc_3] + _loc_5;
            }
            outer_zn.__clamp(jAcc);
            if (!breakUnderForce)
            {
            }
            if (!stiff)
            {
            }
            if (lsq(jAcc) > jMax * jMax)
            {
                if (breakUnderForce)
                {
                    return true;
                }
                else if (!stiff)
                {
                    _clamp(jAcc, jMax);
                }
            }
            _loc_1 = 0;
            _loc_2 = dim;
            while (_loc_1 < _loc_2)
            {
                
                _loc_1++;
                _loc_3 = _loc_1;
                J[_loc_3] = jAcc[_loc_3] - jOld[_loc_3];
            }
            _loc_1 = 0;
            var _loc_6:* = bodies;
            while (_loc_1 < _loc_6.length)
            {
                
                _loc_7 = _loc_6[_loc_1];
                _loc_1++;
                _loc_8 = _loc_7.body;
                outer_zn.__impulse(J, _loc_8.outer, vec3);
                _loc_5 = _loc_8.imass;
                _loc_9 = vec3;
                if (_loc_9 != null)
                {
                }
                if (_loc_9.zpp_disp)
                {
                    throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
                }
                _loc_10 = _loc_9.zpp_inner;
                if (_loc_10._validate != null)
                {
                    _loc_10._validate();
                }
                _loc_8.velx = _loc_8.velx + _loc_9.zpp_inner.x * _loc_5;
                _loc_9 = vec3;
                if (_loc_9 != null)
                {
                }
                if (_loc_9.zpp_disp)
                {
                    throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
                }
                _loc_10 = _loc_9.zpp_inner;
                if (_loc_10._validate != null)
                {
                    _loc_10._validate();
                }
                _loc_8.vely = _loc_8.vely + _loc_9.zpp_inner.y * _loc_5;
                _loc_9 = vec3;
                if (_loc_9 != null)
                {
                }
                if (_loc_9.zpp_disp)
                {
                    throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
                }
                _loc_10 = _loc_9.zpp_inner;
                if (_loc_10._validate != null)
                {
                    _loc_10._validate();
                }
                _loc_8.angvel = _loc_8.angvel + _loc_9.zpp_inner.z * _loc_8.iinertia;
            }
            return false;
        }// end function

        override public function applyImpulsePos() : Boolean
        {
            var _loc_4:* = 0;
            var _loc_5:* = null as Vector.<Number>;
            var _loc_7:* = null as ZPP_UserBody;
            var _loc_8:* = null as ZPP_Body;
            var _loc_9:* = NaN;
            var _loc_10:* = null as Vec3;
            var _loc_11:* = null as ZPP_Vec3;
            var _loc_12:* = NaN;
            var _loc_13:* = NaN;
            var _loc_14:* = NaN;
            var _loc_15:* = NaN;
            if (velonly)
            {
                return false;
            }
            outer_zn.__prepare();
            outer_zn.__position(J);
            var _loc_1:* = lsq(J);
            if (breakUnderError)
            {
            }
            if (_loc_1 > maxError * maxError)
            {
                return true;
            }
            else if (_loc_1 < Config.constraintLinearSlop * Config.constraintLinearSlop)
            {
                return false;
            }
            var _loc_2:* = 0;
            var _loc_3:* = dim;
            while (_loc_2 < _loc_3)
            {
                
                _loc_2++;
                _loc_4 = _loc_2;
                _loc_5 = J;
                _loc_5[_loc_4] = _loc_5[_loc_4] * -1;
            }
            outer_zn.__eff_mass(Keff);
            transform(solve(Keff), J);
            outer_zn.__clamp(J);
            _loc_2 = 0;
            var _loc_6:* = bodies;
            while (_loc_2 < _loc_6.length)
            {
                
                _loc_7 = _loc_6[_loc_2];
                _loc_2++;
                _loc_8 = _loc_7.body;
                outer_zn.__impulse(J, _loc_8.outer, vec3);
                _loc_9 = _loc_8.imass;
                _loc_10 = vec3;
                if (_loc_10 != null)
                {
                }
                if (_loc_10.zpp_disp)
                {
                    throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
                }
                _loc_11 = _loc_10.zpp_inner;
                if (_loc_11._validate != null)
                {
                    _loc_11._validate();
                }
                _loc_8.posx = _loc_8.posx + _loc_10.zpp_inner.x * _loc_9;
                _loc_10 = vec3;
                if (_loc_10 != null)
                {
                }
                if (_loc_10.zpp_disp)
                {
                    throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
                }
                _loc_11 = _loc_10.zpp_inner;
                if (_loc_11._validate != null)
                {
                    _loc_11._validate();
                }
                _loc_8.posy = _loc_8.posy + _loc_10.zpp_inner.y * _loc_9;
                _loc_10 = vec3;
                if (_loc_10 != null)
                {
                }
                if (_loc_10.zpp_disp)
                {
                    throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
                }
                _loc_11 = _loc_10.zpp_inner;
                if (_loc_11._validate != null)
                {
                    _loc_11._validate();
                }
                _loc_9 = _loc_10.zpp_inner.z * _loc_8.iinertia;
                _loc_8.rot = _loc_8.rot + _loc_9;
                if (_loc_9 * _loc_9 > 0.0001)
                {
                    _loc_8.axisx = Math.sin(_loc_8.rot);
                    _loc_8.axisy = Math.cos(_loc_8.rot);
                    continue;
                }
                _loc_12 = _loc_9 * _loc_9;
                _loc_13 = 1 - 0.5 * _loc_12;
                _loc_14 = 1 - _loc_12 * _loc_12 / 8;
                _loc_15 = (_loc_13 * _loc_8.axisx + _loc_9 * _loc_8.axisy) * _loc_14;
                _loc_8.axisy = (_loc_13 * _loc_8.axisy - _loc_9 * _loc_8.axisx) * _loc_14;
                _loc_8.axisx = _loc_15;
            }
            return false;
        }// end function

        public function addBody(param1:ZPP_Body) : void
        {
            var _loc_5:* = null as ZPP_UserBody;
            var _loc_2:* = null;
            var _loc_3:* = 0;
            var _loc_4:* = bodies;
            while (_loc_3 < _loc_4.length)
            {
                
                _loc_5 = _loc_4[_loc_3];
                _loc_3++;
                if (_loc_5.body == param1)
                {
                    _loc_2 = _loc_5;
                    break;
                }
            }
            if (_loc_2 == null)
            {
                bodies.push(new ZPP_UserBody(1, param1));
                if (active)
                {
                }
                if (space != null)
                {
                    if (param1 != null)
                    {
                        param1.constraints.add(this);
                    }
                }
            }
            else
            {
                (_loc_2.cnt + 1);
            }
            return;
        }// end function

        override public function activeBodies() : void
        {
            var _loc_3:* = null as ZPP_UserBody;
            var _loc_1:* = 0;
            var _loc_2:* = bodies;
            while (_loc_1 < _loc_2.length)
            {
                
                _loc_3 = _loc_2[_loc_1];
                _loc_1++;
                if (_loc_3.body != null)
                {
                    _loc_3.body.constraints.add(this);
                }
            }
            return;
        }// end function

        public function _clamp(param1:Vector.<Number>, param2:Number) : void
        {
            var _loc_4:* = NaN;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_3:* = lsq(param1);
            if (_loc_3 > param2 * param2)
            {
                _loc_4 = param2 / Math.sqrt(_loc_3);
                _loc_5 = 0;
                _loc_6 = dim;
                while (_loc_5 < _loc_6)
                {
                    
                    _loc_5++;
                    _loc_7 = _loc_5;
                    param1[_loc_7] = param1[_loc_7] * _loc_4;
                }
            }
            return;
        }// end function

    }
}
