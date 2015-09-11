package haxegame.game.character
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

    public class NapeCharacterMap extends Object
    {
        public var space:Space;
        public var positionY:Number;
        public var map:IMap;
        public var baseBody:Body;
        public var assetsParser:AssetsParser;
        public static var APPEARANCE_AREA:Number;
        public static var APPEARANCE_LEFT:Number;
        public static var APPEARANCE_RIGHT:Number;
        public static var APPEARANCE_CENTER:Number;
        public static var APPEARANCE_LITTLE_LEFT:Number;
        public static var APPEARANCE_LITTLE_RIGHT:Number;

        public function NapeCharacterMap(param1:Space = undefined, param2:AssetsParser = undefined, param3:CbType = undefined, param4:CbType = undefined) : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            space = param1;
            assetsParser = param2;
            positionY = param2.characterShape.guideLeft.y;
            NapeCharacterMap.APPEARANCE_LEFT = param2.characterShape.guideLeft.x;
            NapeCharacterMap.APPEARANCE_RIGHT = param2.characterShape.guideRight.x;
            NapeCharacterMap.APPEARANCE_AREA = NapeCharacterMap.APPEARANCE_RIGHT - NapeCharacterMap.APPEARANCE_LEFT;
            NapeCharacterMap.APPEARANCE_CENTER = Math.floor(NapeCharacterMap.APPEARANCE_AREA / 2) + NapeCharacterMap.APPEARANCE_LEFT;
            NapeCharacterMap.APPEARANCE_LITTLE_LEFT = Math.floor((NapeCharacterMap.APPEARANCE_CENTER - NapeCharacterMap.APPEARANCE_LEFT) / 2) + NapeCharacterMap.APPEARANCE_LEFT;
            NapeCharacterMap.APPEARANCE_LITTLE_RIGHT = Math.floor((NapeCharacterMap.APPEARANCE_RIGHT - NapeCharacterMap.APPEARANCE_CENTER) / 2) + NapeCharacterMap.APPEARANCE_CENTER;
            createBaseBody(param3, param4);
            initialize();
            return;
        }// end function

        public function initialize() : void
        {
            map = new IntMap();
            return;
        }// end function

        public function delete(param1:int) : void
        {
            space.zpp_inner.wrap_bodies.remove(map.h[param1]);
            map.remove(param1);
            return;
        }// end function

        public function createRandomPosition() : Body
        {
            var _loc_1:* = Math.floor(Math.random() * NapeCharacterMap.APPEARANCE_AREA) + NapeCharacterMap.APPEARANCE_LEFT;
            return create(_loc_1);
        }// end function

        public function createLittleRight() : Body
        {
            return create(NapeCharacterMap.APPEARANCE_LITTLE_RIGHT);
        }// end function

        public function createLittleLeft() : Body
        {
            return create(NapeCharacterMap.APPEARANCE_LITTLE_LEFT);
        }// end function

        public function createCenter() : Body
        {
            return create(NapeCharacterMap.APPEARANCE_CENTER);
        }// end function

        public function createBaseBody(param1:CbType, param2:CbType) : void
        {
            var _loc_3:* = assetsParser.flashToPhysicsObjectParser.getPhysicsObject(assetsParser.characterShape, assetsParser.characterShape.guideLeft);
            var _loc_4:* = new Circle(_loc_3.width / 2);
            var _loc_5:* = _loc_4.zpp_inner.material.wrapper();
            if (_loc_5.zpp_inner.elasticity != 1)
            {
                _loc_5.zpp_inner.elasticity = 1;
                _loc_5.zpp_inner.invalidate(ZPP_Material.WAKE | ZPP_Material.ARBITERS);
            }
            _loc_5 = _loc_4.zpp_inner.material.wrapper();
            if (_loc_5.zpp_inner.staticFriction != 0)
            {
                _loc_5.zpp_inner.staticFriction = 0;
                _loc_5.zpp_inner.invalidate(ZPP_Material.WAKE | ZPP_Material.ARBITERS);
            }
            _loc_5 = _loc_4.zpp_inner.material.wrapper();
            if (_loc_5.zpp_inner.dynamicFriction != 0)
            {
                _loc_5.zpp_inner.dynamicFriction = 0;
                _loc_5.zpp_inner.invalidate(ZPP_Material.WAKE | ZPP_Material.ANGDRAG | ZPP_Material.ARBITERS);
            }
            _loc_5 = _loc_4.zpp_inner.material.wrapper();
            if (_loc_5.zpp_inner.rollingFriction != 0)
            {
                _loc_5.zpp_inner.rollingFriction = 0;
                _loc_5.zpp_inner.invalidate(ZPP_Material.WAKE | ZPP_Material.ARBITERS);
            }
            var _loc_6:* = _loc_4.zpp_inner.filter.wrapper();
            if (_loc_6.zpp_inner.collisionGroup != 2)
            {
                _loc_6.zpp_inner.collisionGroup = 2;
                _loc_6.zpp_inner.invalidate();
            }
            _loc_6 = _loc_4.zpp_inner.filter.wrapper();
            if (_loc_6.zpp_inner.collisionMask != -7)
            {
                _loc_6.zpp_inner.collisionMask = -7;
                _loc_6.zpp_inner.invalidate();
            }
            if (ZPP_Flags.BodyType_DYNAMIC == null)
            {
                ZPP_Flags.internal = true;
                ZPP_Flags.BodyType_DYNAMIC = new BodyType();
                ZPP_Flags.internal = false;
            }
            baseBody = new Body(ZPP_Flags.BodyType_DYNAMIC);
            var _loc_7:* = baseBody;
            _loc_7.zpp_inner.bulletEnabled = true;
            _loc_7 = baseBody;
            if (_loc_7.zpp_inner_i.wrap_cbTypes == null)
            {
                _loc_7.zpp_inner_i.setupcbTypes();
            }
            var _loc_8:* = _loc_7.zpp_inner_i.wrap_cbTypes;
            if (_loc_8.zpp_inner.reverse_flag)
            {
                _loc_8.push(param1);
            }
            else
            {
                _loc_8.unshift(param1);
            }
            _loc_7 = baseBody;
            if (_loc_7.zpp_inner_i.wrap_cbTypes == null)
            {
                _loc_7.zpp_inner_i.setupcbTypes();
            }
            _loc_8 = _loc_7.zpp_inner_i.wrap_cbTypes;
            if (_loc_8.zpp_inner.reverse_flag)
            {
                _loc_8.push(param2);
            }
            else
            {
                _loc_8.unshift(param2);
            }
            var _loc_9:* = baseBody.zpp_inner.wrap_shapes;
            if (_loc_9.zpp_inner.reverse_flag)
            {
                _loc_9.push(_loc_4);
            }
            else
            {
                _loc_9.unshift(_loc_4);
            }
            return;
        }// end function

        public function create(param1:Number) : Body
        {
            var _loc_5:* = null as ZPP_Vec2;
            var _loc_6:* = null as Vec2;
            var _loc_7:* = false;
            var _loc_10:* = null as Vec2;
            var _loc_11:* = null as ZPP_Vec2;
            var _loc_2:* = baseBody.copy();
            if (_loc_2.zpp_inner.wrap_pos == null)
            {
                _loc_2.zpp_inner.setupPosition();
            }
            var _loc_3:* = _loc_2.zpp_inner.wrap_pos;
            var _loc_4:* = positionY;
            if (_loc_3 != null)
            {
            }
            if (_loc_3.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_5 = _loc_3.zpp_inner;
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
            if (_loc_4 != _loc_4)
            {
                throw "Error: Vec2 components cannot be NaN";
            }
            if (_loc_3 != null)
            {
            }
            if (_loc_3.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_5 = _loc_3.zpp_inner;
            if (_loc_5._validate != null)
            {
                _loc_5._validate();
            }
            if (_loc_3.zpp_inner.x == param1)
            {
                if (_loc_3 != null)
                {
                }
                if (_loc_3.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_5 = _loc_3.zpp_inner;
                if (_loc_5._validate != null)
                {
                    _loc_5._validate();
                }
            }
            if (_loc_3.zpp_inner.y != _loc_4)
            {
                _loc_3.zpp_inner.x = param1;
                _loc_3.zpp_inner.y = _loc_4;
                _loc_5 = _loc_3.zpp_inner;
                if (_loc_5._invalidate != null)
                {
                    _loc_5._invalidate(_loc_5);
                }
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
                    _loc_5 = new ZPP_Vec2();
                }
                else
                {
                    _loc_5 = ZPP_Vec2.zpp_pool;
                    ZPP_Vec2.zpp_pool = _loc_5.next;
                    _loc_5.next = null;
                }
                _loc_5.weak = false;
                _loc_5._immutable = _loc_7;
                _loc_5.x = 0;
                _loc_5.y = 0;
                _loc_6.zpp_inner = _loc_5;
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
                _loc_5 = _loc_6.zpp_inner;
                if (_loc_5._immutable)
                {
                    throw "Error: Vec2 is immutable";
                }
                if (_loc_5._isimmutable != null)
                {
                    _loc_5._isimmutable();
                }
                if (_loc_6 != null)
                {
                }
                if (_loc_6.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_5 = _loc_6.zpp_inner;
                if (_loc_5._validate != null)
                {
                    _loc_5._validate();
                }
                if (_loc_6.zpp_inner.x == 0)
                {
                    if (_loc_6 != null)
                    {
                    }
                    if (_loc_6.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_5 = _loc_6.zpp_inner;
                    if (_loc_5._validate != null)
                    {
                        _loc_5._validate();
                    }
                }
                if (_loc_6.zpp_inner.y != 0)
                {
                    _loc_6.zpp_inner.x = 0;
                    _loc_6.zpp_inner.y = 0;
                    _loc_5 = _loc_6.zpp_inner;
                    if (_loc_5._invalidate != null)
                    {
                        _loc_5._invalidate(_loc_5);
                    }
                }
            }
            _loc_6.zpp_inner.weak = true;
            _loc_3 = _loc_6;
            if (_loc_3 != null)
            {
            }
            if (_loc_3.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            if (_loc_3 == null)
            {
                throw "Error: Body::" + "velocity" + " cannot be null";
            }
            if (_loc_2.zpp_inner.wrap_vel == null)
            {
                _loc_2.zpp_inner.setupVelocity();
            }
            _loc_6 = _loc_2.zpp_inner.wrap_vel;
            if (_loc_6 != null)
            {
            }
            if (_loc_6.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            if (_loc_3 != null)
            {
            }
            if (_loc_3.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_5 = _loc_6.zpp_inner;
            if (_loc_5._immutable)
            {
                throw "Error: Vec2 is immutable";
            }
            if (_loc_5._isimmutable != null)
            {
                _loc_5._isimmutable();
            }
            if (_loc_3 == null)
            {
                throw "Error: Cannot assign null Vec2";
            }
            if (_loc_3 != null)
            {
            }
            if (_loc_3.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_5 = _loc_3.zpp_inner;
            if (_loc_5._validate != null)
            {
                _loc_5._validate();
            }
            _loc_4 = _loc_3.zpp_inner.x;
            if (_loc_3 != null)
            {
            }
            if (_loc_3.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_5 = _loc_3.zpp_inner;
            if (_loc_5._validate != null)
            {
                _loc_5._validate();
            }
            var _loc_9:* = _loc_3.zpp_inner.y;
            if (_loc_6 != null)
            {
            }
            if (_loc_6.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_5 = _loc_6.zpp_inner;
            if (_loc_5._immutable)
            {
                throw "Error: Vec2 is immutable";
            }
            if (_loc_5._isimmutable != null)
            {
                _loc_5._isimmutable();
            }
            if (_loc_4 == _loc_4)
            {
            }
            if (_loc_9 != _loc_9)
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
            _loc_5 = _loc_6.zpp_inner;
            if (_loc_5._validate != null)
            {
                _loc_5._validate();
            }
            if (_loc_6.zpp_inner.x == _loc_4)
            {
                if (_loc_6 != null)
                {
                }
                if (_loc_6.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_5 = _loc_6.zpp_inner;
                if (_loc_5._validate != null)
                {
                    _loc_5._validate();
                }
            }
            if (_loc_6.zpp_inner.y != _loc_9)
            {
                _loc_6.zpp_inner.x = _loc_4;
                _loc_6.zpp_inner.y = _loc_9;
                _loc_5 = _loc_6.zpp_inner;
                if (_loc_5._invalidate != null)
                {
                    _loc_5._invalidate(_loc_5);
                }
            }
            var _loc_8:* = _loc_6;
            if (_loc_3.zpp_inner.weak)
            {
                if (_loc_3 != null)
                {
                }
                if (_loc_3.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_5 = _loc_3.zpp_inner;
                if (_loc_5._immutable)
                {
                    throw "Error: Vec2 is immutable";
                }
                if (_loc_5._isimmutable != null)
                {
                    _loc_5._isimmutable();
                }
                if (_loc_3.zpp_inner._inuse)
                {
                    throw "Error: This Vec2 is not disposable";
                }
                _loc_5 = _loc_3.zpp_inner;
                _loc_3.zpp_inner.outer = null;
                _loc_3.zpp_inner = null;
                _loc_10 = _loc_3;
                _loc_10.zpp_pool = null;
                if (ZPP_PubPool.nextVec2 != null)
                {
                    ZPP_PubPool.nextVec2.zpp_pool = _loc_10;
                }
                else
                {
                    ZPP_PubPool.poolVec2 = _loc_10;
                }
                ZPP_PubPool.nextVec2 = _loc_10;
                _loc_10.zpp_disp = true;
                _loc_11 = _loc_5;
                if (_loc_11.outer != null)
                {
                    _loc_11.outer.zpp_inner = null;
                    _loc_11.outer = null;
                }
                _loc_11._isimmutable = null;
                _loc_11._validate = null;
                _loc_11._invalidate = null;
                _loc_11.next = ZPP_Vec2.zpp_pool;
                ZPP_Vec2.zpp_pool = _loc_11;
            }
            else
            {
            }
            if (_loc_2.zpp_inner.wrap_vel == null)
            {
                _loc_2.zpp_inner.setupVelocity();
            }
            map.h[_loc_2.zpp_inner_i.id] = _loc_2;
            var _loc_12:* = space.zpp_inner.wrap_bodies;
            if (_loc_12.zpp_inner.reverse_flag)
            {
                _loc_12.push(_loc_2);
            }
            else
            {
                _loc_12.unshift(_loc_2);
            }
            return _loc_2;
        }// end function

    }
}
