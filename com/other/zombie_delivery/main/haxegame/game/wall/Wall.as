package haxegame.game.wall
{
    import flash.*;
    import nape.callbacks.*;
    import nape.dynamics.*;
    import nape.geom.*;
    import nape.phys.*;
    import nape.shape.*;
    import nape.space.*;
    import zpp_nape.geom.*;
    import zpp_nape.phys.*;
    import zpp_nape.util.*;

    public class Wall extends Object
    {
        public var space:Space;
        public var restitution:Number;
        public var lineId:int;
        public var length:Number;
        public var body:Body;
        public static var RESTITUTION_BASE_LENGTH:int;
        public static var RESTITUTION_BASE_POWER:Number;
        public static var RESTITUTION_MAX_POWER:Number;
        public static var HEIGHT:int;

        public function Wall(param1:Space = undefined, param2:int = 0, param3:Object = undefined, param4:Object = undefined, param5:CbType = undefined) : void
        {
            var _loc_16:* = null as ZPP_Vec2;
            if (Boot.skip_constructor)
            {
                return;
            }
            space = param1;
            lineId = param2;
            var _loc_6:* = (param4.x - param3.x) * 0.5 + param3.x;
            var _loc_7:* = (param4.y - param3.y) * 0.5 + param3.y;
            var _loc_8:* = Math.atan2(_loc_7 - param4.y, _loc_6 - param4.x);
            var _loc_9:* = param3.x - param4.x;
            var _loc_10:* = param3.y - param4.y;
            length = Math.sqrt(_loc_9 * _loc_9 + _loc_10 * _loc_10);
            restitution = length / 105 * 0.5;
            if (restitution > 1.3)
            {
                restitution = 1.3;
            }
            var _loc_11:* = new Polygon(Polygon.box(length, 5));
            var _loc_12:* = _loc_11.zpp_inner.material.wrapper();
            if (_loc_12.zpp_inner.elasticity != 1)
            {
                _loc_12.zpp_inner.elasticity = 1;
                _loc_12.zpp_inner.invalidate(ZPP_Material.WAKE | ZPP_Material.ARBITERS);
            }
            _loc_12 = _loc_11.zpp_inner.material.wrapper();
            if (_loc_12.zpp_inner.staticFriction != 0)
            {
                _loc_12.zpp_inner.staticFriction = 0;
                _loc_12.zpp_inner.invalidate(ZPP_Material.WAKE | ZPP_Material.ARBITERS);
            }
            _loc_12 = _loc_11.zpp_inner.material.wrapper();
            if (_loc_12.zpp_inner.dynamicFriction != 0)
            {
                _loc_12.zpp_inner.dynamicFriction = 0;
                _loc_12.zpp_inner.invalidate(ZPP_Material.WAKE | ZPP_Material.ANGDRAG | ZPP_Material.ARBITERS);
            }
            _loc_12 = _loc_11.zpp_inner.material.wrapper();
            if (_loc_12.zpp_inner.rollingFriction != 0)
            {
                _loc_12.zpp_inner.rollingFriction = 0;
                _loc_12.zpp_inner.invalidate(ZPP_Material.WAKE | ZPP_Material.ARBITERS);
            }
            var _loc_13:* = _loc_11.zpp_inner.filter.wrapper();
            if (_loc_13.zpp_inner.collisionGroup != 8)
            {
                _loc_13.zpp_inner.collisionGroup = 8;
                _loc_13.zpp_inner.invalidate();
            }
            if (ZPP_Flags.BodyType_STATIC == null)
            {
                ZPP_Flags.internal = true;
                ZPP_Flags.BodyType_STATIC = new BodyType();
                ZPP_Flags.internal = false;
            }
            body = new Body(ZPP_Flags.BodyType_STATIC);
            var _loc_15:* = body;
            if (_loc_15.zpp_inner.wrap_pos == null)
            {
                _loc_15.zpp_inner.setupPosition();
            }
            var _loc_14:* = _loc_15.zpp_inner.wrap_pos;
            _loc_9 = _loc_6;
            _loc_10 = _loc_7;
            if (_loc_14 != null)
            {
            }
            if (_loc_14.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_16 = _loc_14.zpp_inner;
            if (_loc_16._immutable)
            {
                throw "Error: Vec2 is immutable";
            }
            if (_loc_16._isimmutable != null)
            {
                _loc_16._isimmutable();
            }
            if (_loc_9 == _loc_9)
            {
            }
            if (_loc_10 != _loc_10)
            {
                throw "Error: Vec2 components cannot be NaN";
            }
            if (_loc_14 != null)
            {
            }
            if (_loc_14.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_16 = _loc_14.zpp_inner;
            if (_loc_16._validate != null)
            {
                _loc_16._validate();
            }
            if (_loc_14.zpp_inner.x == _loc_9)
            {
                if (_loc_14 != null)
                {
                }
                if (_loc_14.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_16 = _loc_14.zpp_inner;
                if (_loc_16._validate != null)
                {
                    _loc_16._validate();
                }
            }
            if (_loc_14.zpp_inner.y != _loc_10)
            {
                _loc_14.zpp_inner.x = _loc_9;
                _loc_14.zpp_inner.y = _loc_10;
                _loc_16 = _loc_14.zpp_inner;
                if (_loc_16._invalidate != null)
                {
                    _loc_16._invalidate(_loc_16);
                }
            }
            body.rotate(new Vec2(_loc_6, _loc_7), _loc_8);
            _loc_15 = body;
            _loc_15.zpp_inner.bulletEnabled = true;
            var _loc_17:* = body.zpp_inner.wrap_shapes;
            if (_loc_17.zpp_inner.reverse_flag)
            {
                _loc_17.push(_loc_11);
            }
            else
            {
                _loc_17.unshift(_loc_11);
            }
            _loc_15 = body;
            if (_loc_15.zpp_inner_i.wrap_cbTypes == null)
            {
                _loc_15.zpp_inner_i.setupcbTypes();
            }
            var _loc_18:* = _loc_15.zpp_inner_i.wrap_cbTypes;
            if (_loc_18.zpp_inner.reverse_flag)
            {
                _loc_18.push(param5);
            }
            else
            {
                _loc_18.unshift(param5);
            }
            var _loc_19:* = param1.zpp_inner.wrap_bodies;
            _loc_15 = body;
            if (_loc_19.zpp_inner.reverse_flag)
            {
                _loc_19.push(_loc_15);
            }
            else
            {
                _loc_19.unshift(_loc_15);
            }
            return;
        }// end function

        public function destroy() : void
        {
            space.zpp_inner.wrap_bodies.remove(body);
            return;
        }// end function

    }
}
