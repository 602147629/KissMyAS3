package haxegame.game.background
{
    import com.dango_itimi.physics.*;
    import flash.*;
    import haxegame.game.*;
    import nape.callbacks.*;
    import nape.geom.*;
    import nape.phys.*;
    import nape.shape.*;
    import nape.space.*;
    import zpp_nape.geom.*;
    import zpp_nape.phys.*;
    import zpp_nape.util.*;

    public class NapeBackground extends Object
    {
        public var space:Space;
        public var floorBody:Body;
        public var assetsParser:AssetsParser;
        public var anonymousBodySet:Array;

        public function NapeBackground(param1:AssetsParser = undefined, param2:Space = undefined, param3:CbType = undefined, param4:CbType = undefined) : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            space = param2;
            assetsParser = param1;
            anonymousBodySet = [];
            setFloor(param3, param4);
            setAnonymousBox(param4);
            setAnonymousCircle();
            setAnonymousPolygon();
            return;
        }// end function

        public function setFloor(param1:CbType, param2:CbType) : void
        {
            var _loc_9:* = null as ZPP_Vec2;
            var _loc_3:* = assetsParser.flashToPhysicsObjectParser.getPhysicsObject(assetsParser.backgroundShape, assetsParser.backgroundShape.floor);
            var _loc_4:* = new Polygon(Polygon.box(_loc_3.width, _loc_3.height));
            if (ZPP_Flags.BodyType_STATIC == null)
            {
                ZPP_Flags.internal = true;
                ZPP_Flags.BodyType_STATIC = new BodyType();
                ZPP_Flags.internal = false;
            }
            floorBody = new Body(ZPP_Flags.BodyType_STATIC);
            var _loc_6:* = floorBody;
            if (_loc_6.zpp_inner.wrap_pos == null)
            {
                _loc_6.zpp_inner.setupPosition();
            }
            var _loc_5:* = _loc_6.zpp_inner.wrap_pos;
            var _loc_7:* = _loc_3.x;
            var _loc_8:* = _loc_3.y;
            if (_loc_5 != null)
            {
            }
            if (_loc_5.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_9 = _loc_5.zpp_inner;
            if (_loc_9._immutable)
            {
                throw "Error: Vec2 is immutable";
            }
            if (_loc_9._isimmutable != null)
            {
                _loc_9._isimmutable();
            }
            if (_loc_7 == _loc_7)
            {
            }
            if (_loc_8 != _loc_8)
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
            _loc_9 = _loc_5.zpp_inner;
            if (_loc_9._validate != null)
            {
                _loc_9._validate();
            }
            if (_loc_5.zpp_inner.x == _loc_7)
            {
                if (_loc_5 != null)
                {
                }
                if (_loc_5.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_9 = _loc_5.zpp_inner;
                if (_loc_9._validate != null)
                {
                    _loc_9._validate();
                }
            }
            if (_loc_5.zpp_inner.y != _loc_8)
            {
                _loc_5.zpp_inner.x = _loc_7;
                _loc_5.zpp_inner.y = _loc_8;
                _loc_9 = _loc_5.zpp_inner;
                if (_loc_9._invalidate != null)
                {
                    _loc_9._invalidate(_loc_9);
                }
            }
            var _loc_10:* = floorBody.zpp_inner.wrap_shapes;
            if (_loc_10.zpp_inner.reverse_flag)
            {
                _loc_10.push(_loc_4);
            }
            else
            {
                _loc_10.unshift(_loc_4);
            }
            _loc_6 = floorBody;
            if (_loc_6.zpp_inner_i.wrap_cbTypes == null)
            {
                _loc_6.zpp_inner_i.setupcbTypes();
            }
            var _loc_11:* = _loc_6.zpp_inner_i.wrap_cbTypes;
            if (_loc_11.zpp_inner.reverse_flag)
            {
                _loc_11.push(param1);
            }
            else
            {
                _loc_11.unshift(param1);
            }
            _loc_6 = floorBody;
            if (_loc_6.zpp_inner_i.wrap_cbTypes == null)
            {
                _loc_6.zpp_inner_i.setupcbTypes();
            }
            _loc_11 = _loc_6.zpp_inner_i.wrap_cbTypes;
            if (_loc_11.zpp_inner.reverse_flag)
            {
                _loc_11.push(param2);
            }
            else
            {
                _loc_11.unshift(param2);
            }
            var _loc_12:* = space.zpp_inner.wrap_bodies;
            _loc_6 = floorBody;
            if (_loc_12.zpp_inner.reverse_flag)
            {
                _loc_12.push(_loc_6);
            }
            else
            {
                _loc_12.unshift(_loc_6);
            }
            return;
        }// end function

        public function setAnonymousPolygon() : void
        {
            return;
        }// end function

        public function setAnonymousCircle() : void
        {
            return;
        }// end function

        public function setAnonymousBox(param1:CbType) : void
        {
            var _loc_4:* = null as PhysicsObject;
            var _loc_5:* = null as Polygon;
            var _loc_6:* = null as Material;
            var _loc_7:* = null as Body;
            var _loc_8:* = null as Vec2;
            var _loc_9:* = NaN;
            var _loc_10:* = NaN;
            var _loc_11:* = null as ZPP_Vec2;
            var _loc_12:* = null as ShapeList;
            var _loc_13:* = null as CbTypeList;
            var _loc_14:* = null as BodyList;
            var _loc_2:* = assetsParser.flashToPhysicsObjectParser.getAnonymousPhysicsObjectSet(assetsParser.backgroundShape);
            var _loc_3:* = 0;
            while (_loc_3 < _loc_2.length)
            {
                
                _loc_4 = _loc_2[_loc_3];
                _loc_3++;
                _loc_5 = new Polygon(Polygon.box(_loc_4.width, _loc_4.height));
                _loc_6 = _loc_5.zpp_inner.material.wrapper();
                if (_loc_6.zpp_inner.staticFriction != 0)
                {
                    _loc_6.zpp_inner.staticFriction = 0;
                    _loc_6.zpp_inner.invalidate(ZPP_Material.WAKE | ZPP_Material.ARBITERS);
                }
                _loc_6 = _loc_5.zpp_inner.material.wrapper();
                if (_loc_6.zpp_inner.dynamicFriction != 0)
                {
                    _loc_6.zpp_inner.dynamicFriction = 0;
                    _loc_6.zpp_inner.invalidate(ZPP_Material.WAKE | ZPP_Material.ANGDRAG | ZPP_Material.ARBITERS);
                }
                _loc_6 = _loc_5.zpp_inner.material.wrapper();
                if (_loc_6.zpp_inner.rollingFriction != 0)
                {
                    _loc_6.zpp_inner.rollingFriction = 0;
                    _loc_6.zpp_inner.invalidate(ZPP_Material.WAKE | ZPP_Material.ARBITERS);
                }
                if (ZPP_Flags.BodyType_STATIC == null)
                {
                    ZPP_Flags.internal = true;
                    ZPP_Flags.BodyType_STATIC = new BodyType();
                    ZPP_Flags.internal = false;
                }
                _loc_7 = new Body(ZPP_Flags.BodyType_STATIC);
                if (_loc_7.zpp_inner.wrap_pos == null)
                {
                    _loc_7.zpp_inner.setupPosition();
                }
                _loc_8 = _loc_7.zpp_inner.wrap_pos;
                _loc_9 = _loc_4.x;
                _loc_10 = _loc_4.y;
                if (_loc_8 != null)
                {
                }
                if (_loc_8.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_11 = _loc_8.zpp_inner;
                if (_loc_11._immutable)
                {
                    throw "Error: Vec2 is immutable";
                }
                if (_loc_11._isimmutable != null)
                {
                    _loc_11._isimmutable();
                }
                if (_loc_9 == _loc_9)
                {
                }
                if (_loc_10 != _loc_10)
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
                _loc_11 = _loc_8.zpp_inner;
                if (_loc_11._validate != null)
                {
                    _loc_11._validate();
                }
                if (_loc_8.zpp_inner.x == _loc_9)
                {
                    if (_loc_8 != null)
                    {
                    }
                    if (_loc_8.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_11 = _loc_8.zpp_inner;
                    if (_loc_11._validate != null)
                    {
                        _loc_11._validate();
                    }
                }
                if (_loc_8.zpp_inner.y != _loc_10)
                {
                    _loc_8.zpp_inner.x = _loc_9;
                    _loc_8.zpp_inner.y = _loc_10;
                    _loc_11 = _loc_8.zpp_inner;
                    if (_loc_11._invalidate != null)
                    {
                        _loc_11._invalidate(_loc_11);
                    }
                }
                _loc_7.rotate(new Vec2(_loc_4.x, _loc_4.y), _loc_4.radian);
                _loc_12 = _loc_7.zpp_inner.wrap_shapes;
                if (_loc_12.zpp_inner.reverse_flag)
                {
                    _loc_12.push(_loc_5);
                }
                else
                {
                    _loc_12.unshift(_loc_5);
                }
                if (_loc_7.zpp_inner_i.wrap_cbTypes == null)
                {
                    _loc_7.zpp_inner_i.setupcbTypes();
                }
                _loc_13 = _loc_7.zpp_inner_i.wrap_cbTypes;
                if (_loc_13.zpp_inner.reverse_flag)
                {
                    _loc_13.push(param1);
                }
                else
                {
                    _loc_13.unshift(param1);
                }
                _loc_14 = space.zpp_inner.wrap_bodies;
                if (_loc_14.zpp_inner.reverse_flag)
                {
                    _loc_14.push(_loc_7);
                }
                else
                {
                    _loc_14.unshift(_loc_7);
                }
                anonymousBodySet.push(_loc_7);
            }
            return;
        }// end function

        public function destroy() : void
        {
            var _loc_3:* = null as Body;
            space.zpp_inner.wrap_bodies.remove(floorBody);
            var _loc_1:* = 0;
            var _loc_2:* = anonymousBodySet;
            while (_loc_1 < _loc_2.length)
            {
                
                _loc_3 = _loc_2[_loc_1];
                _loc_1++;
                space.zpp_inner.wrap_bodies.remove(_loc_3);
            }
            return;
        }// end function

    }
}
