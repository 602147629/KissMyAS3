package haxegame.game.coin
{
    import com.dango_itimi.physics.*;
    import flash.*;
    import haxe.ds.*;
    import haxegame.game.*;
    import nape.callbacks.*;
    import nape.dynamics.*;
    import nape.geom.*;
    import nape.phys.*;
    import nape.shape.*;
    import nape.space.*;
    import zpp_nape.geom.*;
    import zpp_nape.phys.*;
    import zpp_nape.util.*;

    public class NapeCoinMap extends Object
    {
        public var space:Space;
        public var pool:Array;
        public var map:IMap;
        public var baseBody:Body;
        public var assetsParser:AssetsParser;
        public static var RANDOM_SPEED_X:int;
        public static var RANDOM_SPEED_Y:int;
        public static var POOL_SIZE:int;

        public function NapeCoinMap(param1:Space = undefined, param2:AssetsParser = undefined, param3:CbType = undefined) : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            space = param1;
            assetsParser = param2;
            createBaseBody(param3);
            createPool();
            initialize();
            return;
        }// end function

        public function initialize() : void
        {
            map = new IntMap();
            return;
        }// end function

        public function existsPool() : Boolean
        {
            return pool.length > 0;
        }// end function

        public function delete(param1:int) : void
        {
            var _loc_2:* = map.h[param1];
            space.zpp_inner.wrap_bodies.remove(_loc_2);
            map.remove(param1);
            pool.push(_loc_2);
            return;
        }// end function

        public function createPool() : void
        {
            var _loc_2:* = 0;
            pool = [];
            var _loc_1:* = 0;
            while (_loc_1 < 100)
            {
                
                _loc_1++;
                _loc_2 = _loc_1;
                pool.push(baseBody.copy());
            }
            return;
        }// end function

        public function createBaseBody(param1:CbType) : void
        {
            var _loc_2:* = assetsParser.flashToPhysicsObjectParser.getPhysicsObject(assetsParser.coinShape, assetsParser.coinShape.guideLeft);
            var _loc_3:* = new Circle(_loc_2.width / 2);
            var _loc_4:* = _loc_3.zpp_inner.material.wrapper();
            if (_loc_4.zpp_inner.elasticity != 1)
            {
                _loc_4.zpp_inner.elasticity = 1;
                _loc_4.zpp_inner.invalidate(ZPP_Material.WAKE | ZPP_Material.ARBITERS);
            }
            _loc_4 = _loc_3.zpp_inner.material.wrapper();
            if (_loc_4.zpp_inner.staticFriction != 0)
            {
                _loc_4.zpp_inner.staticFriction = 0;
                _loc_4.zpp_inner.invalidate(ZPP_Material.WAKE | ZPP_Material.ARBITERS);
            }
            _loc_4 = _loc_3.zpp_inner.material.wrapper();
            if (_loc_4.zpp_inner.dynamicFriction != 0)
            {
                _loc_4.zpp_inner.dynamicFriction = 0;
                _loc_4.zpp_inner.invalidate(ZPP_Material.WAKE | ZPP_Material.ANGDRAG | ZPP_Material.ARBITERS);
            }
            _loc_4 = _loc_3.zpp_inner.material.wrapper();
            if (_loc_4.zpp_inner.rollingFriction != 0)
            {
                _loc_4.zpp_inner.rollingFriction = 0;
                _loc_4.zpp_inner.invalidate(ZPP_Material.WAKE | ZPP_Material.ARBITERS);
            }
            var _loc_5:* = _loc_3.zpp_inner.filter.wrapper();
            if (_loc_5.zpp_inner.collisionGroup != 4)
            {
                _loc_5.zpp_inner.collisionGroup = 4;
                _loc_5.zpp_inner.invalidate();
            }
            _loc_5 = _loc_3.zpp_inner.filter.wrapper();
            if (_loc_5.zpp_inner.collisionMask != -13)
            {
                _loc_5.zpp_inner.collisionMask = -13;
                _loc_5.zpp_inner.invalidate();
            }
            if (ZPP_Flags.BodyType_DYNAMIC == null)
            {
                ZPP_Flags.internal = true;
                ZPP_Flags.BodyType_DYNAMIC = new BodyType();
                ZPP_Flags.internal = false;
            }
            baseBody = new Body(ZPP_Flags.BodyType_DYNAMIC);
            var _loc_6:* = baseBody;
            _loc_6.zpp_inner.bulletEnabled = true;
            var _loc_7:* = baseBody.zpp_inner.wrap_shapes;
            if (_loc_7.zpp_inner.reverse_flag)
            {
                _loc_7.push(_loc_3);
            }
            else
            {
                _loc_7.unshift(_loc_3);
            }
            _loc_6 = baseBody;
            if (_loc_6.zpp_inner_i.wrap_cbTypes == null)
            {
                _loc_6.zpp_inner_i.setupcbTypes();
            }
            var _loc_8:* = _loc_6.zpp_inner_i.wrap_cbTypes;
            if (_loc_8.zpp_inner.reverse_flag)
            {
                _loc_8.push(param1);
            }
            else
            {
                _loc_8.unshift(param1);
            }
            return;
        }// end function

        public function create(param1:Number, param2:Number) : Body
        {
            var _loc_5:* = null as ZPP_Vec2;
            var _loc_8:* = null as Vec2;
            var _loc_9:* = false;
            var _loc_13:* = null as Vec2;
            var _loc_14:* = null as ZPP_Vec2;
            var _loc_3:* = pool.shift();
            if (_loc_3.zpp_inner.wrap_pos == null)
            {
                _loc_3.zpp_inner.setupPosition();
            }
            var _loc_4:* = _loc_3.zpp_inner.wrap_pos;
            if (_loc_4 != null)
            {
            }
            if (_loc_4.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_5 = _loc_4.zpp_inner;
            if (_loc_5._immutable)
            {
                throw "Error: Vec2 is immutable";
            }
            if (_loc_5._isimmutable != null)
            {
                _loc_5._isimmutable();
            }
            if (param1 == param1)
            {
            }
            if (param2 != param2)
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
            _loc_5 = _loc_4.zpp_inner;
            if (_loc_5._validate != null)
            {
                _loc_5._validate();
            }
            if (_loc_4.zpp_inner.x == param1)
            {
                if (_loc_4 != null)
                {
                }
                if (_loc_4.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_5 = _loc_4.zpp_inner;
                if (_loc_5._validate != null)
                {
                    _loc_5._validate();
                }
            }
            if (_loc_4.zpp_inner.y != param2)
            {
                _loc_4.zpp_inner.x = param1;
                _loc_4.zpp_inner.y = param2;
                _loc_5 = _loc_4.zpp_inner;
                if (_loc_5._invalidate != null)
                {
                    _loc_5._invalidate(_loc_5);
                }
            }
            var _loc_6:* = Math.floor(Math.random() * 100);
            if (Math.random() > 0.5)
            {
                _loc_6 = _loc_6 * -1;
            }
            var _loc_7:* = Math.floor(Math.random() * 100);
            if (Math.random() > 0.5)
            {
                _loc_7 = _loc_7 * -1;
            }
            if (_loc_6 == _loc_6)
            {
            }
            if (_loc_7 != _loc_7)
            {
                throw "Error: Vec2 components cannot be NaN";
            }
            if (ZPP_PubPool.poolVec2 == null)
            {
                _loc_8 = new Vec2();
            }
            else
            {
                _loc_8 = ZPP_PubPool.poolVec2;
                ZPP_PubPool.poolVec2 = _loc_8.zpp_pool;
                _loc_8.zpp_pool = null;
                _loc_8.zpp_disp = false;
                if (_loc_8 == ZPP_PubPool.nextVec2)
                {
                    ZPP_PubPool.nextVec2 = null;
                }
            }
            if (_loc_8.zpp_inner == null)
            {
                _loc_9 = false;
                if (ZPP_Vec2.zpp_pool == null)
                {
                    _loc_5 = new ZPP_Vec2();
                }
                else
                {
                    _loc_5 = ZPP_Vec2.zpp_pool;
                    ZPP_Vec2.zpp_pool = _loc_5.next;
                    _loc_5.next = null;
                }
                _loc_5.weak = false;
                _loc_5._immutable = _loc_9;
                _loc_5.x = _loc_6;
                _loc_5.y = _loc_7;
                _loc_8.zpp_inner = _loc_5;
                _loc_8.zpp_inner.outer = _loc_8;
            }
            else
            {
                if (_loc_8 != null)
                {
                }
                if (_loc_8.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_5 = _loc_8.zpp_inner;
                if (_loc_5._immutable)
                {
                    throw "Error: Vec2 is immutable";
                }
                if (_loc_5._isimmutable != null)
                {
                    _loc_5._isimmutable();
                }
                if (_loc_6 == _loc_6)
                {
                }
                if (_loc_7 != _loc_7)
                {
                    throw "Error: Vec2 components cannot be NaN";
                }
                if (_loc_8 != null)
                {
                }
                if (_loc_8.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_5 = _loc_8.zpp_inner;
                if (_loc_5._validate != null)
                {
                    _loc_5._validate();
                }
                if (_loc_8.zpp_inner.x == _loc_6)
                {
                    if (_loc_8 != null)
                    {
                    }
                    if (_loc_8.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_5 = _loc_8.zpp_inner;
                    if (_loc_5._validate != null)
                    {
                        _loc_5._validate();
                    }
                }
                if (_loc_8.zpp_inner.y != _loc_7)
                {
                    _loc_8.zpp_inner.x = _loc_6;
                    _loc_8.zpp_inner.y = _loc_7;
                    _loc_5 = _loc_8.zpp_inner;
                    if (_loc_5._invalidate != null)
                    {
                        _loc_5._invalidate(_loc_5);
                    }
                }
            }
            _loc_8.zpp_inner.weak = true;
            _loc_4 = _loc_8;
            if (_loc_4 != null)
            {
            }
            if (_loc_4.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            if (_loc_4 == null)
            {
                throw "Error: Body::" + "velocity" + " cannot be null";
            }
            if (_loc_3.zpp_inner.wrap_vel == null)
            {
                _loc_3.zpp_inner.setupVelocity();
            }
            _loc_8 = _loc_3.zpp_inner.wrap_vel;
            if (_loc_8 != null)
            {
            }
            if (_loc_8.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            if (_loc_4 != null)
            {
            }
            if (_loc_4.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_5 = _loc_8.zpp_inner;
            if (_loc_5._immutable)
            {
                throw "Error: Vec2 is immutable";
            }
            if (_loc_5._isimmutable != null)
            {
                _loc_5._isimmutable();
            }
            if (_loc_4 == null)
            {
                throw "Error: Cannot assign null Vec2";
            }
            if (_loc_4 != null)
            {
            }
            if (_loc_4.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_5 = _loc_4.zpp_inner;
            if (_loc_5._validate != null)
            {
                _loc_5._validate();
            }
            var _loc_11:* = _loc_4.zpp_inner.x;
            if (_loc_4 != null)
            {
            }
            if (_loc_4.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_5 = _loc_4.zpp_inner;
            if (_loc_5._validate != null)
            {
                _loc_5._validate();
            }
            var _loc_12:* = _loc_4.zpp_inner.y;
            if (_loc_8 != null)
            {
            }
            if (_loc_8.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_5 = _loc_8.zpp_inner;
            if (_loc_5._immutable)
            {
                throw "Error: Vec2 is immutable";
            }
            if (_loc_5._isimmutable != null)
            {
                _loc_5._isimmutable();
            }
            if (_loc_11 == _loc_11)
            {
            }
            if (_loc_12 != _loc_12)
            {
                throw "Error: Vec2 components cannot be NaN";
            }
            if (_loc_8 != null)
            {
            }
            if (_loc_8.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_5 = _loc_8.zpp_inner;
            if (_loc_5._validate != null)
            {
                _loc_5._validate();
            }
            if (_loc_8.zpp_inner.x == _loc_11)
            {
                if (_loc_8 != null)
                {
                }
                if (_loc_8.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_5 = _loc_8.zpp_inner;
                if (_loc_5._validate != null)
                {
                    _loc_5._validate();
                }
            }
            if (_loc_8.zpp_inner.y != _loc_12)
            {
                _loc_8.zpp_inner.x = _loc_11;
                _loc_8.zpp_inner.y = _loc_12;
                _loc_5 = _loc_8.zpp_inner;
                if (_loc_5._invalidate != null)
                {
                    _loc_5._invalidate(_loc_5);
                }
            }
            var _loc_10:* = _loc_8;
            if (_loc_4.zpp_inner.weak)
            {
                if (_loc_4 != null)
                {
                }
                if (_loc_4.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_5 = _loc_4.zpp_inner;
                if (_loc_5._immutable)
                {
                    throw "Error: Vec2 is immutable";
                }
                if (_loc_5._isimmutable != null)
                {
                    _loc_5._isimmutable();
                }
                if (_loc_4.zpp_inner._inuse)
                {
                    throw "Error: This Vec2 is not disposable";
                }
                _loc_5 = _loc_4.zpp_inner;
                _loc_4.zpp_inner.outer = null;
                _loc_4.zpp_inner = null;
                _loc_13 = _loc_4;
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
                _loc_14 = _loc_5;
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
            else
            {
            }
            if (_loc_3.zpp_inner.wrap_vel == null)
            {
                _loc_3.zpp_inner.setupVelocity();
            }
            map.h[_loc_3.zpp_inner_i.id] = _loc_3;
            var _loc_15:* = space.zpp_inner.wrap_bodies;
            if (_loc_15.zpp_inner.reverse_flag)
            {
                _loc_15.push(_loc_3);
            }
            else
            {
                _loc_15.unshift(_loc_3);
            }
            return _loc_3;
        }// end function

    }
}
