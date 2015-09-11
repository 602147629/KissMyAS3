package nape.phys
{
    import flash.*;
    import nape.constraint.*;
    import nape.geom.*;
    import nape.shape.*;
    import nape.space.*;
    import zpp_nape.callbacks.*;
    import zpp_nape.geom.*;
    import zpp_nape.phys.*;
    import zpp_nape.space.*;
    import zpp_nape.util.*;

    final public class Compound extends Interactor
    {
        public var zpp_inner:ZPP_Compound;

        public function Compound() : void
        {
            var _loc_2:* = null;
            if (Boot.skip_constructor)
            {
                return;
            }
            zpp_inner = null;
            ;
            _loc_2 = this;
            zpp_inner = new ZPP_Compound();
            zpp_inner.outer = this;
            zpp_inner.outer_i = this;
            zpp_inner_i = zpp_inner;
            zpp_inner.insert_cbtype(ZPP_CbType.ANY_COMPOUND.zpp_inner);
            return;
        }// end function

        public function visitConstraints(param1:Function) : void
        {
            var _loc_3:* = null as ConstraintList;
            var _loc_4:* = null as Constraint;
            var _loc_5:* = 0;
            var _loc_7:* = null as CompoundList;
            var _loc_8:* = null as Compound;
            if (param1 == null)
            {
                throw "Error: lambda cannot be null for Compound::visitConstraints";
            }
            _loc_3 = zpp_inner.wrap_constraints;
            _loc_3.zpp_inner.valmod();
            var _loc_2:* = ConstraintIterator.get(_loc_3);
            do
            {
                
                _loc_2.zpp_critical = false;
                _loc_5 = _loc_2.zpp_i;
                (_loc_2.zpp_i + 1);
                _loc_4 = _loc_2.zpp_inner.at(_loc_5);
                this.param1(_loc_4);
                _loc_2.zpp_inner.zpp_inner.valmod();
                _loc_3 = _loc_2.zpp_inner;
                _loc_3.zpp_inner.valmod();
                if (_loc_3.zpp_inner.zip_length)
                {
                    _loc_3.zpp_inner.zip_length = false;
                    _loc_3.zpp_inner.user_length = _loc_3.zpp_inner.inner.length;
                }
                _loc_5 = _loc_3.zpp_inner.user_length;
                _loc_2.zpp_critical = true;
            }while (_loc_2.zpp_i < _loc_5 ? (true) : (_loc_2.zpp_next = ConstraintIterator.zpp_pool, ConstraintIterator.zpp_pool = _loc_2, _loc_2.zpp_inner = null, false))
            _loc_7 = zpp_inner.wrap_compounds;
            _loc_7.zpp_inner.valmod();
            var _loc_6:* = CompoundIterator.get(_loc_7);
            do
            {
                
                _loc_6.zpp_critical = false;
                _loc_5 = _loc_6.zpp_i;
                (_loc_6.zpp_i + 1);
                _loc_8 = _loc_6.zpp_inner.at(_loc_5);
                _loc_8.visitConstraints(param1);
                _loc_6.zpp_inner.zpp_inner.valmod();
                _loc_7 = _loc_6.zpp_inner;
                _loc_7.zpp_inner.valmod();
                if (_loc_7.zpp_inner.zip_length)
                {
                    _loc_7.zpp_inner.zip_length = false;
                    _loc_7.zpp_inner.user_length = _loc_7.zpp_inner.inner.length;
                }
                _loc_5 = _loc_7.zpp_inner.user_length;
                _loc_6.zpp_critical = true;
            }while (_loc_6.zpp_i < _loc_5 ? (true) : (_loc_6.zpp_next = CompoundIterator.zpp_pool, CompoundIterator.zpp_pool = _loc_6, _loc_6.zpp_inner = null, false))
            return;
        }// end function

        public function visitCompounds(param1:Function) : void
        {
            var _loc_3:* = null as CompoundList;
            var _loc_4:* = null as Compound;
            var _loc_5:* = 0;
            if (param1 == null)
            {
                throw "Error: lambda cannot be null for Compound::visitConstraints";
            }
            _loc_3 = zpp_inner.wrap_compounds;
            _loc_3.zpp_inner.valmod();
            var _loc_2:* = CompoundIterator.get(_loc_3);
            do
            {
                
                _loc_2.zpp_critical = false;
                _loc_5 = _loc_2.zpp_i;
                (_loc_2.zpp_i + 1);
                _loc_4 = _loc_2.zpp_inner.at(_loc_5);
                this.param1(_loc_4);
                _loc_4.visitCompounds(param1);
                _loc_2.zpp_inner.zpp_inner.valmod();
                _loc_3 = _loc_2.zpp_inner;
                _loc_3.zpp_inner.valmod();
                if (_loc_3.zpp_inner.zip_length)
                {
                    _loc_3.zpp_inner.zip_length = false;
                    _loc_3.zpp_inner.user_length = _loc_3.zpp_inner.inner.length;
                }
                _loc_5 = _loc_3.zpp_inner.user_length;
                _loc_2.zpp_critical = true;
            }while (_loc_2.zpp_i < _loc_5 ? (true) : (_loc_2.zpp_next = CompoundIterator.zpp_pool, CompoundIterator.zpp_pool = _loc_2, _loc_2.zpp_inner = null, false))
            return;
        }// end function

        public function visitBodies(param1:Function) : void
        {
            var _loc_3:* = null as BodyList;
            var _loc_4:* = null as Body;
            var _loc_5:* = 0;
            var _loc_7:* = null as CompoundList;
            var _loc_8:* = null as Compound;
            if (param1 == null)
            {
                throw "Error: lambda cannot be null for Compound::visitBodies";
            }
            _loc_3 = zpp_inner.wrap_bodies;
            _loc_3.zpp_inner.valmod();
            var _loc_2:* = BodyIterator.get(_loc_3);
            do
            {
                
                _loc_2.zpp_critical = false;
                _loc_5 = _loc_2.zpp_i;
                (_loc_2.zpp_i + 1);
                _loc_4 = _loc_2.zpp_inner.at(_loc_5);
                this.param1(_loc_4);
                _loc_2.zpp_inner.zpp_inner.valmod();
                _loc_3 = _loc_2.zpp_inner;
                _loc_3.zpp_inner.valmod();
                if (_loc_3.zpp_inner.zip_length)
                {
                    _loc_3.zpp_inner.zip_length = false;
                    _loc_3.zpp_inner.user_length = _loc_3.zpp_inner.inner.length;
                }
                _loc_5 = _loc_3.zpp_inner.user_length;
                _loc_2.zpp_critical = true;
            }while (_loc_2.zpp_i < _loc_5 ? (true) : (_loc_2.zpp_next = BodyIterator.zpp_pool, BodyIterator.zpp_pool = _loc_2, _loc_2.zpp_inner = null, false))
            _loc_7 = zpp_inner.wrap_compounds;
            _loc_7.zpp_inner.valmod();
            var _loc_6:* = CompoundIterator.get(_loc_7);
            do
            {
                
                _loc_6.zpp_critical = false;
                _loc_5 = _loc_6.zpp_i;
                (_loc_6.zpp_i + 1);
                _loc_8 = _loc_6.zpp_inner.at(_loc_5);
                _loc_8.visitBodies(param1);
                _loc_6.zpp_inner.zpp_inner.valmod();
                _loc_7 = _loc_6.zpp_inner;
                _loc_7.zpp_inner.valmod();
                if (_loc_7.zpp_inner.zip_length)
                {
                    _loc_7.zpp_inner.zip_length = false;
                    _loc_7.zpp_inner.user_length = _loc_7.zpp_inner.inner.length;
                }
                _loc_5 = _loc_7.zpp_inner.user_length;
                _loc_6.zpp_critical = true;
            }while (_loc_6.zpp_i < _loc_5 ? (true) : (_loc_6.zpp_next = CompoundIterator.zpp_pool, CompoundIterator.zpp_pool = _loc_6, _loc_6.zpp_inner = null, false))
            return;
        }// end function

        public function translate(param1:Vec2) : Compound
        {
            var _loc_3:* = null as ZPP_Vec2;
            var _loc_4:* = null as Vec2;
            var _loc_5:* = null as ZPP_Vec2;
            var translation:* = param1;
            if (translation != null)
            {
            }
            if (translation.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            if (translation == null)
            {
                throw "Error: Cannot translate by null Vec2";
            }
            var _loc_2:* = translation.zpp_inner.weak;
            translation.zpp_inner.weak = false;
            visitBodies(function (param1:Body) : void
            {
                if (param1.zpp_inner.wrap_pos == null)
                {
                    param1.zpp_inner.setupPosition();
                }
                param1.zpp_inner.wrap_pos.addeq(translation);
                return;
            }// end function
            );
            translation.zpp_inner.weak = _loc_2;
            if (translation.zpp_inner.weak)
            {
                if (translation != null)
                {
                }
                if (translation.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_3 = translation.zpp_inner;
                if (_loc_3._immutable)
                {
                    throw "Error: Vec2 is immutable";
                }
                if (_loc_3._isimmutable != null)
                {
                    _loc_3._isimmutable();
                }
                if (translation.zpp_inner._inuse)
                {
                    throw "Error: This Vec2 is not disposable";
                }
                _loc_3 = translation.zpp_inner;
                translation.zpp_inner.outer = null;
                translation.zpp_inner = null;
                _loc_4 = translation;
                _loc_4.zpp_pool = null;
                if (ZPP_PubPool.nextVec2 != null)
                {
                    ZPP_PubPool.nextVec2.zpp_pool = _loc_4;
                }
                else
                {
                    ZPP_PubPool.poolVec2 = _loc_4;
                }
                ZPP_PubPool.nextVec2 = _loc_4;
                _loc_4.zpp_disp = true;
                _loc_5 = _loc_3;
                if (_loc_5.outer != null)
                {
                    _loc_5.outer.zpp_inner = null;
                    _loc_5.outer = null;
                }
                _loc_5._isimmutable = null;
                _loc_5._validate = null;
                _loc_5._invalidate = null;
                _loc_5.next = ZPP_Vec2.zpp_pool;
                ZPP_Vec2.zpp_pool = _loc_5;
            }
            else
            {
            }
            return this;
        }// end function

        override public function toString() : String
        {
            return "Compound" + zpp_inner_i.id;
        }// end function

        public function set_space(param1:Space) : Space
        {
            var _loc_2:* = null as CompoundList;
            if (zpp_inner.compound != null)
            {
                throw "Error: Cannot set the space of an inner Compound, only the root Compound space can be set";
            }
            zpp_inner.immutable_midstep("Compound::space");
            if ((zpp_inner.space == null ? (null) : (zpp_inner.space.outer)) != param1)
            {
                if ((zpp_inner.space == null ? (null) : (zpp_inner.space.outer)) != null)
                {
                    (zpp_inner.space == null ? (null) : (zpp_inner.space.outer)).zpp_inner.wrap_compounds.remove(this);
                }
                if (param1 != null)
                {
                    _loc_2 = param1.zpp_inner.wrap_compounds;
                    if (_loc_2.zpp_inner.reverse_flag)
                    {
                        _loc_2.push(this);
                    }
                    else
                    {
                        _loc_2.unshift(this);
                    }
                }
            }
            if (zpp_inner.space == null)
            {
                return null;
            }
            else
            {
                return zpp_inner.space.outer;
            }
        }// end function

        public function set_compound(param1:Compound) : Compound
        {
            var _loc_2:* = null as CompoundList;
            zpp_inner.immutable_midstep("Compound::compound");
            if ((zpp_inner.compound == null ? (null) : (zpp_inner.compound.outer)) != param1)
            {
                if ((zpp_inner.compound == null ? (null) : (zpp_inner.compound.outer)) != null)
                {
                    (zpp_inner.compound == null ? (null) : (zpp_inner.compound.outer)).zpp_inner.wrap_compounds.remove(this);
                }
                if (param1 != null)
                {
                    _loc_2 = param1.zpp_inner.wrap_compounds;
                    if (_loc_2.zpp_inner.reverse_flag)
                    {
                        _loc_2.push(this);
                    }
                    else
                    {
                        _loc_2.unshift(this);
                    }
                }
            }
            if (zpp_inner.compound == null)
            {
                return null;
            }
            else
            {
                return zpp_inner.compound.outer;
            }
        }// end function

        public function rotate(param1:Vec2, param2:Number) : Compound
        {
            var _loc_4:* = null as ZPP_Vec2;
            var _loc_5:* = null as Vec2;
            var _loc_6:* = null as ZPP_Vec2;
            var centre:* = param1;
            var angle:* = param2;
            if (centre != null)
            {
            }
            if (centre.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            if (centre == null)
            {
                throw "Error: Cannot rotate about a null Vec2";
            }
            if (angle != angle)
            {
                throw "Error: Cannot rotate by NaN radians";
            }
            var _loc_3:* = centre.zpp_inner.weak;
            centre.zpp_inner.weak = false;
            visitBodies(function (param1:Body) : void
            {
                param1.rotate(centre, angle);
                return;
            }// end function
            );
            centre.zpp_inner.weak = _loc_3;
            if (centre.zpp_inner.weak)
            {
                if (centre != null)
                {
                }
                if (centre.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_4 = centre.zpp_inner;
                if (_loc_4._immutable)
                {
                    throw "Error: Vec2 is immutable";
                }
                if (_loc_4._isimmutable != null)
                {
                    _loc_4._isimmutable();
                }
                if (centre.zpp_inner._inuse)
                {
                    throw "Error: This Vec2 is not disposable";
                }
                _loc_4 = centre.zpp_inner;
                centre.zpp_inner.outer = null;
                centre.zpp_inner = null;
                _loc_5 = centre;
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
                _loc_6 = _loc_4;
                if (_loc_6.outer != null)
                {
                    _loc_6.outer.zpp_inner = null;
                    _loc_6.outer = null;
                }
                _loc_6._isimmutable = null;
                _loc_6._validate = null;
                _loc_6._invalidate = null;
                _loc_6.next = ZPP_Vec2.zpp_pool;
                ZPP_Vec2.zpp_pool = _loc_6;
            }
            else
            {
            }
            return this;
        }// end function

        public function get_space() : Space
        {
            if (zpp_inner.space == null)
            {
                return null;
            }
            else
            {
                return zpp_inner.space.outer;
            }
        }// end function

        public function get_constraints() : ConstraintList
        {
            return zpp_inner.wrap_constraints;
        }// end function

        public function get_compounds() : CompoundList
        {
            return zpp_inner.wrap_compounds;
        }// end function

        public function get_compound() : Compound
        {
            if (zpp_inner.compound == null)
            {
                return null;
            }
            else
            {
                return zpp_inner.compound.outer;
            }
        }// end function

        public function get_bodies() : BodyList
        {
            return zpp_inner.wrap_bodies;
        }// end function

        public function copy() : Compound
        {
            return zpp_inner.copy();
        }// end function

        public function breakApart() : void
        {
            zpp_inner.breakApart();
            return;
        }// end function

        public function COM(param1:Boolean = false) : Vec2
        {
            var _loc_2:* = null as Vec2;
            var _loc_3:* = false;
            var _loc_4:* = null as ZPP_Vec2;
            if (ZPP_PubPool.poolVec2 == null)
            {
                _loc_2 = new Vec2();
            }
            else
            {
                _loc_2 = ZPP_PubPool.poolVec2;
                ZPP_PubPool.poolVec2 = _loc_2.zpp_pool;
                _loc_2.zpp_pool = null;
                _loc_2.zpp_disp = false;
                if (_loc_2 == ZPP_PubPool.nextVec2)
                {
                    ZPP_PubPool.nextVec2 = null;
                }
            }
            if (_loc_2.zpp_inner == null)
            {
                _loc_3 = false;
                if (ZPP_Vec2.zpp_pool == null)
                {
                    _loc_4 = new ZPP_Vec2();
                }
                else
                {
                    _loc_4 = ZPP_Vec2.zpp_pool;
                    ZPP_Vec2.zpp_pool = _loc_4.next;
                    _loc_4.next = null;
                }
                _loc_4.weak = false;
                _loc_4._immutable = _loc_3;
                _loc_4.x = 0;
                _loc_4.y = 0;
                _loc_2.zpp_inner = _loc_4;
                _loc_2.zpp_inner.outer = _loc_2;
            }
            else
            {
                if (_loc_2 != null)
                {
                }
                if (_loc_2.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_4 = _loc_2.zpp_inner;
                if (_loc_4._immutable)
                {
                    throw "Error: Vec2 is immutable";
                }
                if (_loc_4._isimmutable != null)
                {
                    _loc_4._isimmutable();
                }
                if (_loc_2 != null)
                {
                }
                if (_loc_2.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_4 = _loc_2.zpp_inner;
                if (_loc_4._validate != null)
                {
                    _loc_4._validate();
                }
                if (_loc_2.zpp_inner.x == 0)
                {
                    if (_loc_2 != null)
                    {
                    }
                    if (_loc_2.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_4 = _loc_2.zpp_inner;
                    if (_loc_4._validate != null)
                    {
                        _loc_4._validate();
                    }
                }
                if (_loc_2.zpp_inner.y != 0)
                {
                    _loc_2.zpp_inner.x = 0;
                    _loc_2.zpp_inner.y = 0;
                    _loc_4 = _loc_2.zpp_inner;
                    if (_loc_4._invalidate != null)
                    {
                        _loc_4._invalidate(_loc_4);
                    }
                }
            }
            _loc_2.zpp_inner.weak = param1;
            var ret:* = _loc_2;
            var total:Number;
            visitBodies(function (param1:Body) : void
            {
                var _loc_3:* = NaN;
                var _loc_4:* = NaN;
                var _loc_5:* = false;
                var _loc_6:* = null as Vec2;
                var _loc_7:* = false;
                var _loc_8:* = null as ZPP_Vec2;
                var _loc_2:* = param1.zpp_inner.wrap_shapes;
                if (_loc_2.zpp_inner.inner.head != null)
                {
                    if (param1.zpp_inner.world)
                    {
                        throw "Error: Space::world has no " + "worldCOM";
                    }
                    if (param1.zpp_inner.wrap_worldCOM == null)
                    {
                        _loc_3 = param1.zpp_inner.worldCOMx;
                        _loc_4 = param1.zpp_inner.worldCOMy;
                        _loc_5 = false;
                        if (_loc_3 == _loc_3)
                        {
                        }
                        if (_loc_4 != _loc_4)
                        {
                            throw "Error: Vec2 components cannot be NaN";
                        }
                        if (ZPP_PubPool.poolVec2 == null)
                        {
                            _loc_6 = new Vec2();
                        }
                        else
                        {
                            _loc_6 = ZPP_PubPool.poolVec2;
                            ZPP_PubPool.poolVec2 = _loc_6.zpp_pool;
                            _loc_6.zpp_pool = null;
                            _loc_6.zpp_disp = false;
                            if (_loc_6 == ZPP_PubPool.nextVec2)
                            {
                                ZPP_PubPool.nextVec2 = null;
                            }
                        }
                        if (_loc_6.zpp_inner == null)
                        {
                            _loc_7 = false;
                            if (ZPP_Vec2.zpp_pool == null)
                            {
                                _loc_8 = new ZPP_Vec2();
                            }
                            else
                            {
                                _loc_8 = ZPP_Vec2.zpp_pool;
                                ZPP_Vec2.zpp_pool = _loc_8.next;
                                _loc_8.next = null;
                            }
                            _loc_8.weak = false;
                            _loc_8._immutable = _loc_7;
                            _loc_8.x = _loc_3;
                            _loc_8.y = _loc_4;
                            _loc_6.zpp_inner = _loc_8;
                            _loc_6.zpp_inner.outer = _loc_6;
                        }
                        else
                        {
                            if (_loc_6 != null)
                            {
                            }
                            if (_loc_6.zpp_disp)
                            {
                                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                            }
                            _loc_8 = _loc_6.zpp_inner;
                            if (_loc_8._immutable)
                            {
                                throw "Error: Vec2 is immutable";
                            }
                            if (_loc_8._isimmutable != null)
                            {
                                _loc_8._isimmutable();
                            }
                            if (_loc_3 == _loc_3)
                            {
                            }
                            if (_loc_4 != _loc_4)
                            {
                                throw "Error: Vec2 components cannot be NaN";
                            }
                            if (_loc_6 != null)
                            {
                            }
                            if (_loc_6.zpp_disp)
                            {
                                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                            }
                            _loc_8 = _loc_6.zpp_inner;
                            if (_loc_8._validate != null)
                            {
                                _loc_8._validate();
                            }
                            if (_loc_6.zpp_inner.x == _loc_3)
                            {
                                if (_loc_6 != null)
                                {
                                }
                                if (_loc_6.zpp_disp)
                                {
                                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                                }
                                _loc_8 = _loc_6.zpp_inner;
                                if (_loc_8._validate != null)
                                {
                                    _loc_8._validate();
                                }
                            }
                            if (_loc_6.zpp_inner.y != _loc_4)
                            {
                                _loc_6.zpp_inner.x = _loc_3;
                                _loc_6.zpp_inner.y = _loc_4;
                                _loc_8 = _loc_6.zpp_inner;
                                if (_loc_8._invalidate != null)
                                {
                                    _loc_8._invalidate(_loc_8);
                                }
                            }
                        }
                        _loc_6.zpp_inner.weak = _loc_5;
                        param1.zpp_inner.wrap_worldCOM = _loc_6;
                        param1.zpp_inner.wrap_worldCOM.zpp_inner._inuse = true;
                        param1.zpp_inner.wrap_worldCOM.zpp_inner._immutable = true;
                        param1.zpp_inner.wrap_worldCOM.zpp_inner._validate = param1.zpp_inner.getworldCOM;
                    }
                    if (param1.zpp_inner.world)
                    {
                        throw "Error: Space::world has no mass";
                    }
                    param1.zpp_inner.validate_mass();
                    if (param1.zpp_inner.massMode == ZPP_Flags.id_MassMode_DEFAULT)
                    {
                    }
                    if (param1.zpp_inner.shapes.head == null)
                    {
                        throw "Error: Given current mass mode, Body::mass only makes sense if it contains shapes";
                    }
                    ret.addeq(param1.zpp_inner.wrap_worldCOM.mul(param1.zpp_inner.cmass, true));
                    if (param1.zpp_inner.world)
                    {
                        throw "Error: Space::world has no mass";
                    }
                    param1.zpp_inner.validate_mass();
                    if (param1.zpp_inner.massMode == ZPP_Flags.id_MassMode_DEFAULT)
                    {
                    }
                    if (param1.zpp_inner.shapes.head == null)
                    {
                        throw "Error: Given current mass mode, Body::mass only makes sense if it contains shapes";
                    }
                    total = total + param1.zpp_inner.cmass;
                }
                return;
            }// end function
            );
            if (total == 0)
            {
                throw "Error: COM of an empty Compound is undefined silly";
            }
            ret.muleq(1 / total);
            return ret;
        }// end function

    }
}
