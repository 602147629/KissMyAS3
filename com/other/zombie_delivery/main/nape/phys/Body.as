package nape.phys
{
    import flash.*;
    import nape.callbacks.*;
    import nape.constraint.*;
    import nape.dynamics.*;
    import nape.geom.*;
    import nape.shape.*;
    import nape.space.*;
    import zpp_nape.callbacks.*;
    import zpp_nape.constraint.*;
    import zpp_nape.dynamics.*;
    import zpp_nape.geom.*;
    import zpp_nape.phys.*;
    import zpp_nape.shape.*;
    import zpp_nape.space.*;
    import zpp_nape.util.*;

    final public class Body extends Interactor
    {
        public var zpp_inner:ZPP_Body;
        public var debugDraw:Boolean;

        public function Body(param1:BodyType = undefined, param2:Vec2 = undefined) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = null as ZPP_Vec2;
            var _loc_6:* = null as BodyType;
            var _loc_7:* = 0;
            var _loc_8:* = null as Vec2;
            var _loc_9:* = null as ZPP_Vec2;
            if (Boot.skip_constructor)
            {
                return;
            }
            debugDraw = true;
            zpp_inner = null;
            ;
            _loc_4 = this;
            zpp_inner = new ZPP_Body();
            zpp_inner.outer = this;
            zpp_inner.outer_i = this;
            zpp_inner_i = zpp_inner;
            if (param2 != null)
            {
                if (param2 != null)
                {
                }
                if (param2.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                if (param2 != null)
                {
                }
                if (param2.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_5 = param2.zpp_inner;
                if (_loc_5._validate != null)
                {
                    _loc_5._validate();
                }
                zpp_inner.posx = param2.zpp_inner.x;
                if (param2 != null)
                {
                }
                if (param2.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_5 = param2.zpp_inner;
                if (_loc_5._validate != null)
                {
                    _loc_5._validate();
                }
                zpp_inner.posy = param2.zpp_inner.y;
            }
            else
            {
                zpp_inner.posx = 0;
                zpp_inner.posy = 0;
            }
            if (param1 == null)
            {
                if (ZPP_Flags.BodyType_DYNAMIC == null)
                {
                    ZPP_Flags.internal = true;
                    ZPP_Flags.BodyType_DYNAMIC = new BodyType();
                    ZPP_Flags.internal = false;
                }
                _loc_6 = ZPP_Flags.BodyType_DYNAMIC;
            }
            else
            {
                _loc_6 = param1;
            }
            zpp_inner.immutable_midstep("Body::type");
            if (zpp_inner.world)
            {
                throw "Error: Space::world is immutable";
            }
            if (ZPP_Body.types[zpp_inner.type] != _loc_6)
            {
                if (_loc_6 == null)
                {
                    throw "Error: Cannot use null BodyType";
                }
                if (ZPP_Flags.BodyType_DYNAMIC == null)
                {
                    ZPP_Flags.internal = true;
                    ZPP_Flags.BodyType_DYNAMIC = new BodyType();
                    ZPP_Flags.internal = false;
                }
                if (_loc_6 == ZPP_Flags.BodyType_DYNAMIC)
                {
                    _loc_7 = ZPP_Flags.id_BodyType_DYNAMIC;
                }
                else
                {
                    if (ZPP_Flags.BodyType_KINEMATIC == null)
                    {
                        ZPP_Flags.internal = true;
                        ZPP_Flags.BodyType_KINEMATIC = new BodyType();
                        ZPP_Flags.internal = false;
                    }
                    if (_loc_6 == ZPP_Flags.BodyType_KINEMATIC)
                    {
                        _loc_7 = ZPP_Flags.id_BodyType_KINEMATIC;
                    }
                    else
                    {
                        _loc_7 = ZPP_Flags.id_BodyType_STATIC;
                    }
                }
                if (_loc_7 == ZPP_Flags.id_BodyType_STATIC)
                {
                }
                if (zpp_inner.space != null)
                {
                    zpp_inner.velx = 0;
                    zpp_inner.vely = 0;
                    zpp_inner.angvel = 0;
                }
                zpp_inner.invalidate_type();
                if (zpp_inner.space != null)
                {
                    zpp_inner.space.transmitType(zpp_inner, _loc_7);
                }
                else
                {
                    zpp_inner.type = _loc_7;
                }
            }
            if (param2 != null)
            {
                if (param2.zpp_inner.weak)
                {
                    if (param2 != null)
                    {
                    }
                    if (param2.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_5 = param2.zpp_inner;
                    if (_loc_5._immutable)
                    {
                        throw "Error: Vec2 is immutable";
                    }
                    if (_loc_5._isimmutable != null)
                    {
                        _loc_5._isimmutable();
                    }
                    if (param2.zpp_inner._inuse)
                    {
                        throw "Error: This Vec2 is not disposable";
                    }
                    _loc_5 = param2.zpp_inner;
                    param2.zpp_inner.outer = null;
                    param2.zpp_inner = null;
                    _loc_8 = param2;
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
                    _loc_9 = _loc_5;
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
            }
            zpp_inner_i.insert_cbtype(ZPP_CbType.ANY_BODY.zpp_inner);
            return;
        }// end function

        public function worldVectorToLocal(param1:Vec2, param2:Boolean = false) : Vec2
        {
            var _loc_6:* = null as ZPP_Vec2;
            var _loc_7:* = null as Vec2;
            var _loc_8:* = null as ZPP_Vec2;
            var _loc_9:* = false;
            if (param1 != null)
            {
            }
            if (param1.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            if (param1 == null)
            {
                throw "Error: Cannot transform null Vec2";
            }
            var _loc_3:* = zpp_inner;
            if (_loc_3.zip_axis)
            {
                _loc_3.zip_axis = false;
                _loc_3.axisx = Math.sin(_loc_3.rot);
                _loc_3.axisy = Math.cos(_loc_3.rot);
            }
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            if (param1 != null)
            {
            }
            if (param1.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_6 = param1.zpp_inner;
            if (_loc_6._validate != null)
            {
                _loc_6._validate();
            }
            if (param1 != null)
            {
            }
            if (param1.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_6 = param1.zpp_inner;
            if (_loc_6._validate != null)
            {
                _loc_6._validate();
            }
            _loc_4 = param1.zpp_inner.x * zpp_inner.axisy + param1.zpp_inner.y * zpp_inner.axisx;
            if (param1 != null)
            {
            }
            if (param1.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_6 = param1.zpp_inner;
            if (_loc_6._validate != null)
            {
                _loc_6._validate();
            }
            if (param1 != null)
            {
            }
            if (param1.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_6 = param1.zpp_inner;
            if (_loc_6._validate != null)
            {
                _loc_6._validate();
            }
            _loc_5 = param1.zpp_inner.y * zpp_inner.axisy - param1.zpp_inner.x * zpp_inner.axisx;
            if (param1.zpp_inner.weak)
            {
                if (param1 != null)
                {
                }
                if (param1.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_6 = param1.zpp_inner;
                if (_loc_6._immutable)
                {
                    throw "Error: Vec2 is immutable";
                }
                if (_loc_6._isimmutable != null)
                {
                    _loc_6._isimmutable();
                }
                if (param1.zpp_inner._inuse)
                {
                    throw "Error: This Vec2 is not disposable";
                }
                _loc_6 = param1.zpp_inner;
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
                _loc_8 = _loc_6;
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
            if (_loc_4 == _loc_4)
            {
            }
            if (_loc_5 != _loc_5)
            {
                throw "Error: Vec2 components cannot be NaN";
            }
            if (ZPP_PubPool.poolVec2 == null)
            {
                _loc_7 = new Vec2();
            }
            else
            {
                _loc_7 = ZPP_PubPool.poolVec2;
                ZPP_PubPool.poolVec2 = _loc_7.zpp_pool;
                _loc_7.zpp_pool = null;
                _loc_7.zpp_disp = false;
                if (_loc_7 == ZPP_PubPool.nextVec2)
                {
                    ZPP_PubPool.nextVec2 = null;
                }
            }
            if (_loc_7.zpp_inner == null)
            {
                _loc_9 = false;
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
                _loc_6._immutable = _loc_9;
                _loc_6.x = _loc_4;
                _loc_6.y = _loc_5;
                _loc_7.zpp_inner = _loc_6;
                _loc_7.zpp_inner.outer = _loc_7;
            }
            else
            {
                if (_loc_7 != null)
                {
                }
                if (_loc_7.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_6 = _loc_7.zpp_inner;
                if (_loc_6._immutable)
                {
                    throw "Error: Vec2 is immutable";
                }
                if (_loc_6._isimmutable != null)
                {
                    _loc_6._isimmutable();
                }
                if (_loc_4 == _loc_4)
                {
                }
                if (_loc_5 != _loc_5)
                {
                    throw "Error: Vec2 components cannot be NaN";
                }
                if (_loc_7 != null)
                {
                }
                if (_loc_7.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_6 = _loc_7.zpp_inner;
                if (_loc_6._validate != null)
                {
                    _loc_6._validate();
                }
                if (_loc_7.zpp_inner.x == _loc_4)
                {
                    if (_loc_7 != null)
                    {
                    }
                    if (_loc_7.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_6 = _loc_7.zpp_inner;
                    if (_loc_6._validate != null)
                    {
                        _loc_6._validate();
                    }
                }
                if (_loc_7.zpp_inner.y != _loc_5)
                {
                    _loc_7.zpp_inner.x = _loc_4;
                    _loc_7.zpp_inner.y = _loc_5;
                    _loc_6 = _loc_7.zpp_inner;
                    if (_loc_6._invalidate != null)
                    {
                        _loc_6._invalidate(_loc_6);
                    }
                }
            }
            _loc_7.zpp_inner.weak = param2;
            return _loc_7;
        }// end function

        public function worldPointToLocal(param1:Vec2, param2:Boolean = false) : Vec2
        {
            var _loc_8:* = null as ZPP_Vec2;
            var _loc_9:* = null as Vec2;
            var _loc_10:* = null as ZPP_Vec2;
            var _loc_11:* = false;
            if (param1 != null)
            {
            }
            if (param1.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            if (param1 == null)
            {
                throw "Error: Cannot transform null Vec2";
            }
            var _loc_3:* = zpp_inner;
            if (_loc_3.zip_axis)
            {
                _loc_3.zip_axis = false;
                _loc_3.axisx = Math.sin(_loc_3.rot);
                _loc_3.axisy = Math.cos(_loc_3.rot);
            }
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            if (param1 != null)
            {
            }
            if (param1.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_8 = param1.zpp_inner;
            if (_loc_8._validate != null)
            {
                _loc_8._validate();
            }
            _loc_6 = param1.zpp_inner.x - zpp_inner.posx;
            if (param1 != null)
            {
            }
            if (param1.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_8 = param1.zpp_inner;
            if (_loc_8._validate != null)
            {
                _loc_8._validate();
            }
            _loc_7 = param1.zpp_inner.y - zpp_inner.posy;
            _loc_4 = _loc_6 * zpp_inner.axisy + _loc_7 * zpp_inner.axisx;
            _loc_5 = _loc_7 * zpp_inner.axisy - _loc_6 * zpp_inner.axisx;
            if (param1.zpp_inner.weak)
            {
                if (param1 != null)
                {
                }
                if (param1.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_8 = param1.zpp_inner;
                if (_loc_8._immutable)
                {
                    throw "Error: Vec2 is immutable";
                }
                if (_loc_8._isimmutable != null)
                {
                    _loc_8._isimmutable();
                }
                if (param1.zpp_inner._inuse)
                {
                    throw "Error: This Vec2 is not disposable";
                }
                _loc_8 = param1.zpp_inner;
                param1.zpp_inner.outer = null;
                param1.zpp_inner = null;
                _loc_9 = param1;
                _loc_9.zpp_pool = null;
                if (ZPP_PubPool.nextVec2 != null)
                {
                    ZPP_PubPool.nextVec2.zpp_pool = _loc_9;
                }
                else
                {
                    ZPP_PubPool.poolVec2 = _loc_9;
                }
                ZPP_PubPool.nextVec2 = _loc_9;
                _loc_9.zpp_disp = true;
                _loc_10 = _loc_8;
                if (_loc_10.outer != null)
                {
                    _loc_10.outer.zpp_inner = null;
                    _loc_10.outer = null;
                }
                _loc_10._isimmutable = null;
                _loc_10._validate = null;
                _loc_10._invalidate = null;
                _loc_10.next = ZPP_Vec2.zpp_pool;
                ZPP_Vec2.zpp_pool = _loc_10;
            }
            else
            {
            }
            if (_loc_4 == _loc_4)
            {
            }
            if (_loc_5 != _loc_5)
            {
                throw "Error: Vec2 components cannot be NaN";
            }
            if (ZPP_PubPool.poolVec2 == null)
            {
                _loc_9 = new Vec2();
            }
            else
            {
                _loc_9 = ZPP_PubPool.poolVec2;
                ZPP_PubPool.poolVec2 = _loc_9.zpp_pool;
                _loc_9.zpp_pool = null;
                _loc_9.zpp_disp = false;
                if (_loc_9 == ZPP_PubPool.nextVec2)
                {
                    ZPP_PubPool.nextVec2 = null;
                }
            }
            if (_loc_9.zpp_inner == null)
            {
                _loc_11 = false;
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
                _loc_8._immutable = _loc_11;
                _loc_8.x = _loc_4;
                _loc_8.y = _loc_5;
                _loc_9.zpp_inner = _loc_8;
                _loc_9.zpp_inner.outer = _loc_9;
            }
            else
            {
                if (_loc_9 != null)
                {
                }
                if (_loc_9.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_8 = _loc_9.zpp_inner;
                if (_loc_8._immutable)
                {
                    throw "Error: Vec2 is immutable";
                }
                if (_loc_8._isimmutable != null)
                {
                    _loc_8._isimmutable();
                }
                if (_loc_4 == _loc_4)
                {
                }
                if (_loc_5 != _loc_5)
                {
                    throw "Error: Vec2 components cannot be NaN";
                }
                if (_loc_9 != null)
                {
                }
                if (_loc_9.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_8 = _loc_9.zpp_inner;
                if (_loc_8._validate != null)
                {
                    _loc_8._validate();
                }
                if (_loc_9.zpp_inner.x == _loc_4)
                {
                    if (_loc_9 != null)
                    {
                    }
                    if (_loc_9.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_8 = _loc_9.zpp_inner;
                    if (_loc_8._validate != null)
                    {
                        _loc_8._validate();
                    }
                }
                if (_loc_9.zpp_inner.y != _loc_5)
                {
                    _loc_9.zpp_inner.x = _loc_4;
                    _loc_9.zpp_inner.y = _loc_5;
                    _loc_8 = _loc_9.zpp_inner;
                    if (_loc_8._invalidate != null)
                    {
                        _loc_8._invalidate(_loc_8);
                    }
                }
            }
            _loc_9.zpp_inner.weak = param2;
            return _loc_9;
        }// end function

        public function translateShapes(param1:Vec2) : Body
        {
            var _loc_4:* = null as ZPP_Shape;
            var _loc_5:* = null as ZPP_Vec2;
            var _loc_6:* = null as Vec2;
            var _loc_7:* = null as ZPP_Vec2;
            zpp_inner.immutable_midstep("Body::translateShapes()");
            if (param1 != null)
            {
            }
            if (param1.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            if (zpp_inner.world)
            {
                throw "Error: Space::world is immutable";
            }
            if (param1 == null)
            {
                throw "Error: Cannot displace by null Vec2";
            }
            var _loc_2:* = param1.zpp_inner.weak;
            param1.zpp_inner.weak = false;
            var _loc_3:* = zpp_inner.shapes.head;
            while (_loc_3 != null)
            {
                
                _loc_4 = _loc_3.elt;
                _loc_4.outer.translate(param1);
                _loc_3 = _loc_3.next;
            }
            param1.zpp_inner.weak = _loc_2;
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
            return this;
        }// end function

        public function transformShapes(param1:Mat23) : Body
        {
            var _loc_3:* = null as ZPP_Shape;
            zpp_inner.immutable_midstep("Body::transformShapes()");
            if (zpp_inner.world)
            {
                throw "Error: Space::world is immutable";
            }
            var _loc_2:* = zpp_inner.shapes.head;
            while (_loc_2 != null)
            {
                
                _loc_3 = _loc_2.elt;
                _loc_3.outer.transform(param1);
                _loc_2 = _loc_2.next;
            }
            return this;
        }// end function

        public function totalImpulse(param1:Body = undefined, param2:Boolean = false) : Vec3
        {
            var _loc_8:* = null as Arbiter;
            var _loc_9:* = 0;
            var _loc_10:* = null as ZPP_Arbiter;
            var _loc_11:* = null as Vec3;
            var _loc_12:* = 0;
            var _loc_13:* = null as ZPP_Vec3;
            var _loc_15:* = null as ZPP_Constraint;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = zpp_inner.arbiters;
            if (zpp_inner.wrap_arbiters == null)
            {
                zpp_inner.wrap_arbiters = ZPP_ArbiterList.get(zpp_inner.arbiters, true);
            }
            var _loc_7:* = zpp_inner.wrap_arbiters.iterator();
            do
            {
                
                _loc_7.zpp_critical = false;
                _loc_9 = _loc_7.zpp_i;
                (_loc_7.zpp_i + 1);
                _loc_8 = _loc_7.zpp_inner.at(_loc_9);
                _loc_10 = _loc_8.zpp_inner;
                if (_loc_10.type == ZPP_Arbiter.SENSOR)
                {
                }
                else
                {
                    if (param1 != null)
                    {
                    }
                    if (_loc_10.b2 != param1.zpp_inner)
                    {
                    }
                    if (_loc_10.b1 != param1.zpp_inner)
                    {
                    }
                    else
                    {
                        _loc_11 = _loc_10.wrapper().totalImpulse(this, param2);
                        _loc_9 = 1;
                        _loc_12 = _loc_9;
                        if (_loc_11 != null)
                        {
                        }
                        if (_loc_11.zpp_disp)
                        {
                            throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
                        }
                        _loc_13 = _loc_11.zpp_inner;
                        if (_loc_13._validate != null)
                        {
                            _loc_13._validate();
                        }
                        _loc_3 = _loc_3 + _loc_11.zpp_inner.x * _loc_12;
                        if (_loc_11 != null)
                        {
                        }
                        if (_loc_11.zpp_disp)
                        {
                            throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
                        }
                        _loc_13 = _loc_11.zpp_inner;
                        if (_loc_13._validate != null)
                        {
                            _loc_13._validate();
                        }
                        _loc_4 = _loc_4 + _loc_11.zpp_inner.y * _loc_12;
                        if (_loc_11 != null)
                        {
                        }
                        if (_loc_11.zpp_disp)
                        {
                            throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
                        }
                        _loc_13 = _loc_11.zpp_inner;
                        if (_loc_13._validate != null)
                        {
                            _loc_13._validate();
                        }
                        _loc_5 = _loc_5 + _loc_11.zpp_inner.z * _loc_9;
                        _loc_11.dispose();
                    }
                }
                _loc_7.zpp_inner.zpp_inner.valmod();
                _loc_9 = _loc_7.zpp_inner.zpp_gl();
                _loc_7.zpp_critical = true;
            }while (_loc_7.zpp_i < _loc_9 ? (true) : (_loc_7.zpp_next = ArbiterIterator.zpp_pool, ArbiterIterator.zpp_pool = _loc_7, _loc_7.zpp_inner = null, false))
            var _loc_14:* = zpp_inner.constraints.head;
            while (_loc_14 != null)
            {
                
                _loc_15 = _loc_14.elt;
                if (_loc_15.active)
                {
                    _loc_11 = _loc_15.outer.bodyImpulse(this);
                    _loc_9 = 1;
                    _loc_12 = _loc_9;
                    if (_loc_11 != null)
                    {
                    }
                    if (_loc_11.zpp_disp)
                    {
                        throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
                    }
                    _loc_13 = _loc_11.zpp_inner;
                    if (_loc_13._validate != null)
                    {
                        _loc_13._validate();
                    }
                    _loc_3 = _loc_3 + _loc_11.zpp_inner.x * _loc_12;
                    if (_loc_11 != null)
                    {
                    }
                    if (_loc_11.zpp_disp)
                    {
                        throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
                    }
                    _loc_13 = _loc_11.zpp_inner;
                    if (_loc_13._validate != null)
                    {
                        _loc_13._validate();
                    }
                    _loc_4 = _loc_4 + _loc_11.zpp_inner.y * _loc_12;
                    if (_loc_11 != null)
                    {
                    }
                    if (_loc_11.zpp_disp)
                    {
                        throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
                    }
                    _loc_13 = _loc_11.zpp_inner;
                    if (_loc_13._validate != null)
                    {
                        _loc_13._validate();
                    }
                    _loc_5 = _loc_5 + _loc_11.zpp_inner.z * _loc_9;
                    _loc_11.dispose();
                }
                _loc_14 = _loc_14.next;
            }
            return Vec3.get(_loc_3, _loc_4, _loc_5);
        }// end function

        public function totalFluidImpulse(param1:Body = undefined) : Vec3
        {
            var _loc_7:* = null as Arbiter;
            var _loc_8:* = 0;
            var _loc_9:* = null as ZPP_Arbiter;
            var _loc_10:* = null as Vec3;
            var _loc_11:* = null as Arbiter;
            var _loc_12:* = 0;
            var _loc_13:* = null as ZPP_Vec3;
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = zpp_inner.arbiters;
            if (zpp_inner.wrap_arbiters == null)
            {
                zpp_inner.wrap_arbiters = ZPP_ArbiterList.get(zpp_inner.arbiters, true);
            }
            var _loc_6:* = zpp_inner.wrap_arbiters.iterator();
            do
            {
                
                _loc_6.zpp_critical = false;
                _loc_8 = _loc_6.zpp_i;
                (_loc_6.zpp_i + 1);
                _loc_7 = _loc_6.zpp_inner.at(_loc_8);
                _loc_9 = _loc_7.zpp_inner;
                if (_loc_9.type != ZPP_Arbiter.FLUID)
                {
                }
                else
                {
                    if (param1 != null)
                    {
                    }
                    if (_loc_9.b2 != param1.zpp_inner)
                    {
                    }
                    if (_loc_9.b1 != param1.zpp_inner)
                    {
                    }
                    else
                    {
                        _loc_11 = _loc_9.wrapper();
                        _loc_10 = (_loc_11.zpp_inner.type == ZPP_Arbiter.FLUID ? (_loc_11.zpp_inner.fluidarb.outer_zn) : (null)).totalImpulse(this);
                        _loc_8 = 1;
                        _loc_12 = _loc_8;
                        if (_loc_10 != null)
                        {
                        }
                        if (_loc_10.zpp_disp)
                        {
                            throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
                        }
                        _loc_13 = _loc_10.zpp_inner;
                        if (_loc_13._validate != null)
                        {
                            _loc_13._validate();
                        }
                        _loc_2 = _loc_2 + _loc_10.zpp_inner.x * _loc_12;
                        if (_loc_10 != null)
                        {
                        }
                        if (_loc_10.zpp_disp)
                        {
                            throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
                        }
                        _loc_13 = _loc_10.zpp_inner;
                        if (_loc_13._validate != null)
                        {
                            _loc_13._validate();
                        }
                        _loc_3 = _loc_3 + _loc_10.zpp_inner.y * _loc_12;
                        if (_loc_10 != null)
                        {
                        }
                        if (_loc_10.zpp_disp)
                        {
                            throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
                        }
                        _loc_13 = _loc_10.zpp_inner;
                        if (_loc_13._validate != null)
                        {
                            _loc_13._validate();
                        }
                        _loc_4 = _loc_4 + _loc_10.zpp_inner.z * _loc_8;
                        _loc_10.dispose();
                    }
                }
                _loc_6.zpp_inner.zpp_inner.valmod();
                _loc_8 = _loc_6.zpp_inner.zpp_gl();
                _loc_6.zpp_critical = true;
            }while (_loc_6.zpp_i < _loc_8 ? (true) : (_loc_6.zpp_next = ArbiterIterator.zpp_pool, ArbiterIterator.zpp_pool = _loc_6, _loc_6.zpp_inner = null, false))
            return Vec3.get(_loc_2, _loc_3, _loc_4);
        }// end function

        public function totalContactsImpulse(param1:Body = undefined, param2:Boolean = false) : Vec3
        {
            var _loc_8:* = null as Arbiter;
            var _loc_9:* = 0;
            var _loc_10:* = null as ZPP_Arbiter;
            var _loc_11:* = null as Vec3;
            var _loc_12:* = null as Arbiter;
            var _loc_13:* = 0;
            var _loc_14:* = null as ZPP_Vec3;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = zpp_inner.arbiters;
            if (zpp_inner.wrap_arbiters == null)
            {
                zpp_inner.wrap_arbiters = ZPP_ArbiterList.get(zpp_inner.arbiters, true);
            }
            var _loc_7:* = zpp_inner.wrap_arbiters.iterator();
            do
            {
                
                _loc_7.zpp_critical = false;
                _loc_9 = _loc_7.zpp_i;
                (_loc_7.zpp_i + 1);
                _loc_8 = _loc_7.zpp_inner.at(_loc_9);
                _loc_10 = _loc_8.zpp_inner;
                if (_loc_10.type != ZPP_Arbiter.COL)
                {
                }
                else
                {
                    if (param1 != null)
                    {
                    }
                    if (_loc_10.b2 != param1.zpp_inner)
                    {
                    }
                    if (_loc_10.b1 != param1.zpp_inner)
                    {
                    }
                    else
                    {
                        _loc_12 = _loc_10.wrapper();
                        _loc_11 = (_loc_12.zpp_inner.type == ZPP_Arbiter.COL ? (_loc_12.zpp_inner.colarb.outer_zn) : (null)).totalImpulse(this, param2);
                        _loc_9 = 1;
                        _loc_13 = _loc_9;
                        if (_loc_11 != null)
                        {
                        }
                        if (_loc_11.zpp_disp)
                        {
                            throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
                        }
                        _loc_14 = _loc_11.zpp_inner;
                        if (_loc_14._validate != null)
                        {
                            _loc_14._validate();
                        }
                        _loc_3 = _loc_3 + _loc_11.zpp_inner.x * _loc_13;
                        if (_loc_11 != null)
                        {
                        }
                        if (_loc_11.zpp_disp)
                        {
                            throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
                        }
                        _loc_14 = _loc_11.zpp_inner;
                        if (_loc_14._validate != null)
                        {
                            _loc_14._validate();
                        }
                        _loc_4 = _loc_4 + _loc_11.zpp_inner.y * _loc_13;
                        if (_loc_11 != null)
                        {
                        }
                        if (_loc_11.zpp_disp)
                        {
                            throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
                        }
                        _loc_14 = _loc_11.zpp_inner;
                        if (_loc_14._validate != null)
                        {
                            _loc_14._validate();
                        }
                        _loc_5 = _loc_5 + _loc_11.zpp_inner.z * _loc_9;
                        _loc_11.dispose();
                    }
                }
                _loc_7.zpp_inner.zpp_inner.valmod();
                _loc_9 = _loc_7.zpp_inner.zpp_gl();
                _loc_7.zpp_critical = true;
            }while (_loc_7.zpp_i < _loc_9 ? (true) : (_loc_7.zpp_next = ArbiterIterator.zpp_pool, ArbiterIterator.zpp_pool = _loc_7, _loc_7.zpp_inner = null, false))
            return Vec3.get(_loc_3, _loc_4, _loc_5);
        }// end function

        override public function toString() : String
        {
            return (zpp_inner.world ? ("(space::world") : ("(" + (zpp_inner.type == ZPP_Flags.id_BodyType_DYNAMIC ? ("dynamic") : (zpp_inner.type == ZPP_Flags.id_BodyType_STATIC ? ("static") : ("kinematic"))))) + ")#" + zpp_inner_i.id;
        }// end function

        public function tangentImpulse(param1:Body = undefined, param2:Boolean = false) : Vec3
        {
            var _loc_8:* = null as Arbiter;
            var _loc_9:* = 0;
            var _loc_10:* = null as ZPP_Arbiter;
            var _loc_11:* = null as Vec3;
            var _loc_12:* = null as Arbiter;
            var _loc_13:* = 0;
            var _loc_14:* = null as ZPP_Vec3;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = zpp_inner.arbiters;
            if (zpp_inner.wrap_arbiters == null)
            {
                zpp_inner.wrap_arbiters = ZPP_ArbiterList.get(zpp_inner.arbiters, true);
            }
            var _loc_7:* = zpp_inner.wrap_arbiters.iterator();
            do
            {
                
                _loc_7.zpp_critical = false;
                _loc_9 = _loc_7.zpp_i;
                (_loc_7.zpp_i + 1);
                _loc_8 = _loc_7.zpp_inner.at(_loc_9);
                _loc_10 = _loc_8.zpp_inner;
                if (_loc_10.type != ZPP_Arbiter.COL)
                {
                }
                else
                {
                    if (param1 != null)
                    {
                    }
                    if (_loc_10.b2 != param1.zpp_inner)
                    {
                    }
                    if (_loc_10.b1 != param1.zpp_inner)
                    {
                    }
                    else
                    {
                        _loc_12 = _loc_10.wrapper();
                        _loc_11 = (_loc_12.zpp_inner.type == ZPP_Arbiter.COL ? (_loc_12.zpp_inner.colarb.outer_zn) : (null)).tangentImpulse(this, param2);
                        _loc_9 = 1;
                        _loc_13 = _loc_9;
                        if (_loc_11 != null)
                        {
                        }
                        if (_loc_11.zpp_disp)
                        {
                            throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
                        }
                        _loc_14 = _loc_11.zpp_inner;
                        if (_loc_14._validate != null)
                        {
                            _loc_14._validate();
                        }
                        _loc_3 = _loc_3 + _loc_11.zpp_inner.x * _loc_13;
                        if (_loc_11 != null)
                        {
                        }
                        if (_loc_11.zpp_disp)
                        {
                            throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
                        }
                        _loc_14 = _loc_11.zpp_inner;
                        if (_loc_14._validate != null)
                        {
                            _loc_14._validate();
                        }
                        _loc_4 = _loc_4 + _loc_11.zpp_inner.y * _loc_13;
                        if (_loc_11 != null)
                        {
                        }
                        if (_loc_11.zpp_disp)
                        {
                            throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
                        }
                        _loc_14 = _loc_11.zpp_inner;
                        if (_loc_14._validate != null)
                        {
                            _loc_14._validate();
                        }
                        _loc_5 = _loc_5 + _loc_11.zpp_inner.z * _loc_9;
                        _loc_11.dispose();
                    }
                }
                _loc_7.zpp_inner.zpp_inner.valmod();
                _loc_9 = _loc_7.zpp_inner.zpp_gl();
                _loc_7.zpp_critical = true;
            }while (_loc_7.zpp_i < _loc_9 ? (true) : (_loc_7.zpp_next = ArbiterIterator.zpp_pool, ArbiterIterator.zpp_pool = _loc_7, _loc_7.zpp_inner = null, false))
            return Vec3.get(_loc_3, _loc_4, _loc_5);
        }// end function

        public function set_velocity(param1:Vec2) : Vec2
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
                throw "Error: Body::" + "velocity" + " cannot be null";
            }
            if (zpp_inner.wrap_vel == null)
            {
                zpp_inner.setupVelocity();
            }
            var _loc_2:* = zpp_inner.wrap_vel;
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
            if (zpp_inner.wrap_vel == null)
            {
                zpp_inner.setupVelocity();
            }
            return zpp_inner.wrap_vel;
        }// end function

        public function set_type(param1:BodyType) : BodyType
        {
            var _loc_2:* = 0;
            zpp_inner.immutable_midstep("Body::type");
            if (zpp_inner.world)
            {
                throw "Error: Space::world is immutable";
            }
            if (ZPP_Body.types[zpp_inner.type] != param1)
            {
                if (param1 == null)
                {
                    throw "Error: Cannot use null BodyType";
                }
                if (ZPP_Flags.BodyType_DYNAMIC == null)
                {
                    ZPP_Flags.internal = true;
                    ZPP_Flags.BodyType_DYNAMIC = new BodyType();
                    ZPP_Flags.internal = false;
                }
                if (param1 == ZPP_Flags.BodyType_DYNAMIC)
                {
                    _loc_2 = ZPP_Flags.id_BodyType_DYNAMIC;
                }
                else
                {
                    if (ZPP_Flags.BodyType_KINEMATIC == null)
                    {
                        ZPP_Flags.internal = true;
                        ZPP_Flags.BodyType_KINEMATIC = new BodyType();
                        ZPP_Flags.internal = false;
                    }
                    if (param1 == ZPP_Flags.BodyType_KINEMATIC)
                    {
                        _loc_2 = ZPP_Flags.id_BodyType_KINEMATIC;
                    }
                    else
                    {
                        _loc_2 = ZPP_Flags.id_BodyType_STATIC;
                    }
                }
                if (_loc_2 == ZPP_Flags.id_BodyType_STATIC)
                {
                }
                if (zpp_inner.space != null)
                {
                    zpp_inner.velx = 0;
                    zpp_inner.vely = 0;
                    zpp_inner.angvel = 0;
                }
                zpp_inner.invalidate_type();
                if (zpp_inner.space != null)
                {
                    zpp_inner.space.transmitType(zpp_inner, _loc_2);
                }
                else
                {
                    zpp_inner.type = _loc_2;
                }
            }
            return ZPP_Body.types[zpp_inner.type];
        }// end function

        public function set_torque(param1:Number) : Number
        {
            if (zpp_inner.world)
            {
                throw "Error: Space::world is immutable";
            }
            if (zpp_inner.type != ZPP_Flags.id_BodyType_DYNAMIC)
            {
                throw "Error: Non-dynamic body cannot have torque applied.";
            }
            if (param1 != param1)
            {
                throw "Error: Body::torque cannot be NaN";
            }
            if (zpp_inner.torque != param1)
            {
                zpp_inner.torque = param1;
                zpp_inner.wake();
            }
            return zpp_inner.torque;
        }// end function

        public function set_surfaceVel(param1:Vec2) : Vec2
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
                throw "Error: Body::" + "surfaceVel" + " cannot be null";
            }
            if (zpp_inner.wrap_svel == null)
            {
                zpp_inner.setupsvel();
            }
            var _loc_2:* = zpp_inner.wrap_svel;
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
            if (zpp_inner.wrap_svel == null)
            {
                zpp_inner.setupsvel();
            }
            return zpp_inner.wrap_svel;
        }// end function

        public function set_space(param1:Space) : Space
        {
            var _loc_2:* = null as BodyList;
            if (zpp_inner.compound != null)
            {
                throw "Error: Cannot set the space of a Body belonging to a Compound, only the root Compound space can be set";
            }
            zpp_inner.immutable_midstep("Body::space");
            if (zpp_inner.world)
            {
                throw "Error: Space::world is immutable";
            }
            if ((zpp_inner.space == null ? (null) : (zpp_inner.space.outer)) != param1)
            {
                if ((zpp_inner.space == null ? (null) : (zpp_inner.space.outer)) != null)
                {
                    zpp_inner.component.woken = false;
                }
                if ((zpp_inner.space == null ? (null) : (zpp_inner.space.outer)) != null)
                {
                    (zpp_inner.space == null ? (null) : (zpp_inner.space.outer)).zpp_inner.wrap_bodies.remove(this);
                }
                if (param1 != null)
                {
                    _loc_2 = param1.zpp_inner.wrap_bodies;
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

        public function set_rotation(param1:Number) : Number
        {
            var _loc_2:* = null as ZPP_Body;
            var _loc_3:* = null as ZNPNode_ZPP_Shape;
            var _loc_4:* = null as ZPP_Shape;
            zpp_inner.immutable_midstep("Body::rotation");
            if (zpp_inner.world)
            {
                throw "Error: Space::world is immutable";
            }
            if (zpp_inner.type == ZPP_Flags.id_BodyType_STATIC)
            {
            }
            if (zpp_inner.space != null)
            {
                throw "Error: Static objects cannot be rotated once inside a Space";
            }
            if (zpp_inner.rot != param1)
            {
                if (param1 != param1)
                {
                    throw "Error: Body::rotation cannot be NaN";
                }
                zpp_inner.rot = param1;
                _loc_2 = zpp_inner;
                _loc_2.zip_axis = true;
                _loc_3 = _loc_2.shapes.head;
                while (_loc_3 != null)
                {
                    
                    _loc_4 = _loc_3.elt;
                    if (_loc_4.type == ZPP_Flags.id_ShapeType_POLYGON)
                    {
                        _loc_4.polygon.invalidate_gverts();
                        _loc_4.polygon.invalidate_gaxi();
                    }
                    _loc_4.invalidate_worldCOM();
                    _loc_3 = _loc_3.next;
                }
                _loc_2.zip_worldCOM = true;
                zpp_inner.wake();
            }
            return zpp_inner.rot;
        }// end function

        public function set_position(param1:Vec2) : Vec2
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
                throw "Error: Body::" + "position" + " cannot be null";
            }
            if (zpp_inner.wrap_pos == null)
            {
                zpp_inner.setupPosition();
            }
            var _loc_2:* = zpp_inner.wrap_pos;
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
            if (zpp_inner.wrap_pos == null)
            {
                zpp_inner.setupPosition();
            }
            return zpp_inner.wrap_pos;
        }// end function

        public function set_massMode(param1:MassMode) : MassMode
        {
            zpp_inner.immutable_midstep("Body::massMode");
            if (zpp_inner.world)
            {
                throw "Error: Space::world is immutable";
            }
            if (param1 == null)
            {
                throw "Error: cannot use null massMode";
            }
            if (ZPP_Flags.MassMode_DEFAULT == null)
            {
                ZPP_Flags.internal = true;
                ZPP_Flags.MassMode_DEFAULT = new MassMode();
                ZPP_Flags.internal = false;
            }
            if (param1 == ZPP_Flags.MassMode_DEFAULT)
            {
                zpp_inner.massMode = ZPP_Flags.id_MassMode_DEFAULT;
            }
            else
            {
                zpp_inner.massMode = ZPP_Flags.id_MassMode_FIXED;
            }
            zpp_inner.invalidate_mass();
            if (ZPP_Flags.MassMode_DEFAULT == null)
            {
                ZPP_Flags.internal = true;
                ZPP_Flags.MassMode_DEFAULT = new MassMode();
                ZPP_Flags.internal = false;
            }
            if (ZPP_Flags.MassMode_FIXED == null)
            {
                ZPP_Flags.internal = true;
                ZPP_Flags.MassMode_FIXED = new MassMode();
                ZPP_Flags.internal = false;
            }
            return [ZPP_Flags.MassMode_DEFAULT, ZPP_Flags.MassMode_FIXED][zpp_inner.massMode];
        }// end function

        public function set_mass(param1:Number) : Number
        {
            zpp_inner.immutable_midstep("Body::mass");
            if (zpp_inner.world)
            {
                throw "Error: Space::world is immutable";
            }
            if (param1 != param1)
            {
                throw "Error: Mass cannot be NaN";
            }
            if (param1 <= 0)
            {
                throw "Error: Mass must be strictly positive";
            }
            if (param1 >= 17899999999999994000000000000)
            {
                throw "Error: Mass cannot be infinite, use allowMovement = false instead";
            }
            zpp_inner.massMode = ZPP_Flags.id_MassMode_FIXED;
            zpp_inner.cmass = param1;
            zpp_inner.invalidate_mass();
            if (zpp_inner.world)
            {
                throw "Error: Space::world has no mass";
            }
            zpp_inner.validate_mass();
            if (zpp_inner.massMode == ZPP_Flags.id_MassMode_DEFAULT)
            {
            }
            if (zpp_inner.shapes.head == null)
            {
                throw "Error: Given current mass mode, Body::mass only makes sense if it contains shapes";
            }
            return zpp_inner.cmass;
        }// end function

        public function set_kinematicVel(param1:Vec2) : Vec2
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
                throw "Error: Body::" + "kinematicVel" + " cannot be null";
            }
            if (zpp_inner.wrap_kinvel == null)
            {
                zpp_inner.setupkinvel();
            }
            var _loc_2:* = zpp_inner.wrap_kinvel;
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
            if (zpp_inner.wrap_kinvel == null)
            {
                zpp_inner.setupkinvel();
            }
            return zpp_inner.wrap_kinvel;
        }// end function

        public function set_kinAngVel(param1:Number) : Number
        {
            if (zpp_inner.world)
            {
                throw "Error: Space::world is immutable";
            }
            if (zpp_inner.kinangvel != param1)
            {
                if (param1 != param1)
                {
                    throw "Error: Body::kinAngVel cannot be NaN";
                }
                zpp_inner.kinangvel = param1;
                zpp_inner.wake();
            }
            return zpp_inner.kinangvel;
        }// end function

        public function set_isBullet(param1:Boolean) : Boolean
        {
            zpp_inner.bulletEnabled = param1;
            return zpp_inner.bulletEnabled;
        }// end function

        public function set_inertiaMode(param1:InertiaMode) : InertiaMode
        {
            zpp_inner.immutable_midstep("Body::inertiaMode");
            if (zpp_inner.world)
            {
                throw "Error: Space::world is immutable";
            }
            if (param1 == null)
            {
                throw "Error: Cannot use null InertiaMode";
            }
            if (ZPP_Flags.InertiaMode_FIXED == null)
            {
                ZPP_Flags.internal = true;
                ZPP_Flags.InertiaMode_FIXED = new InertiaMode();
                ZPP_Flags.internal = false;
            }
            if (param1 == ZPP_Flags.InertiaMode_FIXED)
            {
                zpp_inner.inertiaMode = ZPP_Flags.id_InertiaMode_FIXED;
            }
            else
            {
                zpp_inner.inertiaMode = ZPP_Flags.id_InertiaMode_DEFAULT;
            }
            zpp_inner.invalidate_inertia();
            if (ZPP_Flags.InertiaMode_DEFAULT == null)
            {
                ZPP_Flags.internal = true;
                ZPP_Flags.InertiaMode_DEFAULT = new InertiaMode();
                ZPP_Flags.internal = false;
            }
            if (ZPP_Flags.InertiaMode_FIXED == null)
            {
                ZPP_Flags.internal = true;
                ZPP_Flags.InertiaMode_FIXED = new InertiaMode();
                ZPP_Flags.internal = false;
            }
            return [ZPP_Flags.InertiaMode_DEFAULT, ZPP_Flags.InertiaMode_FIXED][zpp_inner.inertiaMode];
        }// end function

        public function set_inertia(param1:Number) : Number
        {
            var _loc_2:* = null as ShapeList;
            zpp_inner.immutable_midstep("Body::inertia");
            if (zpp_inner.world)
            {
                throw "Error: Space::world is immutable";
            }
            if (param1 != param1)
            {
                throw "Error: Inertia cannot be NaN";
            }
            if (param1 <= 0)
            {
                throw "Error: Inertia must be strictly positive";
            }
            if (param1 >= 17899999999999994000000000000)
            {
                throw "Error: Inertia cannot be infinite, use allowRotation = false instead";
            }
            zpp_inner.inertiaMode = ZPP_Flags.id_InertiaMode_FIXED;
            zpp_inner.cinertia = param1;
            zpp_inner.invalidate_inertia();
            if (zpp_inner.world)
            {
                throw "Error: Space::world has no inertia";
            }
            zpp_inner.validate_inertia();
            if (zpp_inner.inertiaMode == ZPP_Flags.id_InertiaMode_DEFAULT)
            {
                _loc_2 = zpp_inner.wrap_shapes;
            }
            if (_loc_2.zpp_inner.inner.head == null)
            {
                throw "Error: Given current inertia mode flag, Body::inertia only makes sense if Body contains Shapes";
            }
            return zpp_inner.cinertia;
        }// end function

        public function set_gravMassScale(param1:Number) : Number
        {
            zpp_inner.immutable_midstep("Body::gravMassScale");
            if (zpp_inner.world)
            {
                throw "Error: Space::world is immutable";
            }
            if (param1 != param1)
            {
                throw "Error: gravMassScale cannot be NaN";
            }
            zpp_inner.gravMassMode = ZPP_Flags.id_GravMassMode_SCALED;
            zpp_inner.gravMassScale = param1;
            zpp_inner.invalidate_gravMassScale();
            zpp_inner.validate_gravMassScale();
            if (zpp_inner.shapes.head == null)
            {
                if (zpp_inner.massMode == ZPP_Flags.id_MassMode_DEFAULT)
                {
                }
                if (zpp_inner.gravMassMode != ZPP_Flags.id_GravMassMode_SCALED)
                {
                    throw "Error: Given current mass/gravMass modes; Body::gravMassScale only makes sense if it contains Shapes";
                }
            }
            return zpp_inner.gravMassScale;
        }// end function

        public function set_gravMassMode(param1:GravMassMode) : GravMassMode
        {
            zpp_inner.immutable_midstep("Body::gravMassMode");
            if (zpp_inner.world)
            {
                throw "Error: Space::world is immutable";
            }
            if (param1 == null)
            {
                throw "Error: Cannot use null gravMassMode";
            }
            if (ZPP_Flags.GravMassMode_SCALED == null)
            {
                ZPP_Flags.internal = true;
                ZPP_Flags.GravMassMode_SCALED = new GravMassMode();
                ZPP_Flags.internal = false;
            }
            if (param1 == ZPP_Flags.GravMassMode_SCALED)
            {
                zpp_inner.gravMassMode = ZPP_Flags.id_GravMassMode_SCALED;
            }
            else
            {
                if (ZPP_Flags.GravMassMode_DEFAULT == null)
                {
                    ZPP_Flags.internal = true;
                    ZPP_Flags.GravMassMode_DEFAULT = new GravMassMode();
                    ZPP_Flags.internal = false;
                }
                if (param1 == ZPP_Flags.GravMassMode_DEFAULT)
                {
                    zpp_inner.gravMassMode = ZPP_Flags.id_GravMassMode_DEFAULT;
                }
                else
                {
                    zpp_inner.gravMassMode = ZPP_Flags.id_GravMassMode_FIXED;
                }
            }
            zpp_inner.invalidate_gravMass();
            if (ZPP_Flags.GravMassMode_DEFAULT == null)
            {
                ZPP_Flags.internal = true;
                ZPP_Flags.GravMassMode_DEFAULT = new GravMassMode();
                ZPP_Flags.internal = false;
            }
            if (ZPP_Flags.GravMassMode_FIXED == null)
            {
                ZPP_Flags.internal = true;
                ZPP_Flags.GravMassMode_FIXED = new GravMassMode();
                ZPP_Flags.internal = false;
            }
            if (ZPP_Flags.GravMassMode_SCALED == null)
            {
                ZPP_Flags.internal = true;
                ZPP_Flags.GravMassMode_SCALED = new GravMassMode();
                ZPP_Flags.internal = false;
            }
            return [ZPP_Flags.GravMassMode_DEFAULT, ZPP_Flags.GravMassMode_FIXED, ZPP_Flags.GravMassMode_SCALED][zpp_inner.massMode];
        }// end function

        public function set_gravMass(param1:Number) : Number
        {
            zpp_inner.immutable_midstep("Body::gravMass");
            if (zpp_inner.world)
            {
                throw "Error: Space::world is immutable";
            }
            if (param1 != param1)
            {
                throw "Error: gravMass cannot be NaN";
            }
            zpp_inner.gravMassMode = ZPP_Flags.id_GravMassMode_FIXED;
            zpp_inner.gravMass = param1;
            zpp_inner.invalidate_gravMass();
            if (zpp_inner.world)
            {
                throw "Error: Space::world has no gravMass";
            }
            zpp_inner.validate_gravMass();
            if (zpp_inner.shapes.head == null)
            {
                if (zpp_inner.massMode == ZPP_Flags.id_MassMode_DEFAULT)
                {
                }
                if (zpp_inner.gravMassMode != ZPP_Flags.id_GravMassMode_FIXED)
                {
                    throw "Error: Given current mass/gravMass modes; Body::gravMass only makes sense if it contains Shapes";
                }
            }
            return zpp_inner.gravMass;
        }// end function

        public function set_force(param1:Vec2) : Vec2
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
                throw "Error: Body::" + "force" + " cannot be null";
            }
            if (zpp_inner.wrap_force == null)
            {
                zpp_inner.setupForce();
            }
            var _loc_2:* = zpp_inner.wrap_force;
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
            if (zpp_inner.wrap_force == null)
            {
                zpp_inner.setupForce();
            }
            return zpp_inner.wrap_force;
        }// end function

        public function set_disableCCD(param1:Boolean) : Boolean
        {
            zpp_inner.disableCCD = param1;
            return zpp_inner.disableCCD;
        }// end function

        public function set_compound(param1:Compound) : Compound
        {
            var _loc_2:* = null as BodyList;
            if ((zpp_inner.compound == null ? (null) : (zpp_inner.compound.outer)) != param1)
            {
                if ((zpp_inner.compound == null ? (null) : (zpp_inner.compound.outer)) != null)
                {
                    (zpp_inner.compound == null ? (null) : (zpp_inner.compound.outer)).zpp_inner.wrap_bodies.remove(this);
                }
                if (param1 != null)
                {
                    _loc_2 = param1.zpp_inner.wrap_bodies;
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

        public function set_angularVel(param1:Number) : Number
        {
            if (zpp_inner.world)
            {
                throw "Error: Space::world is immutable";
            }
            if (zpp_inner.angvel != param1)
            {
                if (param1 != param1)
                {
                    throw "Error: Body::angularVel cannot be NaN";
                }
                if (zpp_inner.type == ZPP_Flags.id_BodyType_STATIC)
                {
                    throw "Error: A static object cannot be given a velocity";
                }
                zpp_inner.angvel = param1;
                zpp_inner.wake();
            }
            return zpp_inner.angvel;
        }// end function

        public function set_allowRotation(param1:Boolean) : Boolean
        {
            zpp_inner.immutable_midstep("Body::" + ("" + param1));
            if (!zpp_inner.norotate != param1)
            {
                zpp_inner.norotate = !param1;
                zpp_inner.invalidate_inertia();
            }
            return !zpp_inner.norotate;
        }// end function

        public function set_allowMovement(param1:Boolean) : Boolean
        {
            zpp_inner.immutable_midstep("Body::" + ("" + param1));
            if (!zpp_inner.nomove != param1)
            {
                zpp_inner.nomove = !param1;
                zpp_inner.invalidate_mass();
            }
            return !zpp_inner.nomove;
        }// end function

        public function setVelocityFromTarget(param1:Vec2, param2:Number, param3:Number) : Body
        {
            var _loc_5:* = null as Vec2;
            var _loc_7:* = null as ZPP_Vec2;
            var _loc_11:* = null as Vec2;
            var _loc_12:* = null as ZPP_Vec2;
            if (param1 != null)
            {
            }
            if (param1.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            if (param1 == null)
            {
                throw "Cannot set velocity for null target position";
            }
            if (param3 == 0)
            {
                throw "deltaTime cannot be 0 for setVelocityFromTarget";
            }
            var _loc_4:* = 1 / param3;
            if (zpp_inner.wrap_vel == null)
            {
                zpp_inner.setupVelocity();
            }
            _loc_5 = zpp_inner.wrap_vel;
            if (zpp_inner.wrap_pos == null)
            {
                zpp_inner.setupPosition();
            }
            var _loc_6:* = param1.sub(zpp_inner.wrap_pos, true).muleq(_loc_4);
            if (_loc_5 != null)
            {
            }
            if (_loc_5.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            if (_loc_6 != null)
            {
            }
            if (_loc_6.zpp_disp)
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
            if (_loc_6 == null)
            {
                throw "Error: Cannot assign null Vec2";
            }
            if (_loc_6 != null)
            {
            }
            if (_loc_6.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_7 = _loc_6.zpp_inner;
            if (_loc_7._validate != null)
            {
                _loc_7._validate();
            }
            var _loc_9:* = _loc_6.zpp_inner.x;
            if (_loc_6 != null)
            {
            }
            if (_loc_6.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_7 = _loc_6.zpp_inner;
            if (_loc_7._validate != null)
            {
                _loc_7._validate();
            }
            var _loc_10:* = _loc_6.zpp_inner.y;
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
            if (_loc_9 == _loc_9)
            {
            }
            if (_loc_10 != _loc_10)
            {
                throw "Error: Vec2 components cannot be NaN";
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
            if (_loc_5.zpp_inner.x == _loc_9)
            {
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
            }
            if (_loc_5.zpp_inner.y != _loc_10)
            {
                _loc_5.zpp_inner.x = _loc_9;
                _loc_5.zpp_inner.y = _loc_10;
                _loc_7 = _loc_5.zpp_inner;
                if (_loc_7._invalidate != null)
                {
                    _loc_7._invalidate(_loc_7);
                }
            }
            var _loc_8:* = _loc_5;
            if (_loc_6.zpp_inner.weak)
            {
                if (_loc_6 != null)
                {
                }
                if (_loc_6.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_7 = _loc_6.zpp_inner;
                if (_loc_7._immutable)
                {
                    throw "Error: Vec2 is immutable";
                }
                if (_loc_7._isimmutable != null)
                {
                    _loc_7._isimmutable();
                }
                if (_loc_6.zpp_inner._inuse)
                {
                    throw "Error: This Vec2 is not disposable";
                }
                _loc_7 = _loc_6.zpp_inner;
                _loc_6.zpp_inner.outer = null;
                _loc_6.zpp_inner = null;
                _loc_11 = _loc_6;
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
                _loc_12 = _loc_7;
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
            else
            {
            }
            _loc_9 = (param2 - zpp_inner.rot) * _loc_4;
            if (zpp_inner.world)
            {
                throw "Error: Space::world is immutable";
            }
            if (zpp_inner.angvel != _loc_9)
            {
                if (_loc_9 != _loc_9)
                {
                    throw "Error: Body::angularVel cannot be NaN";
                }
                if (zpp_inner.type == ZPP_Flags.id_BodyType_STATIC)
                {
                    throw "Error: A static object cannot be given a velocity";
                }
                zpp_inner.angvel = _loc_9;
                zpp_inner.wake();
            }
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
                _loc_5 = param1;
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
                _loc_12 = _loc_7;
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
            else
            {
            }
            return this;
        }// end function

        public function setShapeMaterials(param1:Material) : Body
        {
            var _loc_3:* = null as ZPP_Shape;
            var _loc_4:* = null as Shape;
            zpp_inner.immutable_midstep("Body::setShapeMaterials()");
            if (zpp_inner.world)
            {
                throw "Error: Space::world is immutable";
            }
            var _loc_2:* = zpp_inner.shapes.head;
            while (_loc_2 != null)
            {
                
                _loc_3 = _loc_2.elt;
                _loc_4 = _loc_3.outer;
                _loc_4.zpp_inner.immutable_midstep("Shape::material");
                if (param1 == null)
                {
                    throw "Error: Cannot assign null as Shape material";
                }
                _loc_4.zpp_inner.setMaterial(param1.zpp_inner);
                _loc_4.zpp_inner.material.wrapper();
                _loc_2 = _loc_2.next;
            }
            return this;
        }// end function

        public function setShapeFluidProperties(param1:FluidProperties) : Body
        {
            var _loc_3:* = null as ZPP_Shape;
            var _loc_4:* = null as Shape;
            zpp_inner.immutable_midstep("Body::setShapeFluidProperties()");
            if (zpp_inner.world)
            {
                throw "Error: Space::world is immutable";
            }
            var _loc_2:* = zpp_inner.shapes.head;
            while (_loc_2 != null)
            {
                
                _loc_3 = _loc_2.elt;
                _loc_4 = _loc_3.outer;
                if (param1 == null)
                {
                    throw "Error: Cannot assign null as Shape fluidProperties, disable fluids by setting fluidEnabled to false";
                }
                _loc_4.zpp_inner.setFluid(param1.zpp_inner);
                _loc_4.zpp_inner.immutable_midstep("Shape::fluidProperties");
                if (_loc_4.zpp_inner.fluidProperties == null)
                {
                    _loc_4.zpp_inner.setFluid(new FluidProperties().zpp_inner);
                }
                _loc_4.zpp_inner.fluidProperties.wrapper();
                _loc_2 = _loc_2.next;
            }
            return this;
        }// end function

        public function setShapeFilters(param1:InteractionFilter) : Body
        {
            var _loc_3:* = null as ZPP_Shape;
            var _loc_4:* = null as Shape;
            zpp_inner.immutable_midstep("Body::setShapeFilters()");
            if (zpp_inner.world)
            {
                throw "Error: Space::world is immutable";
            }
            var _loc_2:* = zpp_inner.shapes.head;
            while (_loc_2 != null)
            {
                
                _loc_3 = _loc_2.elt;
                _loc_4 = _loc_3.outer;
                _loc_4.zpp_inner.immutable_midstep("Shape::filter");
                if (param1 == null)
                {
                    throw "Error: Cannot assign null as Shape filter";
                }
                _loc_4.zpp_inner.setFilter(param1.zpp_inner);
                _loc_4.zpp_inner.filter.wrapper();
                _loc_2 = _loc_2.next;
            }
            return this;
        }// end function

        public function scaleShapes(param1:Number, param2:Number) : Body
        {
            var _loc_4:* = null as ZPP_Shape;
            zpp_inner.immutable_midstep("Body::scaleShapes()");
            if (zpp_inner.world)
            {
                throw "Error: Space::world is immutable";
            }
            var _loc_3:* = zpp_inner.shapes.head;
            while (_loc_3 != null)
            {
                
                _loc_4 = _loc_3.elt;
                _loc_4.outer.scale(param1, param2);
                _loc_3 = _loc_3.next;
            }
            return this;
        }// end function

        public function rotateShapes(param1:Number) : Body
        {
            var _loc_3:* = null as ZPP_Shape;
            zpp_inner.immutable_midstep("Body::rotateShapes()");
            if (zpp_inner.world)
            {
                throw "Error: Space::world is immutable";
            }
            var _loc_2:* = zpp_inner.shapes.head;
            while (_loc_2 != null)
            {
                
                _loc_3 = _loc_2.elt;
                _loc_3.outer.rotate(param1);
                _loc_2 = _loc_2.next;
            }
            return this;
        }// end function

        public function rotate(param1:Vec2, param2:Number) : Body
        {
            var _loc_5:* = null as Vec2;
            var _loc_7:* = null as ZPP_Vec2;
            var _loc_11:* = null as Vec2;
            var _loc_12:* = null as ZPP_Vec2;
            var _loc_14:* = null as ZPP_Body;
            var _loc_15:* = null as ZNPNode_ZPP_Shape;
            var _loc_16:* = null as ZPP_Shape;
            if (param1 != null)
            {
            }
            if (param1.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            if (param1 == null)
            {
                throw "Error: Cannot rotate about a null Vec2";
            }
            if (param2 != param2)
            {
                throw "Error: Cannot rotate by NaN radians";
            }
            var _loc_3:* = param1.zpp_inner.weak;
            param1.zpp_inner.weak = false;
            if (zpp_inner.wrap_pos == null)
            {
                zpp_inner.setupPosition();
            }
            var _loc_4:* = zpp_inner.wrap_pos.sub(param1);
            _loc_4.rotate(param2);
            _loc_5 = param1.add(_loc_4, true);
            if (_loc_5 != null)
            {
            }
            if (_loc_5.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            if (_loc_5 == null)
            {
                throw "Error: Body::" + "position" + " cannot be null";
            }
            if (zpp_inner.wrap_pos == null)
            {
                zpp_inner.setupPosition();
            }
            var _loc_6:* = zpp_inner.wrap_pos;
            if (_loc_6 != null)
            {
            }
            if (_loc_6.zpp_disp)
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
            _loc_7 = _loc_6.zpp_inner;
            if (_loc_7._immutable)
            {
                throw "Error: Vec2 is immutable";
            }
            if (_loc_7._isimmutable != null)
            {
                _loc_7._isimmutable();
            }
            if (_loc_5 == null)
            {
                throw "Error: Cannot assign null Vec2";
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
            var _loc_9:* = _loc_5.zpp_inner.x;
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
            var _loc_10:* = _loc_5.zpp_inner.y;
            if (_loc_6 != null)
            {
            }
            if (_loc_6.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_7 = _loc_6.zpp_inner;
            if (_loc_7._immutable)
            {
                throw "Error: Vec2 is immutable";
            }
            if (_loc_7._isimmutable != null)
            {
                _loc_7._isimmutable();
            }
            if (_loc_9 == _loc_9)
            {
            }
            if (_loc_10 != _loc_10)
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
            _loc_7 = _loc_6.zpp_inner;
            if (_loc_7._validate != null)
            {
                _loc_7._validate();
            }
            if (_loc_6.zpp_inner.x == _loc_9)
            {
                if (_loc_6 != null)
                {
                }
                if (_loc_6.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_7 = _loc_6.zpp_inner;
                if (_loc_7._validate != null)
                {
                    _loc_7._validate();
                }
            }
            if (_loc_6.zpp_inner.y != _loc_10)
            {
                _loc_6.zpp_inner.x = _loc_9;
                _loc_6.zpp_inner.y = _loc_10;
                _loc_7 = _loc_6.zpp_inner;
                if (_loc_7._invalidate != null)
                {
                    _loc_7._invalidate(_loc_7);
                }
            }
            var _loc_8:* = _loc_6;
            if (_loc_5.zpp_inner.weak)
            {
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
                _loc_11 = _loc_5;
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
                _loc_12 = _loc_7;
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
            else
            {
            }
            if (zpp_inner.wrap_pos == null)
            {
                zpp_inner.setupPosition();
            }
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
            _loc_5 = _loc_4;
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
            _loc_12 = _loc_7;
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
            var _loc_13:* = this;
            _loc_9 = _loc_13.zpp_inner.rot + param2;
            _loc_13.zpp_inner.immutable_midstep("Body::rotation");
            if (_loc_13.zpp_inner.world)
            {
                throw "Error: Space::world is immutable";
            }
            if (_loc_13.zpp_inner.type == ZPP_Flags.id_BodyType_STATIC)
            {
            }
            if (_loc_13.zpp_inner.space != null)
            {
                throw "Error: Static objects cannot be rotated once inside a Space";
            }
            if (_loc_13.zpp_inner.rot != _loc_9)
            {
                if (_loc_9 != _loc_9)
                {
                    throw "Error: Body::rotation cannot be NaN";
                }
                _loc_13.zpp_inner.rot = _loc_9;
                _loc_14 = _loc_13.zpp_inner;
                _loc_14.zip_axis = true;
                _loc_15 = _loc_14.shapes.head;
                while (_loc_15 != null)
                {
                    
                    _loc_16 = _loc_15.elt;
                    if (_loc_16.type == ZPP_Flags.id_ShapeType_POLYGON)
                    {
                        _loc_16.polygon.invalidate_gverts();
                        _loc_16.polygon.invalidate_gaxi();
                    }
                    _loc_16.invalidate_worldCOM();
                    _loc_15 = _loc_15.next;
                }
                _loc_14.zip_worldCOM = true;
                _loc_13.zpp_inner.wake();
            }
            param1.zpp_inner.weak = _loc_3;
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
                _loc_5 = param1;
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
                _loc_12 = _loc_7;
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
            else
            {
            }
            return this;
        }// end function

        public function rollingImpulse(param1:Body = undefined, param2:Boolean = false) : Number
        {
            var _loc_6:* = null as Arbiter;
            var _loc_7:* = 0;
            var _loc_8:* = null as ZPP_Arbiter;
            var _loc_9:* = null as Arbiter;
            var _loc_3:* = 0;
            var _loc_4:* = zpp_inner.arbiters;
            if (zpp_inner.wrap_arbiters == null)
            {
                zpp_inner.wrap_arbiters = ZPP_ArbiterList.get(zpp_inner.arbiters, true);
            }
            var _loc_5:* = zpp_inner.wrap_arbiters.iterator();
            do
            {
                
                _loc_5.zpp_critical = false;
                _loc_7 = _loc_5.zpp_i;
                (_loc_5.zpp_i + 1);
                _loc_6 = _loc_5.zpp_inner.at(_loc_7);
                _loc_8 = _loc_6.zpp_inner;
                if (_loc_8.type != ZPP_Arbiter.COL)
                {
                }
                else
                {
                    if (param1 != null)
                    {
                    }
                    if (_loc_8.b2 != param1.zpp_inner)
                    {
                    }
                    if (_loc_8.b1 != param1.zpp_inner)
                    {
                    }
                    else
                    {
                        _loc_9 = _loc_8.wrapper();
                        _loc_3 = _loc_3 + (_loc_9.zpp_inner.type == ZPP_Arbiter.COL ? (_loc_9.zpp_inner.colarb.outer_zn) : (null)).rollingImpulse(this, param2);
                    }
                }
                _loc_5.zpp_inner.zpp_inner.valmod();
                _loc_7 = _loc_5.zpp_inner.zpp_gl();
                _loc_5.zpp_critical = true;
            }while (_loc_5.zpp_i < _loc_7 ? (true) : (_loc_5.zpp_next = ArbiterIterator.zpp_pool, ArbiterIterator.zpp_pool = _loc_5, _loc_5.zpp_inner = null, false))
            return _loc_3;
        }// end function

        public function normalImpulse(param1:Body = undefined, param2:Boolean = false) : Vec3
        {
            var _loc_8:* = null as Arbiter;
            var _loc_9:* = 0;
            var _loc_10:* = null as ZPP_Arbiter;
            var _loc_11:* = null as Vec3;
            var _loc_12:* = null as Arbiter;
            var _loc_13:* = 0;
            var _loc_14:* = null as ZPP_Vec3;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = zpp_inner.arbiters;
            if (zpp_inner.wrap_arbiters == null)
            {
                zpp_inner.wrap_arbiters = ZPP_ArbiterList.get(zpp_inner.arbiters, true);
            }
            var _loc_7:* = zpp_inner.wrap_arbiters.iterator();
            do
            {
                
                _loc_7.zpp_critical = false;
                _loc_9 = _loc_7.zpp_i;
                (_loc_7.zpp_i + 1);
                _loc_8 = _loc_7.zpp_inner.at(_loc_9);
                _loc_10 = _loc_8.zpp_inner;
                if (_loc_10.type != ZPP_Arbiter.COL)
                {
                }
                else
                {
                    if (param1 != null)
                    {
                    }
                    if (_loc_10.b2 != param1.zpp_inner)
                    {
                    }
                    if (_loc_10.b1 != param1.zpp_inner)
                    {
                    }
                    else
                    {
                        _loc_12 = _loc_10.wrapper();
                        _loc_11 = (_loc_12.zpp_inner.type == ZPP_Arbiter.COL ? (_loc_12.zpp_inner.colarb.outer_zn) : (null)).normalImpulse(this, param2);
                        _loc_9 = 1;
                        _loc_13 = _loc_9;
                        if (_loc_11 != null)
                        {
                        }
                        if (_loc_11.zpp_disp)
                        {
                            throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
                        }
                        _loc_14 = _loc_11.zpp_inner;
                        if (_loc_14._validate != null)
                        {
                            _loc_14._validate();
                        }
                        _loc_3 = _loc_3 + _loc_11.zpp_inner.x * _loc_13;
                        if (_loc_11 != null)
                        {
                        }
                        if (_loc_11.zpp_disp)
                        {
                            throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
                        }
                        _loc_14 = _loc_11.zpp_inner;
                        if (_loc_14._validate != null)
                        {
                            _loc_14._validate();
                        }
                        _loc_4 = _loc_4 + _loc_11.zpp_inner.y * _loc_13;
                        if (_loc_11 != null)
                        {
                        }
                        if (_loc_11.zpp_disp)
                        {
                            throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
                        }
                        _loc_14 = _loc_11.zpp_inner;
                        if (_loc_14._validate != null)
                        {
                            _loc_14._validate();
                        }
                        _loc_5 = _loc_5 + _loc_11.zpp_inner.z * _loc_9;
                        _loc_11.dispose();
                    }
                }
                _loc_7.zpp_inner.zpp_inner.valmod();
                _loc_9 = _loc_7.zpp_inner.zpp_gl();
                _loc_7.zpp_critical = true;
            }while (_loc_7.zpp_i < _loc_9 ? (true) : (_loc_7.zpp_next = ArbiterIterator.zpp_pool, ArbiterIterator.zpp_pool = _loc_7, _loc_7.zpp_inner = null, false))
            return Vec3.get(_loc_3, _loc_4, _loc_5);
        }// end function

        public function localVectorToWorld(param1:Vec2, param2:Boolean = false) : Vec2
        {
            var _loc_6:* = null as ZPP_Vec2;
            var _loc_7:* = null as Vec2;
            var _loc_8:* = null as ZPP_Vec2;
            var _loc_9:* = false;
            if (param1 != null)
            {
            }
            if (param1.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            if (param1 == null)
            {
                throw "Error: Cannot transform null Vec2";
            }
            var _loc_3:* = zpp_inner;
            if (_loc_3.zip_axis)
            {
                _loc_3.zip_axis = false;
                _loc_3.axisx = Math.sin(_loc_3.rot);
                _loc_3.axisy = Math.cos(_loc_3.rot);
            }
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            if (param1 != null)
            {
            }
            if (param1.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_6 = param1.zpp_inner;
            if (_loc_6._validate != null)
            {
                _loc_6._validate();
            }
            if (param1 != null)
            {
            }
            if (param1.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_6 = param1.zpp_inner;
            if (_loc_6._validate != null)
            {
                _loc_6._validate();
            }
            _loc_4 = zpp_inner.axisy * param1.zpp_inner.x - zpp_inner.axisx * param1.zpp_inner.y;
            if (param1 != null)
            {
            }
            if (param1.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_6 = param1.zpp_inner;
            if (_loc_6._validate != null)
            {
                _loc_6._validate();
            }
            if (param1 != null)
            {
            }
            if (param1.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_6 = param1.zpp_inner;
            if (_loc_6._validate != null)
            {
                _loc_6._validate();
            }
            _loc_5 = param1.zpp_inner.x * zpp_inner.axisx + param1.zpp_inner.y * zpp_inner.axisy;
            if (param1.zpp_inner.weak)
            {
                if (param1 != null)
                {
                }
                if (param1.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_6 = param1.zpp_inner;
                if (_loc_6._immutable)
                {
                    throw "Error: Vec2 is immutable";
                }
                if (_loc_6._isimmutable != null)
                {
                    _loc_6._isimmutable();
                }
                if (param1.zpp_inner._inuse)
                {
                    throw "Error: This Vec2 is not disposable";
                }
                _loc_6 = param1.zpp_inner;
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
                _loc_8 = _loc_6;
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
            if (_loc_4 == _loc_4)
            {
            }
            if (_loc_5 != _loc_5)
            {
                throw "Error: Vec2 components cannot be NaN";
            }
            if (ZPP_PubPool.poolVec2 == null)
            {
                _loc_7 = new Vec2();
            }
            else
            {
                _loc_7 = ZPP_PubPool.poolVec2;
                ZPP_PubPool.poolVec2 = _loc_7.zpp_pool;
                _loc_7.zpp_pool = null;
                _loc_7.zpp_disp = false;
                if (_loc_7 == ZPP_PubPool.nextVec2)
                {
                    ZPP_PubPool.nextVec2 = null;
                }
            }
            if (_loc_7.zpp_inner == null)
            {
                _loc_9 = false;
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
                _loc_6._immutable = _loc_9;
                _loc_6.x = _loc_4;
                _loc_6.y = _loc_5;
                _loc_7.zpp_inner = _loc_6;
                _loc_7.zpp_inner.outer = _loc_7;
            }
            else
            {
                if (_loc_7 != null)
                {
                }
                if (_loc_7.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_6 = _loc_7.zpp_inner;
                if (_loc_6._immutable)
                {
                    throw "Error: Vec2 is immutable";
                }
                if (_loc_6._isimmutable != null)
                {
                    _loc_6._isimmutable();
                }
                if (_loc_4 == _loc_4)
                {
                }
                if (_loc_5 != _loc_5)
                {
                    throw "Error: Vec2 components cannot be NaN";
                }
                if (_loc_7 != null)
                {
                }
                if (_loc_7.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_6 = _loc_7.zpp_inner;
                if (_loc_6._validate != null)
                {
                    _loc_6._validate();
                }
                if (_loc_7.zpp_inner.x == _loc_4)
                {
                    if (_loc_7 != null)
                    {
                    }
                    if (_loc_7.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_6 = _loc_7.zpp_inner;
                    if (_loc_6._validate != null)
                    {
                        _loc_6._validate();
                    }
                }
                if (_loc_7.zpp_inner.y != _loc_5)
                {
                    _loc_7.zpp_inner.x = _loc_4;
                    _loc_7.zpp_inner.y = _loc_5;
                    _loc_6 = _loc_7.zpp_inner;
                    if (_loc_6._invalidate != null)
                    {
                        _loc_6._invalidate(_loc_6);
                    }
                }
            }
            _loc_7.zpp_inner.weak = param2;
            return _loc_7;
        }// end function

        public function localPointToWorld(param1:Vec2, param2:Boolean = false) : Vec2
        {
            var _loc_6:* = null as ZPP_Vec2;
            var _loc_7:* = null as Vec2;
            var _loc_8:* = null as ZPP_Vec2;
            var _loc_11:* = false;
            if (param1 != null)
            {
            }
            if (param1.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            if (param1 == null)
            {
                throw "Error: Cannot transform null Vec2";
            }
            var _loc_3:* = zpp_inner;
            if (_loc_3.zip_axis)
            {
                _loc_3.zip_axis = false;
                _loc_3.axisx = Math.sin(_loc_3.rot);
                _loc_3.axisy = Math.cos(_loc_3.rot);
            }
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            if (param1 != null)
            {
            }
            if (param1.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_6 = param1.zpp_inner;
            if (_loc_6._validate != null)
            {
                _loc_6._validate();
            }
            if (param1 != null)
            {
            }
            if (param1.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_6 = param1.zpp_inner;
            if (_loc_6._validate != null)
            {
                _loc_6._validate();
            }
            _loc_4 = zpp_inner.axisy * param1.zpp_inner.x - zpp_inner.axisx * param1.zpp_inner.y;
            if (param1 != null)
            {
            }
            if (param1.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_6 = param1.zpp_inner;
            if (_loc_6._validate != null)
            {
                _loc_6._validate();
            }
            if (param1 != null)
            {
            }
            if (param1.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_6 = param1.zpp_inner;
            if (_loc_6._validate != null)
            {
                _loc_6._validate();
            }
            _loc_5 = param1.zpp_inner.x * zpp_inner.axisx + param1.zpp_inner.y * zpp_inner.axisy;
            if (param1.zpp_inner.weak)
            {
                if (param1 != null)
                {
                }
                if (param1.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_6 = param1.zpp_inner;
                if (_loc_6._immutable)
                {
                    throw "Error: Vec2 is immutable";
                }
                if (_loc_6._isimmutable != null)
                {
                    _loc_6._isimmutable();
                }
                if (param1.zpp_inner._inuse)
                {
                    throw "Error: This Vec2 is not disposable";
                }
                _loc_6 = param1.zpp_inner;
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
                _loc_8 = _loc_6;
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
            var _loc_9:* = _loc_4 + zpp_inner.posx;
            var _loc_10:* = _loc_5 + zpp_inner.posy;
            if (_loc_9 == _loc_9)
            {
            }
            if (_loc_10 != _loc_10)
            {
                throw "Error: Vec2 components cannot be NaN";
            }
            if (ZPP_PubPool.poolVec2 == null)
            {
                _loc_7 = new Vec2();
            }
            else
            {
                _loc_7 = ZPP_PubPool.poolVec2;
                ZPP_PubPool.poolVec2 = _loc_7.zpp_pool;
                _loc_7.zpp_pool = null;
                _loc_7.zpp_disp = false;
                if (_loc_7 == ZPP_PubPool.nextVec2)
                {
                    ZPP_PubPool.nextVec2 = null;
                }
            }
            if (_loc_7.zpp_inner == null)
            {
                _loc_11 = false;
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
                _loc_6._immutable = _loc_11;
                _loc_6.x = _loc_9;
                _loc_6.y = _loc_10;
                _loc_7.zpp_inner = _loc_6;
                _loc_7.zpp_inner.outer = _loc_7;
            }
            else
            {
                if (_loc_7 != null)
                {
                }
                if (_loc_7.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_6 = _loc_7.zpp_inner;
                if (_loc_6._immutable)
                {
                    throw "Error: Vec2 is immutable";
                }
                if (_loc_6._isimmutable != null)
                {
                    _loc_6._isimmutable();
                }
                if (_loc_9 == _loc_9)
                {
                }
                if (_loc_10 != _loc_10)
                {
                    throw "Error: Vec2 components cannot be NaN";
                }
                if (_loc_7 != null)
                {
                }
                if (_loc_7.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_6 = _loc_7.zpp_inner;
                if (_loc_6._validate != null)
                {
                    _loc_6._validate();
                }
                if (_loc_7.zpp_inner.x == _loc_9)
                {
                    if (_loc_7 != null)
                    {
                    }
                    if (_loc_7.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_6 = _loc_7.zpp_inner;
                    if (_loc_6._validate != null)
                    {
                        _loc_6._validate();
                    }
                }
                if (_loc_7.zpp_inner.y != _loc_10)
                {
                    _loc_7.zpp_inner.x = _loc_9;
                    _loc_7.zpp_inner.y = _loc_10;
                    _loc_6 = _loc_7.zpp_inner;
                    if (_loc_6._invalidate != null)
                    {
                        _loc_6._invalidate(_loc_6);
                    }
                }
            }
            _loc_7.zpp_inner.weak = param2;
            return _loc_7;
        }// end function

        public function isStatic() : Boolean
        {
            return zpp_inner.type == ZPP_Flags.id_BodyType_STATIC;
        }// end function

        public function isKinematic() : Boolean
        {
            return zpp_inner.type == ZPP_Flags.id_BodyType_KINEMATIC;
        }// end function

        public function isDynamic() : Boolean
        {
            return zpp_inner.type == ZPP_Flags.id_BodyType_DYNAMIC;
        }// end function

        public function interactingBodies(param1:InteractionType = undefined, param2:int = -1, param3:BodyList = undefined) : BodyList
        {
            var _loc_4:* = 0;
            if (param1 == null)
            {
                _loc_4 = ZPP_Arbiter.COL | ZPP_Arbiter.SENSOR | ZPP_Arbiter.FLUID;
            }
            else
            {
                if (ZPP_Flags.InteractionType_COLLISION == null)
                {
                    ZPP_Flags.internal = true;
                    ZPP_Flags.InteractionType_COLLISION = new InteractionType();
                    ZPP_Flags.internal = false;
                }
                if (param1 == ZPP_Flags.InteractionType_COLLISION)
                {
                    _loc_4 = ZPP_Arbiter.COL;
                }
                else
                {
                    if (ZPP_Flags.InteractionType_SENSOR == null)
                    {
                        ZPP_Flags.internal = true;
                        ZPP_Flags.InteractionType_SENSOR = new InteractionType();
                        ZPP_Flags.internal = false;
                    }
                    if (param1 == ZPP_Flags.InteractionType_SENSOR)
                    {
                        _loc_4 = ZPP_Arbiter.SENSOR;
                    }
                    else
                    {
                        _loc_4 = ZPP_Arbiter.FLUID;
                    }
                }
            }
            return zpp_inner.interactingBodies(_loc_4, param2, param3);
        }// end function

        public function integrate(param1:Number) : Body
        {
            var _loc_4:* = NaN;
            var _loc_5:* = NaN;
            var _loc_6:* = NaN;
            var _loc_7:* = NaN;
            var _loc_8:* = NaN;
            var _loc_10:* = null as ZPP_Shape;
            if (param1 != param1)
            {
                throw "Cannot integrate by NaN time";
            }
            zpp_inner.immutable_midstep("Body::space");
            if (zpp_inner.world)
            {
                throw "Error: Space::world is immutable";
            }
            if (param1 == 0)
            {
                return this;
            }
            var _loc_2:* = zpp_inner;
            _loc_2.sweepTime = 0;
            _loc_2.sweep_angvel = _loc_2.angvel;
            var _loc_3:* = param1 - _loc_2.sweepTime;
            if (_loc_3 != 0)
            {
                _loc_2.sweepTime = param1;
                _loc_4 = _loc_3;
                _loc_2.posx = _loc_2.posx + _loc_2.velx * _loc_4;
                _loc_2.posy = _loc_2.posy + _loc_2.vely * _loc_4;
                if (_loc_2.angvel != 0)
                {
                    _loc_4 = _loc_2.sweep_angvel * _loc_3;
                    _loc_2.rot = _loc_2.rot + _loc_4;
                    if (_loc_4 * _loc_4 > 0.0001)
                    {
                        _loc_2.axisx = Math.sin(_loc_2.rot);
                        _loc_2.axisy = Math.cos(_loc_2.rot);
                    }
                    else
                    {
                        _loc_5 = _loc_4 * _loc_4;
                        _loc_6 = 1 - 0.5 * _loc_5;
                        _loc_7 = 1 - _loc_5 * _loc_5 / 8;
                        _loc_8 = (_loc_6 * _loc_2.axisx + _loc_4 * _loc_2.axisy) * _loc_7;
                        _loc_2.axisy = (_loc_6 * _loc_2.axisy - _loc_4 * _loc_2.axisx) * _loc_7;
                        _loc_2.axisx = _loc_8;
                    }
                }
            }
            var _loc_9:* = _loc_2.shapes.head;
            while (_loc_9 != null)
            {
                
                _loc_10 = _loc_9.elt;
                if (_loc_10.type == ZPP_Flags.id_ShapeType_POLYGON)
                {
                    _loc_10.polygon.invalidate_gverts();
                    _loc_10.polygon.invalidate_gaxi();
                }
                _loc_10.invalidate_worldCOM();
                _loc_9 = _loc_9.next;
            }
            _loc_2.zip_worldCOM = true;
            _loc_2.zip_axis = true;
            _loc_9 = _loc_2.shapes.head;
            while (_loc_9 != null)
            {
                
                _loc_10 = _loc_9.elt;
                if (_loc_10.type == ZPP_Flags.id_ShapeType_POLYGON)
                {
                    _loc_10.polygon.invalidate_gverts();
                    _loc_10.polygon.invalidate_gaxi();
                }
                _loc_10.invalidate_worldCOM();
                _loc_9 = _loc_9.next;
            }
            _loc_2.zip_worldCOM = true;
            _loc_2.sweepTime = 0;
            return this;
        }// end function

        public function get_worldCOM() : Vec2
        {
            var _loc_1:* = NaN;
            var _loc_2:* = NaN;
            var _loc_3:* = false;
            var _loc_4:* = null as Vec2;
            var _loc_5:* = false;
            var _loc_6:* = null as ZPP_Vec2;
            if (zpp_inner.world)
            {
                throw "Error: Space::world has no " + "worldCOM";
            }
            if (zpp_inner.wrap_worldCOM == null)
            {
                _loc_1 = zpp_inner.worldCOMx;
                _loc_2 = zpp_inner.worldCOMy;
                _loc_3 = false;
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
                zpp_inner.wrap_worldCOM = _loc_4;
                zpp_inner.wrap_worldCOM.zpp_inner._inuse = true;
                zpp_inner.wrap_worldCOM.zpp_inner._immutable = true;
                zpp_inner.wrap_worldCOM.zpp_inner._validate = zpp_inner.getworldCOM;
            }
            return zpp_inner.wrap_worldCOM;
        }// end function

        public function get_velocity() : Vec2
        {
            if (zpp_inner.wrap_vel == null)
            {
                zpp_inner.setupVelocity();
            }
            return zpp_inner.wrap_vel;
        }// end function

        public function get_type() : BodyType
        {
            return ZPP_Body.types[zpp_inner.type];
        }// end function

        public function get_torque() : Number
        {
            return zpp_inner.torque;
        }// end function

        public function get_surfaceVel() : Vec2
        {
            if (zpp_inner.wrap_svel == null)
            {
                zpp_inner.setupsvel();
            }
            return zpp_inner.wrap_svel;
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

        public function get_shapes() : ShapeList
        {
            return zpp_inner.wrap_shapes;
        }// end function

        public function get_rotation() : Number
        {
            return zpp_inner.rot;
        }// end function

        public function get_position() : Vec2
        {
            if (zpp_inner.wrap_pos == null)
            {
                zpp_inner.setupPosition();
            }
            return zpp_inner.wrap_pos;
        }// end function

        public function get_massMode() : MassMode
        {
            if (ZPP_Flags.MassMode_DEFAULT == null)
            {
                ZPP_Flags.internal = true;
                ZPP_Flags.MassMode_DEFAULT = new MassMode();
                ZPP_Flags.internal = false;
            }
            if (ZPP_Flags.MassMode_FIXED == null)
            {
                ZPP_Flags.internal = true;
                ZPP_Flags.MassMode_FIXED = new MassMode();
                ZPP_Flags.internal = false;
            }
            return [ZPP_Flags.MassMode_DEFAULT, ZPP_Flags.MassMode_FIXED][zpp_inner.massMode];
        }// end function

        public function get_mass() : Number
        {
            if (zpp_inner.world)
            {
                throw "Error: Space::world has no mass";
            }
            zpp_inner.validate_mass();
            if (zpp_inner.massMode == ZPP_Flags.id_MassMode_DEFAULT)
            {
            }
            if (zpp_inner.shapes.head == null)
            {
                throw "Error: Given current mass mode, Body::mass only makes sense if it contains shapes";
            }
            return zpp_inner.cmass;
        }// end function

        public function get_localCOM() : Vec2
        {
            var _loc_1:* = NaN;
            var _loc_2:* = NaN;
            var _loc_3:* = false;
            var _loc_4:* = null as Vec2;
            var _loc_5:* = false;
            var _loc_6:* = null as ZPP_Vec2;
            if (zpp_inner.world)
            {
                throw "Error: Space::world has no " + "localCOM";
            }
            if (zpp_inner.wrap_localCOM == null)
            {
                _loc_1 = zpp_inner.localCOMx;
                _loc_2 = zpp_inner.localCOMy;
                _loc_3 = false;
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
                zpp_inner.wrap_localCOM = _loc_4;
                zpp_inner.wrap_localCOM.zpp_inner._inuse = true;
                zpp_inner.wrap_localCOM.zpp_inner._immutable = true;
                zpp_inner.wrap_localCOM.zpp_inner._validate = zpp_inner.getlocalCOM;
            }
            return zpp_inner.wrap_localCOM;
        }// end function

        public function get_kinematicVel() : Vec2
        {
            if (zpp_inner.wrap_kinvel == null)
            {
                zpp_inner.setupkinvel();
            }
            return zpp_inner.wrap_kinvel;
        }// end function

        public function get_kinAngVel() : Number
        {
            return zpp_inner.kinangvel;
        }// end function

        public function get_isSleeping() : Boolean
        {
            if (zpp_inner.space == null)
            {
                throw "Error: isSleeping makes no sense if the object is not contained within a Space";
            }
            return zpp_inner.component.sleeping;
        }// end function

        public function get_isBullet() : Boolean
        {
            return zpp_inner.bulletEnabled;
        }// end function

        public function get_inertiaMode() : InertiaMode
        {
            if (ZPP_Flags.InertiaMode_DEFAULT == null)
            {
                ZPP_Flags.internal = true;
                ZPP_Flags.InertiaMode_DEFAULT = new InertiaMode();
                ZPP_Flags.internal = false;
            }
            if (ZPP_Flags.InertiaMode_FIXED == null)
            {
                ZPP_Flags.internal = true;
                ZPP_Flags.InertiaMode_FIXED = new InertiaMode();
                ZPP_Flags.internal = false;
            }
            return [ZPP_Flags.InertiaMode_DEFAULT, ZPP_Flags.InertiaMode_FIXED][zpp_inner.inertiaMode];
        }// end function

        public function get_inertia() : Number
        {
            var _loc_1:* = null as ShapeList;
            if (zpp_inner.world)
            {
                throw "Error: Space::world has no inertia";
            }
            zpp_inner.validate_inertia();
            if (zpp_inner.inertiaMode == ZPP_Flags.id_InertiaMode_DEFAULT)
            {
                _loc_1 = zpp_inner.wrap_shapes;
            }
            if (_loc_1.zpp_inner.inner.head == null)
            {
                throw "Error: Given current inertia mode flag, Body::inertia only makes sense if Body contains Shapes";
            }
            return zpp_inner.cinertia;
        }// end function

        public function get_gravMassScale() : Number
        {
            zpp_inner.validate_gravMassScale();
            if (zpp_inner.shapes.head == null)
            {
                if (zpp_inner.massMode == ZPP_Flags.id_MassMode_DEFAULT)
                {
                }
                if (zpp_inner.gravMassMode != ZPP_Flags.id_GravMassMode_SCALED)
                {
                    throw "Error: Given current mass/gravMass modes; Body::gravMassScale only makes sense if it contains Shapes";
                }
            }
            return zpp_inner.gravMassScale;
        }// end function

        public function get_gravMassMode() : GravMassMode
        {
            if (ZPP_Flags.GravMassMode_DEFAULT == null)
            {
                ZPP_Flags.internal = true;
                ZPP_Flags.GravMassMode_DEFAULT = new GravMassMode();
                ZPP_Flags.internal = false;
            }
            if (ZPP_Flags.GravMassMode_FIXED == null)
            {
                ZPP_Flags.internal = true;
                ZPP_Flags.GravMassMode_FIXED = new GravMassMode();
                ZPP_Flags.internal = false;
            }
            if (ZPP_Flags.GravMassMode_SCALED == null)
            {
                ZPP_Flags.internal = true;
                ZPP_Flags.GravMassMode_SCALED = new GravMassMode();
                ZPP_Flags.internal = false;
            }
            return [ZPP_Flags.GravMassMode_DEFAULT, ZPP_Flags.GravMassMode_FIXED, ZPP_Flags.GravMassMode_SCALED][zpp_inner.massMode];
        }// end function

        public function get_gravMass() : Number
        {
            if (zpp_inner.world)
            {
                throw "Error: Space::world has no gravMass";
            }
            zpp_inner.validate_gravMass();
            if (zpp_inner.shapes.head == null)
            {
                if (zpp_inner.massMode == ZPP_Flags.id_MassMode_DEFAULT)
                {
                }
                if (zpp_inner.gravMassMode != ZPP_Flags.id_GravMassMode_FIXED)
                {
                    throw "Error: Given current mass/gravMass modes; Body::gravMass only makes sense if it contains Shapes";
                }
            }
            return zpp_inner.gravMass;
        }// end function

        public function get_force() : Vec2
        {
            if (zpp_inner.wrap_force == null)
            {
                zpp_inner.setupForce();
            }
            return zpp_inner.wrap_force;
        }// end function

        public function get_disableCCD() : Boolean
        {
            return zpp_inner.disableCCD;
        }// end function

        public function get_constraints() : ConstraintList
        {
            if (zpp_inner.wrap_constraints == null)
            {
                zpp_inner.wrap_constraints = ZPP_ConstraintList.get(zpp_inner.constraints, true);
            }
            return zpp_inner.wrap_constraints;
        }// end function

        public function get_constraintVelocity() : Vec3
        {
            if (zpp_inner.wrapcvel == null)
            {
                zpp_inner.setup_cvel();
            }
            return zpp_inner.wrapcvel;
        }// end function

        public function get_constraintMass() : Number
        {
            if (!zpp_inner.world)
            {
                zpp_inner.validate_mass();
            }
            return zpp_inner.smass;
        }// end function

        public function get_constraintInertia() : Number
        {
            if (!zpp_inner.world)
            {
                zpp_inner.validate_inertia();
            }
            return zpp_inner.sinertia;
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

        public function get_bounds() : AABB
        {
            if (zpp_inner.world)
            {
                throw "Error: Space::world has no bounds";
            }
            return zpp_inner.aabb.wrapper();
        }// end function

        public function get_arbiters() : ArbiterList
        {
            if (zpp_inner.wrap_arbiters == null)
            {
                zpp_inner.wrap_arbiters = ZPP_ArbiterList.get(zpp_inner.arbiters, true);
            }
            return zpp_inner.wrap_arbiters;
        }// end function

        public function get_angularVel() : Number
        {
            return zpp_inner.angvel;
        }// end function

        public function get_allowRotation() : Boolean
        {
            return !zpp_inner.norotate;
        }// end function

        public function get_allowMovement() : Boolean
        {
            return !zpp_inner.nomove;
        }// end function

        public function dragImpulse(param1:Body = undefined) : Vec3
        {
            var _loc_7:* = null as Arbiter;
            var _loc_8:* = 0;
            var _loc_9:* = null as ZPP_Arbiter;
            var _loc_10:* = null as Vec3;
            var _loc_11:* = null as Arbiter;
            var _loc_12:* = 0;
            var _loc_13:* = null as ZPP_Vec3;
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = zpp_inner.arbiters;
            if (zpp_inner.wrap_arbiters == null)
            {
                zpp_inner.wrap_arbiters = ZPP_ArbiterList.get(zpp_inner.arbiters, true);
            }
            var _loc_6:* = zpp_inner.wrap_arbiters.iterator();
            do
            {
                
                _loc_6.zpp_critical = false;
                _loc_8 = _loc_6.zpp_i;
                (_loc_6.zpp_i + 1);
                _loc_7 = _loc_6.zpp_inner.at(_loc_8);
                _loc_9 = _loc_7.zpp_inner;
                if (_loc_9.type != ZPP_Arbiter.FLUID)
                {
                }
                else
                {
                    if (param1 != null)
                    {
                    }
                    if (_loc_9.b2 != param1.zpp_inner)
                    {
                    }
                    if (_loc_9.b1 != param1.zpp_inner)
                    {
                    }
                    else
                    {
                        _loc_11 = _loc_9.wrapper();
                        _loc_10 = (_loc_11.zpp_inner.type == ZPP_Arbiter.FLUID ? (_loc_11.zpp_inner.fluidarb.outer_zn) : (null)).dragImpulse(this);
                        _loc_8 = 1;
                        _loc_12 = _loc_8;
                        if (_loc_10 != null)
                        {
                        }
                        if (_loc_10.zpp_disp)
                        {
                            throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
                        }
                        _loc_13 = _loc_10.zpp_inner;
                        if (_loc_13._validate != null)
                        {
                            _loc_13._validate();
                        }
                        _loc_2 = _loc_2 + _loc_10.zpp_inner.x * _loc_12;
                        if (_loc_10 != null)
                        {
                        }
                        if (_loc_10.zpp_disp)
                        {
                            throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
                        }
                        _loc_13 = _loc_10.zpp_inner;
                        if (_loc_13._validate != null)
                        {
                            _loc_13._validate();
                        }
                        _loc_3 = _loc_3 + _loc_10.zpp_inner.y * _loc_12;
                        if (_loc_10 != null)
                        {
                        }
                        if (_loc_10.zpp_disp)
                        {
                            throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
                        }
                        _loc_13 = _loc_10.zpp_inner;
                        if (_loc_13._validate != null)
                        {
                            _loc_13._validate();
                        }
                        _loc_4 = _loc_4 + _loc_10.zpp_inner.z * _loc_8;
                        _loc_10.dispose();
                    }
                }
                _loc_6.zpp_inner.zpp_inner.valmod();
                _loc_8 = _loc_6.zpp_inner.zpp_gl();
                _loc_6.zpp_critical = true;
            }while (_loc_6.zpp_i < _loc_8 ? (true) : (_loc_6.zpp_next = ArbiterIterator.zpp_pool, ArbiterIterator.zpp_pool = _loc_6, _loc_6.zpp_inner = null, false))
            return Vec3.get(_loc_2, _loc_3, _loc_4);
        }// end function

        public function crushFactor() : Number
        {
            var _loc_6:* = null as Vec2;
            var _loc_7:* = false;
            var _loc_8:* = null as ZPP_Vec2;
            var _loc_10:* = null as Arbiter;
            var _loc_11:* = 0;
            var _loc_12:* = null as Vec3;
            var _loc_13:* = null as Vec2;
            var _loc_14:* = null as ZPP_Vec2;
            var _loc_16:* = null as ConstraintList;
            var _loc_17:* = null as Constraint;
            if ((zpp_inner.space == null ? (null) : (zpp_inner.space.outer)) == null)
            {
                throw "Error: Makes no sense to see how much an object not taking part in a simulation is being crushed";
            }
            var _loc_1:* = 0;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = false;
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
            var _loc_2:* = _loc_6;
            if (zpp_inner.wrap_arbiters == null)
            {
                zpp_inner.wrap_arbiters = ZPP_ArbiterList.get(zpp_inner.arbiters, true);
            }
            var _loc_9:* = zpp_inner.wrap_arbiters.iterator();
            do
            {
                
                _loc_9.zpp_critical = false;
                _loc_11 = _loc_9.zpp_i;
                (_loc_9.zpp_i + 1);
                _loc_10 = _loc_9.zpp_inner.at(_loc_11);
                _loc_12 = _loc_10.totalImpulse(this);
                _loc_6 = _loc_12.xy();
                _loc_2.addeq(_loc_6);
                if (_loc_6 != null)
                {
                }
                if (_loc_6.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
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
                _loc_1 = _loc_1 + Math.sqrt(_loc_6.zpp_inner.x * _loc_6.zpp_inner.x + _loc_6.zpp_inner.y * _loc_6.zpp_inner.y);
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
                if (_loc_6.zpp_inner._inuse)
                {
                    throw "Error: This Vec2 is not disposable";
                }
                _loc_8 = _loc_6.zpp_inner;
                _loc_6.zpp_inner.outer = null;
                _loc_6.zpp_inner = null;
                _loc_13 = _loc_6;
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
                _loc_14 = _loc_8;
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
                _loc_12.dispose();
                _loc_9.zpp_inner.zpp_inner.valmod();
                _loc_11 = _loc_9.zpp_inner.zpp_gl();
                _loc_9.zpp_critical = true;
            }while (_loc_9.zpp_i < _loc_11 ? (true) : (_loc_9.zpp_next = ArbiterIterator.zpp_pool, ArbiterIterator.zpp_pool = _loc_9, _loc_9.zpp_inner = null, false))
            if (zpp_inner.wrap_constraints == null)
            {
                zpp_inner.wrap_constraints = ZPP_ConstraintList.get(zpp_inner.constraints, true);
            }
            _loc_16 = zpp_inner.wrap_constraints;
            _loc_16.zpp_inner.valmod();
            var _loc_15:* = ConstraintIterator.get(_loc_16);
            do
            {
                
                _loc_15.zpp_critical = false;
                _loc_11 = _loc_15.zpp_i;
                (_loc_15.zpp_i + 1);
                _loc_17 = _loc_15.zpp_inner.at(_loc_11);
                _loc_12 = _loc_17.bodyImpulse(this);
                _loc_6 = _loc_12.xy();
                _loc_2.addeq(_loc_6);
                if (_loc_6 != null)
                {
                }
                if (_loc_6.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
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
                _loc_1 = _loc_1 + Math.sqrt(_loc_6.zpp_inner.x * _loc_6.zpp_inner.x + _loc_6.zpp_inner.y * _loc_6.zpp_inner.y);
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
                if (_loc_6.zpp_inner._inuse)
                {
                    throw "Error: This Vec2 is not disposable";
                }
                _loc_8 = _loc_6.zpp_inner;
                _loc_6.zpp_inner.outer = null;
                _loc_6.zpp_inner = null;
                _loc_13 = _loc_6;
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
                _loc_14 = _loc_8;
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
                _loc_12.dispose();
                _loc_15.zpp_inner.zpp_inner.valmod();
                _loc_16 = _loc_15.zpp_inner;
                _loc_16.zpp_inner.valmod();
                if (_loc_16.zpp_inner.zip_length)
                {
                    _loc_16.zpp_inner.zip_length = false;
                    _loc_16.zpp_inner.user_length = _loc_16.zpp_inner.inner.length;
                }
                _loc_11 = _loc_16.zpp_inner.user_length;
                _loc_15.zpp_critical = true;
            }while (_loc_15.zpp_i < _loc_11 ? (true) : (_loc_15.zpp_next = ConstraintIterator.zpp_pool, ConstraintIterator.zpp_pool = _loc_15, _loc_15.zpp_inner = null, false))
            if (_loc_2 != null)
            {
            }
            if (_loc_2.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            if (_loc_2 != null)
            {
            }
            if (_loc_2.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_8 = _loc_2.zpp_inner;
            if (_loc_8._validate != null)
            {
                _loc_8._validate();
            }
            if (_loc_2 != null)
            {
            }
            if (_loc_2.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_8 = _loc_2.zpp_inner;
            if (_loc_8._validate != null)
            {
                _loc_8._validate();
            }
            if (_loc_2 != null)
            {
            }
            if (_loc_2.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_8 = _loc_2.zpp_inner;
            if (_loc_8._validate != null)
            {
                _loc_8._validate();
            }
            if (_loc_2 != null)
            {
            }
            if (_loc_2.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_8 = _loc_2.zpp_inner;
            if (_loc_8._validate != null)
            {
                _loc_8._validate();
            }
            if (zpp_inner.world)
            {
                throw "Error: Space::world has no mass";
            }
            zpp_inner.validate_mass();
            if (zpp_inner.massMode == ZPP_Flags.id_MassMode_DEFAULT)
            {
            }
            if (zpp_inner.shapes.head == null)
            {
                throw "Error: Given current mass mode, Body::mass only makes sense if it contains shapes";
            }
            _loc_3 = (_loc_1 - Math.sqrt(_loc_2.zpp_inner.x * _loc_2.zpp_inner.x + _loc_2.zpp_inner.y * _loc_2.zpp_inner.y)) / (zpp_inner.cmass * (zpp_inner.space == null ? (null) : (zpp_inner.space.outer)).zpp_inner.pre_dt);
            if (_loc_2 != null)
            {
            }
            if (_loc_2.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_8 = _loc_2.zpp_inner;
            if (_loc_8._immutable)
            {
                throw "Error: Vec2 is immutable";
            }
            if (_loc_8._isimmutable != null)
            {
                _loc_8._isimmutable();
            }
            if (_loc_2.zpp_inner._inuse)
            {
                throw "Error: This Vec2 is not disposable";
            }
            _loc_8 = _loc_2.zpp_inner;
            _loc_2.zpp_inner.outer = null;
            _loc_2.zpp_inner = null;
            _loc_6 = _loc_2;
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
            _loc_14 = _loc_8;
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
            return _loc_3;
        }// end function

        public function copy() : Body
        {
            if (zpp_inner.world)
            {
                throw "Error: Space::world cannot be copied";
            }
            return zpp_inner.copy();
        }// end function

        public function contains(param1:Vec2) : Boolean
        {
            var _loc_5:* = null as ZPP_Shape;
            var _loc_6:* = null as ZPP_Vec2;
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
                throw "Error: Cannot check containment of null point";
            }
            var _loc_2:* = param1.zpp_inner.weak;
            param1.zpp_inner.weak = false;
            var _loc_3:* = false;
            var _loc_4:* = zpp_inner.shapes.head;
            while (_loc_4 != null)
            {
                
                _loc_5 = _loc_4.elt;
                if (_loc_5.outer.contains(param1))
                {
                    _loc_3 = true;
                    break;
                }
                _loc_4 = _loc_4.next;
            }
            param1.zpp_inner.weak = _loc_2;
            if (param1.zpp_inner.weak)
            {
                if (param1 != null)
                {
                }
                if (param1.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_6 = param1.zpp_inner;
                if (_loc_6._immutable)
                {
                    throw "Error: Vec2 is immutable";
                }
                if (_loc_6._isimmutable != null)
                {
                    _loc_6._isimmutable();
                }
                if (param1.zpp_inner._inuse)
                {
                    throw "Error: This Vec2 is not disposable";
                }
                _loc_6 = param1.zpp_inner;
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
                _loc_8 = _loc_6;
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
            return _loc_3;
        }// end function

        public function constraintsImpulse() : Vec3
        {
            var _loc_5:* = null as ZPP_Constraint;
            var _loc_6:* = null as Vec3;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_9:* = null as ZPP_Vec3;
            var _loc_1:* = 0;
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_4:* = zpp_inner.constraints.head;
            while (_loc_4 != null)
            {
                
                _loc_5 = _loc_4.elt;
                _loc_6 = _loc_5.outer.bodyImpulse(this);
                _loc_7 = 1;
                _loc_8 = _loc_7;
                if (_loc_6 != null)
                {
                }
                if (_loc_6.zpp_disp)
                {
                    throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
                }
                _loc_9 = _loc_6.zpp_inner;
                if (_loc_9._validate != null)
                {
                    _loc_9._validate();
                }
                _loc_1 = _loc_1 + _loc_6.zpp_inner.x * _loc_8;
                if (_loc_6 != null)
                {
                }
                if (_loc_6.zpp_disp)
                {
                    throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
                }
                _loc_9 = _loc_6.zpp_inner;
                if (_loc_9._validate != null)
                {
                    _loc_9._validate();
                }
                _loc_2 = _loc_2 + _loc_6.zpp_inner.y * _loc_8;
                if (_loc_6 != null)
                {
                }
                if (_loc_6.zpp_disp)
                {
                    throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
                }
                _loc_9 = _loc_6.zpp_inner;
                if (_loc_9._validate != null)
                {
                    _loc_9._validate();
                }
                _loc_3 = _loc_3 + _loc_6.zpp_inner.z * _loc_7;
                _loc_6.dispose();
                _loc_4 = _loc_4.next;
            }
            return Vec3.get(_loc_1, _loc_2, _loc_3);
        }// end function

        public function connectedBodies(param1:int = -1, param2:BodyList = undefined) : BodyList
        {
            return zpp_inner.connectedBodies(param1, param2);
        }// end function

        public function buoyancyImpulse(param1:Body = undefined) : Vec3
        {
            var _loc_7:* = null as Arbiter;
            var _loc_8:* = 0;
            var _loc_9:* = null as ZPP_Arbiter;
            var _loc_10:* = null as Vec3;
            var _loc_11:* = null as Arbiter;
            var _loc_12:* = 0;
            var _loc_13:* = null as ZPP_Vec3;
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = zpp_inner.arbiters;
            if (zpp_inner.wrap_arbiters == null)
            {
                zpp_inner.wrap_arbiters = ZPP_ArbiterList.get(zpp_inner.arbiters, true);
            }
            var _loc_6:* = zpp_inner.wrap_arbiters.iterator();
            do
            {
                
                _loc_6.zpp_critical = false;
                _loc_8 = _loc_6.zpp_i;
                (_loc_6.zpp_i + 1);
                _loc_7 = _loc_6.zpp_inner.at(_loc_8);
                _loc_9 = _loc_7.zpp_inner;
                if (_loc_9.type != ZPP_Arbiter.FLUID)
                {
                }
                else
                {
                    if (param1 != null)
                    {
                    }
                    if (_loc_9.b2 != param1.zpp_inner)
                    {
                    }
                    if (_loc_9.b1 != param1.zpp_inner)
                    {
                    }
                    else
                    {
                        _loc_11 = _loc_9.wrapper();
                        _loc_10 = (_loc_11.zpp_inner.type == ZPP_Arbiter.FLUID ? (_loc_11.zpp_inner.fluidarb.outer_zn) : (null)).buoyancyImpulse(this);
                        _loc_8 = 1;
                        _loc_12 = _loc_8;
                        if (_loc_10 != null)
                        {
                        }
                        if (_loc_10.zpp_disp)
                        {
                            throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
                        }
                        _loc_13 = _loc_10.zpp_inner;
                        if (_loc_13._validate != null)
                        {
                            _loc_13._validate();
                        }
                        _loc_2 = _loc_2 + _loc_10.zpp_inner.x * _loc_12;
                        if (_loc_10 != null)
                        {
                        }
                        if (_loc_10.zpp_disp)
                        {
                            throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
                        }
                        _loc_13 = _loc_10.zpp_inner;
                        if (_loc_13._validate != null)
                        {
                            _loc_13._validate();
                        }
                        _loc_3 = _loc_3 + _loc_10.zpp_inner.y * _loc_12;
                        if (_loc_10 != null)
                        {
                        }
                        if (_loc_10.zpp_disp)
                        {
                            throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
                        }
                        _loc_13 = _loc_10.zpp_inner;
                        if (_loc_13._validate != null)
                        {
                            _loc_13._validate();
                        }
                        _loc_4 = _loc_4 + _loc_10.zpp_inner.z * _loc_8;
                        _loc_10.dispose();
                    }
                }
                _loc_6.zpp_inner.zpp_inner.valmod();
                _loc_8 = _loc_6.zpp_inner.zpp_gl();
                _loc_6.zpp_critical = true;
            }while (_loc_6.zpp_i < _loc_8 ? (true) : (_loc_6.zpp_next = ArbiterIterator.zpp_pool, ArbiterIterator.zpp_pool = _loc_6, _loc_6.zpp_inner = null, false))
            return Vec3.get(_loc_2, _loc_3, _loc_4);
        }// end function

        public function applyImpulse(param1:Vec2, param2:Vec2 = undefined, param3:Boolean = false) : Body
        {
            var _loc_4:* = null as ZPP_Vec2;
            var _loc_5:* = null as Vec2;
            var _loc_6:* = null as ZPP_Vec2;
            var _loc_7:* = NaN;
            var _loc_8:* = NaN;
            if (param1 != null)
            {
            }
            if (param1.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            if (param2 != null)
            {
            }
            if (param2.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            if (zpp_inner.world)
            {
                throw "Error: Space::world is immutable";
            }
            if (param1 == null)
            {
                throw "Error: Cannot apply null impulse to Body";
            }
            if (param3)
            {
                if (zpp_inner.space == null)
                {
                    throw "Error: isSleeping makes no sense if the object is not contained within a Space";
                }
            }
            if (zpp_inner.component.sleeping)
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
                    _loc_4 = param1.zpp_inner;
                    if (_loc_4._immutable)
                    {
                        throw "Error: Vec2 is immutable";
                    }
                    if (_loc_4._isimmutable != null)
                    {
                        _loc_4._isimmutable();
                    }
                    if (param1.zpp_inner._inuse)
                    {
                        throw "Error: This Vec2 is not disposable";
                    }
                    _loc_4 = param1.zpp_inner;
                    param1.zpp_inner.outer = null;
                    param1.zpp_inner = null;
                    _loc_5 = param1;
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
                if (param2 != null)
                {
                    if (param2.zpp_inner.weak)
                    {
                        if (param2 != null)
                        {
                        }
                        if (param2.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_4 = param2.zpp_inner;
                        if (_loc_4._immutable)
                        {
                            throw "Error: Vec2 is immutable";
                        }
                        if (_loc_4._isimmutable != null)
                        {
                            _loc_4._isimmutable();
                        }
                        if (param2.zpp_inner._inuse)
                        {
                            throw "Error: This Vec2 is not disposable";
                        }
                        _loc_4 = param2.zpp_inner;
                        param2.zpp_inner.outer = null;
                        param2.zpp_inner = null;
                        _loc_5 = param2;
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
                }
                return this;
            }
            zpp_inner.validate_mass();
            _loc_7 = zpp_inner.imass;
            if (param1 != null)
            {
            }
            if (param1.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_4 = param1.zpp_inner;
            if (_loc_4._validate != null)
            {
                _loc_4._validate();
            }
            zpp_inner.velx = zpp_inner.velx + param1.zpp_inner.x * _loc_7;
            if (param1 != null)
            {
            }
            if (param1.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_4 = param1.zpp_inner;
            if (_loc_4._validate != null)
            {
                _loc_4._validate();
            }
            zpp_inner.vely = zpp_inner.vely + param1.zpp_inner.y * _loc_7;
            if (param2 != null)
            {
                _loc_7 = 0;
                _loc_8 = 0;
                if (param2 != null)
                {
                }
                if (param2.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_4 = param2.zpp_inner;
                if (_loc_4._validate != null)
                {
                    _loc_4._validate();
                }
                _loc_7 = param2.zpp_inner.x - zpp_inner.posx;
                if (param2 != null)
                {
                }
                if (param2.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_4 = param2.zpp_inner;
                if (_loc_4._validate != null)
                {
                    _loc_4._validate();
                }
                _loc_8 = param2.zpp_inner.y - zpp_inner.posy;
                zpp_inner.validate_inertia();
                if (param1 != null)
                {
                }
                if (param1.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_4 = param1.zpp_inner;
                if (_loc_4._validate != null)
                {
                    _loc_4._validate();
                }
                if (param1 != null)
                {
                }
                if (param1.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_4 = param1.zpp_inner;
                if (_loc_4._validate != null)
                {
                    _loc_4._validate();
                }
                zpp_inner.angvel = zpp_inner.angvel + (param1.zpp_inner.y * _loc_7 - param1.zpp_inner.x * _loc_8) * zpp_inner.iinertia;
                if (param2.zpp_inner.weak)
                {
                    if (param2 != null)
                    {
                    }
                    if (param2.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_4 = param2.zpp_inner;
                    if (_loc_4._immutable)
                    {
                        throw "Error: Vec2 is immutable";
                    }
                    if (_loc_4._isimmutable != null)
                    {
                        _loc_4._isimmutable();
                    }
                    if (param2.zpp_inner._inuse)
                    {
                        throw "Error: This Vec2 is not disposable";
                    }
                    _loc_4 = param2.zpp_inner;
                    param2.zpp_inner.outer = null;
                    param2.zpp_inner = null;
                    _loc_5 = param2;
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
            }
            if (!param3)
            {
                if (zpp_inner.type == ZPP_Flags.id_BodyType_DYNAMIC)
                {
                    zpp_inner.wake();
                }
            }
            if (param1.zpp_inner.weak)
            {
                if (param1 != null)
                {
                }
                if (param1.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_4 = param1.zpp_inner;
                if (_loc_4._immutable)
                {
                    throw "Error: Vec2 is immutable";
                }
                if (_loc_4._isimmutable != null)
                {
                    _loc_4._isimmutable();
                }
                if (param1.zpp_inner._inuse)
                {
                    throw "Error: This Vec2 is not disposable";
                }
                _loc_4 = param1.zpp_inner;
                param1.zpp_inner.outer = null;
                param1.zpp_inner = null;
                _loc_5 = param1;
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

        public function applyAngularImpulse(param1:Number, param2:Boolean = false) : Body
        {
            if (zpp_inner.world)
            {
                throw "Error: Space::world is immutable";
            }
            if (param2)
            {
                if (zpp_inner.space == null)
                {
                    throw "Error: isSleeping makes no sense if the object is not contained within a Space";
                }
            }
            if (zpp_inner.component.sleeping)
            {
                return this;
            }
            zpp_inner.validate_inertia();
            zpp_inner.angvel = zpp_inner.angvel + param1 * zpp_inner.iinertia;
            if (!param2)
            {
                if (zpp_inner.type == ZPP_Flags.id_BodyType_DYNAMIC)
                {
                    zpp_inner.wake();
                }
            }
            return this;
        }// end function

        public function align() : Body
        {
            var _loc_2:* = NaN;
            var _loc_5:* = null as Vec2;
            var _loc_6:* = false;
            var _loc_7:* = null as ZPP_Vec2;
            zpp_inner.immutable_midstep("Body::align()");
            if (zpp_inner.world)
            {
                throw "Error: Space::world is immutable";
            }
            if (zpp_inner.shapes.head == null)
            {
                throw "Error: Cannot align empty Body";
            }
            zpp_inner.validate_localCOM();
            _loc_2 = -zpp_inner.localCOMx;
            var _loc_3:* = -zpp_inner.localCOMy;
            var _loc_4:* = false;
            if (_loc_2 == _loc_2)
            {
            }
            if (_loc_3 != _loc_3)
            {
                throw "Error: Vec2 components cannot be NaN";
            }
            if (ZPP_PubPool.poolVec2 == null)
            {
                _loc_5 = new Vec2();
            }
            else
            {
                _loc_5 = ZPP_PubPool.poolVec2;
                ZPP_PubPool.poolVec2 = _loc_5.zpp_pool;
                _loc_5.zpp_pool = null;
                _loc_5.zpp_disp = false;
                if (_loc_5 == ZPP_PubPool.nextVec2)
                {
                    ZPP_PubPool.nextVec2 = null;
                }
            }
            if (_loc_5.zpp_inner == null)
            {
                _loc_6 = false;
                if (ZPP_Vec2.zpp_pool == null)
                {
                    _loc_7 = new ZPP_Vec2();
                }
                else
                {
                    _loc_7 = ZPP_Vec2.zpp_pool;
                    ZPP_Vec2.zpp_pool = _loc_7.next;
                    _loc_7.next = null;
                }
                _loc_7.weak = false;
                _loc_7._immutable = _loc_6;
                _loc_7.x = _loc_2;
                _loc_7.y = _loc_3;
                _loc_5.zpp_inner = _loc_7;
                _loc_5.zpp_inner.outer = _loc_5;
            }
            else
            {
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
                if (_loc_2 == _loc_2)
                {
                }
                if (_loc_3 != _loc_3)
                {
                    throw "Error: Vec2 components cannot be NaN";
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
                if (_loc_5.zpp_inner.x == _loc_2)
                {
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
                }
                if (_loc_5.zpp_inner.y != _loc_3)
                {
                    _loc_5.zpp_inner.x = _loc_2;
                    _loc_5.zpp_inner.y = _loc_3;
                    _loc_7 = _loc_5.zpp_inner;
                    if (_loc_7._invalidate != null)
                    {
                        _loc_7._invalidate(_loc_7);
                    }
                }
            }
            _loc_5.zpp_inner.weak = _loc_4;
            var _loc_1:* = _loc_5;
            translateShapes(_loc_1);
            _loc_5 = localVectorToWorld(_loc_1);
            if (zpp_inner.wrap_pos == null)
            {
                zpp_inner.setupPosition();
            }
            zpp_inner.wrap_pos.subeq(_loc_5);
            if (zpp_inner.pre_posx < 17899999999999994000000000000)
            {
                _loc_2 = 1;
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
                zpp_inner.pre_posx = zpp_inner.pre_posx - _loc_5.zpp_inner.x * _loc_2;
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
                zpp_inner.pre_posy = zpp_inner.pre_posy - _loc_5.zpp_inner.y * _loc_2;
            }
            if (_loc_1 != null)
            {
            }
            if (_loc_1.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_7 = _loc_1.zpp_inner;
            if (_loc_7._immutable)
            {
                throw "Error: Vec2 is immutable";
            }
            if (_loc_7._isimmutable != null)
            {
                _loc_7._isimmutable();
            }
            if (_loc_1.zpp_inner._inuse)
            {
                throw "Error: This Vec2 is not disposable";
            }
            _loc_7 = _loc_1.zpp_inner;
            _loc_1.zpp_inner.outer = null;
            _loc_1.zpp_inner = null;
            var _loc_8:* = _loc_1;
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
            var _loc_9:* = _loc_7;
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
            return this;
        }// end function

    }
}
