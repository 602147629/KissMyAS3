package nape.dynamics
{
    import flash.*;
    import nape.geom.*;
    import nape.phys.*;
    import nape.shape.*;
    import zpp_nape.dynamics.*;
    import zpp_nape.geom.*;
    import zpp_nape.shape.*;
    import zpp_nape.util.*;

    final public class CollisionArbiter extends Arbiter
    {

        public function CollisionArbiter() : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            if (!ZPP_Arbiter.internal)
            {
                throw "Error: Cannot instantiate CollisionArbiter derp!";
            }
            return;
        }// end function

        override public function totalImpulse(param1:Body = undefined, param2:Boolean = false) : Vec3
        {
            var _loc_7:* = null as Vec3;
            var _loc_8:* = 0;
            var _loc_9:* = 0;
            var _loc_10:* = null as ZPP_Vec3;
            if (!zpp_inner.active)
            {
                throw "Error: Arbiter not currently in use";
            }
            if (param1 != null)
            {
                if (!zpp_inner.active)
                {
                    throw "Error: Arbiter not currently in use";
                }
            }
            if (param1 != (zpp_inner.ws1.id > zpp_inner.ws2.id ? (zpp_inner.b2.outer) : (zpp_inner.b1.outer)))
            {
                if (!zpp_inner.active)
                {
                    throw "Error: Arbiter not currently in use";
                }
            }
            if (param1 != (zpp_inner.ws1.id > zpp_inner.ws2.id ? (zpp_inner.b1.outer) : (zpp_inner.b2.outer)))
            {
                throw "Error: Arbiter does not relate to body";
            }
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = zpp_inner.colarb;
            if (param2)
            {
            }
            if (_loc_6.oc1.fresh)
            {
                _loc_7 = _loc_6.oc1.wrapper().totalImpulse(param1);
                _loc_8 = 1;
                _loc_9 = _loc_8;
                if (_loc_7 != null)
                {
                }
                if (_loc_7.zpp_disp)
                {
                    throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
                }
                _loc_10 = _loc_7.zpp_inner;
                if (_loc_10._validate != null)
                {
                    _loc_10._validate();
                }
                _loc_3 = _loc_3 + _loc_7.zpp_inner.x * _loc_9;
                if (_loc_7 != null)
                {
                }
                if (_loc_7.zpp_disp)
                {
                    throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
                }
                _loc_10 = _loc_7.zpp_inner;
                if (_loc_10._validate != null)
                {
                    _loc_10._validate();
                }
                _loc_4 = _loc_4 + _loc_7.zpp_inner.y * _loc_9;
                if (_loc_7 != null)
                {
                }
                if (_loc_7.zpp_disp)
                {
                    throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
                }
                _loc_10 = _loc_7.zpp_inner;
                if (_loc_10._validate != null)
                {
                    _loc_10._validate();
                }
                _loc_5 = _loc_5 + _loc_7.zpp_inner.z * _loc_8;
                _loc_7.dispose();
            }
            if (_loc_6.hc2)
            {
                if (param2)
                {
                }
                if (_loc_6.oc2.fresh)
                {
                    _loc_7 = _loc_6.oc2.wrapper().totalImpulse(param1);
                    _loc_8 = 1;
                    _loc_9 = _loc_8;
                    if (_loc_7 != null)
                    {
                    }
                    if (_loc_7.zpp_disp)
                    {
                        throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
                    }
                    _loc_10 = _loc_7.zpp_inner;
                    if (_loc_10._validate != null)
                    {
                        _loc_10._validate();
                    }
                    _loc_3 = _loc_3 + _loc_7.zpp_inner.x * _loc_9;
                    if (_loc_7 != null)
                    {
                    }
                    if (_loc_7.zpp_disp)
                    {
                        throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
                    }
                    _loc_10 = _loc_7.zpp_inner;
                    if (_loc_10._validate != null)
                    {
                        _loc_10._validate();
                    }
                    _loc_4 = _loc_4 + _loc_7.zpp_inner.y * _loc_9;
                    if (_loc_7 != null)
                    {
                    }
                    if (_loc_7.zpp_disp)
                    {
                        throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
                    }
                    _loc_10 = _loc_7.zpp_inner;
                    if (_loc_10._validate != null)
                    {
                        _loc_10._validate();
                    }
                    _loc_5 = _loc_5 + _loc_7.zpp_inner.z * _loc_8;
                    _loc_7.dispose();
                }
            }
            return Vec3.get(_loc_3, _loc_4, _loc_5);
        }// end function

        public function tangentImpulse(param1:Body = undefined, param2:Boolean = false) : Vec3
        {
            var _loc_7:* = null as Vec3;
            var _loc_8:* = 0;
            var _loc_9:* = 0;
            var _loc_10:* = null as ZPP_Vec3;
            if (!zpp_inner.active)
            {
                throw "Error: Arbiter not currently in use";
            }
            if (param1 != null)
            {
                if (!zpp_inner.active)
                {
                    throw "Error: Arbiter not currently in use";
                }
            }
            if (param1 != (zpp_inner.ws1.id > zpp_inner.ws2.id ? (zpp_inner.b2.outer) : (zpp_inner.b1.outer)))
            {
                if (!zpp_inner.active)
                {
                    throw "Error: Arbiter not currently in use";
                }
            }
            if (param1 != (zpp_inner.ws1.id > zpp_inner.ws2.id ? (zpp_inner.b1.outer) : (zpp_inner.b2.outer)))
            {
                throw "Error: Arbiter does not relate to body";
            }
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = zpp_inner.colarb;
            if (param2)
            {
            }
            if (_loc_6.oc1.fresh)
            {
                _loc_7 = _loc_6.oc1.wrapper().tangentImpulse(param1);
                _loc_8 = 1;
                _loc_9 = _loc_8;
                if (_loc_7 != null)
                {
                }
                if (_loc_7.zpp_disp)
                {
                    throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
                }
                _loc_10 = _loc_7.zpp_inner;
                if (_loc_10._validate != null)
                {
                    _loc_10._validate();
                }
                _loc_3 = _loc_3 + _loc_7.zpp_inner.x * _loc_9;
                if (_loc_7 != null)
                {
                }
                if (_loc_7.zpp_disp)
                {
                    throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
                }
                _loc_10 = _loc_7.zpp_inner;
                if (_loc_10._validate != null)
                {
                    _loc_10._validate();
                }
                _loc_4 = _loc_4 + _loc_7.zpp_inner.y * _loc_9;
                if (_loc_7 != null)
                {
                }
                if (_loc_7.zpp_disp)
                {
                    throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
                }
                _loc_10 = _loc_7.zpp_inner;
                if (_loc_10._validate != null)
                {
                    _loc_10._validate();
                }
                _loc_5 = _loc_5 + _loc_7.zpp_inner.z * _loc_8;
                _loc_7.dispose();
            }
            if (_loc_6.hc2)
            {
                if (param2)
                {
                }
                if (_loc_6.oc2.fresh)
                {
                    _loc_7 = _loc_6.oc2.wrapper().tangentImpulse(param1);
                    _loc_8 = 1;
                    _loc_9 = _loc_8;
                    if (_loc_7 != null)
                    {
                    }
                    if (_loc_7.zpp_disp)
                    {
                        throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
                    }
                    _loc_10 = _loc_7.zpp_inner;
                    if (_loc_10._validate != null)
                    {
                        _loc_10._validate();
                    }
                    _loc_3 = _loc_3 + _loc_7.zpp_inner.x * _loc_9;
                    if (_loc_7 != null)
                    {
                    }
                    if (_loc_7.zpp_disp)
                    {
                        throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
                    }
                    _loc_10 = _loc_7.zpp_inner;
                    if (_loc_10._validate != null)
                    {
                        _loc_10._validate();
                    }
                    _loc_4 = _loc_4 + _loc_7.zpp_inner.y * _loc_9;
                    if (_loc_7 != null)
                    {
                    }
                    if (_loc_7.zpp_disp)
                    {
                        throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
                    }
                    _loc_10 = _loc_7.zpp_inner;
                    if (_loc_10._validate != null)
                    {
                        _loc_10._validate();
                    }
                    _loc_5 = _loc_5 + _loc_7.zpp_inner.z * _loc_8;
                    _loc_7.dispose();
                }
            }
            return Vec3.get(_loc_3, _loc_4, _loc_5);
        }// end function

        public function set_staticFriction(param1:Number) : Number
        {
            var _loc_3:* = NaN;
            var _loc_4:* = 0;
            var _loc_5:* = NaN;
            if (!zpp_inner.colarb.mutable)
            {
                throw "Error: CollisionArbiter::" + "staticFriction" + " is only mutable during a pre-handler";
            }
            if (param1 != param1)
            {
                throw "Error: CollisionArbiter::" + "staticFriction" + " cannot be NaN";
            }
            if (param1 < 0)
            {
                throw "Error: CollisionArbiter::" + "staticFriction" + " cannot be negative";
            }
            var _loc_2:* = zpp_inner.colarb;
            _loc_2.stat_fric = param1;
            _loc_2.userdef_stat_fric = true;
            if (!zpp_inner.active)
            {
                throw "Error: Arbiter not currently in use";
            }
            _loc_2 = zpp_inner.colarb;
            if (_loc_2.invalidated)
            {
                _loc_2.invalidated = false;
                if (!_loc_2.userdef_restitution)
                {
                    if (_loc_2.s1.material.elasticity > -17899999999999994000000000000)
                    {
                    }
                    if (_loc_2.s2.material.elasticity <= -17899999999999994000000000000)
                    {
                        _loc_2.restitution = 0;
                    }
                    else
                    {
                        if (_loc_2.s1.material.elasticity < 17899999999999994000000000000)
                        {
                        }
                        if (_loc_2.s2.material.elasticity >= 17899999999999994000000000000)
                        {
                            _loc_2.restitution = 1;
                        }
                        else
                        {
                            _loc_2.restitution = (_loc_2.s1.material.elasticity + _loc_2.s2.material.elasticity) / 2;
                        }
                    }
                    if (_loc_2.restitution < 0)
                    {
                        _loc_2.restitution = 0;
                    }
                    if (_loc_2.restitution > 1)
                    {
                        _loc_2.restitution = 1;
                    }
                }
                if (!_loc_2.userdef_dyn_fric)
                {
                    _loc_3 = _loc_2.s1.material.dynamicFriction * _loc_2.s2.material.dynamicFriction;
                    if (_loc_3 == 0)
                    {
                        _loc_2.dyn_fric = 0;
                    }
                    else
                    {
                        _loc_4 = 1597463007 - (0 >> 1);
                        _loc_5 = 0;
                        _loc_4.dyn_fric = 0 / (_loc_5 * (1.5 - 0.5 * _loc_3 * _loc_5 * _loc_5));
                    }
                }
                if (!_loc_2.userdef_stat_fric)
                {
                    _loc_3 = _loc_2.s1.material.staticFriction * _loc_2.s2.material.staticFriction;
                    if (_loc_3 == 0)
                    {
                        _loc_2.stat_fric = 0;
                    }
                    else
                    {
                        _loc_4 = 1597463007 - (0 >> 1);
                        _loc_5 = 0;
                        _loc_4.stat_fric = 0 / (_loc_5 * (1.5 - 0.5 * _loc_3 * _loc_5 * _loc_5));
                    }
                }
                if (!_loc_2.userdef_rfric)
                {
                    _loc_3 = _loc_2.s1.material.rollingFriction * _loc_2.s2.material.rollingFriction;
                    if (_loc_3 == 0)
                    {
                        _loc_2.rfric = 0;
                    }
                    else
                    {
                        _loc_4 = 1597463007 - (0 >> 1);
                        _loc_5 = 0;
                        _loc_4.rfric = 0 / (_loc_5 * (1.5 - 0.5 * _loc_3 * _loc_5 * _loc_5));
                    }
                }
            }
            return _loc_2.stat_fric;
        }// end function

        public function set_rollingFriction(param1:Number) : Number
        {
            var _loc_3:* = NaN;
            var _loc_4:* = 0;
            var _loc_5:* = NaN;
            if (!zpp_inner.colarb.mutable)
            {
                throw "Error: CollisionArbiter::" + "rollingFriction" + " is only mutable during a pre-handler";
            }
            if (param1 != param1)
            {
                throw "Error: CollisionArbiter::" + "rollingFriction" + " cannot be NaN";
            }
            if (param1 < 0)
            {
                throw "Error: CollisionArbiter::" + "rollingFriction" + " cannot be negative";
            }
            var _loc_2:* = zpp_inner.colarb;
            _loc_2.rfric = param1;
            _loc_2.userdef_rfric = true;
            if (!zpp_inner.active)
            {
                throw "Error: Arbiter not currently in use";
            }
            _loc_2 = zpp_inner.colarb;
            if (_loc_2.invalidated)
            {
                _loc_2.invalidated = false;
                if (!_loc_2.userdef_restitution)
                {
                    if (_loc_2.s1.material.elasticity > -17899999999999994000000000000)
                    {
                    }
                    if (_loc_2.s2.material.elasticity <= -17899999999999994000000000000)
                    {
                        _loc_2.restitution = 0;
                    }
                    else
                    {
                        if (_loc_2.s1.material.elasticity < 17899999999999994000000000000)
                        {
                        }
                        if (_loc_2.s2.material.elasticity >= 17899999999999994000000000000)
                        {
                            _loc_2.restitution = 1;
                        }
                        else
                        {
                            _loc_2.restitution = (_loc_2.s1.material.elasticity + _loc_2.s2.material.elasticity) / 2;
                        }
                    }
                    if (_loc_2.restitution < 0)
                    {
                        _loc_2.restitution = 0;
                    }
                    if (_loc_2.restitution > 1)
                    {
                        _loc_2.restitution = 1;
                    }
                }
                if (!_loc_2.userdef_dyn_fric)
                {
                    _loc_3 = _loc_2.s1.material.dynamicFriction * _loc_2.s2.material.dynamicFriction;
                    if (_loc_3 == 0)
                    {
                        _loc_2.dyn_fric = 0;
                    }
                    else
                    {
                        _loc_4 = 1597463007 - (0 >> 1);
                        _loc_5 = 0;
                        _loc_4.dyn_fric = 0 / (_loc_5 * (1.5 - 0.5 * _loc_3 * _loc_5 * _loc_5));
                    }
                }
                if (!_loc_2.userdef_stat_fric)
                {
                    _loc_3 = _loc_2.s1.material.staticFriction * _loc_2.s2.material.staticFriction;
                    if (_loc_3 == 0)
                    {
                        _loc_2.stat_fric = 0;
                    }
                    else
                    {
                        _loc_4 = 1597463007 - (0 >> 1);
                        _loc_5 = 0;
                        _loc_4.stat_fric = 0 / (_loc_5 * (1.5 - 0.5 * _loc_3 * _loc_5 * _loc_5));
                    }
                }
                if (!_loc_2.userdef_rfric)
                {
                    _loc_3 = _loc_2.s1.material.rollingFriction * _loc_2.s2.material.rollingFriction;
                    if (_loc_3 == 0)
                    {
                        _loc_2.rfric = 0;
                    }
                    else
                    {
                        _loc_4 = 1597463007 - (0 >> 1);
                        _loc_5 = 0;
                        _loc_4.rfric = 0 / (_loc_5 * (1.5 - 0.5 * _loc_3 * _loc_5 * _loc_5));
                    }
                }
            }
            return _loc_2.rfric;
        }// end function

        public function set_elasticity(param1:Number) : Number
        {
            var _loc_3:* = NaN;
            var _loc_4:* = 0;
            var _loc_5:* = NaN;
            if (!zpp_inner.colarb.mutable)
            {
                throw "Error: CollisionArbiter::" + "elasticity" + " is only mutable during a pre-handler";
            }
            if (param1 != param1)
            {
                throw "Error: CollisionArbiter::" + "elasticity" + " cannot be NaN";
            }
            if (param1 < 0)
            {
                throw "Error: CollisionArbiter::" + "elasticity" + " cannot be negative";
            }
            var _loc_2:* = zpp_inner.colarb;
            _loc_2.restitution = param1;
            _loc_2.userdef_restitution = true;
            if (!zpp_inner.active)
            {
                throw "Error: Arbiter not currently in use";
            }
            _loc_2 = zpp_inner.colarb;
            if (_loc_2.invalidated)
            {
                _loc_2.invalidated = false;
                if (!_loc_2.userdef_restitution)
                {
                    if (_loc_2.s1.material.elasticity > -17899999999999994000000000000)
                    {
                    }
                    if (_loc_2.s2.material.elasticity <= -17899999999999994000000000000)
                    {
                        _loc_2.restitution = 0;
                    }
                    else
                    {
                        if (_loc_2.s1.material.elasticity < 17899999999999994000000000000)
                        {
                        }
                        if (_loc_2.s2.material.elasticity >= 17899999999999994000000000000)
                        {
                            _loc_2.restitution = 1;
                        }
                        else
                        {
                            _loc_2.restitution = (_loc_2.s1.material.elasticity + _loc_2.s2.material.elasticity) / 2;
                        }
                    }
                    if (_loc_2.restitution < 0)
                    {
                        _loc_2.restitution = 0;
                    }
                    if (_loc_2.restitution > 1)
                    {
                        _loc_2.restitution = 1;
                    }
                }
                if (!_loc_2.userdef_dyn_fric)
                {
                    _loc_3 = _loc_2.s1.material.dynamicFriction * _loc_2.s2.material.dynamicFriction;
                    if (_loc_3 == 0)
                    {
                        _loc_2.dyn_fric = 0;
                    }
                    else
                    {
                        _loc_4 = 1597463007 - (0 >> 1);
                        _loc_5 = 0;
                        _loc_4.dyn_fric = 0 / (_loc_5 * (1.5 - 0.5 * _loc_3 * _loc_5 * _loc_5));
                    }
                }
                if (!_loc_2.userdef_stat_fric)
                {
                    _loc_3 = _loc_2.s1.material.staticFriction * _loc_2.s2.material.staticFriction;
                    if (_loc_3 == 0)
                    {
                        _loc_2.stat_fric = 0;
                    }
                    else
                    {
                        _loc_4 = 1597463007 - (0 >> 1);
                        _loc_5 = 0;
                        _loc_4.stat_fric = 0 / (_loc_5 * (1.5 - 0.5 * _loc_3 * _loc_5 * _loc_5));
                    }
                }
                if (!_loc_2.userdef_rfric)
                {
                    _loc_3 = _loc_2.s1.material.rollingFriction * _loc_2.s2.material.rollingFriction;
                    if (_loc_3 == 0)
                    {
                        _loc_2.rfric = 0;
                    }
                    else
                    {
                        _loc_4 = 1597463007 - (0 >> 1);
                        _loc_5 = 0;
                        _loc_4.rfric = 0 / (_loc_5 * (1.5 - 0.5 * _loc_3 * _loc_5 * _loc_5));
                    }
                }
            }
            return _loc_2.restitution;
        }// end function

        public function set_dynamicFriction(param1:Number) : Number
        {
            var _loc_3:* = NaN;
            var _loc_4:* = 0;
            var _loc_5:* = NaN;
            if (!zpp_inner.colarb.mutable)
            {
                throw "Error: CollisionArbiter::" + "dynamicFriction" + " is only mutable during a pre-handler";
            }
            if (param1 != param1)
            {
                throw "Error: CollisionArbiter::" + "dynamicFriction" + " cannot be NaN";
            }
            if (param1 < 0)
            {
                throw "Error: CollisionArbiter::" + "dynamicFriction" + " cannot be negative";
            }
            var _loc_2:* = zpp_inner.colarb;
            _loc_2.dyn_fric = param1;
            _loc_2.userdef_dyn_fric = true;
            if (!zpp_inner.active)
            {
                throw "Error: Arbiter not currently in use";
            }
            _loc_2 = zpp_inner.colarb;
            if (_loc_2.invalidated)
            {
                _loc_2.invalidated = false;
                if (!_loc_2.userdef_restitution)
                {
                    if (_loc_2.s1.material.elasticity > -17899999999999994000000000000)
                    {
                    }
                    if (_loc_2.s2.material.elasticity <= -17899999999999994000000000000)
                    {
                        _loc_2.restitution = 0;
                    }
                    else
                    {
                        if (_loc_2.s1.material.elasticity < 17899999999999994000000000000)
                        {
                        }
                        if (_loc_2.s2.material.elasticity >= 17899999999999994000000000000)
                        {
                            _loc_2.restitution = 1;
                        }
                        else
                        {
                            _loc_2.restitution = (_loc_2.s1.material.elasticity + _loc_2.s2.material.elasticity) / 2;
                        }
                    }
                    if (_loc_2.restitution < 0)
                    {
                        _loc_2.restitution = 0;
                    }
                    if (_loc_2.restitution > 1)
                    {
                        _loc_2.restitution = 1;
                    }
                }
                if (!_loc_2.userdef_dyn_fric)
                {
                    _loc_3 = _loc_2.s1.material.dynamicFriction * _loc_2.s2.material.dynamicFriction;
                    if (_loc_3 == 0)
                    {
                        _loc_2.dyn_fric = 0;
                    }
                    else
                    {
                        _loc_4 = 1597463007 - (0 >> 1);
                        _loc_5 = 0;
                        _loc_4.dyn_fric = 0 / (_loc_5 * (1.5 - 0.5 * _loc_3 * _loc_5 * _loc_5));
                    }
                }
                if (!_loc_2.userdef_stat_fric)
                {
                    _loc_3 = _loc_2.s1.material.staticFriction * _loc_2.s2.material.staticFriction;
                    if (_loc_3 == 0)
                    {
                        _loc_2.stat_fric = 0;
                    }
                    else
                    {
                        _loc_4 = 1597463007 - (0 >> 1);
                        _loc_5 = 0;
                        _loc_4.stat_fric = 0 / (_loc_5 * (1.5 - 0.5 * _loc_3 * _loc_5 * _loc_5));
                    }
                }
                if (!_loc_2.userdef_rfric)
                {
                    _loc_3 = _loc_2.s1.material.rollingFriction * _loc_2.s2.material.rollingFriction;
                    if (_loc_3 == 0)
                    {
                        _loc_2.rfric = 0;
                    }
                    else
                    {
                        _loc_4 = 1597463007 - (0 >> 1);
                        _loc_5 = 0;
                        _loc_4.rfric = 0 / (_loc_5 * (1.5 - 0.5 * _loc_3 * _loc_5 * _loc_5));
                    }
                }
            }
            return _loc_2.dyn_fric;
        }// end function

        public function secondVertex() : Boolean
        {
            if (!zpp_inner.active)
            {
                throw "Error: Arbiter not currently in use";
            }
            var _loc_1:* = zpp_inner.colarb.__ref_edge1 != null != (zpp_inner.colarb.__ref_edge2 != null);
            if (_loc_1)
            {
                return zpp_inner.colarb.__ref_vertex == 1;
            }
            else
            {
                return false;
            }
        }// end function

        public function rollingImpulse(param1:Body = undefined, param2:Boolean = false) : Number
        {
            if (!zpp_inner.active)
            {
                throw "Error: Arbiter not currently in use";
            }
            if (param1 != null)
            {
                if (!zpp_inner.active)
                {
                    throw "Error: Arbiter not currently in use";
                }
            }
            if (param1 != (zpp_inner.ws1.id > zpp_inner.ws2.id ? (zpp_inner.b2.outer) : (zpp_inner.b1.outer)))
            {
                if (!zpp_inner.active)
                {
                    throw "Error: Arbiter not currently in use";
                }
            }
            if (param1 != (zpp_inner.ws1.id > zpp_inner.ws2.id ? (zpp_inner.b1.outer) : (zpp_inner.b2.outer)))
            {
                throw "Error: Arbiter does not relate to body";
            }
            var _loc_3:* = zpp_inner.colarb;
            if (param2)
            {
            }
            if (_loc_3.oc1.fresh)
            {
                return _loc_3.oc1.wrapper().rollingImpulse(param1);
            }
            else
            {
                return 0;
            }
        }// end function

        public function normalImpulse(param1:Body = undefined, param2:Boolean = false) : Vec3
        {
            var _loc_7:* = null as Vec3;
            var _loc_8:* = 0;
            var _loc_9:* = 0;
            var _loc_10:* = null as ZPP_Vec3;
            if (!zpp_inner.active)
            {
                throw "Error: Arbiter not currently in use";
            }
            if (param1 != null)
            {
                if (!zpp_inner.active)
                {
                    throw "Error: Arbiter not currently in use";
                }
            }
            if (param1 != (zpp_inner.ws1.id > zpp_inner.ws2.id ? (zpp_inner.b2.outer) : (zpp_inner.b1.outer)))
            {
                if (!zpp_inner.active)
                {
                    throw "Error: Arbiter not currently in use";
                }
            }
            if (param1 != (zpp_inner.ws1.id > zpp_inner.ws2.id ? (zpp_inner.b1.outer) : (zpp_inner.b2.outer)))
            {
                throw "Error: Arbiter does not relate to body";
            }
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = zpp_inner.colarb;
            if (param2)
            {
            }
            if (_loc_6.oc1.fresh)
            {
                _loc_7 = _loc_6.oc1.wrapper().normalImpulse(param1);
                _loc_8 = 1;
                _loc_9 = _loc_8;
                if (_loc_7 != null)
                {
                }
                if (_loc_7.zpp_disp)
                {
                    throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
                }
                _loc_10 = _loc_7.zpp_inner;
                if (_loc_10._validate != null)
                {
                    _loc_10._validate();
                }
                _loc_3 = _loc_3 + _loc_7.zpp_inner.x * _loc_9;
                if (_loc_7 != null)
                {
                }
                if (_loc_7.zpp_disp)
                {
                    throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
                }
                _loc_10 = _loc_7.zpp_inner;
                if (_loc_10._validate != null)
                {
                    _loc_10._validate();
                }
                _loc_4 = _loc_4 + _loc_7.zpp_inner.y * _loc_9;
                if (_loc_7 != null)
                {
                }
                if (_loc_7.zpp_disp)
                {
                    throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
                }
                _loc_10 = _loc_7.zpp_inner;
                if (_loc_10._validate != null)
                {
                    _loc_10._validate();
                }
                _loc_5 = _loc_5 + _loc_7.zpp_inner.z * _loc_8;
                _loc_7.dispose();
            }
            if (_loc_6.hc2)
            {
                if (param2)
                {
                }
                if (_loc_6.oc2.fresh)
                {
                    _loc_7 = _loc_6.oc2.wrapper().normalImpulse(param1);
                    _loc_8 = 1;
                    _loc_9 = _loc_8;
                    if (_loc_7 != null)
                    {
                    }
                    if (_loc_7.zpp_disp)
                    {
                        throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
                    }
                    _loc_10 = _loc_7.zpp_inner;
                    if (_loc_10._validate != null)
                    {
                        _loc_10._validate();
                    }
                    _loc_3 = _loc_3 + _loc_7.zpp_inner.x * _loc_9;
                    if (_loc_7 != null)
                    {
                    }
                    if (_loc_7.zpp_disp)
                    {
                        throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
                    }
                    _loc_10 = _loc_7.zpp_inner;
                    if (_loc_10._validate != null)
                    {
                        _loc_10._validate();
                    }
                    _loc_4 = _loc_4 + _loc_7.zpp_inner.y * _loc_9;
                    if (_loc_7 != null)
                    {
                    }
                    if (_loc_7.zpp_disp)
                    {
                        throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
                    }
                    _loc_10 = _loc_7.zpp_inner;
                    if (_loc_10._validate != null)
                    {
                        _loc_10._validate();
                    }
                    _loc_5 = _loc_5 + _loc_7.zpp_inner.z * _loc_8;
                    _loc_7.dispose();
                }
            }
            return Vec3.get(_loc_3, _loc_4, _loc_5);
        }// end function

        public function get_staticFriction() : Number
        {
            var _loc_2:* = NaN;
            var _loc_3:* = 0;
            var _loc_4:* = NaN;
            if (!zpp_inner.active)
            {
                throw "Error: Arbiter not currently in use";
            }
            var _loc_1:* = zpp_inner.colarb;
            if (_loc_1.invalidated)
            {
                _loc_1.invalidated = false;
                if (!_loc_1.userdef_restitution)
                {
                    if (_loc_1.s1.material.elasticity > -17899999999999994000000000000)
                    {
                    }
                    if (_loc_1.s2.material.elasticity <= -17899999999999994000000000000)
                    {
                        _loc_1.restitution = 0;
                    }
                    else
                    {
                        if (_loc_1.s1.material.elasticity < 17899999999999994000000000000)
                        {
                        }
                        if (_loc_1.s2.material.elasticity >= 17899999999999994000000000000)
                        {
                            _loc_1.restitution = 1;
                        }
                        else
                        {
                            _loc_1.restitution = (_loc_1.s1.material.elasticity + _loc_1.s2.material.elasticity) / 2;
                        }
                    }
                    if (_loc_1.restitution < 0)
                    {
                        _loc_1.restitution = 0;
                    }
                    if (_loc_1.restitution > 1)
                    {
                        _loc_1.restitution = 1;
                    }
                }
                if (!_loc_1.userdef_dyn_fric)
                {
                    _loc_2 = _loc_1.s1.material.dynamicFriction * _loc_1.s2.material.dynamicFriction;
                    if (_loc_2 == 0)
                    {
                        _loc_1.dyn_fric = 0;
                    }
                    else
                    {
                        _loc_3 = 1597463007 - (0 >> 1);
                        _loc_4 = 0;
                        _loc_3.dyn_fric = 0 / (_loc_4 * (1.5 - 0.5 * _loc_2 * _loc_4 * _loc_4));
                    }
                }
                if (!_loc_1.userdef_stat_fric)
                {
                    _loc_2 = _loc_1.s1.material.staticFriction * _loc_1.s2.material.staticFriction;
                    if (_loc_2 == 0)
                    {
                        _loc_1.stat_fric = 0;
                    }
                    else
                    {
                        _loc_3 = 1597463007 - (0 >> 1);
                        _loc_4 = 0;
                        _loc_3.stat_fric = 0 / (_loc_4 * (1.5 - 0.5 * _loc_2 * _loc_4 * _loc_4));
                    }
                }
                if (!_loc_1.userdef_rfric)
                {
                    _loc_2 = _loc_1.s1.material.rollingFriction * _loc_1.s2.material.rollingFriction;
                    if (_loc_2 == 0)
                    {
                        _loc_1.rfric = 0;
                    }
                    else
                    {
                        _loc_3 = 1597463007 - (0 >> 1);
                        _loc_4 = 0;
                        _loc_3.rfric = 0 / (_loc_4 * (1.5 - 0.5 * _loc_2 * _loc_4 * _loc_4));
                    }
                }
            }
            return _loc_1.stat_fric;
        }// end function

        public function get_rollingFriction() : Number
        {
            var _loc_2:* = NaN;
            var _loc_3:* = 0;
            var _loc_4:* = NaN;
            if (!zpp_inner.active)
            {
                throw "Error: Arbiter not currently in use";
            }
            var _loc_1:* = zpp_inner.colarb;
            if (_loc_1.invalidated)
            {
                _loc_1.invalidated = false;
                if (!_loc_1.userdef_restitution)
                {
                    if (_loc_1.s1.material.elasticity > -17899999999999994000000000000)
                    {
                    }
                    if (_loc_1.s2.material.elasticity <= -17899999999999994000000000000)
                    {
                        _loc_1.restitution = 0;
                    }
                    else
                    {
                        if (_loc_1.s1.material.elasticity < 17899999999999994000000000000)
                        {
                        }
                        if (_loc_1.s2.material.elasticity >= 17899999999999994000000000000)
                        {
                            _loc_1.restitution = 1;
                        }
                        else
                        {
                            _loc_1.restitution = (_loc_1.s1.material.elasticity + _loc_1.s2.material.elasticity) / 2;
                        }
                    }
                    if (_loc_1.restitution < 0)
                    {
                        _loc_1.restitution = 0;
                    }
                    if (_loc_1.restitution > 1)
                    {
                        _loc_1.restitution = 1;
                    }
                }
                if (!_loc_1.userdef_dyn_fric)
                {
                    _loc_2 = _loc_1.s1.material.dynamicFriction * _loc_1.s2.material.dynamicFriction;
                    if (_loc_2 == 0)
                    {
                        _loc_1.dyn_fric = 0;
                    }
                    else
                    {
                        _loc_3 = 1597463007 - (0 >> 1);
                        _loc_4 = 0;
                        _loc_3.dyn_fric = 0 / (_loc_4 * (1.5 - 0.5 * _loc_2 * _loc_4 * _loc_4));
                    }
                }
                if (!_loc_1.userdef_stat_fric)
                {
                    _loc_2 = _loc_1.s1.material.staticFriction * _loc_1.s2.material.staticFriction;
                    if (_loc_2 == 0)
                    {
                        _loc_1.stat_fric = 0;
                    }
                    else
                    {
                        _loc_3 = 1597463007 - (0 >> 1);
                        _loc_4 = 0;
                        _loc_3.stat_fric = 0 / (_loc_4 * (1.5 - 0.5 * _loc_2 * _loc_4 * _loc_4));
                    }
                }
                if (!_loc_1.userdef_rfric)
                {
                    _loc_2 = _loc_1.s1.material.rollingFriction * _loc_1.s2.material.rollingFriction;
                    if (_loc_2 == 0)
                    {
                        _loc_1.rfric = 0;
                    }
                    else
                    {
                        _loc_3 = 1597463007 - (0 >> 1);
                        _loc_4 = 0;
                        _loc_3.rfric = 0 / (_loc_4 * (1.5 - 0.5 * _loc_2 * _loc_4 * _loc_4));
                    }
                }
            }
            return _loc_1.rfric;
        }// end function

        public function get_referenceEdge2() : Edge
        {
            var _loc_2:* = null as Shape;
            if (!zpp_inner.active)
            {
                throw "Error: Arbiter not currently in use";
            }
            var _loc_1:* = zpp_inner.colarb.__ref_edge1;
            if (_loc_1 != null)
            {
                if (!zpp_inner.active)
                {
                    throw "Error: Arbiter not currently in use";
                }
                if (zpp_inner.ws1.id > zpp_inner.ws2.id)
                {
                    _loc_2 = zpp_inner.ws1.outer;
                }
                else
                {
                    _loc_2 = zpp_inner.ws2.outer;
                }
                if (_loc_2.zpp_inner.type == ZPP_Flags.id_ShapeType_POLYGON)
                {
                    if (!zpp_inner.active)
                    {
                        throw "Error: Arbiter not currently in use";
                    }
                }
            }
            if ((zpp_inner.ws1.id > zpp_inner.ws2.id ? (zpp_inner.ws1.outer) : (zpp_inner.ws2.outer)).zpp_inner != _loc_1.polygon)
            {
                _loc_1 = zpp_inner.colarb.__ref_edge2;
            }
            if (_loc_1 == null)
            {
                return null;
            }
            else
            {
                return _loc_1.wrapper();
            }
        }// end function

        public function get_referenceEdge1() : Edge
        {
            var _loc_2:* = null as Shape;
            if (!zpp_inner.active)
            {
                throw "Error: Arbiter not currently in use";
            }
            var _loc_1:* = zpp_inner.colarb.__ref_edge1;
            if (_loc_1 != null)
            {
                if (!zpp_inner.active)
                {
                    throw "Error: Arbiter not currently in use";
                }
                if (zpp_inner.ws1.id > zpp_inner.ws2.id)
                {
                    _loc_2 = zpp_inner.ws2.outer;
                }
                else
                {
                    _loc_2 = zpp_inner.ws1.outer;
                }
                if (_loc_2.zpp_inner.type == ZPP_Flags.id_ShapeType_POLYGON)
                {
                    if (!zpp_inner.active)
                    {
                        throw "Error: Arbiter not currently in use";
                    }
                }
            }
            if ((zpp_inner.ws1.id > zpp_inner.ws2.id ? (zpp_inner.ws2.outer) : (zpp_inner.ws1.outer)).zpp_inner != _loc_1.polygon)
            {
                _loc_1 = zpp_inner.colarb.__ref_edge2;
            }
            if (_loc_1 == null)
            {
                return null;
            }
            else
            {
                return _loc_1.wrapper();
            }
        }// end function

        public function get_radius() : Number
        {
            if (!zpp_inner.active)
            {
                throw "Error: Arbiter not currently in use";
            }
            return zpp_inner.colarb.radius;
        }// end function

        public function get_normal() : Vec2
        {
            if (!zpp_inner.active)
            {
                throw "Error: Arbiter not currently in use";
            }
            if (zpp_inner.colarb.wrap_normal == null)
            {
                zpp_inner.colarb.getnormal();
            }
            return zpp_inner.colarb.wrap_normal;
        }// end function

        public function get_elasticity() : Number
        {
            var _loc_2:* = NaN;
            var _loc_3:* = 0;
            var _loc_4:* = NaN;
            if (!zpp_inner.active)
            {
                throw "Error: Arbiter not currently in use";
            }
            var _loc_1:* = zpp_inner.colarb;
            if (_loc_1.invalidated)
            {
                _loc_1.invalidated = false;
                if (!_loc_1.userdef_restitution)
                {
                    if (_loc_1.s1.material.elasticity > -17899999999999994000000000000)
                    {
                    }
                    if (_loc_1.s2.material.elasticity <= -17899999999999994000000000000)
                    {
                        _loc_1.restitution = 0;
                    }
                    else
                    {
                        if (_loc_1.s1.material.elasticity < 17899999999999994000000000000)
                        {
                        }
                        if (_loc_1.s2.material.elasticity >= 17899999999999994000000000000)
                        {
                            _loc_1.restitution = 1;
                        }
                        else
                        {
                            _loc_1.restitution = (_loc_1.s1.material.elasticity + _loc_1.s2.material.elasticity) / 2;
                        }
                    }
                    if (_loc_1.restitution < 0)
                    {
                        _loc_1.restitution = 0;
                    }
                    if (_loc_1.restitution > 1)
                    {
                        _loc_1.restitution = 1;
                    }
                }
                if (!_loc_1.userdef_dyn_fric)
                {
                    _loc_2 = _loc_1.s1.material.dynamicFriction * _loc_1.s2.material.dynamicFriction;
                    if (_loc_2 == 0)
                    {
                        _loc_1.dyn_fric = 0;
                    }
                    else
                    {
                        _loc_3 = 1597463007 - (0 >> 1);
                        _loc_4 = 0;
                        _loc_3.dyn_fric = 0 / (_loc_4 * (1.5 - 0.5 * _loc_2 * _loc_4 * _loc_4));
                    }
                }
                if (!_loc_1.userdef_stat_fric)
                {
                    _loc_2 = _loc_1.s1.material.staticFriction * _loc_1.s2.material.staticFriction;
                    if (_loc_2 == 0)
                    {
                        _loc_1.stat_fric = 0;
                    }
                    else
                    {
                        _loc_3 = 1597463007 - (0 >> 1);
                        _loc_4 = 0;
                        _loc_3.stat_fric = 0 / (_loc_4 * (1.5 - 0.5 * _loc_2 * _loc_4 * _loc_4));
                    }
                }
                if (!_loc_1.userdef_rfric)
                {
                    _loc_2 = _loc_1.s1.material.rollingFriction * _loc_1.s2.material.rollingFriction;
                    if (_loc_2 == 0)
                    {
                        _loc_1.rfric = 0;
                    }
                    else
                    {
                        _loc_3 = 1597463007 - (0 >> 1);
                        _loc_4 = 0;
                        _loc_3.rfric = 0 / (_loc_4 * (1.5 - 0.5 * _loc_2 * _loc_4 * _loc_4));
                    }
                }
            }
            return _loc_1.restitution;
        }// end function

        public function get_dynamicFriction() : Number
        {
            var _loc_2:* = NaN;
            var _loc_3:* = 0;
            var _loc_4:* = NaN;
            if (!zpp_inner.active)
            {
                throw "Error: Arbiter not currently in use";
            }
            var _loc_1:* = zpp_inner.colarb;
            if (_loc_1.invalidated)
            {
                _loc_1.invalidated = false;
                if (!_loc_1.userdef_restitution)
                {
                    if (_loc_1.s1.material.elasticity > -17899999999999994000000000000)
                    {
                    }
                    if (_loc_1.s2.material.elasticity <= -17899999999999994000000000000)
                    {
                        _loc_1.restitution = 0;
                    }
                    else
                    {
                        if (_loc_1.s1.material.elasticity < 17899999999999994000000000000)
                        {
                        }
                        if (_loc_1.s2.material.elasticity >= 17899999999999994000000000000)
                        {
                            _loc_1.restitution = 1;
                        }
                        else
                        {
                            _loc_1.restitution = (_loc_1.s1.material.elasticity + _loc_1.s2.material.elasticity) / 2;
                        }
                    }
                    if (_loc_1.restitution < 0)
                    {
                        _loc_1.restitution = 0;
                    }
                    if (_loc_1.restitution > 1)
                    {
                        _loc_1.restitution = 1;
                    }
                }
                if (!_loc_1.userdef_dyn_fric)
                {
                    _loc_2 = _loc_1.s1.material.dynamicFriction * _loc_1.s2.material.dynamicFriction;
                    if (_loc_2 == 0)
                    {
                        _loc_1.dyn_fric = 0;
                    }
                    else
                    {
                        _loc_3 = 1597463007 - (0 >> 1);
                        _loc_4 = 0;
                        _loc_3.dyn_fric = 0 / (_loc_4 * (1.5 - 0.5 * _loc_2 * _loc_4 * _loc_4));
                    }
                }
                if (!_loc_1.userdef_stat_fric)
                {
                    _loc_2 = _loc_1.s1.material.staticFriction * _loc_1.s2.material.staticFriction;
                    if (_loc_2 == 0)
                    {
                        _loc_1.stat_fric = 0;
                    }
                    else
                    {
                        _loc_3 = 1597463007 - (0 >> 1);
                        _loc_4 = 0;
                        _loc_3.stat_fric = 0 / (_loc_4 * (1.5 - 0.5 * _loc_2 * _loc_4 * _loc_4));
                    }
                }
                if (!_loc_1.userdef_rfric)
                {
                    _loc_2 = _loc_1.s1.material.rollingFriction * _loc_1.s2.material.rollingFriction;
                    if (_loc_2 == 0)
                    {
                        _loc_1.rfric = 0;
                    }
                    else
                    {
                        _loc_3 = 1597463007 - (0 >> 1);
                        _loc_4 = 0;
                        _loc_3.rfric = 0 / (_loc_4 * (1.5 - 0.5 * _loc_2 * _loc_4 * _loc_4));
                    }
                }
            }
            return _loc_1.dyn_fric;
        }// end function

        public function get_contacts() : ContactList
        {
            if (!zpp_inner.active)
            {
                throw "Error: Arbiter not currently in use";
            }
            if (zpp_inner.colarb.wrap_contacts == null)
            {
                zpp_inner.colarb.setupcontacts();
            }
            return zpp_inner.colarb.wrap_contacts;
        }// end function

        public function firstVertex() : Boolean
        {
            if (!zpp_inner.active)
            {
                throw "Error: Arbiter not currently in use";
            }
            var _loc_1:* = zpp_inner.colarb.__ref_edge1 != null != (zpp_inner.colarb.__ref_edge2 != null);
            if (_loc_1)
            {
                return zpp_inner.colarb.__ref_vertex == -1;
            }
            else
            {
                return false;
            }
        }// end function

    }
}
