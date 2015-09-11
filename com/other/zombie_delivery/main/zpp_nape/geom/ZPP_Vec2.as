package zpp_nape.geom
{
    import flash.*;
    import nape.geom.*;

    public class ZPP_Vec2 extends Object
    {
        public var y:Number;
        public var x:Number;
        public var weak:Boolean;
        public var pushmod:Boolean;
        public var outer:Vec2;
        public var next:ZPP_Vec2;
        public var modified:Boolean;
        public var length:int;
        public var _validate:Object;
        public var _isimmutable:Object;
        public var _invalidate:Object;
        public var _inuse:Boolean;
        public var _immutable:Boolean;
        public static var zpp_pool:ZPP_Vec2;

        public function ZPP_Vec2() : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            y = 0;
            x = 0;
            length = 0;
            pushmod = false;
            modified = false;
            _inuse = false;
            next = null;
            weak = false;
            outer = null;
            _isimmutable = null;
            _immutable = false;
            _validate = null;
            _invalidate = null;
            return;
        }// end function

        public function wrapper() : Vec2
        {
            var _loc_1:* = null as ZPP_Vec2;
            if (outer == null)
            {
                outer = new Vec2();
                _loc_1 = outer.zpp_inner;
                if (_loc_1.outer != null)
                {
                    _loc_1.outer.zpp_inner = null;
                    _loc_1.outer = null;
                }
                _loc_1._isimmutable = null;
                _loc_1._validate = null;
                _loc_1._invalidate = null;
                _loc_1.next = ZPP_Vec2.zpp_pool;
                ZPP_Vec2.zpp_pool = _loc_1;
                outer.zpp_inner = this;
            }
            return outer;
        }// end function

        public function validate() : void
        {
            if (_validate != null)
            {
                _validate();
            }
            return;
        }// end function

        public function try_remove(param1:ZPP_Vec2) : Boolean
        {
            var _loc_2:* = null;
            var _loc_3:* = next;
            var _loc_4:* = false;
            while (_loc_3 != null)
            {
                
                if (_loc_3 == param1)
                {
                    erase(_loc_2);
                    _loc_4 = true;
                    break;
                }
                _loc_2 = _loc_3;
                _loc_3 = _loc_3.next;
            }
            return _loc_4;
        }// end function

        public function toString() : String
        {
            return "{ x: " + x + " y: " + y + " }";
        }// end function

        public function splice(param1:ZPP_Vec2, param2:int) : ZPP_Vec2
        {
            do
            {
                
                erase(param1);
                param2--;
                if (param2 > 0)
                {
                }
            }while (param1.next != null)
            return param1.next;
        }// end function

        public function size() : int
        {
            return length;
        }// end function

        public function setbegin(param1:ZPP_Vec2) : void
        {
            next = param1;
            modified = true;
            pushmod = true;
            return;
        }// end function

        public function reverse() : void
        {
            var _loc_3:* = null as ZPP_Vec2;
            var _loc_1:* = next;
            var _loc_2:* = null;
            while (_loc_1 != null)
            {
                
                _loc_3 = _loc_1.next;
                _loc_1.next = _loc_2;
                next = _loc_1;
                _loc_2 = _loc_1;
                _loc_1 = _loc_3;
            }
            modified = true;
            pushmod = true;
            return;
        }// end function

        public function remove(param1:ZPP_Vec2) : void
        {
            var _loc_5:* = null as ZPP_Vec2;
            var _loc_6:* = null as ZPP_Vec2;
            var _loc_2:* = null;
            var _loc_3:* = next;
            var _loc_4:* = false;
            while (_loc_3 != null)
            {
                
                if (_loc_3 == param1)
                {
                    if (_loc_2 == null)
                    {
                        _loc_5 = next;
                        _loc_6 = _loc_5.next;
                        next = _loc_6;
                        if (next == null)
                        {
                            pushmod = true;
                        }
                    }
                    else
                    {
                        _loc_5 = _loc_2.next;
                        _loc_6 = _loc_5.next;
                        _loc_2.next = _loc_6;
                        if (_loc_6 == null)
                        {
                            pushmod = true;
                        }
                    }
                    _loc_5._inuse = false;
                    modified = true;
                    (length - 1);
                    pushmod = true;
                    _loc_4 = true;
                    break;
                }
                _loc_2 = _loc_3;
                _loc_3 = _loc_3.next;
            }
            return;
        }// end function

        public function pop_unsafe() : ZPP_Vec2
        {
            var _loc_1:* = next;
            pop();
            return _loc_1;
        }// end function

        public function pop() : void
        {
            var _loc_1:* = next;
            next = _loc_1.next;
            _loc_1._inuse = false;
            if (next == null)
            {
                pushmod = true;
            }
            modified = true;
            (length - 1);
            return;
        }// end function

        public function iterator_at(param1:int) : ZPP_Vec2
        {
            var _loc_2:* = next;
            do
            {
                
                _loc_2 = _loc_2.next;
                param1--;
                if (param1 > 0)
                {
                }
            }while (_loc_2 != null)
            return _loc_2;
        }// end function

        public function invalidate() : void
        {
            if (_invalidate != null)
            {
                _invalidate(this);
            }
            return;
        }// end function

        public function insert(param1:ZPP_Vec2, param2:ZPP_Vec2) : ZPP_Vec2
        {
            param2._inuse = true;
            var _loc_3:* = param2;
            if (param1 == null)
            {
                _loc_3.next = next;
                next = _loc_3;
            }
            else
            {
                _loc_3.next = param1.next;
                param1.next = _loc_3;
            }
            var _loc_4:* = true;
            modified = true;
            pushmod = _loc_4;
            (length + 1);
            return _loc_3;
        }// end function

        public function inlined_try_remove(param1:ZPP_Vec2) : Boolean
        {
            var _loc_5:* = null as ZPP_Vec2;
            var _loc_6:* = null as ZPP_Vec2;
            var _loc_2:* = null;
            var _loc_3:* = next;
            var _loc_4:* = false;
            while (_loc_3 != null)
            {
                
                if (_loc_3 == param1)
                {
                    if (_loc_2 == null)
                    {
                        _loc_5 = next;
                        _loc_6 = _loc_5.next;
                        next = _loc_6;
                        if (next == null)
                        {
                            pushmod = true;
                        }
                    }
                    else
                    {
                        _loc_5 = _loc_2.next;
                        _loc_6 = _loc_5.next;
                        _loc_2.next = _loc_6;
                        if (_loc_6 == null)
                        {
                            pushmod = true;
                        }
                    }
                    _loc_5._inuse = false;
                    modified = true;
                    (length - 1);
                    pushmod = true;
                    _loc_4 = true;
                    break;
                }
                _loc_2 = _loc_3;
                _loc_3 = _loc_3.next;
            }
            return _loc_4;
        }// end function

        public function inlined_remove(param1:ZPP_Vec2) : void
        {
            var _loc_5:* = null as ZPP_Vec2;
            var _loc_6:* = null as ZPP_Vec2;
            var _loc_2:* = null;
            var _loc_3:* = next;
            var _loc_4:* = false;
            while (_loc_3 != null)
            {
                
                if (_loc_3 == param1)
                {
                    if (_loc_2 == null)
                    {
                        _loc_5 = next;
                        _loc_6 = _loc_5.next;
                        next = _loc_6;
                        if (next == null)
                        {
                            pushmod = true;
                        }
                    }
                    else
                    {
                        _loc_5 = _loc_2.next;
                        _loc_6 = _loc_5.next;
                        _loc_2.next = _loc_6;
                        if (_loc_6 == null)
                        {
                            pushmod = true;
                        }
                    }
                    _loc_5._inuse = false;
                    modified = true;
                    (length - 1);
                    pushmod = true;
                    _loc_4 = true;
                    break;
                }
                _loc_2 = _loc_3;
                _loc_3 = _loc_3.next;
            }
            return;
        }// end function

        public function inlined_pop_unsafe() : ZPP_Vec2
        {
            var _loc_1:* = next;
            pop();
            return _loc_1;
        }// end function

        public function inlined_pop() : void
        {
            var _loc_1:* = next;
            next = _loc_1.next;
            _loc_1._inuse = false;
            if (next == null)
            {
                pushmod = true;
            }
            modified = true;
            (length - 1);
            return;
        }// end function

        public function inlined_insert(param1:ZPP_Vec2, param2:ZPP_Vec2) : ZPP_Vec2
        {
            param2._inuse = true;
            var _loc_3:* = param2;
            if (param1 == null)
            {
                _loc_3.next = next;
                next = _loc_3;
            }
            else
            {
                _loc_3.next = param1.next;
                param1.next = _loc_3;
            }
            var _loc_4:* = true;
            modified = true;
            pushmod = _loc_4;
            (length + 1);
            return _loc_3;
        }// end function

        public function inlined_has(param1:ZPP_Vec2) : Boolean
        {
            var _loc_4:* = null as ZPP_Vec2;
            var _loc_2:* = false;
            var _loc_3:* = next;
            while (_loc_3 != null)
            {
                
                _loc_4 = _loc_3;
                if (_loc_4 == param1)
                {
                    _loc_2 = true;
                    break;
                }
                _loc_3 = _loc_3.next;
            }
            return _loc_2;
        }// end function

        public function inlined_erase(param1:ZPP_Vec2) : ZPP_Vec2
        {
            var _loc_2:* = null as ZPP_Vec2;
            var _loc_3:* = null as ZPP_Vec2;
            if (param1 == null)
            {
                _loc_2 = next;
                _loc_3 = _loc_2.next;
                next = _loc_3;
                if (next == null)
                {
                    pushmod = true;
                }
            }
            else
            {
                _loc_2 = param1.next;
                _loc_3 = _loc_2.next;
                param1.next = _loc_3;
                if (_loc_3 == null)
                {
                    pushmod = true;
                }
            }
            _loc_2._inuse = false;
            modified = true;
            (length - 1);
            pushmod = true;
            return _loc_3;
        }// end function

        public function inlined_clear() : void
        {
            return;
        }// end function

        public function inlined_add(param1:ZPP_Vec2) : ZPP_Vec2
        {
            param1._inuse = true;
            var _loc_2:* = param1;
            _loc_2.next = next;
            next = _loc_2;
            modified = true;
            (length + 1);
            return param1;
        }// end function

        public function immutable() : void
        {
            if (_immutable)
            {
                throw "Error: Vec2 is immutable";
            }
            if (_isimmutable != null)
            {
                _isimmutable();
            }
            return;
        }// end function

        public function has(param1:ZPP_Vec2) : Boolean
        {
            var _loc_4:* = null as ZPP_Vec2;
            var _loc_2:* = false;
            var _loc_3:* = next;
            while (_loc_3 != null)
            {
                
                _loc_4 = _loc_3;
                if (_loc_4 == param1)
                {
                    _loc_2 = true;
                    break;
                }
                _loc_3 = _loc_3.next;
            }
            return _loc_2;
        }// end function

        public function front() : ZPP_Vec2
        {
            return next;
        }// end function

        public function free() : void
        {
            if (outer != null)
            {
                outer.zpp_inner = null;
                outer = null;
            }
            _isimmutable = null;
            _validate = null;
            _invalidate = null;
            return;
        }// end function

        public function erase(param1:ZPP_Vec2) : ZPP_Vec2
        {
            var _loc_2:* = null as ZPP_Vec2;
            var _loc_3:* = null as ZPP_Vec2;
            if (param1 == null)
            {
                _loc_2 = next;
                _loc_3 = _loc_2.next;
                next = _loc_3;
                if (next == null)
                {
                    pushmod = true;
                }
            }
            else
            {
                _loc_2 = param1.next;
                _loc_3 = _loc_2.next;
                param1.next = _loc_3;
                if (_loc_3 == null)
                {
                    pushmod = true;
                }
            }
            _loc_2._inuse = false;
            modified = true;
            (length - 1);
            pushmod = true;
            return _loc_3;
        }// end function

        public function empty() : Boolean
        {
            return next == null;
        }// end function

        public function elem() : ZPP_Vec2
        {
            return this;
        }// end function

        public function copy() : ZPP_Vec2
        {
            var _loc_2:* = null as ZPP_Vec2;
            var _loc_1:* = false;
            if (ZPP_Vec2.zpp_pool == null)
            {
                _loc_2 = new ZPP_Vec2();
            }
            else
            {
                _loc_2 = ZPP_Vec2.zpp_pool;
                ZPP_Vec2.zpp_pool = _loc_2.next;
                _loc_2.next = null;
            }
            _loc_2.weak = false;
            _loc_2._immutable = _loc_1;
            _loc_2.x = x;
            _loc_2.y = y;
            return _loc_2;
        }// end function

        public function clear() : void
        {
            return;
        }// end function

        public function begin() : ZPP_Vec2
        {
            return next;
        }// end function

        public function back() : ZPP_Vec2
        {
            var _loc_1:* = next;
            var _loc_2:* = _loc_1;
            while (_loc_2 != null)
            {
                
                _loc_1 = _loc_2;
                _loc_2 = _loc_2.next;
            }
            return _loc_1;
        }// end function

        public function at(param1:int) : ZPP_Vec2
        {
            var _loc_2:* = iterator_at(param1);
            if (_loc_2 != null)
            {
                return _loc_2;
            }
            else
            {
                return null;
            }
        }// end function

        public function alloc() : void
        {
            weak = false;
            return;
        }// end function

        public function addAll(param1:ZPP_Vec2) : void
        {
            var _loc_3:* = null as ZPP_Vec2;
            var _loc_2:* = param1.next;
            while (_loc_2 != null)
            {
                
                _loc_3 = _loc_2;
                add(_loc_3);
                _loc_2 = _loc_2.next;
            }
            return;
        }// end function

        public function add(param1:ZPP_Vec2) : ZPP_Vec2
        {
            param1._inuse = true;
            var _loc_2:* = param1;
            _loc_2.next = next;
            next = _loc_2;
            modified = true;
            (length + 1);
            return param1;
        }// end function

        public static function get(param1:Number, param2:Number, param3:Boolean = false) : ZPP_Vec2
        {
            var _loc_4:* = null as ZPP_Vec2;
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
            _loc_4._immutable = param3;
            _loc_4.x = param1;
            _loc_4.y = param2;
            return _loc_4;
        }// end function

    }
}
