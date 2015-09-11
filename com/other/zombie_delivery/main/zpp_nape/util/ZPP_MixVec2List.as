package zpp_nape.util
{
    import flash.*;
    import nape.geom.*;
    import zpp_nape.geom.*;

    public class ZPP_MixVec2List extends Vec2List
    {
        public var zip_length:Boolean;
        public var inner:ZPP_Vec2;
        public var at_ite:ZPP_Vec2;
        public var at_index:int;
        public var _length:int;

        public function ZPP_MixVec2List() : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            at_index = 0;
            at_ite = null;
            zip_length = false;
            _length = 0;
            inner = null;
            at_ite = null;
            at_index = 0;
            zip_length = true;
            _length = 0;
            return;
        }// end function

        override public function zpp_vm() : void
        {
            zpp_inner.validate();
            if (inner.modified)
            {
                zip_length = true;
                _length = 0;
                at_ite = null;
            }
            return;
        }// end function

        override public function zpp_gl() : int
        {
            var _loc_1:* = null as ZPP_Vec2;
            var _loc_2:* = null as ZPP_Vec2;
            zpp_vm();
            if (zip_length)
            {
                _length = 0;
                _loc_1 = inner.next;
                while (_loc_1 != null)
                {
                    
                    _loc_2 = _loc_1;
                    (_length + 1);
                    _loc_1 = _loc_1.next;
                }
                zip_length = false;
            }
            return _length;
        }// end function

        override public function unshift(param1:Vec2) : Boolean
        {
            var _loc_2:* = false;
            var _loc_3:* = null as ZPP_Vec2;
            if (zpp_inner.immutable)
            {
                throw "Error: " + "Vec2" + "List is immutable";
            }
            zpp_inner.modify_test();
            zpp_vm();
            if (param1.zpp_inner._inuse)
            {
                throw "Error: " + "Vec2" + " is already in use";
            }
            if (zpp_inner.adder != null)
            {
                _loc_2 = zpp_inner.adder(param1);
            }
            else
            {
                _loc_2 = true;
            }
            if (_loc_2)
            {
                if (zpp_inner.reverse_flag)
                {
                    _loc_3 = inner.iterator_at((zpp_gl() - 1));
                    inner.insert(_loc_3, param1.zpp_inner);
                }
                else
                {
                    inner.add(param1.zpp_inner);
                }
                zpp_inner.invalidate();
                if (zpp_inner.post_adder != null)
                {
                    zpp_inner.post_adder(param1);
                }
            }
            return _loc_2;
        }// end function

        override public function shift() : Vec2
        {
            var _loc_2:* = null as ZPP_Vec2;
            var _loc_3:* = null as Vec2;
            var _loc_4:* = null as ZPP_Vec2;
            if (zpp_inner.immutable)
            {
                throw "Error: " + "Vec2" + "List is immutable";
            }
            zpp_inner.modify_test();
            if (empty())
            {
                throw "Error: Cannot remove from empty list";
            }
            zpp_vm();
            var _loc_1:* = null;
            if (zpp_inner.reverse_flag)
            {
                if (at_ite != null)
                {
                }
                if (at_ite.next == null)
                {
                    at_ite = null;
                }
                if (zpp_gl() == 1)
                {
                    _loc_2 = null;
                }
                else
                {
                    _loc_2 = inner.iterator_at(zpp_gl() - 2);
                }
                if (_loc_2 == null)
                {
                    _loc_1 = inner.next;
                }
                else
                {
                    _loc_1 = _loc_2.next;
                }
                if (_loc_1.outer == null)
                {
                    _loc_1.outer = new Vec2();
                    _loc_4 = _loc_1.outer.zpp_inner;
                    if (_loc_4.outer != null)
                    {
                        _loc_4.outer.zpp_inner = null;
                        _loc_4.outer = null;
                    }
                    _loc_4._isimmutable = null;
                    _loc_4._validate = null;
                    _loc_4._invalidate = null;
                    _loc_4.next = ZPP_Vec2.zpp_pool;
                    ZPP_Vec2.zpp_pool = _loc_4;
                    _loc_1.outer.zpp_inner = _loc_1;
                }
                _loc_3 = _loc_1.outer;
                if (zpp_inner.subber != null)
                {
                    zpp_inner.subber(_loc_3);
                }
                if (!zpp_inner.dontremove)
                {
                    inner.erase(_loc_2);
                }
            }
            else
            {
                _loc_1 = inner.next;
                if (_loc_1.outer == null)
                {
                    _loc_1.outer = new Vec2();
                    _loc_2 = _loc_1.outer.zpp_inner;
                    if (_loc_2.outer != null)
                    {
                        _loc_2.outer.zpp_inner = null;
                        _loc_2.outer = null;
                    }
                    _loc_2._isimmutable = null;
                    _loc_2._validate = null;
                    _loc_2._invalidate = null;
                    _loc_2.next = ZPP_Vec2.zpp_pool;
                    ZPP_Vec2.zpp_pool = _loc_2;
                    _loc_1.outer.zpp_inner = _loc_1;
                }
                _loc_3 = _loc_1.outer;
                if (zpp_inner.subber != null)
                {
                    zpp_inner.subber(_loc_3);
                }
                if (!zpp_inner.dontremove)
                {
                    inner.pop();
                }
            }
            zpp_inner.invalidate();
            if (_loc_1.outer == null)
            {
                _loc_1.outer = new Vec2();
                _loc_2 = _loc_1.outer.zpp_inner;
                if (_loc_2.outer != null)
                {
                    _loc_2.outer.zpp_inner = null;
                    _loc_2.outer = null;
                }
                _loc_2._isimmutable = null;
                _loc_2._validate = null;
                _loc_2._invalidate = null;
                _loc_2.next = ZPP_Vec2.zpp_pool;
                ZPP_Vec2.zpp_pool = _loc_2;
                _loc_1.outer.zpp_inner = _loc_1;
            }
            _loc_3 = _loc_1.outer;
            return _loc_3;
        }// end function

        override public function remove(param1:Vec2) : Boolean
        {
            var _loc_4:* = null as ZPP_Vec2;
            if (zpp_inner.immutable)
            {
                throw "Error: " + "Vec2" + "List is immutable";
            }
            zpp_inner.modify_test();
            zpp_vm();
            var _loc_2:* = false;
            var _loc_3:* = inner.next;
            while (_loc_3 != null)
            {
                
                _loc_4 = _loc_3;
                if (param1.zpp_inner == _loc_4)
                {
                    _loc_2 = true;
                    break;
                }
                _loc_3 = _loc_3.next;
            }
            if (_loc_2)
            {
                if (zpp_inner.subber != null)
                {
                    zpp_inner.subber(param1);
                }
                if (!zpp_inner.dontremove)
                {
                    inner.remove(param1.zpp_inner);
                }
                zpp_inner.invalidate();
            }
            return _loc_2;
        }// end function

        override public function push(param1:Vec2) : Boolean
        {
            var _loc_2:* = false;
            var _loc_3:* = null as ZPP_Vec2;
            if (zpp_inner.immutable)
            {
                throw "Error: " + "Vec2" + "List is immutable";
            }
            zpp_inner.modify_test();
            zpp_vm();
            if (param1.zpp_inner._inuse)
            {
                throw "Error: " + "Vec2" + " is already in use";
            }
            if (zpp_inner.adder != null)
            {
                _loc_2 = zpp_inner.adder(param1);
            }
            else
            {
                _loc_2 = true;
            }
            if (_loc_2)
            {
                if (zpp_inner.reverse_flag)
                {
                    inner.add(param1.zpp_inner);
                }
                else
                {
                    _loc_3 = inner.iterator_at((zpp_gl() - 1));
                    inner.insert(_loc_3, param1.zpp_inner);
                }
                zpp_inner.invalidate();
                if (zpp_inner.post_adder != null)
                {
                    zpp_inner.post_adder(param1);
                }
            }
            return _loc_2;
        }// end function

        override public function pop() : Vec2
        {
            var _loc_2:* = null as Vec2;
            var _loc_3:* = null as ZPP_Vec2;
            var _loc_4:* = null as ZPP_Vec2;
            if (zpp_inner.immutable)
            {
                throw "Error: " + "Vec2" + "List is immutable";
            }
            zpp_inner.modify_test();
            if (empty())
            {
                throw "Error: Cannot remove from empty list";
            }
            zpp_vm();
            var _loc_1:* = null;
            if (zpp_inner.reverse_flag)
            {
                _loc_1 = inner.next;
                if (_loc_1.outer == null)
                {
                    _loc_1.outer = new Vec2();
                    _loc_3 = _loc_1.outer.zpp_inner;
                    if (_loc_3.outer != null)
                    {
                        _loc_3.outer.zpp_inner = null;
                        _loc_3.outer = null;
                    }
                    _loc_3._isimmutable = null;
                    _loc_3._validate = null;
                    _loc_3._invalidate = null;
                    _loc_3.next = ZPP_Vec2.zpp_pool;
                    ZPP_Vec2.zpp_pool = _loc_3;
                    _loc_1.outer.zpp_inner = _loc_1;
                }
                _loc_2 = _loc_1.outer;
                if (zpp_inner.subber != null)
                {
                    zpp_inner.subber(_loc_2);
                }
                if (!zpp_inner.dontremove)
                {
                    inner.pop();
                }
            }
            else
            {
                if (at_ite != null)
                {
                }
                if (at_ite.next == null)
                {
                    at_ite = null;
                }
                if (zpp_gl() == 1)
                {
                    _loc_3 = null;
                }
                else
                {
                    _loc_3 = inner.iterator_at(zpp_gl() - 2);
                }
                if (_loc_3 == null)
                {
                    _loc_1 = inner.next;
                }
                else
                {
                    _loc_1 = _loc_3.next;
                }
                if (_loc_1.outer == null)
                {
                    _loc_1.outer = new Vec2();
                    _loc_4 = _loc_1.outer.zpp_inner;
                    if (_loc_4.outer != null)
                    {
                        _loc_4.outer.zpp_inner = null;
                        _loc_4.outer = null;
                    }
                    _loc_4._isimmutable = null;
                    _loc_4._validate = null;
                    _loc_4._invalidate = null;
                    _loc_4.next = ZPP_Vec2.zpp_pool;
                    ZPP_Vec2.zpp_pool = _loc_4;
                    _loc_1.outer.zpp_inner = _loc_1;
                }
                _loc_2 = _loc_1.outer;
                if (zpp_inner.subber != null)
                {
                    zpp_inner.subber(_loc_2);
                }
                if (!zpp_inner.dontremove)
                {
                    inner.erase(_loc_3);
                }
            }
            zpp_inner.invalidate();
            if (_loc_1.outer == null)
            {
                _loc_1.outer = new Vec2();
                _loc_3 = _loc_1.outer.zpp_inner;
                if (_loc_3.outer != null)
                {
                    _loc_3.outer.zpp_inner = null;
                    _loc_3.outer = null;
                }
                _loc_3._isimmutable = null;
                _loc_3._validate = null;
                _loc_3._invalidate = null;
                _loc_3.next = ZPP_Vec2.zpp_pool;
                ZPP_Vec2.zpp_pool = _loc_3;
                _loc_1.outer.zpp_inner = _loc_1;
            }
            _loc_2 = _loc_1.outer;
            return _loc_2;
        }// end function

        override public function clear() : void
        {
            if (zpp_inner.immutable)
            {
                throw "Error: " + "Vec2" + "List is immutable";
            }
            if (zpp_inner.reverse_flag)
            {
                while (!empty())
                {
                    
                    pop();
                }
            }
            else
            {
                while (!empty())
                {
                    
                    shift();
                }
            }
            return;
        }// end function

        override public function at(param1:int) : Vec2
        {
            var _loc_2:* = null as ZPP_Vec2;
            var _loc_3:* = null as ZPP_Vec2;
            zpp_vm();
            if (param1 >= 0)
            {
            }
            if (param1 >= zpp_gl())
            {
                throw "Error: Index out of bounds";
            }
            if (zpp_inner.reverse_flag)
            {
                param1 = (zpp_gl() - 1) - param1;
            }
            if (param1 >= at_index)
            {
            }
            if (at_ite == null)
            {
                at_index = 0;
                at_ite = inner.next;
                while (true)
                {
                    
                    _loc_2 = at_ite;
                    break;
                    at_ite = at_ite.next;
                }
            }
            while (at_index != param1)
            {
                
                (at_index + 1);
                at_ite = at_ite.next;
                while (true)
                {
                    
                    _loc_2 = at_ite;
                    break;
                    at_ite = at_ite.next;
                }
            }
            _loc_2 = at_ite;
            if (_loc_2.outer == null)
            {
                _loc_2.outer = new Vec2();
                _loc_3 = _loc_2.outer.zpp_inner;
                if (_loc_3.outer != null)
                {
                    _loc_3.outer.zpp_inner = null;
                    _loc_3.outer = null;
                }
                _loc_3._isimmutable = null;
                _loc_3._validate = null;
                _loc_3._invalidate = null;
                _loc_3.next = ZPP_Vec2.zpp_pool;
                ZPP_Vec2.zpp_pool = _loc_3;
                _loc_2.outer.zpp_inner = _loc_2;
            }
            return _loc_2.outer;
        }// end function

        public static function get(param1:ZPP_Vec2, param2:Boolean = false) : ZPP_MixVec2List
        {
            var _loc_3:* = new ZPP_MixVec2List();
            _loc_3.inner = param1;
            _loc_3.zpp_inner.immutable = param2;
            return _loc_3;
        }// end function

    }
}
