package nape.geom
{
    import __AS3__.vec.*;
    import flash.*;
    import zpp_nape.geom.*;
    import zpp_nape.util.*;

    public class Vec2List extends Object
    {
        public var zpp_inner:ZPP_Vec2List;

        public function Vec2List() : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            zpp_inner = null;
            zpp_inner = new ZPP_Vec2List();
            zpp_inner.outer = this;
            return;
        }// end function

        public function zpp_vm() : void
        {
            zpp_inner.valmod();
            return;
        }// end function

        public function zpp_gl() : int
        {
            zpp_inner.valmod();
            if (zpp_inner.zip_length)
            {
                zpp_inner.zip_length = false;
                zpp_inner.user_length = zpp_inner.inner.length;
            }
            return zpp_inner.user_length;
        }// end function

        public function unshift(param1:Vec2) : Boolean
        {
            var _loc_2:* = false;
            if (zpp_inner.immutable)
            {
                throw "Error: " + "Vec2" + "List is immutable";
            }
            zpp_inner.modify_test();
            zpp_vm();
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
                    if (zpp_inner.push_ite == null)
                    {
                        if (empty())
                        {
                            zpp_inner.push_ite = null;
                        }
                        else
                        {
                            zpp_inner.push_ite = zpp_inner.inner.iterator_at((zpp_gl() - 1));
                        }
                    }
                    zpp_inner.push_ite = zpp_inner.inner.insert(zpp_inner.push_ite, param1.zpp_inner);
                }
                else
                {
                    zpp_inner.inner.add(param1.zpp_inner);
                }
                zpp_inner.invalidate();
                if (zpp_inner.post_adder != null)
                {
                    zpp_inner.post_adder(param1);
                }
            }
            return _loc_2;
        }// end function

        public function toString() : String
        {
            var _loc_4:* = null as Vec2;
            var _loc_5:* = 0;
            var _loc_1:* = "[";
            var _loc_2:* = true;
            var _loc_3:* = iterator();
            do
            {
                
                _loc_3.zpp_critical = false;
                _loc_5 = _loc_3.zpp_i;
                (_loc_3.zpp_i + 1);
                _loc_4 = _loc_3.zpp_inner.at(_loc_5);
                if (!_loc_2)
                {
                    _loc_1 = _loc_1 + ",";
                }
                if (_loc_4 == null)
                {
                    _loc_1 = _loc_1 + "NULL";
                }
                else
                {
                    _loc_1 = _loc_1 + _loc_4.toString();
                }
                _loc_2 = false;
                _loc_3.zpp_inner.zpp_inner.valmod();
                _loc_5 = _loc_3.zpp_inner.zpp_gl();
                _loc_3.zpp_critical = true;
            }while (_loc_3.zpp_i < _loc_5 ? (true) : (_loc_3.zpp_next = Vec2Iterator.zpp_pool, Vec2Iterator.zpp_pool = _loc_3, _loc_3.zpp_inner = null, false))
            return _loc_1 + "]";
        }// end function

        public function shift() : Vec2
        {
            var _loc_2:* = null as ZNPNode_ZPP_Vec2;
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
                if (zpp_inner.at_ite != null)
                {
                }
                if (zpp_inner.at_ite.next == null)
                {
                    zpp_inner.at_ite = null;
                }
                if (zpp_gl() == 1)
                {
                    _loc_2 = null;
                }
                else
                {
                    _loc_2 = zpp_inner.inner.iterator_at(zpp_gl() - 2);
                }
                if (_loc_2 == null)
                {
                    _loc_1 = zpp_inner.inner.head.elt;
                }
                else
                {
                    _loc_1 = _loc_2.next.elt;
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
                    zpp_inner.inner.erase(_loc_2);
                }
            }
            else
            {
                _loc_1 = zpp_inner.inner.head.elt;
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
                    zpp_inner.inner.pop();
                }
            }
            zpp_inner.invalidate();
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
            return _loc_3;
        }// end function

        public function remove(param1:Vec2) : Boolean
        {
            var _loc_4:* = null as ZPP_Vec2;
            if (zpp_inner.immutable)
            {
                throw "Error: " + "Vec2" + "List is immutable";
            }
            zpp_inner.modify_test();
            zpp_vm();
            var _loc_2:* = false;
            var _loc_3:* = zpp_inner.inner.head;
            while (_loc_3 != null)
            {
                
                _loc_4 = _loc_3.elt;
                if (_loc_4 == param1.zpp_inner)
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
                    zpp_inner.inner.remove(param1.zpp_inner);
                }
                zpp_inner.invalidate();
            }
            return _loc_2;
        }// end function

        public function push(param1:Vec2) : Boolean
        {
            var _loc_2:* = false;
            if (zpp_inner.immutable)
            {
                throw "Error: " + "Vec2" + "List is immutable";
            }
            zpp_inner.modify_test();
            zpp_vm();
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
                    zpp_inner.inner.add(param1.zpp_inner);
                }
                else
                {
                    if (zpp_inner.push_ite == null)
                    {
                        if (empty())
                        {
                            zpp_inner.push_ite = null;
                        }
                        else
                        {
                            zpp_inner.push_ite = zpp_inner.inner.iterator_at((zpp_gl() - 1));
                        }
                    }
                    zpp_inner.push_ite = zpp_inner.inner.insert(zpp_inner.push_ite, param1.zpp_inner);
                }
                zpp_inner.invalidate();
                if (zpp_inner.post_adder != null)
                {
                    zpp_inner.post_adder(param1);
                }
            }
            return _loc_2;
        }// end function

        public function pop() : Vec2
        {
            var _loc_2:* = null as Vec2;
            var _loc_3:* = null as ZPP_Vec2;
            var _loc_4:* = null as ZNPNode_ZPP_Vec2;
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
                _loc_1 = zpp_inner.inner.head.elt;
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
                    zpp_inner.inner.pop();
                }
            }
            else
            {
                if (zpp_inner.at_ite != null)
                {
                }
                if (zpp_inner.at_ite.next == null)
                {
                    zpp_inner.at_ite = null;
                }
                if (zpp_gl() == 1)
                {
                    _loc_4 = null;
                }
                else
                {
                    _loc_4 = zpp_inner.inner.iterator_at(zpp_gl() - 2);
                }
                if (_loc_4 == null)
                {
                    _loc_1 = zpp_inner.inner.head.elt;
                }
                else
                {
                    _loc_1 = _loc_4.next.elt;
                }
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
                    zpp_inner.inner.erase(_loc_4);
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

        public function merge(param1:Vec2List) : void
        {
            var _loc_3:* = null as Vec2;
            var _loc_4:* = 0;
            if (param1 == null)
            {
                throw "Error: Cannot merge with null list";
            }
            var _loc_2:* = param1.iterator();
            do
            {
                
                _loc_2.zpp_critical = false;
                _loc_4 = _loc_2.zpp_i;
                (_loc_2.zpp_i + 1);
                _loc_3 = _loc_2.zpp_inner.at(_loc_4);
                if (!has(_loc_3))
                {
                    add(_loc_3);
                }
                _loc_2.zpp_inner.zpp_inner.valmod();
                _loc_4 = _loc_2.zpp_inner.zpp_gl();
                _loc_2.zpp_critical = true;
            }while (_loc_2.zpp_i < _loc_4 ? (true) : (_loc_2.zpp_next = Vec2Iterator.zpp_pool, Vec2Iterator.zpp_pool = _loc_2, _loc_2.zpp_inner = null, false))
            return;
        }// end function

        public function iterator() : Vec2Iterator
        {
            zpp_vm();
            return Vec2Iterator.get(this);
        }// end function

        public function has(param1:Vec2) : Boolean
        {
            zpp_vm();
            return zpp_inner.inner.has(param1.zpp_inner);
        }// end function

        public function get_length() : int
        {
            return zpp_gl();
        }// end function

        public function foreach(param1:Function) : Vec2List
        {
            var _loc_4:* = 0;
            var _loc_5:* = null;
            if (param1 == null)
            {
                throw "Error: Cannot execute null on list elements";
            }
            var _loc_3:* = iterator();
            do
            {
                
                _loc_3.zpp_critical = false;
                _loc_4 = _loc_3.zpp_i;
                (_loc_3.zpp_i + 1);
                this.param1(_loc_3.zpp_inner.at(_loc_4));
                ;
                _loc_5 = null;
                _loc_3.zpp_next = Vec2Iterator.zpp_pool;
                Vec2Iterator.zpp_pool = _loc_3;
                _loc_3.zpp_inner = null;
                break;
                _loc_3.zpp_inner.zpp_inner.valmod();
                _loc_4 = _loc_3.zpp_inner.zpp_gl();
                _loc_3.zpp_critical = true;
            }while (_loc_3.zpp_i < _loc_4 ? (true) : (_loc_3.zpp_next = Vec2Iterator.zpp_pool, Vec2Iterator.zpp_pool = _loc_3, _loc_3.zpp_inner = null, false))
            return this;
        }// end function

        public function filter(param1:Function) : Vec2List
        {
            var _loc_4:* = null as Vec2;
            var _loc_5:* = null;
            if (param1 == null)
            {
                throw "Error: Cannot select elements of list with null";
            }
            var _loc_3:* = 0;
            while (_loc_3 < zpp_gl())
            {
                
                _loc_4 = at(_loc_3);
                if (this.param1(_loc_4))
                {
                    _loc_3++;
                }
                else
                {
                    remove(_loc_4);
                }
                continue;
                _loc_5 = null;
                break;
            }
            return this;
        }// end function

        public function empty() : Boolean
        {
            return zpp_gl() == 0;
        }// end function

        public function copy(param1:Boolean = false) : Vec2List
        {
            var _loc_4:* = null as Vec2;
            var _loc_5:* = 0;
            var _loc_6:* = false;
            var _loc_7:* = NaN;
            var _loc_8:* = null as ZPP_Vec2;
            var _loc_9:* = NaN;
            var _loc_10:* = null as Vec2;
            var _loc_11:* = false;
            var _loc_2:* = new Vec2List();
            var _loc_3:* = iterator();
            do
            {
                
                _loc_3.zpp_critical = false;
                _loc_5 = _loc_3.zpp_i;
                (_loc_3.zpp_i + 1);
                _loc_4 = _loc_3.zpp_inner.at(_loc_5);
                if (param1)
                {
                    _loc_6 = false;
                    if (_loc_4 != null)
                    {
                    }
                    if (_loc_4.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    if (_loc_4.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_8 = _loc_4.zpp_inner;
                    if (_loc_8._validate != null)
                    {
                        _loc_8._validate();
                    }
                    _loc_7 = _loc_4.zpp_inner.x;
                    if (_loc_4.zpp_disp)
                    {
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                    }
                    _loc_8 = _loc_4.zpp_inner;
                    if (_loc_8._validate != null)
                    {
                        _loc_8._validate();
                    }
                    _loc_9 = _loc_4.zpp_inner.y;
                    if (_loc_7 == _loc_7)
                    {
                    }
                    if (_loc_9 != _loc_9)
                    {
                        throw "Error: Vec2 components cannot be NaN";
                    }
                    if (ZPP_PubPool.poolVec2 == null)
                    {
                        _loc_10 = new Vec2();
                    }
                    else
                    {
                        _loc_10 = ZPP_PubPool.poolVec2;
                        ZPP_PubPool.poolVec2 = _loc_10.zpp_pool;
                        _loc_10.zpp_pool = null;
                        _loc_10.zpp_disp = false;
                        if (_loc_10 == ZPP_PubPool.nextVec2)
                        {
                            ZPP_PubPool.nextVec2 = null;
                        }
                    }
                    if (_loc_10.zpp_inner == null)
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
                        _loc_8.x = _loc_7;
                        _loc_8.y = _loc_9;
                        _loc_10.zpp_inner = _loc_8;
                        _loc_10.zpp_inner.outer = _loc_10;
                    }
                    else
                    {
                        if (_loc_10 != null)
                        {
                        }
                        if (_loc_10.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_8 = _loc_10.zpp_inner;
                        if (_loc_8._immutable)
                        {
                            throw "Error: Vec2 is immutable";
                        }
                        if (_loc_8._isimmutable != null)
                        {
                            _loc_8._isimmutable();
                        }
                        if (_loc_7 == _loc_7)
                        {
                        }
                        if (_loc_9 != _loc_9)
                        {
                            throw "Error: Vec2 components cannot be NaN";
                        }
                        if (_loc_10 != null)
                        {
                        }
                        if (_loc_10.zpp_disp)
                        {
                            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc_8 = _loc_10.zpp_inner;
                        if (_loc_8._validate != null)
                        {
                            _loc_8._validate();
                        }
                        if (_loc_10.zpp_inner.x == _loc_7)
                        {
                            if (_loc_10 != null)
                            {
                            }
                            if (_loc_10.zpp_disp)
                            {
                                throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                            }
                            _loc_8 = _loc_10.zpp_inner;
                            if (_loc_8._validate != null)
                            {
                                _loc_8._validate();
                            }
                        }
                        if (_loc_10.zpp_inner.y != _loc_9)
                        {
                            _loc_10.zpp_inner.x = _loc_7;
                            _loc_10.zpp_inner.y = _loc_9;
                            _loc_8 = _loc_10.zpp_inner;
                            if (_loc_8._invalidate != null)
                            {
                                _loc_8._invalidate(_loc_8);
                            }
                        }
                    }
                    _loc_10.zpp_inner.weak = _loc_6;
                }
                else
                {
                }
                _loc_10.push(_loc_4);
                _loc_3.zpp_inner.zpp_inner.valmod();
                _loc_5 = _loc_3.zpp_inner.zpp_gl();
                _loc_3.zpp_critical = true;
            }while (_loc_3.zpp_i < _loc_5 ? (true) : (_loc_3.zpp_next = Vec2Iterator.zpp_pool, Vec2Iterator.zpp_pool = _loc_3, _loc_3.zpp_inner = null, false))
            return _loc_2;
        }// end function

        public function clear() : void
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

        public function at(param1:int) : Vec2
        {
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
            if (param1 >= zpp_inner.at_index)
            {
            }
            if (zpp_inner.at_ite == null)
            {
                zpp_inner.at_index = param1;
                zpp_inner.at_ite = zpp_inner.inner.iterator_at(param1);
            }
            else
            {
                while (zpp_inner.at_index != param1)
                {
                    
                    (zpp_inner.at_index + 1);
                    zpp_inner.at_ite = zpp_inner.at_ite.next;
                }
            }
            var _loc_2:* = zpp_inner.at_ite.elt;
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

        public function add(param1:Vec2) : Boolean
        {
            if (zpp_inner.reverse_flag)
            {
                return push(param1);
            }
            else
            {
                return unshift(param1);
            }
        }// end function

        public static function fromArray(param1:Array) : Vec2List
        {
            var _loc_4:* = null as Vec2;
            if (param1 == null)
            {
                throw "Error: Cannot convert null Array to Nape list";
            }
            var _loc_2:* = new Vec2List();
            var _loc_3:* = 0;
            while (_loc_3 < param1.length)
            {
                
                _loc_4 = param1[_loc_3];
                _loc_3++;
                if (!(_loc_4 is Vec2))
                {
                    throw "Error: Array contains non " + "Vec2" + " types.";
                }
                _loc_2.push(_loc_4);
            }
            return _loc_2;
        }// end function

        public static function fromVector(param1:Vector.<Vec2>) : Vec2List
        {
            var _loc_4:* = null as Vec2;
            if (param1 == null)
            {
                throw "Error: Cannot convert null Vector to Nape list";
            }
            var _loc_2:* = new Vec2List();
            var _loc_3:* = 0;
            while (_loc_3 < param1.length)
            {
                
                _loc_4 = param1[_loc_3];
                _loc_3++;
                _loc_2.push(_loc_4);
            }
            return _loc_2;
        }// end function

    }
}
