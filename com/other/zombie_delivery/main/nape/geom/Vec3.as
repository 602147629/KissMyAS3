package nape.geom
{
    import flash.*;
    import zpp_nape.geom.*;
    import zpp_nape.util.*;

    final public class Vec3 extends Object
    {
        public var zpp_pool:Vec3;
        public var zpp_inner:ZPP_Vec3;
        public var zpp_disp:Boolean;

        public function Vec3(param1:Number = 0, param2:Number = 0, param3:Number = 0) : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            zpp_pool = null;
            zpp_inner = null;
            zpp_inner = new ZPP_Vec3();
            zpp_inner.outer = this;
            if (zpp_disp)
            {
                throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
            }
            if (zpp_inner.immutable)
            {
                throw "Error: Vec3 is immutable";
            }
            zpp_inner.x = param1;
            if (zpp_disp)
            {
                throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
            }
            var _loc_4:* = zpp_inner;
            if (_loc_4._validate != null)
            {
                _loc_4._validate();
            }
            if (zpp_disp)
            {
                throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
            }
            if (zpp_inner.immutable)
            {
                throw "Error: Vec3 is immutable";
            }
            zpp_inner.y = param2;
            if (zpp_disp)
            {
                throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
            }
            _loc_4 = zpp_inner;
            if (_loc_4._validate != null)
            {
                _loc_4._validate();
            }
            if (zpp_disp)
            {
                throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
            }
            if (zpp_inner.immutable)
            {
                throw "Error: Vec3 is immutable";
            }
            zpp_inner.z = param3;
            if (zpp_disp)
            {
                throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
            }
            _loc_4 = zpp_inner;
            if (_loc_4._validate != null)
            {
                _loc_4._validate();
            }
            return;
        }// end function

        public function xy(param1:Boolean = false) : Vec2
        {
            var _loc_5:* = null as Vec2;
            var _loc_6:* = false;
            var _loc_7:* = null as ZPP_Vec2;
            if (zpp_disp)
            {
                throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
            }
            if (zpp_disp)
            {
                throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
            }
            var _loc_3:* = zpp_inner;
            if (_loc_3._validate != null)
            {
                _loc_3._validate();
            }
            var _loc_2:* = zpp_inner.x;
            if (zpp_disp)
            {
                throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
            }
            _loc_3 = zpp_inner;
            if (_loc_3._validate != null)
            {
                _loc_3._validate();
            }
            var _loc_4:* = zpp_inner.y;
            if (_loc_2 == _loc_2)
            {
            }
            if (_loc_4 != _loc_4)
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
                _loc_7.y = _loc_4;
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
                if (_loc_4 != _loc_4)
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
                if (_loc_5.zpp_inner.y != _loc_4)
                {
                    _loc_5.zpp_inner.x = _loc_2;
                    _loc_5.zpp_inner.y = _loc_4;
                    _loc_7 = _loc_5.zpp_inner;
                    if (_loc_7._invalidate != null)
                    {
                        _loc_7._invalidate(_loc_7);
                    }
                }
            }
            _loc_5.zpp_inner.weak = param1;
            return _loc_5;
        }// end function

        public function toString() : String
        {
            if (zpp_disp)
            {
                throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
            }
            if (zpp_disp)
            {
                throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
            }
            var _loc_1:* = zpp_inner;
            if (_loc_1._validate != null)
            {
                _loc_1._validate();
            }
            if (zpp_disp)
            {
                throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
            }
            _loc_1 = zpp_inner;
            if (_loc_1._validate != null)
            {
                _loc_1._validate();
            }
            if (zpp_disp)
            {
                throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
            }
            _loc_1 = zpp_inner;
            if (_loc_1._validate != null)
            {
                _loc_1._validate();
            }
            return "{ x: " + zpp_inner.x + " y: " + zpp_inner.y + " z: " + zpp_inner.z + " }";
        }// end function

        public function setxyz(param1:Number, param2:Number, param3:Number) : Vec3
        {
            if (zpp_disp)
            {
                throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
            }
            if (zpp_disp)
            {
                throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
            }
            if (zpp_inner.immutable)
            {
                throw "Error: Vec3 is immutable";
            }
            zpp_inner.x = param1;
            if (zpp_disp)
            {
                throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
            }
            var _loc_4:* = zpp_inner;
            if (_loc_4._validate != null)
            {
                _loc_4._validate();
            }
            if (zpp_disp)
            {
                throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
            }
            if (zpp_inner.immutable)
            {
                throw "Error: Vec3 is immutable";
            }
            zpp_inner.y = param2;
            if (zpp_disp)
            {
                throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
            }
            _loc_4 = zpp_inner;
            if (_loc_4._validate != null)
            {
                _loc_4._validate();
            }
            if (zpp_disp)
            {
                throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
            }
            if (zpp_inner.immutable)
            {
                throw "Error: Vec3 is immutable";
            }
            zpp_inner.z = param3;
            if (zpp_disp)
            {
                throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
            }
            _loc_4 = zpp_inner;
            if (_loc_4._validate != null)
            {
                _loc_4._validate();
            }
            return this;
        }// end function

        public function set_z(param1:Number) : Number
        {
            if (zpp_disp)
            {
                throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
            }
            if (zpp_inner.immutable)
            {
                throw "Error: Vec3 is immutable";
            }
            zpp_inner.z = param1;
            if (zpp_disp)
            {
                throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
            }
            var _loc_2:* = zpp_inner;
            if (_loc_2._validate != null)
            {
                _loc_2._validate();
            }
            return zpp_inner.z;
        }// end function

        public function set_y(param1:Number) : Number
        {
            if (zpp_disp)
            {
                throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
            }
            if (zpp_inner.immutable)
            {
                throw "Error: Vec3 is immutable";
            }
            zpp_inner.y = param1;
            if (zpp_disp)
            {
                throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
            }
            var _loc_2:* = zpp_inner;
            if (_loc_2._validate != null)
            {
                _loc_2._validate();
            }
            return zpp_inner.y;
        }// end function

        public function set_x(param1:Number) : Number
        {
            if (zpp_disp)
            {
                throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
            }
            if (zpp_inner.immutable)
            {
                throw "Error: Vec3 is immutable";
            }
            zpp_inner.x = param1;
            if (zpp_disp)
            {
                throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
            }
            var _loc_2:* = zpp_inner;
            if (_loc_2._validate != null)
            {
                _loc_2._validate();
            }
            return zpp_inner.x;
        }// end function

        public function set_length(param1:Number) : Number
        {
            if (zpp_disp)
            {
                throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
            }
            if (param1 != param1)
            {
                throw "Error: Vec3::length cannot be NaN";
            }
            if (zpp_disp)
            {
                throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
            }
            var _loc_2:* = zpp_inner;
            if (_loc_2._validate != null)
            {
                _loc_2._validate();
            }
            if (zpp_disp)
            {
                throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
            }
            _loc_2 = zpp_inner;
            if (_loc_2._validate != null)
            {
                _loc_2._validate();
            }
            if (zpp_disp)
            {
                throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
            }
            _loc_2 = zpp_inner;
            if (_loc_2._validate != null)
            {
                _loc_2._validate();
            }
            if (zpp_disp)
            {
                throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
            }
            _loc_2 = zpp_inner;
            if (_loc_2._validate != null)
            {
                _loc_2._validate();
            }
            if (zpp_disp)
            {
                throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
            }
            _loc_2 = zpp_inner;
            if (_loc_2._validate != null)
            {
                _loc_2._validate();
            }
            if (zpp_disp)
            {
                throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
            }
            _loc_2 = zpp_inner;
            if (_loc_2._validate != null)
            {
                _loc_2._validate();
            }
            if (zpp_inner.x * zpp_inner.x + zpp_inner.y * zpp_inner.y + zpp_inner.z * zpp_inner.z == 0)
            {
                throw "Error: Cannot set length of a zero vector";
            }
            if (zpp_disp)
            {
                throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
            }
            if (zpp_disp)
            {
                throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
            }
            _loc_2 = zpp_inner;
            if (_loc_2._validate != null)
            {
                _loc_2._validate();
            }
            if (zpp_disp)
            {
                throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
            }
            _loc_2 = zpp_inner;
            if (_loc_2._validate != null)
            {
                _loc_2._validate();
            }
            if (zpp_disp)
            {
                throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
            }
            _loc_2 = zpp_inner;
            if (_loc_2._validate != null)
            {
                _loc_2._validate();
            }
            if (zpp_disp)
            {
                throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
            }
            _loc_2 = zpp_inner;
            if (_loc_2._validate != null)
            {
                _loc_2._validate();
            }
            if (zpp_disp)
            {
                throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
            }
            _loc_2 = zpp_inner;
            if (_loc_2._validate != null)
            {
                _loc_2._validate();
            }
            if (zpp_disp)
            {
                throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
            }
            _loc_2 = zpp_inner;
            if (_loc_2._validate != null)
            {
                _loc_2._validate();
            }
            var _loc_3:* = param1 / Math.sqrt(zpp_inner.x * zpp_inner.x + zpp_inner.y * zpp_inner.y + zpp_inner.z * zpp_inner.z);
            var _loc_4:* = _loc_3;
            var _loc_5:* = this;
            if (_loc_5 != null)
            {
            }
            if (_loc_5.zpp_disp)
            {
                throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
            }
            _loc_2 = _loc_5.zpp_inner;
            if (_loc_2._validate != null)
            {
                _loc_2._validate();
            }
            var _loc_6:* = _loc_5.zpp_inner.x * _loc_4;
            if (_loc_5 != null)
            {
            }
            if (_loc_5.zpp_disp)
            {
                throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
            }
            if (_loc_5.zpp_inner.immutable)
            {
                throw "Error: Vec3 is immutable";
            }
            _loc_5.zpp_inner.x = _loc_6;
            if (_loc_5 != null)
            {
            }
            if (_loc_5.zpp_disp)
            {
                throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
            }
            _loc_2 = _loc_5.zpp_inner;
            if (_loc_2._validate != null)
            {
                _loc_2._validate();
            }
            _loc_5 = this;
            if (_loc_5 != null)
            {
            }
            if (_loc_5.zpp_disp)
            {
                throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
            }
            _loc_2 = _loc_5.zpp_inner;
            if (_loc_2._validate != null)
            {
                _loc_2._validate();
            }
            _loc_6 = _loc_5.zpp_inner.y * _loc_4;
            if (_loc_5 != null)
            {
            }
            if (_loc_5.zpp_disp)
            {
                throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
            }
            if (_loc_5.zpp_inner.immutable)
            {
                throw "Error: Vec3 is immutable";
            }
            _loc_5.zpp_inner.y = _loc_6;
            if (_loc_5 != null)
            {
            }
            if (_loc_5.zpp_disp)
            {
                throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
            }
            _loc_2 = _loc_5.zpp_inner;
            if (_loc_2._validate != null)
            {
                _loc_2._validate();
            }
            _loc_5 = this;
            if (_loc_5 != null)
            {
            }
            if (_loc_5.zpp_disp)
            {
                throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
            }
            _loc_2 = _loc_5.zpp_inner;
            if (_loc_2._validate != null)
            {
                _loc_2._validate();
            }
            _loc_4 = _loc_5.zpp_inner.z * _loc_3;
            if (_loc_5 != null)
            {
            }
            if (_loc_5.zpp_disp)
            {
                throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
            }
            if (_loc_5.zpp_inner.immutable)
            {
                throw "Error: Vec3 is immutable";
            }
            _loc_5.zpp_inner.z = _loc_4;
            if (_loc_5 != null)
            {
            }
            if (_loc_5.zpp_disp)
            {
                throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
            }
            _loc_2 = _loc_5.zpp_inner;
            if (_loc_2._validate != null)
            {
                _loc_2._validate();
            }
            if (zpp_disp)
            {
                throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
            }
            if (zpp_disp)
            {
                throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
            }
            _loc_2 = zpp_inner;
            if (_loc_2._validate != null)
            {
                _loc_2._validate();
            }
            if (zpp_disp)
            {
                throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
            }
            _loc_2 = zpp_inner;
            if (_loc_2._validate != null)
            {
                _loc_2._validate();
            }
            if (zpp_disp)
            {
                throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
            }
            _loc_2 = zpp_inner;
            if (_loc_2._validate != null)
            {
                _loc_2._validate();
            }
            if (zpp_disp)
            {
                throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
            }
            _loc_2 = zpp_inner;
            if (_loc_2._validate != null)
            {
                _loc_2._validate();
            }
            if (zpp_disp)
            {
                throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
            }
            _loc_2 = zpp_inner;
            if (_loc_2._validate != null)
            {
                _loc_2._validate();
            }
            if (zpp_disp)
            {
                throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
            }
            _loc_2 = zpp_inner;
            if (_loc_2._validate != null)
            {
                _loc_2._validate();
            }
            return Math.sqrt(zpp_inner.x * zpp_inner.x + zpp_inner.y * zpp_inner.y + zpp_inner.z * zpp_inner.z);
        }// end function

        public function set(param1:Vec3) : Vec3
        {
            if (zpp_disp)
            {
                throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
            }
            if (param1 != null)
            {
            }
            if (param1.zpp_disp)
            {
                throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
            }
            if (param1 == null)
            {
                throw "Error: Cannot assign null Vec3";
            }
            if (param1 != null)
            {
            }
            if (param1.zpp_disp)
            {
                throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
            }
            var _loc_2:* = param1.zpp_inner;
            if (_loc_2._validate != null)
            {
                _loc_2._validate();
            }
            if (param1 != null)
            {
            }
            if (param1.zpp_disp)
            {
                throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
            }
            _loc_2 = param1.zpp_inner;
            if (_loc_2._validate != null)
            {
                _loc_2._validate();
            }
            if (param1 != null)
            {
            }
            if (param1.zpp_disp)
            {
                throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
            }
            _loc_2 = param1.zpp_inner;
            if (_loc_2._validate != null)
            {
                _loc_2._validate();
            }
            return setxyz(param1.zpp_inner.x, param1.zpp_inner.y, param1.zpp_inner.z);
        }// end function

        public function lsq() : Number
        {
            if (zpp_disp)
            {
                throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
            }
            if (zpp_disp)
            {
                throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
            }
            var _loc_1:* = zpp_inner;
            if (_loc_1._validate != null)
            {
                _loc_1._validate();
            }
            if (zpp_disp)
            {
                throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
            }
            _loc_1 = zpp_inner;
            if (_loc_1._validate != null)
            {
                _loc_1._validate();
            }
            if (zpp_disp)
            {
                throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
            }
            _loc_1 = zpp_inner;
            if (_loc_1._validate != null)
            {
                _loc_1._validate();
            }
            if (zpp_disp)
            {
                throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
            }
            _loc_1 = zpp_inner;
            if (_loc_1._validate != null)
            {
                _loc_1._validate();
            }
            if (zpp_disp)
            {
                throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
            }
            _loc_1 = zpp_inner;
            if (_loc_1._validate != null)
            {
                _loc_1._validate();
            }
            if (zpp_disp)
            {
                throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
            }
            _loc_1 = zpp_inner;
            if (_loc_1._validate != null)
            {
                _loc_1._validate();
            }
            return zpp_inner.x * zpp_inner.x + zpp_inner.y * zpp_inner.y + zpp_inner.z * zpp_inner.z;
        }// end function

        public function get_z() : Number
        {
            if (zpp_disp)
            {
                throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
            }
            var _loc_1:* = zpp_inner;
            if (_loc_1._validate != null)
            {
                _loc_1._validate();
            }
            return zpp_inner.z;
        }// end function

        public function get_y() : Number
        {
            if (zpp_disp)
            {
                throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
            }
            var _loc_1:* = zpp_inner;
            if (_loc_1._validate != null)
            {
                _loc_1._validate();
            }
            return zpp_inner.y;
        }// end function

        public function get_x() : Number
        {
            if (zpp_disp)
            {
                throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
            }
            var _loc_1:* = zpp_inner;
            if (_loc_1._validate != null)
            {
                _loc_1._validate();
            }
            return zpp_inner.x;
        }// end function

        public function get_length() : Number
        {
            if (zpp_disp)
            {
                throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
            }
            if (zpp_disp)
            {
                throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
            }
            var _loc_1:* = zpp_inner;
            if (_loc_1._validate != null)
            {
                _loc_1._validate();
            }
            if (zpp_disp)
            {
                throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
            }
            _loc_1 = zpp_inner;
            if (_loc_1._validate != null)
            {
                _loc_1._validate();
            }
            if (zpp_disp)
            {
                throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
            }
            _loc_1 = zpp_inner;
            if (_loc_1._validate != null)
            {
                _loc_1._validate();
            }
            if (zpp_disp)
            {
                throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
            }
            _loc_1 = zpp_inner;
            if (_loc_1._validate != null)
            {
                _loc_1._validate();
            }
            if (zpp_disp)
            {
                throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
            }
            _loc_1 = zpp_inner;
            if (_loc_1._validate != null)
            {
                _loc_1._validate();
            }
            if (zpp_disp)
            {
                throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
            }
            _loc_1 = zpp_inner;
            if (_loc_1._validate != null)
            {
                _loc_1._validate();
            }
            return Math.sqrt(zpp_inner.x * zpp_inner.x + zpp_inner.y * zpp_inner.y + zpp_inner.z * zpp_inner.z);
        }// end function

        public function dispose() : void
        {
            if (zpp_disp)
            {
                throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
            }
            if (zpp_inner.immutable)
            {
                throw "Error: This Vec3 is not disposable";
            }
            var _loc_1:* = this;
            _loc_1.zpp_pool = null;
            if (ZPP_PubPool.nextVec3 != null)
            {
                ZPP_PubPool.nextVec3.zpp_pool = _loc_1;
            }
            else
            {
                ZPP_PubPool.poolVec3 = _loc_1;
            }
            ZPP_PubPool.nextVec3 = _loc_1;
            _loc_1.zpp_disp = true;
            return;
        }// end function

        public static function get(param1:Number = 0, param2:Number = 0, param3:Number = 0) : Vec3
        {
            var _loc_4:* = null as Vec3;
            if (ZPP_PubPool.poolVec3 == null)
            {
                _loc_4 = new Vec3();
            }
            else
            {
                _loc_4 = ZPP_PubPool.poolVec3;
                ZPP_PubPool.poolVec3 = _loc_4.zpp_pool;
                _loc_4.zpp_pool = null;
                _loc_4.zpp_disp = false;
                if (_loc_4 == ZPP_PubPool.nextVec3)
                {
                    ZPP_PubPool.nextVec3 = null;
                }
            }
            _loc_4.setxyz(param1, param2, param3);
            _loc_4.zpp_inner.immutable = false;
            _loc_4.zpp_inner._validate = null;
            return _loc_4;
        }// end function

    }
}
