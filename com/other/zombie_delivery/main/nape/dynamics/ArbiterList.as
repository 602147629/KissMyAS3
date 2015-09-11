package nape.dynamics
{
    import __AS3__.vec.*;
    import flash.*;
    import zpp_nape.dynamics.*;
    import zpp_nape.util.*;

    public class ArbiterList extends Object
    {
        public var zpp_inner:ZPP_ArbiterList;

        public function ArbiterList() : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            zpp_inner = null;
            zpp_inner = new ZPP_ArbiterList();
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
            var _loc_1:* = null as ZNPNode_ZPP_Arbiter;
            var _loc_2:* = null as ZPP_Arbiter;
            zpp_inner.valmod();
            if (zpp_inner.zip_length)
            {
                zpp_inner.zip_length = false;
                zpp_inner.user_length = 0;
                _loc_1 = zpp_inner.inner.head;
                while (_loc_1 != null)
                {
                    
                    _loc_2 = _loc_1.elt;
                    if (_loc_2.active)
                    {
                        (zpp_inner.user_length + 1);
                    }
                    _loc_1 = _loc_1.next;
                }
            }
            return zpp_inner.user_length;
        }// end function

        public function unshift(param1:Arbiter) : Boolean
        {
            var _loc_2:* = false;
            if (zpp_inner.immutable)
            {
                throw "Error: " + "Arbiter" + "List is immutable";
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
            var _loc_4:* = null as Arbiter;
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
            }while (_loc_3.zpp_i < _loc_5 ? (true) : (_loc_3.zpp_next = ArbiterIterator.zpp_pool, ArbiterIterator.zpp_pool = _loc_3, _loc_3.zpp_inner = null, false))
            return _loc_1 + "]";
        }// end function

        public function shift() : Arbiter
        {
            var _loc_2:* = null as ZNPNode_ZPP_Arbiter;
            var _loc_3:* = null as Arbiter;
            if (zpp_inner.immutable)
            {
                throw "Error: " + "Arbiter" + "List is immutable";
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
                _loc_3 = _loc_1.wrapper();
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
                _loc_3 = _loc_1.wrapper();
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
            _loc_3 = _loc_1.wrapper();
            return _loc_3;
        }// end function

        public function remove(param1:Arbiter) : Boolean
        {
            var _loc_4:* = null as ZPP_Arbiter;
            if (zpp_inner.immutable)
            {
                throw "Error: " + "Arbiter" + "List is immutable";
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

        public function push(param1:Arbiter) : Boolean
        {
            var _loc_2:* = false;
            if (zpp_inner.immutable)
            {
                throw "Error: " + "Arbiter" + "List is immutable";
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

        public function pop() : Arbiter
        {
            var _loc_2:* = null as Arbiter;
            var _loc_3:* = null as ZNPNode_ZPP_Arbiter;
            if (zpp_inner.immutable)
            {
                throw "Error: " + "Arbiter" + "List is immutable";
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
                _loc_2 = _loc_1.wrapper();
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
                    _loc_3 = null;
                }
                else
                {
                    _loc_3 = zpp_inner.inner.iterator_at(zpp_gl() - 2);
                }
                if (_loc_3 == null)
                {
                    _loc_1 = zpp_inner.inner.head.elt;
                }
                else
                {
                    _loc_1 = _loc_3.next.elt;
                }
                _loc_2 = _loc_1.wrapper();
                if (zpp_inner.subber != null)
                {
                    zpp_inner.subber(_loc_2);
                }
                if (!zpp_inner.dontremove)
                {
                    zpp_inner.inner.erase(_loc_3);
                }
            }
            zpp_inner.invalidate();
            _loc_2 = _loc_1.wrapper();
            return _loc_2;
        }// end function

        public function merge(param1:ArbiterList) : void
        {
            var _loc_3:* = null as Arbiter;
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
            }while (_loc_2.zpp_i < _loc_4 ? (true) : (_loc_2.zpp_next = ArbiterIterator.zpp_pool, ArbiterIterator.zpp_pool = _loc_2, _loc_2.zpp_inner = null, false))
            return;
        }// end function

        public function iterator() : ArbiterIterator
        {
            zpp_vm();
            return ArbiterIterator.get(this);
        }// end function

        public function has(param1:Arbiter) : Boolean
        {
            zpp_vm();
            return zpp_inner.inner.has(param1.zpp_inner);
        }// end function

        public function get_length() : int
        {
            return zpp_gl();
        }// end function

        public function foreach(param1:Function) : ArbiterList
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
                _loc_3.zpp_next = ArbiterIterator.zpp_pool;
                ArbiterIterator.zpp_pool = _loc_3;
                _loc_3.zpp_inner = null;
                break;
                _loc_3.zpp_inner.zpp_inner.valmod();
                _loc_4 = _loc_3.zpp_inner.zpp_gl();
                _loc_3.zpp_critical = true;
            }while (_loc_3.zpp_i < _loc_4 ? (true) : (_loc_3.zpp_next = ArbiterIterator.zpp_pool, ArbiterIterator.zpp_pool = _loc_3, _loc_3.zpp_inner = null, false))
            return this;
        }// end function

        public function filter(param1:Function) : ArbiterList
        {
            var _loc_4:* = null as Arbiter;
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

        public function copy(param1:Boolean = false) : ArbiterList
        {
            var _loc_4:* = null as Arbiter;
            var _loc_5:* = 0;
            var _loc_2:* = new ArbiterList();
            var _loc_3:* = iterator();
            do
            {
                
                _loc_3.zpp_critical = false;
                _loc_5 = _loc_3.zpp_i;
                (_loc_3.zpp_i + 1);
                _loc_4 = _loc_3.zpp_inner.at(_loc_5);
                _loc_2.push(param1 ? (throw "Error: " + "Arbiter" + " is not a copyable type", null) : (_loc_4));
                _loc_3.zpp_inner.zpp_inner.valmod();
                _loc_5 = _loc_3.zpp_inner.zpp_gl();
                _loc_3.zpp_critical = true;
            }while (_loc_3.zpp_i < _loc_5 ? (true) : (_loc_3.zpp_next = ArbiterIterator.zpp_pool, ArbiterIterator.zpp_pool = _loc_3, _loc_3.zpp_inner = null, false))
            return _loc_2;
        }// end function

        public function clear() : void
        {
            if (zpp_inner.immutable)
            {
                throw "Error: " + "Arbiter" + "List is immutable";
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

        public function at(param1:int) : Arbiter
        {
            var _loc_2:* = null as ZPP_Arbiter;
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
                zpp_inner.at_index = 0;
                zpp_inner.at_ite = zpp_inner.inner.head;
                while (true)
                {
                    
                    _loc_2 = zpp_inner.at_ite.elt;
                    if (_loc_2.active)
                    {
                        break;
                    }
                    zpp_inner.at_ite = zpp_inner.at_ite.next;
                }
            }
            while (zpp_inner.at_index != param1)
            {
                
                (zpp_inner.at_index + 1);
                zpp_inner.at_ite = zpp_inner.at_ite.next;
                while (true)
                {
                    
                    _loc_2 = zpp_inner.at_ite.elt;
                    if (_loc_2.active)
                    {
                        break;
                    }
                    zpp_inner.at_ite = zpp_inner.at_ite.next;
                }
            }
            return zpp_inner.at_ite.elt.wrapper();
        }// end function

        public function add(param1:Arbiter) : Boolean
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

        public static function fromArray(param1:Array) : ArbiterList
        {
            var _loc_4:* = null as Arbiter;
            if (param1 == null)
            {
                throw "Error: Cannot convert null Array to Nape list";
            }
            var _loc_2:* = new ArbiterList();
            var _loc_3:* = 0;
            while (_loc_3 < param1.length)
            {
                
                _loc_4 = param1[_loc_3];
                _loc_3++;
                if (!(_loc_4 is Arbiter))
                {
                    throw "Error: Array contains non " + "Arbiter" + " types.";
                }
                _loc_2.push(_loc_4);
            }
            return _loc_2;
        }// end function

        public static function fromVector(param1:Vector.<Arbiter>) : ArbiterList
        {
            var _loc_4:* = null as Arbiter;
            if (param1 == null)
            {
                throw "Error: Cannot convert null Vector to Nape list";
            }
            var _loc_2:* = new ArbiterList();
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
