package nape.geom
{
    import __AS3__.vec.*;
    import flash.*;
    import zpp_nape.util.*;

    final public class ConvexResultList extends Object
    {
        public var zpp_inner:ZPP_ConvexResultList;

        public function ConvexResultList() : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            zpp_inner = null;
            zpp_inner = new ZPP_ConvexResultList();
            zpp_inner.outer = this;
            return;
        }// end function

        public function unshift(param1:ConvexResult) : Boolean
        {
            var _loc_2:* = false;
            if (zpp_inner.immutable)
            {
                throw "Error: " + "ConvexResult" + "List is immutable";
            }
            zpp_inner.modify_test();
            zpp_inner.valmod();
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
                        if (zpp_inner.inner.head == null)
                        {
                            zpp_inner.push_ite = null;
                        }
                        else
                        {
                            zpp_inner.valmod();
                            if (zpp_inner.zip_length)
                            {
                                zpp_inner.zip_length = false;
                                zpp_inner.user_length = zpp_inner.inner.length;
                            }
                            zpp_inner.push_ite = zpp_inner.inner.iterator_at((zpp_inner.user_length - 1));
                        }
                    }
                    zpp_inner.push_ite = zpp_inner.inner.insert(zpp_inner.push_ite, param1);
                }
                else
                {
                    zpp_inner.inner.add(param1);
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
            var _loc_4:* = null as ConvexResult;
            var _loc_5:* = 0;
            var _loc_6:* = null as ConvexResultList;
            var _loc_1:* = "[";
            var _loc_2:* = true;
            zpp_inner.valmod();
            var _loc_3:* = ConvexResultIterator.get(this);
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
                _loc_6 = _loc_3.zpp_inner;
                _loc_6.zpp_inner.valmod();
                if (_loc_6.zpp_inner.zip_length)
                {
                    _loc_6.zpp_inner.zip_length = false;
                    _loc_6.zpp_inner.user_length = _loc_6.zpp_inner.inner.length;
                }
                _loc_5 = _loc_6.zpp_inner.user_length;
                _loc_3.zpp_critical = true;
            }while (_loc_3.zpp_i < _loc_5 ? (true) : (_loc_3.zpp_next = ConvexResultIterator.zpp_pool, ConvexResultIterator.zpp_pool = _loc_3, _loc_3.zpp_inner = null, false))
            return _loc_1 + "]";
        }// end function

        public function shift() : ConvexResult
        {
            var _loc_2:* = null as ZNPNode_ConvexResult;
            var _loc_3:* = null as ConvexResult;
            if (zpp_inner.immutable)
            {
                throw "Error: " + "ConvexResult" + "List is immutable";
            }
            zpp_inner.modify_test();
            if (zpp_inner.inner.head == null)
            {
                throw "Error: Cannot remove from empty list";
            }
            zpp_inner.valmod();
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
                zpp_inner.valmod();
                if (zpp_inner.zip_length)
                {
                    zpp_inner.zip_length = false;
                    zpp_inner.user_length = zpp_inner.inner.length;
                }
                if (zpp_inner.user_length == 1)
                {
                    _loc_2 = null;
                }
                else
                {
                    zpp_inner.valmod();
                    if (zpp_inner.zip_length)
                    {
                        zpp_inner.zip_length = false;
                        zpp_inner.user_length = zpp_inner.inner.length;
                    }
                    _loc_2 = zpp_inner.inner.iterator_at(zpp_inner.user_length - 2);
                }
                if (_loc_2 == null)
                {
                    _loc_1 = zpp_inner.inner.head.elt;
                }
                else
                {
                    _loc_1 = _loc_2.next.elt;
                }
                _loc_3 = _loc_1;
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
                _loc_3 = _loc_1;
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
            _loc_3 = _loc_1;
            return _loc_3;
        }// end function

        public function remove(param1:ConvexResult) : Boolean
        {
            var _loc_4:* = null as ConvexResult;
            if (zpp_inner.immutable)
            {
                throw "Error: " + "ConvexResult" + "List is immutable";
            }
            zpp_inner.modify_test();
            zpp_inner.valmod();
            var _loc_2:* = false;
            var _loc_3:* = zpp_inner.inner.head;
            while (_loc_3 != null)
            {
                
                _loc_4 = _loc_3.elt;
                if (_loc_4 == param1)
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
                    zpp_inner.inner.remove(param1);
                }
                zpp_inner.invalidate();
            }
            return _loc_2;
        }// end function

        public function push(param1:ConvexResult) : Boolean
        {
            var _loc_2:* = false;
            if (zpp_inner.immutable)
            {
                throw "Error: " + "ConvexResult" + "List is immutable";
            }
            zpp_inner.modify_test();
            zpp_inner.valmod();
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
                    zpp_inner.inner.add(param1);
                }
                else
                {
                    if (zpp_inner.push_ite == null)
                    {
                        if (zpp_inner.inner.head == null)
                        {
                            zpp_inner.push_ite = null;
                        }
                        else
                        {
                            zpp_inner.valmod();
                            if (zpp_inner.zip_length)
                            {
                                zpp_inner.zip_length = false;
                                zpp_inner.user_length = zpp_inner.inner.length;
                            }
                            zpp_inner.push_ite = zpp_inner.inner.iterator_at((zpp_inner.user_length - 1));
                        }
                    }
                    zpp_inner.push_ite = zpp_inner.inner.insert(zpp_inner.push_ite, param1);
                }
                zpp_inner.invalidate();
                if (zpp_inner.post_adder != null)
                {
                    zpp_inner.post_adder(param1);
                }
            }
            return _loc_2;
        }// end function

        public function pop() : ConvexResult
        {
            var _loc_2:* = null as ConvexResult;
            var _loc_3:* = null as ZNPNode_ConvexResult;
            if (zpp_inner.immutable)
            {
                throw "Error: " + "ConvexResult" + "List is immutable";
            }
            zpp_inner.modify_test();
            if (zpp_inner.inner.head == null)
            {
                throw "Error: Cannot remove from empty list";
            }
            zpp_inner.valmod();
            var _loc_1:* = null;
            if (zpp_inner.reverse_flag)
            {
                _loc_1 = zpp_inner.inner.head.elt;
                _loc_2 = _loc_1;
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
                zpp_inner.valmod();
                if (zpp_inner.zip_length)
                {
                    zpp_inner.zip_length = false;
                    zpp_inner.user_length = zpp_inner.inner.length;
                }
                if (zpp_inner.user_length == 1)
                {
                    _loc_3 = null;
                }
                else
                {
                    zpp_inner.valmod();
                    if (zpp_inner.zip_length)
                    {
                        zpp_inner.zip_length = false;
                        zpp_inner.user_length = zpp_inner.inner.length;
                    }
                    _loc_3 = zpp_inner.inner.iterator_at(zpp_inner.user_length - 2);
                }
                if (_loc_3 == null)
                {
                    _loc_1 = zpp_inner.inner.head.elt;
                }
                else
                {
                    _loc_1 = _loc_3.next.elt;
                }
                _loc_2 = _loc_1;
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
            _loc_2 = _loc_1;
            return _loc_2;
        }// end function

        public function merge(param1:ConvexResultList) : void
        {
            var _loc_3:* = null as ConvexResult;
            var _loc_4:* = 0;
            var _loc_5:* = null as ConvexResultList;
            if (param1 == null)
            {
                throw "Error: Cannot merge with null list";
            }
            param1.zpp_inner.valmod();
            var _loc_2:* = ConvexResultIterator.get(param1);
            do
            {
                
                _loc_2.zpp_critical = false;
                _loc_4 = _loc_2.zpp_i;
                (_loc_2.zpp_i + 1);
                _loc_3 = _loc_2.zpp_inner.at(_loc_4);
                if (!has(_loc_3))
                {
                    if (zpp_inner.reverse_flag)
                    {
                        push(_loc_3);
                    }
                    else
                    {
                        unshift(_loc_3);
                    }
                }
                _loc_2.zpp_inner.zpp_inner.valmod();
                _loc_5 = _loc_2.zpp_inner;
                _loc_5.zpp_inner.valmod();
                if (_loc_5.zpp_inner.zip_length)
                {
                    _loc_5.zpp_inner.zip_length = false;
                    _loc_5.zpp_inner.user_length = _loc_5.zpp_inner.inner.length;
                }
                _loc_4 = _loc_5.zpp_inner.user_length;
                _loc_2.zpp_critical = true;
            }while (_loc_2.zpp_i < _loc_4 ? (true) : (_loc_2.zpp_next = ConvexResultIterator.zpp_pool, ConvexResultIterator.zpp_pool = _loc_2, _loc_2.zpp_inner = null, false))
            return;
        }// end function

        public function iterator() : ConvexResultIterator
        {
            zpp_inner.valmod();
            return ConvexResultIterator.get(this);
        }// end function

        public function has(param1:ConvexResult) : Boolean
        {
            zpp_inner.valmod();
            return zpp_inner.inner.has(param1);
        }// end function

        public function get_length() : int
        {
            zpp_inner.valmod();
            if (zpp_inner.zip_length)
            {
                zpp_inner.zip_length = false;
                zpp_inner.user_length = zpp_inner.inner.length;
            }
            return zpp_inner.user_length;
        }// end function

        public function foreach(param1:Function) : ConvexResultList
        {
            var _loc_4:* = 0;
            var _loc_5:* = null;
            var _loc_6:* = null as ConvexResultList;
            if (param1 == null)
            {
                throw "Error: Cannot execute null on list elements";
            }
            zpp_inner.valmod();
            var _loc_3:* = ConvexResultIterator.get(this);
            do
            {
                
                _loc_3.zpp_critical = false;
                _loc_4 = _loc_3.zpp_i;
                (_loc_3.zpp_i + 1);
                this.param1(_loc_3.zpp_inner.at(_loc_4));
                ;
                _loc_5 = null;
                _loc_3.zpp_next = ConvexResultIterator.zpp_pool;
                ConvexResultIterator.zpp_pool = _loc_3;
                _loc_3.zpp_inner = null;
                break;
                _loc_3.zpp_inner.zpp_inner.valmod();
                _loc_6 = _loc_3.zpp_inner;
                _loc_6.zpp_inner.valmod();
                if (_loc_6.zpp_inner.zip_length)
                {
                    _loc_6.zpp_inner.zip_length = false;
                    _loc_6.zpp_inner.user_length = _loc_6.zpp_inner.inner.length;
                }
                _loc_4 = _loc_6.zpp_inner.user_length;
                _loc_3.zpp_critical = true;
            }while (_loc_3.zpp_i < _loc_4 ? (true) : (_loc_3.zpp_next = ConvexResultIterator.zpp_pool, ConvexResultIterator.zpp_pool = _loc_3, _loc_3.zpp_inner = null, false))
            return this;
        }// end function

        public function filter(param1:Function) : ConvexResultList
        {
            var _loc_4:* = null as ConvexResult;
            var _loc_5:* = null;
            if (param1 == null)
            {
                throw "Error: Cannot select elements of list with null";
            }
            var _loc_3:* = 0;
            do
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
                ;
                _loc_5 = null;
                break;
                zpp_inner.valmod();
                if (zpp_inner.zip_length)
                {
                    zpp_inner.zip_length = false;
                    zpp_inner.user_length = zpp_inner.inner.length;
                }
            }while (_loc_3 < zpp_inner.user_length)
            return this;
        }// end function

        public function empty() : Boolean
        {
            return zpp_inner.inner.head == null;
        }// end function

        public function copy(param1:Boolean = false) : ConvexResultList
        {
            var _loc_4:* = null as ConvexResult;
            var _loc_5:* = 0;
            var _loc_6:* = null as ConvexResultList;
            var _loc_2:* = new ConvexResultList();
            zpp_inner.valmod();
            var _loc_3:* = ConvexResultIterator.get(this);
            do
            {
                
                _loc_3.zpp_critical = false;
                _loc_5 = _loc_3.zpp_i;
                (_loc_3.zpp_i + 1);
                _loc_4 = _loc_3.zpp_inner.at(_loc_5);
                _loc_2.push(param1 ? (throw "Error: " + "ConvexResult" + " is not a copyable type", null) : (_loc_4));
                _loc_3.zpp_inner.zpp_inner.valmod();
                _loc_6 = _loc_3.zpp_inner;
                _loc_6.zpp_inner.valmod();
                if (_loc_6.zpp_inner.zip_length)
                {
                    _loc_6.zpp_inner.zip_length = false;
                    _loc_6.zpp_inner.user_length = _loc_6.zpp_inner.inner.length;
                }
                _loc_5 = _loc_6.zpp_inner.user_length;
                _loc_3.zpp_critical = true;
            }while (_loc_3.zpp_i < _loc_5 ? (true) : (_loc_3.zpp_next = ConvexResultIterator.zpp_pool, ConvexResultIterator.zpp_pool = _loc_3, _loc_3.zpp_inner = null, false))
            return _loc_2;
        }// end function

        public function clear() : void
        {
            if (zpp_inner.immutable)
            {
                throw "Error: " + "ConvexResult" + "List is immutable";
            }
            if (zpp_inner.reverse_flag)
            {
                while (zpp_inner.inner.head != null)
                {
                    
                    pop();
                }
            }
            else
            {
                while (zpp_inner.inner.head != null)
                {
                    
                    shift();
                }
            }
            return;
        }// end function

        public function at(param1:int) : ConvexResult
        {
            zpp_inner.valmod();
            if (param1 >= 0)
            {
                zpp_inner.valmod();
                if (zpp_inner.zip_length)
                {
                    zpp_inner.zip_length = false;
                    zpp_inner.user_length = zpp_inner.inner.length;
                }
            }
            if (param1 >= zpp_inner.user_length)
            {
                throw "Error: Index out of bounds";
            }
            if (zpp_inner.reverse_flag)
            {
                zpp_inner.valmod();
                if (zpp_inner.zip_length)
                {
                    zpp_inner.zip_length = false;
                    zpp_inner.user_length = zpp_inner.inner.length;
                }
                param1 = (zpp_inner.user_length - 1) - param1;
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
            return zpp_inner.at_ite.elt;
        }// end function

        public function add(param1:ConvexResult) : Boolean
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

        public static function fromArray(param1:Array) : ConvexResultList
        {
            var _loc_4:* = null as ConvexResult;
            if (param1 == null)
            {
                throw "Error: Cannot convert null Array to Nape list";
            }
            var _loc_2:* = new ConvexResultList();
            var _loc_3:* = 0;
            while (_loc_3 < param1.length)
            {
                
                _loc_4 = param1[_loc_3];
                _loc_3++;
                if (!(_loc_4 is ConvexResult))
                {
                    throw "Error: Array contains non " + "ConvexResult" + " types.";
                }
                _loc_2.push(_loc_4);
            }
            return _loc_2;
        }// end function

        public static function fromVector(param1:Vector.<ConvexResult>) : ConvexResultList
        {
            var _loc_4:* = null as ConvexResult;
            if (param1 == null)
            {
                throw "Error: Cannot convert null Vector to Nape list";
            }
            var _loc_2:* = new ConvexResultList();
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
