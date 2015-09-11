package nape.geom
{
    import flash.*;
    import zpp_nape.geom.*;
    import zpp_nape.util.*;

    final public class Ray extends Object
    {
        public var zpp_inner:ZPP_Ray;

        public function Ray(param1:Vec2 = undefined, param2:Vec2 = undefined) : void
        {
            var _loc_4:* = null as ZPP_Vec2;
            var _loc_8:* = null as Vec2;
            var _loc_9:* = null as ZPP_Vec2;
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
            if (param2 != null)
            {
            }
            if (param2.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            zpp_inner = new ZPP_Ray();
            if (param1 != null)
            {
            }
            if (param1.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            if (param1 == null)
            {
                throw "Error: Ray::origin cannot be null";
            }
            var _loc_3:* = zpp_inner.origin;
            if (_loc_3 != null)
            {
            }
            if (_loc_3.zpp_disp)
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
            _loc_4 = _loc_3.zpp_inner;
            if (_loc_4._immutable)
            {
                throw "Error: Vec2 is immutable";
            }
            if (_loc_4._isimmutable != null)
            {
                _loc_4._isimmutable();
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
            _loc_4 = param1.zpp_inner;
            if (_loc_4._validate != null)
            {
                _loc_4._validate();
            }
            var _loc_6:* = param1.zpp_inner.x;
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
            var _loc_7:* = param1.zpp_inner.y;
            if (_loc_3 != null)
            {
            }
            if (_loc_3.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_4 = _loc_3.zpp_inner;
            if (_loc_4._immutable)
            {
                throw "Error: Vec2 is immutable";
            }
            if (_loc_4._isimmutable != null)
            {
                _loc_4._isimmutable();
            }
            if (_loc_6 == _loc_6)
            {
            }
            if (_loc_7 != _loc_7)
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
            _loc_4 = _loc_3.zpp_inner;
            if (_loc_4._validate != null)
            {
                _loc_4._validate();
            }
            if (_loc_3.zpp_inner.x == _loc_6)
            {
                if (_loc_3 != null)
                {
                }
                if (_loc_3.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_4 = _loc_3.zpp_inner;
                if (_loc_4._validate != null)
                {
                    _loc_4._validate();
                }
            }
            if (_loc_3.zpp_inner.y != _loc_7)
            {
                _loc_3.zpp_inner.x = _loc_6;
                _loc_3.zpp_inner.y = _loc_7;
                _loc_4 = _loc_3.zpp_inner;
                if (_loc_4._invalidate != null)
                {
                    _loc_4._invalidate(_loc_4);
                }
            }
            var _loc_5:* = _loc_3;
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
                _loc_9 = _loc_4;
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
            if (param2 != null)
            {
            }
            if (param2.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            if (param2 == null)
            {
                throw "Error: Ray::direction cannot be null";
            }
            _loc_3 = zpp_inner.direction;
            if (_loc_3 != null)
            {
            }
            if (_loc_3.zpp_disp)
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
            _loc_4 = _loc_3.zpp_inner;
            if (_loc_4._immutable)
            {
                throw "Error: Vec2 is immutable";
            }
            if (_loc_4._isimmutable != null)
            {
                _loc_4._isimmutable();
            }
            if (param2 == null)
            {
                throw "Error: Cannot assign null Vec2";
            }
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
            _loc_6 = param2.zpp_inner.x;
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
            _loc_7 = param2.zpp_inner.y;
            if (_loc_3 != null)
            {
            }
            if (_loc_3.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_4 = _loc_3.zpp_inner;
            if (_loc_4._immutable)
            {
                throw "Error: Vec2 is immutable";
            }
            if (_loc_4._isimmutable != null)
            {
                _loc_4._isimmutable();
            }
            if (_loc_6 == _loc_6)
            {
            }
            if (_loc_7 != _loc_7)
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
            _loc_4 = _loc_3.zpp_inner;
            if (_loc_4._validate != null)
            {
                _loc_4._validate();
            }
            if (_loc_3.zpp_inner.x == _loc_6)
            {
                if (_loc_3 != null)
                {
                }
                if (_loc_3.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_4 = _loc_3.zpp_inner;
                if (_loc_4._validate != null)
                {
                    _loc_4._validate();
                }
            }
            if (_loc_3.zpp_inner.y != _loc_7)
            {
                _loc_3.zpp_inner.x = _loc_6;
                _loc_3.zpp_inner.y = _loc_7;
                _loc_4 = _loc_3.zpp_inner;
                if (_loc_4._invalidate != null)
                {
                    _loc_4._invalidate(_loc_4);
                }
            }
            _loc_5 = _loc_3;
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
                _loc_9 = _loc_4;
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
            zpp_inner.zip_dir = true;
            zpp_inner.maxdist = 17899999999999994000000000000;
            return;
        }// end function

        public function set_origin(param1:Vec2) : Vec2
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
                throw "Error: Ray::origin cannot be null";
            }
            var _loc_2:* = zpp_inner.origin;
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
            return zpp_inner.origin;
        }// end function

        public function set_maxDistance(param1:Number) : Number
        {
            if (param1 != param1)
            {
                throw "Error: maxDistance cannot be NaN";
            }
            zpp_inner.maxdist = param1;
            return zpp_inner.maxdist;
        }// end function

        public function set_direction(param1:Vec2) : Vec2
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
                throw "Error: Ray::direction cannot be null";
            }
            var _loc_2:* = zpp_inner.direction;
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
            zpp_inner.zip_dir = true;
            return zpp_inner.direction;
        }// end function

        public function get_userData()
        {
            if (zpp_inner.userData == null)
            {
                zpp_inner.userData = {};
            }
            return zpp_inner.userData;
        }// end function

        public function get_origin() : Vec2
        {
            return zpp_inner.origin;
        }// end function

        public function get_maxDistance() : Number
        {
            return zpp_inner.maxdist;
        }// end function

        public function get_direction() : Vec2
        {
            return zpp_inner.direction;
        }// end function

        public function copy() : Ray
        {
            var _loc_1:* = new Ray(zpp_inner.origin, zpp_inner.direction);
            var _loc_2:* = zpp_inner.maxdist;
            if (_loc_2 != _loc_2)
            {
                throw "Error: maxDistance cannot be NaN";
            }
            _loc_1.zpp_inner.maxdist = _loc_2;
            return _loc_1;
        }// end function

        public function at(param1:Number, param2:Boolean = false) : Vec2
        {
            var _loc_4:* = null as Vec2;
            var _loc_5:* = null as ZPP_Vec2;
            var _loc_7:* = false;
            zpp_inner.validate_dir();
            _loc_4 = zpp_inner.origin;
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
            var _loc_3:* = _loc_4.zpp_inner.x + param1 * zpp_inner.dirx;
            _loc_4 = zpp_inner.origin;
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
            var _loc_6:* = _loc_4.zpp_inner.y + param1 * zpp_inner.diry;
            if (_loc_3 == _loc_3)
            {
            }
            if (_loc_6 != _loc_6)
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
                _loc_5.x = _loc_3;
                _loc_5.y = _loc_6;
                _loc_4.zpp_inner = _loc_5;
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
                _loc_5 = _loc_4.zpp_inner;
                if (_loc_5._immutable)
                {
                    throw "Error: Vec2 is immutable";
                }
                if (_loc_5._isimmutable != null)
                {
                    _loc_5._isimmutable();
                }
                if (_loc_3 == _loc_3)
                {
                }
                if (_loc_6 != _loc_6)
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
                if (_loc_4.zpp_inner.x == _loc_3)
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
                if (_loc_4.zpp_inner.y != _loc_6)
                {
                    _loc_4.zpp_inner.x = _loc_3;
                    _loc_4.zpp_inner.y = _loc_6;
                    _loc_5 = _loc_4.zpp_inner;
                    if (_loc_5._invalidate != null)
                    {
                        _loc_5._invalidate(_loc_5);
                    }
                }
            }
            _loc_4.zpp_inner.weak = param2;
            return _loc_4;
        }// end function

        public function aabb() : AABB
        {
            return zpp_inner.rayAABB().wrapper();
        }// end function

        public static function fromSegment(param1:Vec2, param2:Vec2) : Ray
        {
            var _loc_7:* = null as ZPP_Vec2;
            var _loc_13:* = null as Vec2;
            var _loc_14:* = null as ZPP_Vec2;
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
            if (param1 == null)
            {
                throw "Error: Ray::fromSegment::start is null";
            }
            if (param2 == null)
            {
                throw "Error: Ray::fromSegment::end is null";
            }
            var _loc_3:* = param2.sub(param1, true);
            var _loc_4:* = new Ray(param1, _loc_3);
            if (param1 != null)
            {
            }
            if (param1.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_7 = param1.zpp_inner;
            if (_loc_7._validate != null)
            {
                _loc_7._validate();
            }
            var _loc_6:* = param1.zpp_inner.x;
            if (param1 != null)
            {
            }
            if (param1.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_7 = param1.zpp_inner;
            if (_loc_7._validate != null)
            {
                _loc_7._validate();
            }
            var _loc_8:* = param1.zpp_inner.y;
            if (param2 != null)
            {
            }
            if (param2.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_7 = param2.zpp_inner;
            if (_loc_7._validate != null)
            {
                _loc_7._validate();
            }
            var _loc_9:* = param2.zpp_inner.x;
            if (param2 != null)
            {
            }
            if (param2.zpp_disp)
            {
                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc_7 = param2.zpp_inner;
            if (_loc_7._validate != null)
            {
                _loc_7._validate();
            }
            var _loc_10:* = param2.zpp_inner.y;
            var _loc_11:* = 0;
            var _loc_12:* = 0;
            _loc_11 = _loc_6 - _loc_9;
            _loc_12 = _loc_8 - _loc_10;
            var _loc_5:* = Math.sqrt(_loc_11 * _loc_11 + _loc_12 * _loc_12);
            if (_loc_5 != _loc_5)
            {
                throw "Error: maxDistance cannot be NaN";
            }
            _loc_4.zpp_inner.maxdist = _loc_5;
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
                _loc_13 = param1;
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
                _loc_14 = _loc_7;
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
            if (param2.zpp_inner.weak)
            {
                if (param2 != null)
                {
                }
                if (param2.zpp_disp)
                {
                    throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                }
                _loc_7 = param2.zpp_inner;
                if (_loc_7._immutable)
                {
                    throw "Error: Vec2 is immutable";
                }
                if (_loc_7._isimmutable != null)
                {
                    _loc_7._isimmutable();
                }
                if (param2.zpp_inner._inuse)
                {
                    throw "Error: This Vec2 is not disposable";
                }
                _loc_7 = param2.zpp_inner;
                param2.zpp_inner.outer = null;
                param2.zpp_inner = null;
                _loc_13 = param2;
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
                _loc_14 = _loc_7;
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
            return _loc_4;
        }// end function

    }
}
