package nape.space
{
    import flash.*;
    import nape.callbacks.*;
    import nape.constraint.*;
    import nape.dynamics.*;
    import nape.geom.*;
    import nape.phys.*;
    import nape.shape.*;
    import zpp_nape.constraint.*;
    import zpp_nape.dynamics.*;
    import zpp_nape.geom.*;
    import zpp_nape.phys.*;
    import zpp_nape.shape.*;
    import zpp_nape.space.*;
    import zpp_nape.util.*;

    final public class Space extends Object
    {
        public var zpp_inner:ZPP_Space;

        public function Space(param1:Vec2 = undefined, param2:Broadphase = undefined) : void
        {
            var _loc_3:* = null as ZPP_Vec2;
            var _loc_4:* = null as Vec2;
            var _loc_5:* = null as ZPP_Vec2;
            if (Boot.skip_constructor)
            {
                return;
            }
            zpp_inner = null;
            if (param1 != null)
            {
            }
            if (param1.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            zpp_inner = new ZPP_Space(param1 == null ? (null) : (param1.zpp_inner), param2);
            zpp_inner.outer = this;
            if (param1 != null)
            {
                if (param1.zpp_inner.weak)
                {
                    if (param1 != null)
                    {
                    }
                    if (param1.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_3 = param1.zpp_inner;
                    if (_loc_3._immutable)
                    {
                        throw "Error: Vec2 is immutable";
                    }
                    if (_loc_3._isimmutable != null)
                    {
                        _loc_3._isimmutable();
                    }
                    if (param1.zpp_inner._inuse)
                    {
                        throw "Error: This Vec2 is not disposable";
                    }
                    _loc_3 = param1.zpp_inner;
                    param1.zpp_inner.outer = null;
                    param1.zpp_inner = null;
                    _loc_4 = param1;
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
            }
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
                throw "Error: lambda cannot be null for Space::visitConstraints";
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
                throw "Error: lambda cannot be null for Space::visitCompounds";
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
                throw "Error: lambda cannot be null for Space::visitBodies";
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

        public function step(param1:Number, param2:int = 10, param3:int = 10) : void
        {
            if (param1 != param1)
            {
                throw "Error: deltaTime cannot be NaN";
            }
            if (param1 <= 0)
            {
                throw "Error: deltaTime must be strictly positive";
            }
            if (param2 <= 0)
            {
                throw "Error: must use atleast one velocity iteration";
            }
            if (param3 <= 0)
            {
                throw "Error: must use atleast one position iteration";
            }
            zpp_inner.step(param1, param2, param3);
            return;
        }// end function

        public function shapesUnderPoint(param1:Vec2, param2:InteractionFilter = undefined, param3:ShapeList = undefined) : ShapeList
        {
            var _loc_5:* = null as ZPP_Vec2;
            var _loc_6:* = null as Vec2;
            var _loc_7:* = null as ZPP_Vec2;
            if (param1 != null)
            {
            }
            if (param1.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            if (param1 == null)
            {
                throw "Error: Cannot evaluate shapes under a null point :)";
            }
            if (param1 != null)
            {
            }
            if (param1.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_5 = param1.zpp_inner;
            if (_loc_5._validate != null)
            {
                _loc_5._validate();
            }
            if (param1 != null)
            {
            }
            if (param1.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_5 = param1.zpp_inner;
            if (_loc_5._validate != null)
            {
                _loc_5._validate();
            }
            var _loc_4:* = zpp_inner.shapesUnderPoint(param1.zpp_inner.x, param1.zpp_inner.y, param2 == null ? (null) : (param2.zpp_inner), param3);
            if (param1.zpp_inner.weak)
            {
                if (param1 != null)
                {
                }
                if (param1.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_5 = param1.zpp_inner;
                if (_loc_5._immutable)
                {
                    throw "Error: Vec2 is immutable";
                }
                if (_loc_5._isimmutable != null)
                {
                    _loc_5._isimmutable();
                }
                if (param1.zpp_inner._inuse)
                {
                    throw "Error: This Vec2 is not disposable";
                }
                _loc_5 = param1.zpp_inner;
                param1.zpp_inner.outer = null;
                param1.zpp_inner = null;
                _loc_6 = param1;
                _loc_6.zpp_pool = null;
                if (ZPP_PubPool.nextVec2 != null)
                {
                    ZPP_PubPool.nextVec2.zpp_pool = _loc_6;
                }
                else
                {
                    ZPP_PubPool.poolVec2 = _loc_6;
                }
                ZPP_PubPool.nextVec2 = _loc_6;
                _loc_6.zpp_disp = true;
                _loc_7 = _loc_5;
                if (_loc_7.outer != null)
                {
                    _loc_7.outer.zpp_inner = null;
                    _loc_7.outer = null;
                }
                _loc_7._isimmutable = null;
                _loc_7._validate = null;
                _loc_7._invalidate = null;
                _loc_7.next = ZPP_Vec2.zpp_pool;
                ZPP_Vec2.zpp_pool = _loc_7;
            }
            else
            {
            }
            return _loc_4;
        }// end function

        public function shapesInShape(param1:Shape, param2:Boolean = false, param3:InteractionFilter = undefined, param4:ShapeList = undefined) : ShapeList
        {
            var _loc_5:* = null as ValidationResult;
            if (param1 == null)
            {
                throw "Error: Cannot evaluate shapes in a null shapes :)";
            }
            if ((param1.zpp_inner.body != null ? (param1.zpp_inner.body.outer) : (null)) == null)
            {
                throw "Error: Query shape needs to be inside a Body to be well defined :)";
            }
            if (param1.zpp_inner.type == ZPP_Flags.id_ShapeType_POLYGON)
            {
                _loc_5 = param1.zpp_inner.polygon.valid();
                if (ZPP_Flags.ValidationResult_VALID == null)
                {
                    ZPP_Flags.internal = true;
                    ZPP_Flags.ValidationResult_VALID = new ValidationResult();
                    ZPP_Flags.internal = false;
                }
                if (_loc_5 != ZPP_Flags.ValidationResult_VALID)
                {
                    throw "Error: Polygon query shape is invalid : " + _loc_5.toString();
                }
            }
            return zpp_inner.shapesInShape(param1.zpp_inner, param2, param3 == null ? (null) : (param3.zpp_inner), param4);
        }// end function

        public function shapesInCircle(param1:Vec2, param2:Number, param3:Boolean = false, param4:InteractionFilter = undefined, param5:ShapeList = undefined) : ShapeList
        {
            var _loc_7:* = null as ZPP_Vec2;
            var _loc_8:* = null as Vec2;
            var _loc_9:* = null as ZPP_Vec2;
            if (param1 != null)
            {
            }
            if (param1.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            if (param1 == null)
            {
                throw "Error: Cannot evaluate shapes at null circle :)";
            }
            if (param2 != param2)
            {
                throw "Error: Circle radius cannot be NaN";
            }
            if (param2 <= 0)
            {
                throw "Error: Circle radius must be strictly positive";
            }
            var _loc_6:* = zpp_inner.shapesInCircle(param1, param2, param3, param4 == null ? (null) : (param4.zpp_inner), param5);
            if (param1.zpp_inner.weak)
            {
                if (param1 != null)
                {
                }
                if (param1.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_7 = param1.zpp_inner;
                if (_loc_7._immutable)
                {
                    throw "Error: Vec2 is immutable";
                }
                if (_loc_7._isimmutable != null)
                {
                    _loc_7._isimmutable();
                }
                if (param1.zpp_inner._inuse)
                {
                    throw "Error: This Vec2 is not disposable";
                }
                _loc_7 = param1.zpp_inner;
                param1.zpp_inner.outer = null;
                param1.zpp_inner = null;
                _loc_8 = param1;
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
            }
            else
            {
            }
            return _loc_6;
        }// end function

        public function shapesInBody(param1:Body, param2:InteractionFilter = undefined, param3:ShapeList = undefined) : ShapeList
        {
            var _loc_4:* = null as ShapeList;
            var _loc_6:* = null as ShapeList;
            var _loc_7:* = null as Shape;
            var _loc_8:* = 0;
            if (param1 == null)
            {
                throw "Error: Cannot evaluate shapes in null body";
            }
            if (param3 == null)
            {
                _loc_4 = new ShapeList();
            }
            else
            {
                _loc_4 = param3;
            }
            _loc_6 = param1.zpp_inner.wrap_shapes;
            _loc_6.zpp_inner.valmod();
            var _loc_5:* = ShapeIterator.get(_loc_6);
            do
            {
                
                _loc_5.zpp_critical = false;
                _loc_8 = _loc_5.zpp_i;
                (_loc_5.zpp_i + 1);
                _loc_7 = _loc_5.zpp_inner.at(_loc_8);
                _loc_6 = shapesInShape(_loc_7, false, param2, _loc_4);
                _loc_5.zpp_inner.zpp_inner.valmod();
                _loc_6 = _loc_5.zpp_inner;
                _loc_6.zpp_inner.valmod();
                if (_loc_6.zpp_inner.zip_length)
                {
                    _loc_6.zpp_inner.zip_length = false;
                    _loc_6.zpp_inner.user_length = _loc_6.zpp_inner.inner.length;
                }
                _loc_8 = _loc_6.zpp_inner.user_length;
                _loc_5.zpp_critical = true;
            }while (_loc_5.zpp_i < _loc_8 ? (true) : (_loc_5.zpp_next = ShapeIterator.zpp_pool, ShapeIterator.zpp_pool = _loc_5, _loc_5.zpp_inner = null, false))
            return _loc_4;
        }// end function

        public function shapesInAABB(param1:AABB, param2:Boolean = false, param3:Boolean = true, param4:InteractionFilter = undefined, param5:ShapeList = undefined) : ShapeList
        {
            var _loc_6:* = null as ZPP_AABB;
            if (param1 == null)
            {
                throw "Error: Cannot evaluate shapes in a null AABB :)";
            }
            _loc_6 = param1.zpp_inner;
            if (_loc_6._validate != null)
            {
                _loc_6._validate();
            }
            _loc_6 = param1.zpp_inner;
            if (_loc_6.maxx - _loc_6.minx != 0)
            {
                _loc_6 = param1.zpp_inner;
                if (_loc_6._validate != null)
                {
                    _loc_6._validate();
                }
                _loc_6 = param1.zpp_inner;
            }
            if (_loc_6.maxy - _loc_6.miny == 0)
            {
                throw "Error: Cannot evaluate shapes in degenerate AABB :/";
            }
            return zpp_inner.shapesInAABB(param1, param3, param2, param4 == null ? (null) : (param4.zpp_inner), param5);
        }// end function

        public function set_worldLinearDrag(param1:Number) : Number
        {
            var _loc_2:* = param1;
            if (_loc_2 != _loc_2)
            {
                throw "Error: Space::worldLinearDrag cannot be NaN";
            }
            zpp_inner.global_lin_drag = _loc_2;
            return zpp_inner.global_lin_drag;
        }// end function

        public function set_worldAngularDrag(param1:Number) : Number
        {
            var _loc_2:* = param1;
            if (_loc_2 != _loc_2)
            {
                throw "Error: Space::worldAngularDrag cannot be NaN";
            }
            zpp_inner.global_ang_drag = _loc_2;
            return zpp_inner.global_ang_drag;
        }// end function

        public function set_sortContacts(param1:Boolean) : Boolean
        {
            zpp_inner.sortcontacts = param1;
            return zpp_inner.sortcontacts;
        }// end function

        public function set_gravity(param1:Vec2) : Vec2
        {
            var _loc_3:* = null as ZPP_Vec2;
            var _loc_7:* = null as Vec2;
            var _loc_8:* = null as ZPP_Vec2;
            if (param1 != null)
            {
            }
            if (param1.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            if (param1 == null)
            {
                throw "Error: Space::gravity cannot be null";
            }
            if (zpp_inner.wrap_gravity == null)
            {
                zpp_inner.getgravity();
            }
            var _loc_2:* = zpp_inner.wrap_gravity;
            if (_loc_2 != null)
            {
            }
            if (_loc_2.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            if (param1 != null)
            {
            }
            if (param1.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_3 = _loc_2.zpp_inner;
            if (_loc_3._immutable)
            {
                throw "Error: Vec2 is immutable";
            }
            if (_loc_3._isimmutable != null)
            {
                _loc_3._isimmutable();
            }
            if (param1 == null)
            {
                throw "Error: Cannot assign null Vec2";
            }
            if (param1 != null)
            {
            }
            if (param1.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_3 = param1.zpp_inner;
            if (_loc_3._validate != null)
            {
                _loc_3._validate();
            }
            var _loc_5:* = param1.zpp_inner.x;
            if (param1 != null)
            {
            }
            if (param1.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_3 = param1.zpp_inner;
            if (_loc_3._validate != null)
            {
                _loc_3._validate();
            }
            var _loc_6:* = param1.zpp_inner.y;
            if (_loc_2 != null)
            {
            }
            if (_loc_2.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_3 = _loc_2.zpp_inner;
            if (_loc_3._immutable)
            {
                throw "Error: Vec2 is immutable";
            }
            if (_loc_3._isimmutable != null)
            {
                _loc_3._isimmutable();
            }
            if (_loc_5 == _loc_5)
            {
            }
            if (_loc_6 != _loc_6)
            {
                throw "Error: Vec2 components cannot be NaN";
            }
            if (_loc_2 != null)
            {
            }
            if (_loc_2.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_3 = _loc_2.zpp_inner;
            if (_loc_3._validate != null)
            {
                _loc_3._validate();
            }
            if (_loc_2.zpp_inner.x == _loc_5)
            {
                if (_loc_2 != null)
                {
                }
                if (_loc_2.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_3 = _loc_2.zpp_inner;
                if (_loc_3._validate != null)
                {
                    _loc_3._validate();
                }
            }
            if (_loc_2.zpp_inner.y != _loc_6)
            {
                _loc_2.zpp_inner.x = _loc_5;
                _loc_2.zpp_inner.y = _loc_6;
                _loc_3 = _loc_2.zpp_inner;
                if (_loc_3._invalidate != null)
                {
                    _loc_3._invalidate(_loc_3);
                }
            }
            var _loc_4:* = _loc_2;
            if (param1.zpp_inner.weak)
            {
                if (param1 != null)
                {
                }
                if (param1.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_3 = param1.zpp_inner;
                if (_loc_3._immutable)
                {
                    throw "Error: Vec2 is immutable";
                }
                if (_loc_3._isimmutable != null)
                {
                    _loc_3._isimmutable();
                }
                if (param1.zpp_inner._inuse)
                {
                    throw "Error: This Vec2 is not disposable";
                }
                _loc_3 = param1.zpp_inner;
                param1.zpp_inner.outer = null;
                param1.zpp_inner = null;
                _loc_7 = param1;
                _loc_7.zpp_pool = null;
                if (ZPP_PubPool.nextVec2 != null)
                {
                    ZPP_PubPool.nextVec2.zpp_pool = _loc_7;
                }
                else
                {
                    ZPP_PubPool.poolVec2 = _loc_7;
                }
                ZPP_PubPool.nextVec2 = _loc_7;
                _loc_7.zpp_disp = true;
                _loc_8 = _loc_3;
                if (_loc_8.outer != null)
                {
                    _loc_8.outer.zpp_inner = null;
                    _loc_8.outer = null;
                }
                _loc_8._isimmutable = null;
                _loc_8._validate = null;
                _loc_8._invalidate = null;
                _loc_8.next = ZPP_Vec2.zpp_pool;
                ZPP_Vec2.zpp_pool = _loc_8;
            }
            else
            {
            }
            if (zpp_inner.wrap_gravity == null)
            {
                zpp_inner.getgravity();
            }
            return zpp_inner.wrap_gravity;
        }// end function

        public function rayMultiCast(param1:Ray, param2:Boolean = false, param3:InteractionFilter = undefined, param4:RayResultList = undefined) : RayResultList
        {
            if (param1 == null)
            {
                throw "Error: Cannot cast null ray :)";
            }
            return zpp_inner.rayMultiCast(param1, param2, param3, param4);
        }// end function

        public function rayCast(param1:Ray, param2:Boolean = false, param3:InteractionFilter = undefined) : RayResult
        {
            if (param1 == null)
            {
                throw "Error: Cannot cast null ray :)";
            }
            return zpp_inner.rayCast(param1, param2, param3);
        }// end function

        public function interactionType(param1:Shape, param2:Shape) : InteractionType
        {
            var _loc_5:* = 0;
            var _loc_10:* = null as ZPP_Constraint;
            var _loc_11:* = null as ZPP_InteractionGroup;
            var _loc_12:* = null as ZPP_Interactor;
            var _loc_13:* = null as ZPP_InteractionGroup;
            var _loc_14:* = false;
            var _loc_15:* = null as ZPP_InteractionFilter;
            var _loc_16:* = null as ZPP_InteractionFilter;
            if (param1 != null)
            {
            }
            if (param2 == null)
            {
                throw "Error: Cannot evaluate interaction type for null shapes";
            }
            if ((param1.zpp_inner.body != null ? (param1.zpp_inner.body.outer) : (null)) != null)
            {
            }
            if ((param2.zpp_inner.body != null ? (param2.zpp_inner.body.outer) : (null)) == null)
            {
                throw "Error: Cannot evaluate interaction type for shapes not part of a Body";
            }
            if ((param1.zpp_inner.body != null ? (param1.zpp_inner.body.outer) : (null)).zpp_inner.type == ZPP_Flags.id_BodyType_STATIC)
            {
            }
            if ((param2.zpp_inner.body != null ? (param2.zpp_inner.body.outer) : (null)).zpp_inner.type == ZPP_Flags.id_BodyType_STATIC)
            {
                return null;
            }
            if ((param1.zpp_inner.body != null ? (param1.zpp_inner.body.outer) : (null)) == (param2.zpp_inner.body != null ? (param2.zpp_inner.body.outer) : (null)))
            {
                return null;
            }
            var _loc_3:* = param1.zpp_inner;
            var _loc_4:* = param2.zpp_inner;
            var _loc_6:* = _loc_3.body;
            var _loc_7:* = _loc_4.body;
            var _loc_8:* = false;
            var _loc_9:* = _loc_6.constraints.head;
            while (_loc_9 != null)
            {
                
                _loc_10 = _loc_9.elt;
                if (_loc_10.ignore)
                {
                }
                if (_loc_10.pair_exists(_loc_6.id, _loc_7.id))
                {
                    _loc_8 = true;
                    break;
                }
                _loc_9 = _loc_9.next;
            }
            if (!_loc_8)
            {
                _loc_12 = _loc_3;
                do
                {
                    
                    if (_loc_12.ishape != null)
                    {
                        _loc_12 = _loc_12.ishape.body;
                    }
                    else if (_loc_12.icompound != null)
                    {
                        _loc_12 = _loc_12.icompound.compound;
                    }
                    else
                    {
                        _loc_12 = _loc_12.ibody.compound;
                    }
                    if (_loc_12 != null)
                    {
                    }
                }while (_loc_12.group == null)
                if (_loc_12 == null)
                {
                    _loc_11 = null;
                }
                else
                {
                    _loc_11 = _loc_12.group;
                }
                while (_loc_12.group == null)
                {
                    if (_loc_12.ishape != null)
                    {
                        continue;
                    }
                    if (_loc_12.icompound != null)
                    {
                        continue;
                    }
                    if (_loc_12 != null)
                    {
                    }
                }
                if (_loc_12 == null)
                {
                }
                else
                {
                }
                while (_loc_13 != null)
                {
                    if (_loc_11 == _loc_13)
                    {
                        break;
                    }
                    if (_loc_11.depth < _loc_13.depth)
                    {
                        continue;
                    }
                    if (_loc_11 != null)
                    {
                    }
                }
            }
            if (!(_loc_11.depth < _loc_13.depth ? (false) : (_loc_12 = _loc_4, // Jump to 722, // label, if (_loc_12.ishape == null) goto 679, _loc_12 = _loc_12.ishape.body, // Jump to 722, if (_loc_12.icompound == null) goto 709, _loc_12 = _loc_12.icompound.compound, // Jump to 722, _loc_12 = _loc_12.ibody.compound, if (_loc_12 == null) goto 745, if (_loc_12.group == null) goto 648, if (!(_loc_12 == null)) goto 772, _loc_13 = null, // Jump to 782, _loc_13 = _loc_12.group, _loc_13 == null ? (false) : (_loc_14 = false, // Jump to 864, // label, if (!(_loc_11 == _loc_13)) goto 826, _loc_14 = _loc_11.ignore, // Jump to 889, if (!(_loc_11.depth < _loc_13.depth)) goto 854, _loc_13 = _loc_13.group, // Jump to 864, _loc_11 = _loc_11.group, if (_loc_11 == null) goto 885, if (_loc_13 != null) goto 805, _loc_14))))
            {
                if (!_loc_3.sensorEnabled)
                {
                }
                if (_loc_4.sensorEnabled)
                {
                    _loc_15 = _loc_3.filter;
                    _loc_16 = _loc_4.filter;
                    if ((_loc_15.sensorMask & _loc_16.sensorGroup) != 0)
                    {
                    }
                }
                if ((_loc_16.sensorMask & _loc_15.sensorGroup) != 0)
                {
                    _loc_5 = 2;
                }
                else
                {
                    if (!_loc_3.fluidEnabled)
                    {
                    }
                    if (_loc_4.fluidEnabled)
                    {
                        _loc_15 = _loc_3.filter;
                        _loc_16 = _loc_4.filter;
                        if ((_loc_15.fluidMask & _loc_16.fluidGroup) != 0)
                        {
                        }
                    }
                    if ((_loc_16.fluidMask & _loc_15.fluidGroup) != 0)
                    {
                        if (_loc_6.imass == 0)
                        {
                        }
                        if (_loc_7.imass == 0)
                        {
                        }
                        if (_loc_6.iinertia == 0)
                        {
                        }
                    }
                    if (_loc_7.iinertia != 0)
                    {
                        _loc_5 = 0;
                    }
                    else
                    {
                        _loc_15 = _loc_3.filter;
                        _loc_16 = _loc_4.filter;
                        if ((_loc_15.collisionMask & _loc_16.collisionGroup) != 0)
                        {
                        }
                        if ((_loc_16.collisionMask & _loc_15.collisionGroup) != 0)
                        {
                            if (_loc_6.imass == 0)
                            {
                            }
                            if (_loc_7.imass == 0)
                            {
                            }
                            if (_loc_6.iinertia == 0)
                            {
                            }
                        }
                        if (_loc_7.iinertia != 0)
                        {
                            _loc_5 = 1;
                        }
                        else
                        {
                            _loc_5 = -1;
                        }
                    }
                }
            }
            else
            {
                _loc_5 = -1;
            }
            switch(_loc_5) branch count is:<2>[23, 75, 127] default offset is:<14>;
            return null;
            ;
            if (ZPP_Flags.InteractionType_FLUID == null)
            {
                ZPP_Flags.internal = true;
                ZPP_Flags.InteractionType_FLUID = new InteractionType();
                ZPP_Flags.internal = false;
            }
            return ZPP_Flags.InteractionType_FLUID;
            ;
            if (ZPP_Flags.InteractionType_COLLISION == null)
            {
                ZPP_Flags.internal = true;
                ZPP_Flags.InteractionType_COLLISION = new InteractionType();
                ZPP_Flags.internal = false;
            }
            return ZPP_Flags.InteractionType_COLLISION;
            ;
            if (ZPP_Flags.InteractionType_SENSOR == null)
            {
                ZPP_Flags.internal = true;
                ZPP_Flags.InteractionType_SENSOR = new InteractionType();
                ZPP_Flags.internal = false;
            }
            return ZPP_Flags.InteractionType_SENSOR;
            return;
        }// end function

        public function get_worldLinearDrag() : Number
        {
            return zpp_inner.global_lin_drag;
        }// end function

        public function get_worldAngularDrag() : Number
        {
            return zpp_inner.global_ang_drag;
        }// end function

        public function get_world() : Body
        {
            return zpp_inner.__static;
        }// end function

        public function get_userData()
        {
            if (zpp_inner.userData == null)
            {
                zpp_inner.userData = {};
            }
            return zpp_inner.userData;
        }// end function

        public function get_timeStamp() : int
        {
            return zpp_inner.stamp;
        }// end function

        public function get_sortContacts() : Boolean
        {
            return zpp_inner.sortcontacts;
        }// end function

        public function get_liveConstraints() : ConstraintList
        {
            return zpp_inner.wrap_livecon;
        }// end function

        public function get_liveBodies() : BodyList
        {
            return zpp_inner.wrap_live;
        }// end function

        public function get_listeners() : ListenerList
        {
            return zpp_inner.wrap_listeners;
        }// end function

        public function get_gravity() : Vec2
        {
            if (zpp_inner.wrap_gravity == null)
            {
                zpp_inner.getgravity();
            }
            return zpp_inner.wrap_gravity;
        }// end function

        public function get_elapsedTime() : Number
        {
            return zpp_inner.time;
        }// end function

        public function get_constraints() : ConstraintList
        {
            return zpp_inner.wrap_constraints;
        }// end function

        public function get_compounds() : CompoundList
        {
            return zpp_inner.wrap_compounds;
        }// end function

        public function get_broadphase() : Broadphase
        {
            if (zpp_inner.bphase.is_sweep)
            {
                if (ZPP_Flags.Broadphase_SWEEP_AND_PRUNE == null)
                {
                    ZPP_Flags.internal = true;
                    ZPP_Flags.Broadphase_SWEEP_AND_PRUNE = new Broadphase();
                    ZPP_Flags.internal = false;
                }
                return ZPP_Flags.Broadphase_SWEEP_AND_PRUNE;
            }
            else
            {
                if (ZPP_Flags.Broadphase_DYNAMIC_AABB_TREE == null)
                {
                    ZPP_Flags.internal = true;
                    ZPP_Flags.Broadphase_DYNAMIC_AABB_TREE = new Broadphase();
                    ZPP_Flags.internal = false;
                }
                return ZPP_Flags.Broadphase_DYNAMIC_AABB_TREE;
            }
        }// end function

        public function get_bodies() : BodyList
        {
            return zpp_inner.wrap_bodies;
        }// end function

        public function get_arbiters() : ArbiterList
        {
            var _loc_1:* = null as ZPP_SpaceArbiterList;
            if (zpp_inner.wrap_arbiters == null)
            {
                _loc_1 = new ZPP_SpaceArbiterList();
                _loc_1.space = zpp_inner;
                zpp_inner.wrap_arbiters = _loc_1;
            }
            return zpp_inner.wrap_arbiters;
        }// end function

        public function convexMultiCast(param1:Shape, param2:Number, param3:Boolean = false, param4:InteractionFilter = undefined, param5:ConvexResultList = undefined) : ConvexResultList
        {
            if (param1 == null)
            {
                throw "Error: Cannot cast null shape :)";
            }
            if ((param1.zpp_inner.body != null ? (param1.zpp_inner.body.outer) : (null)) == null)
            {
                throw "Error: Shape must belong to a body to be cast.";
            }
            if (param2 >= 0)
            {
            }
            if (param2 != param2)
            {
                throw "Error: deltaTime must be positive";
            }
            return zpp_inner.convexMultiCast(param1.zpp_inner, param2, param4, param3, param5);
        }// end function

        public function convexCast(param1:Shape, param2:Number, param3:Boolean = false, param4:InteractionFilter = undefined) : ConvexResult
        {
            if (param1 == null)
            {
                throw "Error: Cannot cast null shape :)";
            }
            if ((param1.zpp_inner.body != null ? (param1.zpp_inner.body.outer) : (null)) == null)
            {
                throw "Error: Shape must belong to a body to be cast.";
            }
            if (param2 >= 0)
            {
            }
            if (param2 != param2)
            {
                throw "Error: deltaTime must be positive";
            }
            return zpp_inner.convexCast(param1.zpp_inner, param2, param4, param3);
        }// end function

        public function clear() : void
        {
            if (zpp_inner.midstep)
            {
                throw "Error: Space::clear() cannot be called during space step()";
            }
            zpp_inner.clear();
            return;
        }// end function

        public function bodiesUnderPoint(param1:Vec2, param2:InteractionFilter = undefined, param3:BodyList = undefined) : BodyList
        {
            var _loc_5:* = null as ZPP_Vec2;
            var _loc_6:* = null as Vec2;
            var _loc_7:* = null as ZPP_Vec2;
            if (param1 != null)
            {
            }
            if (param1.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            if (param1 == null)
            {
                throw "Error: Cannot evaluate objects under a null point :)";
            }
            if (param1 != null)
            {
            }
            if (param1.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_5 = param1.zpp_inner;
            if (_loc_5._validate != null)
            {
                _loc_5._validate();
            }
            if (param1 != null)
            {
            }
            if (param1.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_5 = param1.zpp_inner;
            if (_loc_5._validate != null)
            {
                _loc_5._validate();
            }
            var _loc_4:* = zpp_inner.bodiesUnderPoint(param1.zpp_inner.x, param1.zpp_inner.y, param2 == null ? (null) : (param2.zpp_inner), param3);
            if (param1.zpp_inner.weak)
            {
                if (param1 != null)
                {
                }
                if (param1.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_5 = param1.zpp_inner;
                if (_loc_5._immutable)
                {
                    throw "Error: Vec2 is immutable";
                }
                if (_loc_5._isimmutable != null)
                {
                    _loc_5._isimmutable();
                }
                if (param1.zpp_inner._inuse)
                {
                    throw "Error: This Vec2 is not disposable";
                }
                _loc_5 = param1.zpp_inner;
                param1.zpp_inner.outer = null;
                param1.zpp_inner = null;
                _loc_6 = param1;
                _loc_6.zpp_pool = null;
                if (ZPP_PubPool.nextVec2 != null)
                {
                    ZPP_PubPool.nextVec2.zpp_pool = _loc_6;
                }
                else
                {
                    ZPP_PubPool.poolVec2 = _loc_6;
                }
                ZPP_PubPool.nextVec2 = _loc_6;
                _loc_6.zpp_disp = true;
                _loc_7 = _loc_5;
                if (_loc_7.outer != null)
                {
                    _loc_7.outer.zpp_inner = null;
                    _loc_7.outer = null;
                }
                _loc_7._isimmutable = null;
                _loc_7._validate = null;
                _loc_7._invalidate = null;
                _loc_7.next = ZPP_Vec2.zpp_pool;
                ZPP_Vec2.zpp_pool = _loc_7;
            }
            else
            {
            }
            return _loc_4;
        }// end function

        public function bodiesInShape(param1:Shape, param2:Boolean = false, param3:InteractionFilter = undefined, param4:BodyList = undefined) : BodyList
        {
            var _loc_5:* = null as ValidationResult;
            if (param1 == null)
            {
                throw "Error: Cannot evaluate bodies in a null shapes :)";
            }
            if ((param1.zpp_inner.body != null ? (param1.zpp_inner.body.outer) : (null)) == null)
            {
                throw "Error: Query shape needs to be inside a Body to be well defined :)";
            }
            if (param1.zpp_inner.type == ZPP_Flags.id_ShapeType_POLYGON)
            {
                _loc_5 = param1.zpp_inner.polygon.valid();
                if (ZPP_Flags.ValidationResult_VALID == null)
                {
                    ZPP_Flags.internal = true;
                    ZPP_Flags.ValidationResult_VALID = new ValidationResult();
                    ZPP_Flags.internal = false;
                }
                if (_loc_5 != ZPP_Flags.ValidationResult_VALID)
                {
                    throw "Error: Polygon query shape is invalid : " + _loc_5.toString();
                }
            }
            return zpp_inner.bodiesInShape(param1.zpp_inner, param2, param3 == null ? (null) : (param3.zpp_inner), param4);
        }// end function

        public function bodiesInCircle(param1:Vec2, param2:Number, param3:Boolean = false, param4:InteractionFilter = undefined, param5:BodyList = undefined) : BodyList
        {
            var _loc_7:* = null as ZPP_Vec2;
            var _loc_8:* = null as Vec2;
            var _loc_9:* = null as ZPP_Vec2;
            if (param1 != null)
            {
            }
            if (param1.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            if (param1 == null)
            {
                throw "Error: Cannot evaluate objects at null circle :)";
            }
            if (param2 != param2)
            {
                throw "Error: Circle radius cannot be NaN";
            }
            if (param2 <= 0)
            {
                throw "Error: Circle radius must be strictly positive";
            }
            var _loc_6:* = zpp_inner.bodiesInCircle(param1, param2, param3, param4 == null ? (null) : (param4.zpp_inner), param5);
            if (param1.zpp_inner.weak)
            {
                if (param1 != null)
                {
                }
                if (param1.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_7 = param1.zpp_inner;
                if (_loc_7._immutable)
                {
                    throw "Error: Vec2 is immutable";
                }
                if (_loc_7._isimmutable != null)
                {
                    _loc_7._isimmutable();
                }
                if (param1.zpp_inner._inuse)
                {
                    throw "Error: This Vec2 is not disposable";
                }
                _loc_7 = param1.zpp_inner;
                param1.zpp_inner.outer = null;
                param1.zpp_inner = null;
                _loc_8 = param1;
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
            }
            else
            {
            }
            return _loc_6;
        }// end function

        public function bodiesInBody(param1:Body, param2:InteractionFilter = undefined, param3:BodyList = undefined) : BodyList
        {
            var _loc_4:* = null as BodyList;
            var _loc_6:* = null as ShapeList;
            var _loc_7:* = null as Shape;
            var _loc_8:* = 0;
            var _loc_9:* = null as BodyList;
            if (param1 == null)
            {
                throw "Error: Cannot evaluate shapes in null body";
            }
            if (param3 == null)
            {
                _loc_4 = new BodyList();
            }
            else
            {
                _loc_4 = param3;
            }
            _loc_6 = param1.zpp_inner.wrap_shapes;
            _loc_6.zpp_inner.valmod();
            var _loc_5:* = ShapeIterator.get(_loc_6);
            do
            {
                
                _loc_5.zpp_critical = false;
                _loc_8 = _loc_5.zpp_i;
                (_loc_5.zpp_i + 1);
                _loc_7 = _loc_5.zpp_inner.at(_loc_8);
                _loc_9 = bodiesInShape(_loc_7, false, param2, _loc_4);
                _loc_5.zpp_inner.zpp_inner.valmod();
                _loc_6 = _loc_5.zpp_inner;
                _loc_6.zpp_inner.valmod();
                if (_loc_6.zpp_inner.zip_length)
                {
                    _loc_6.zpp_inner.zip_length = false;
                    _loc_6.zpp_inner.user_length = _loc_6.zpp_inner.inner.length;
                }
                _loc_8 = _loc_6.zpp_inner.user_length;
                _loc_5.zpp_critical = true;
            }while (_loc_5.zpp_i < _loc_8 ? (true) : (_loc_5.zpp_next = ShapeIterator.zpp_pool, ShapeIterator.zpp_pool = _loc_5, _loc_5.zpp_inner = null, false))
            return _loc_4;
        }// end function

        public function bodiesInAABB(param1:AABB, param2:Boolean = false, param3:Boolean = true, param4:InteractionFilter = undefined, param5:BodyList = undefined) : BodyList
        {
            var _loc_6:* = null as ZPP_AABB;
            if (param1 == null)
            {
                throw "Error: Cannot evaluate objects in a null AABB :)";
            }
            _loc_6 = param1.zpp_inner;
            if (_loc_6._validate != null)
            {
                _loc_6._validate();
            }
            _loc_6 = param1.zpp_inner;
            if (_loc_6.maxx - _loc_6.minx != 0)
            {
                _loc_6 = param1.zpp_inner;
                if (_loc_6._validate != null)
                {
                    _loc_6._validate();
                }
                _loc_6 = param1.zpp_inner;
            }
            if (_loc_6.maxy - _loc_6.miny == 0)
            {
                throw "Error: Cannot evaluate objects in degenerate AABB :/";
            }
            return zpp_inner.bodiesInAABB(param1, param3, param2, param4 == null ? (null) : (param4.zpp_inner), param5);
        }// end function

    }
}
