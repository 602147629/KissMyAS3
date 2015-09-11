package nape.constraint
{
    import __AS3__.vec.*;
    import flash.*;
    import nape.geom.*;
    import nape.phys.*;
    import nape.space.*;
    import nape.util.*;
    import zpp_nape.constraint.*;
    import zpp_nape.phys.*;
    import zpp_nape.space.*;

    public class UserConstraint extends Constraint
    {
        public var zpp_inner_zn:ZPP_UserConstraint;

        public function UserConstraint(param1:int = 0, param2:Boolean = false) : void
        {
            var _loc_4:* = null;
            if (Boot.skip_constructor)
            {
                return;
            }
            zpp_inner_zn = null;
            if (param1 < 1)
            {
                throw "Error: Constraint dimension must be at least 1";
            }
            zpp_inner_zn = new ZPP_UserConstraint(param1, param2);
            zpp_inner = zpp_inner_zn;
            zpp_inner.outer = this;
            zpp_inner_zn.outer_zn = this;
            ;
            _loc_4 = this;
            return;
        }// end function

        override public function visitBodies(param1:Function) : void
        {
            var _loc_4:* = null as ZPP_UserBody;
            var _loc_5:* = false;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = null as ZPP_UserBody;
            var _loc_2:* = 0;
            var _loc_3:* = zpp_inner_zn.bodies.length;
            while (_loc_2 < _loc_3)
            {
                
                _loc_4 = zpp_inner_zn.bodies[_loc_2];
                if (_loc_4.body != null)
                {
                    _loc_5 = false;
                    _loc_6 = _loc_2 + 1;
                    while (_loc_6 < _loc_3)
                    {
                        
                        _loc_6++;
                        _loc_7 = _loc_6;
                        _loc_8 = zpp_inner_zn.bodies[_loc_7];
                        if (_loc_8.body == _loc_4.body)
                        {
                            _loc_5 = true;
                            break;
                        }
                    }
                    if (!_loc_5)
                    {
                        this.param1(_loc_4.body.outer);
                    }
                }
                _loc_2++;
            }
            return;
        }// end function

        override public function impulse() : MatMN
        {
            var _loc_4:* = 0;
            var _loc_1:* = new MatMN(zpp_inner_zn.dim, 1);
            var _loc_2:* = 0;
            var _loc_3:* = zpp_inner_zn.dim;
            while (_loc_2 < _loc_3)
            {
                
                _loc_2++;
                _loc_4 = _loc_2;
                if (_loc_4 >= 0)
                {
                }
                if (_loc_4 < _loc_1.zpp_inner.m)
                {
                }
                if (_loc_1.zpp_inner.n <= 0)
                {
                    throw "Error: MatMN indices out of range";
                }
                _loc_1.zpp_inner.x[_loc_4 * _loc_1.zpp_inner.n] = zpp_inner_zn.jAcc[_loc_4];
            }
            return _loc_1;
        }// end function

        override public function bodyImpulse(param1:Body) : Vec3
        {
            var _loc_5:* = null as ZPP_UserBody;
            if (param1 == null)
            {
                throw "Error: Cannot evaluate impulse on null body";
            }
            var _loc_2:* = false;
            var _loc_3:* = 0;
            var _loc_4:* = zpp_inner_zn.bodies;
            while (_loc_3 < _loc_4.length)
            {
                
                _loc_5 = _loc_4[_loc_3];
                _loc_3++;
                if (_loc_5.body == param1.zpp_inner)
                {
                    _loc_2 = true;
                    break;
                }
            }
            if (!_loc_2)
            {
                throw "Error: Body is not linked to this constraint";
            }
            if (!zpp_inner.active)
            {
                return Vec3.get();
            }
            else
            {
                return zpp_inner_zn.bodyImpulse(param1.zpp_inner);
            }
        }// end function

        public function __velocity(param1:Vector.<Number>) : void
        {
            throw "Error: Userconstraint::__velocity must be overriden";
            return;
        }// end function

        public function __validate() : void
        {
            return;
        }// end function

        public function __registerBody(param1:Body, param2:Body) : Body
        {
            zpp_inner.immutable_midstep("UserConstraint::registerBody(..)");
            if (param1 != param2)
            {
                if (param1 != null)
                {
                    if (!zpp_inner_zn.remBody(param1.zpp_inner))
                    {
                        throw "Error: oldBody is not registered to the cosntraint";
                    }
                    if (zpp_inner.active)
                    {
                    }
                    if ((zpp_inner.space == null ? (null) : (zpp_inner.space.outer)) != null)
                    {
                        param1.zpp_inner.wake();
                    }
                }
                if (param2 != null)
                {
                    zpp_inner_zn.addBody(param2.zpp_inner);
                }
                zpp_inner.wake();
                if (param2 != null)
                {
                    param2.zpp_inner.wake();
                }
            }
            return param2;
        }// end function

        public function __prepare() : void
        {
            return;
        }// end function

        public function __position(param1:Vector.<Number>) : void
        {
            throw "Error: UserConstraint::__position must be overriden";
            return;
        }// end function

        public function __invalidate() : void
        {
            zpp_inner.immutable_midstep("UserConstraint::invalidate()");
            if (zpp_inner.active)
            {
            }
            if ((zpp_inner.space == null ? (null) : (zpp_inner.space.outer)) != null)
            {
                zpp_inner.wake();
            }
            return;
        }// end function

        public function __impulse(param1:Vector.<Number>, param2:Body, param3:Vec3) : void
        {
            throw "Error: UserConstraint::__impulse must be overriden";
            return;
        }// end function

        public function __eff_mass(param1:Vector.<Number>) : void
        {
            throw "Error: UserConstraint::__eff_mass must be overriden";
            return;
        }// end function

        public function __draw(param1:Debug) : void
        {
            return;
        }// end function

        public function __copy() : UserConstraint
        {
            throw "Error: UserConstraint::__copy must be overriden";
            return null;
        }// end function

        public function __clamp(param1:Vector.<Number>) : void
        {
            return;
        }// end function

        public function __broken() : void
        {
            return;
        }// end function

        public function __bindVec2() : Vec2
        {
            var _loc_1:* = new Vec2();
            _loc_1.zpp_inner._inuse = true;
            _loc_1.zpp_inner._invalidate = zpp_inner_zn.bindVec2_invalidate;
            return _loc_1;
        }// end function

    }
}
