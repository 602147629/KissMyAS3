package nape.dynamics
{
    import __AS3__.vec.*;
    import flash.*;
    import zpp_nape.dynamics.*;
    import zpp_nape.util.*;

    final public class ContactList extends Object
    {
        public var zpp_inner:ZPP_ContactList;

        public function ContactList() : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            zpp_inner = null;
            zpp_inner = new ZPP_ContactList();
            zpp_inner.outer = this;
            return;
        }// end function

        public function unshift(param1:Contact) : Boolean
        {
            var _loc_2:* = false;
            var _loc_3:* = null as ZPP_Contact;
            var _loc_4:* = null as ZPP_Contact;
            if (zpp_inner.immutable)
            {
                throw "Error: " + "Contact" + "List is immutable";
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
                        zpp_inner.valmod();
                        if (zpp_inner.zip_length)
                        {
                            zpp_inner.zip_length = false;
                            zpp_inner.user_length = 0;
                            _loc_3 = zpp_inner.inner.next;
                            while (_loc_3 != null)
                            {
                                
                                _loc_4 = _loc_3;
                                if (_loc_4.active)
                                {
                                }
                                if (_loc_4.arbiter.active)
                                {
                                    (zpp_inner.user_length + 1);
                                }
                                _loc_3 = _loc_3.next;
                            }
                        }
                        if (zpp_inner.user_length == 0)
                        {
                            zpp_inner.push_ite = null;
                        }
                        else
                        {
                            zpp_inner.valmod();
                            if (zpp_inner.zip_length)
                            {
                                zpp_inner.zip_length = false;
                                zpp_inner.user_length = 0;
                                _loc_3 = zpp_inner.inner.next;
                                while (_loc_3 != null)
                                {
                                    
                                    _loc_4 = _loc_3;
                                    if (_loc_4.active)
                                    {
                                    }
                                    if (_loc_4.arbiter.active)
                                    {
                                        (zpp_inner.user_length + 1);
                                    }
                                    _loc_3 = _loc_3.next;
                                }
                            }
                            zpp_inner.push_ite = zpp_inner.inner.iterator_at((zpp_inner.user_length - 1));
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
            var _loc_4:* = null as Contact;
            var _loc_5:* = 0;
            var _loc_6:* = null as ContactList;
            var _loc_7:* = null as ZPP_Contact;
            var _loc_8:* = null as ZPP_Contact;
            var _loc_1:* = "[";
            var _loc_2:* = true;
            zpp_inner.valmod();
            var _loc_3:* = ContactIterator.get(this);
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
                    _loc_6.zpp_inner.user_length = 0;
                    _loc_7 = _loc_6.zpp_inner.inner.next;
                    while (_loc_7 != null)
                    {
                        
                        _loc_8 = _loc_7;
                        if (_loc_8.active)
                        {
                        }
                        if (_loc_8.arbiter.active)
                        {
                            (_loc_6.zpp_inner.user_length + 1);
                        }
                        _loc_7 = _loc_7.next;
                    }
                }
                _loc_5 = _loc_6.zpp_inner.user_length;
                _loc_3.zpp_critical = true;
            }while (_loc_3.zpp_i < _loc_5 ? (true) : (_loc_3.zpp_next = ContactIterator.zpp_pool, ContactIterator.zpp_pool = _loc_3, _loc_3.zpp_inner = null, false))
            return _loc_1 + "]";
        }// end function

        public function shift() : Contact
        {
            var _loc_1:* = null as ZPP_Contact;
            var _loc_2:* = null as ZPP_Contact;
            var _loc_3:* = null as ZPP_Contact;
            var _loc_4:* = null as ZPP_Contact;
            var _loc_5:* = null as Contact;
            if (zpp_inner.immutable)
            {
                throw "Error: " + "Contact" + "List is immutable";
            }
            zpp_inner.modify_test();
            zpp_inner.valmod();
            if (zpp_inner.zip_length)
            {
                zpp_inner.zip_length = false;
                zpp_inner.user_length = 0;
                _loc_1 = zpp_inner.inner.next;
                while (_loc_1 != null)
                {
                    
                    _loc_2 = _loc_1;
                    if (_loc_2.active)
                    {
                    }
                    if (_loc_2.arbiter.active)
                    {
                        (zpp_inner.user_length + 1);
                    }
                    _loc_1 = _loc_1.next;
                }
            }
            if (zpp_inner.user_length == 0)
            {
                throw "Error: Cannot remove from empty list";
            }
            zpp_inner.valmod();
            _loc_1 = null;
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
                    zpp_inner.user_length = 0;
                    _loc_3 = zpp_inner.inner.next;
                    while (_loc_3 != null)
                    {
                        
                        _loc_4 = _loc_3;
                        if (_loc_4.active)
                        {
                        }
                        if (_loc_4.arbiter.active)
                        {
                            (zpp_inner.user_length + 1);
                        }
                        _loc_3 = _loc_3.next;
                    }
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
                        zpp_inner.user_length = 0;
                        _loc_3 = zpp_inner.inner.next;
                        while (_loc_3 != null)
                        {
                            
                            _loc_4 = _loc_3;
                            if (_loc_4.active)
                            {
                            }
                            if (_loc_4.arbiter.active)
                            {
                                (zpp_inner.user_length + 1);
                            }
                            _loc_3 = _loc_3.next;
                        }
                    }
                    _loc_2 = zpp_inner.inner.iterator_at(zpp_inner.user_length - 2);
                }
                if (_loc_2 == null)
                {
                    _loc_1 = zpp_inner.inner.next;
                }
                else
                {
                    _loc_1 = _loc_2.next;
                }
                _loc_5 = _loc_1.wrapper();
                if (zpp_inner.subber != null)
                {
                    zpp_inner.subber(_loc_5);
                }
                if (!zpp_inner.dontremove)
                {
                    zpp_inner.inner.erase(_loc_2);
                }
            }
            else
            {
                _loc_1 = zpp_inner.inner.next;
                _loc_5 = _loc_1.wrapper();
                if (zpp_inner.subber != null)
                {
                    zpp_inner.subber(_loc_5);
                }
                if (!zpp_inner.dontremove)
                {
                    zpp_inner.inner.pop();
                }
            }
            zpp_inner.invalidate();
            _loc_5 = _loc_1.wrapper();
            return _loc_5;
        }// end function

        public function remove(param1:Contact) : Boolean
        {
            var _loc_4:* = null as ZPP_Contact;
            if (zpp_inner.immutable)
            {
                throw "Error: " + "Contact" + "List is immutable";
            }
            zpp_inner.modify_test();
            zpp_inner.valmod();
            var _loc_2:* = false;
            var _loc_3:* = zpp_inner.inner.next;
            while (_loc_3 != null)
            {
                
                _loc_4 = _loc_3;
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

        public function push(param1:Contact) : Boolean
        {
            var _loc_2:* = false;
            var _loc_3:* = null as ZPP_Contact;
            var _loc_4:* = null as ZPP_Contact;
            if (zpp_inner.immutable)
            {
                throw "Error: " + "Contact" + "List is immutable";
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
                    zpp_inner.inner.add(param1.zpp_inner);
                }
                else
                {
                    if (zpp_inner.push_ite == null)
                    {
                        zpp_inner.valmod();
                        if (zpp_inner.zip_length)
                        {
                            zpp_inner.zip_length = false;
                            zpp_inner.user_length = 0;
                            _loc_3 = zpp_inner.inner.next;
                            while (_loc_3 != null)
                            {
                                
                                _loc_4 = _loc_3;
                                if (_loc_4.active)
                                {
                                }
                                if (_loc_4.arbiter.active)
                                {
                                    (zpp_inner.user_length + 1);
                                }
                                _loc_3 = _loc_3.next;
                            }
                        }
                        if (zpp_inner.user_length == 0)
                        {
                            zpp_inner.push_ite = null;
                        }
                        else
                        {
                            zpp_inner.valmod();
                            if (zpp_inner.zip_length)
                            {
                                zpp_inner.zip_length = false;
                                zpp_inner.user_length = 0;
                                _loc_3 = zpp_inner.inner.next;
                                while (_loc_3 != null)
                                {
                                    
                                    _loc_4 = _loc_3;
                                    if (_loc_4.active)
                                    {
                                    }
                                    if (_loc_4.arbiter.active)
                                    {
                                        (zpp_inner.user_length + 1);
                                    }
                                    _loc_3 = _loc_3.next;
                                }
                            }
                            zpp_inner.push_ite = zpp_inner.inner.iterator_at((zpp_inner.user_length - 1));
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

        public function pop() : Contact
        {
            var _loc_1:* = null as ZPP_Contact;
            var _loc_2:* = null as ZPP_Contact;
            var _loc_3:* = null as Contact;
            var _loc_4:* = null as ZPP_Contact;
            var _loc_5:* = null as ZPP_Contact;
            if (zpp_inner.immutable)
            {
                throw "Error: " + "Contact" + "List is immutable";
            }
            zpp_inner.modify_test();
            zpp_inner.valmod();
            if (zpp_inner.zip_length)
            {
                zpp_inner.zip_length = false;
                zpp_inner.user_length = 0;
                _loc_1 = zpp_inner.inner.next;
                while (_loc_1 != null)
                {
                    
                    _loc_2 = _loc_1;
                    if (_loc_2.active)
                    {
                    }
                    if (_loc_2.arbiter.active)
                    {
                        (zpp_inner.user_length + 1);
                    }
                    _loc_1 = _loc_1.next;
                }
            }
            if (zpp_inner.user_length == 0)
            {
                throw "Error: Cannot remove from empty list";
            }
            zpp_inner.valmod();
            _loc_1 = null;
            if (zpp_inner.reverse_flag)
            {
                _loc_1 = zpp_inner.inner.next;
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
                    zpp_inner.user_length = 0;
                    _loc_4 = zpp_inner.inner.next;
                    while (_loc_4 != null)
                    {
                        
                        _loc_5 = _loc_4;
                        if (_loc_5.active)
                        {
                        }
                        if (_loc_5.arbiter.active)
                        {
                            (zpp_inner.user_length + 1);
                        }
                        _loc_4 = _loc_4.next;
                    }
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
                        zpp_inner.user_length = 0;
                        _loc_4 = zpp_inner.inner.next;
                        while (_loc_4 != null)
                        {
                            
                            _loc_5 = _loc_4;
                            if (_loc_5.active)
                            {
                            }
                            if (_loc_5.arbiter.active)
                            {
                                (zpp_inner.user_length + 1);
                            }
                            _loc_4 = _loc_4.next;
                        }
                    }
                    _loc_2 = zpp_inner.inner.iterator_at(zpp_inner.user_length - 2);
                }
                if (_loc_2 == null)
                {
                    _loc_1 = zpp_inner.inner.next;
                }
                else
                {
                    _loc_1 = _loc_2.next;
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
            zpp_inner.invalidate();
            _loc_3 = _loc_1.wrapper();
            return _loc_3;
        }// end function

        public function merge(param1:ContactList) : void
        {
            var _loc_3:* = null as Contact;
            var _loc_4:* = 0;
            var _loc_5:* = null as ContactList;
            var _loc_6:* = null as ZPP_Contact;
            var _loc_7:* = null as ZPP_Contact;
            if (param1 == null)
            {
                throw "Error: Cannot merge with null list";
            }
            param1.zpp_inner.valmod();
            var _loc_2:* = ContactIterator.get(param1);
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
                    _loc_5.zpp_inner.user_length = 0;
                    _loc_6 = _loc_5.zpp_inner.inner.next;
                    while (_loc_6 != null)
                    {
                        
                        _loc_7 = _loc_6;
                        if (_loc_7.active)
                        {
                        }
                        if (_loc_7.arbiter.active)
                        {
                            (_loc_5.zpp_inner.user_length + 1);
                        }
                        _loc_6 = _loc_6.next;
                    }
                }
                _loc_4 = _loc_5.zpp_inner.user_length;
                _loc_2.zpp_critical = true;
            }while (_loc_2.zpp_i < _loc_4 ? (true) : (_loc_2.zpp_next = ContactIterator.zpp_pool, ContactIterator.zpp_pool = _loc_2, _loc_2.zpp_inner = null, false))
            return;
        }// end function

        public function iterator() : ContactIterator
        {
            zpp_inner.valmod();
            return ContactIterator.get(this);
        }// end function

        public function has(param1:Contact) : Boolean
        {
            zpp_inner.valmod();
            return zpp_inner.inner.has(param1.zpp_inner);
        }// end function

        public function get_length() : int
        {
            var _loc_1:* = null as ZPP_Contact;
            var _loc_2:* = null as ZPP_Contact;
            zpp_inner.valmod();
            if (zpp_inner.zip_length)
            {
                zpp_inner.zip_length = false;
                zpp_inner.user_length = 0;
                _loc_1 = zpp_inner.inner.next;
                while (_loc_1 != null)
                {
                    
                    _loc_2 = _loc_1;
                    if (_loc_2.active)
                    {
                    }
                    if (_loc_2.arbiter.active)
                    {
                        (zpp_inner.user_length + 1);
                    }
                    _loc_1 = _loc_1.next;
                }
            }
            return zpp_inner.user_length;
        }// end function

        public function foreach(param1:Function) : ContactList
        {
            var _loc_4:* = 0;
            var _loc_5:* = null;
            var _loc_6:* = null as ContactList;
            var _loc_7:* = null as ZPP_Contact;
            var _loc_8:* = null as ZPP_Contact;
            if (param1 == null)
            {
                throw "Error: Cannot execute null on list elements";
            }
            zpp_inner.valmod();
            var _loc_3:* = ContactIterator.get(this);
            do
            {
                
                _loc_3.zpp_critical = false;
                _loc_4 = _loc_3.zpp_i;
                (_loc_3.zpp_i + 1);
                this.param1(_loc_3.zpp_inner.at(_loc_4));
                ;
                _loc_5 = null;
                _loc_3.zpp_next = ContactIterator.zpp_pool;
                ContactIterator.zpp_pool = _loc_3;
                _loc_3.zpp_inner = null;
                break;
                _loc_3.zpp_inner.zpp_inner.valmod();
                _loc_6 = _loc_3.zpp_inner;
                _loc_6.zpp_inner.valmod();
                if (_loc_6.zpp_inner.zip_length)
                {
                    _loc_6.zpp_inner.zip_length = false;
                    _loc_6.zpp_inner.user_length = 0;
                    _loc_7 = _loc_6.zpp_inner.inner.next;
                    while (_loc_7 != null)
                    {
                        
                        _loc_8 = _loc_7;
                        if (_loc_8.active)
                        {
                        }
                        if (_loc_8.arbiter.active)
                        {
                            (_loc_6.zpp_inner.user_length + 1);
                        }
                        _loc_7 = _loc_7.next;
                    }
                }
                _loc_4 = _loc_6.zpp_inner.user_length;
                _loc_3.zpp_critical = true;
            }while (_loc_3.zpp_i < _loc_4 ? (true) : (_loc_3.zpp_next = ContactIterator.zpp_pool, ContactIterator.zpp_pool = _loc_3, _loc_3.zpp_inner = null, false))
            return this;
        }// end function

        public function filter(param1:Function) : ContactList
        {
            var _loc_4:* = null as Contact;
            var _loc_5:* = null;
            var _loc_6:* = null as ZPP_Contact;
            var _loc_7:* = null as ZPP_Contact;
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
                    zpp_inner.user_length = 0;
                    _loc_6 = zpp_inner.inner.next;
                    while (_loc_6 != null)
                    {
                        
                        _loc_7 = _loc_6;
                        if (_loc_7.active)
                        {
                        }
                        if (_loc_7.arbiter.active)
                        {
                            (zpp_inner.user_length + 1);
                        }
                        _loc_6 = _loc_6.next;
                    }
                }
            }while (_loc_3 < zpp_inner.user_length)
            return this;
        }// end function

        public function empty() : Boolean
        {
            var _loc_1:* = null as ZPP_Contact;
            var _loc_2:* = null as ZPP_Contact;
            zpp_inner.valmod();
            if (zpp_inner.zip_length)
            {
                zpp_inner.zip_length = false;
                zpp_inner.user_length = 0;
                _loc_1 = zpp_inner.inner.next;
                while (_loc_1 != null)
                {
                    
                    _loc_2 = _loc_1;
                    if (_loc_2.active)
                    {
                    }
                    if (_loc_2.arbiter.active)
                    {
                        (zpp_inner.user_length + 1);
                    }
                    _loc_1 = _loc_1.next;
                }
            }
            return zpp_inner.user_length == 0;
        }// end function

        public function copy(param1:Boolean = false) : ContactList
        {
            var _loc_4:* = null as Contact;
            var _loc_5:* = 0;
            var _loc_6:* = null as ContactList;
            var _loc_7:* = null as ZPP_Contact;
            var _loc_8:* = null as ZPP_Contact;
            var _loc_2:* = new ContactList();
            zpp_inner.valmod();
            var _loc_3:* = ContactIterator.get(this);
            do
            {
                
                _loc_3.zpp_critical = false;
                _loc_5 = _loc_3.zpp_i;
                (_loc_3.zpp_i + 1);
                _loc_4 = _loc_3.zpp_inner.at(_loc_5);
                _loc_2.push(param1 ? (throw "Error: " + "Contact" + " is not a copyable type", null) : (_loc_4));
                _loc_3.zpp_inner.zpp_inner.valmod();
                _loc_6 = _loc_3.zpp_inner;
                _loc_6.zpp_inner.valmod();
                if (_loc_6.zpp_inner.zip_length)
                {
                    _loc_6.zpp_inner.zip_length = false;
                    _loc_6.zpp_inner.user_length = 0;
                    _loc_7 = _loc_6.zpp_inner.inner.next;
                    while (_loc_7 != null)
                    {
                        
                        _loc_8 = _loc_7;
                        if (_loc_8.active)
                        {
                        }
                        if (_loc_8.arbiter.active)
                        {
                            (_loc_6.zpp_inner.user_length + 1);
                        }
                        _loc_7 = _loc_7.next;
                    }
                }
                _loc_5 = _loc_6.zpp_inner.user_length;
                _loc_3.zpp_critical = true;
            }while (_loc_3.zpp_i < _loc_5 ? (true) : (_loc_3.zpp_next = ContactIterator.zpp_pool, ContactIterator.zpp_pool = _loc_3, _loc_3.zpp_inner = null, false))
            return _loc_2;
        }// end function

        public function clear() : void
        {
            var _loc_1:* = null as ZPP_Contact;
            var _loc_2:* = null as ZPP_Contact;
            if (zpp_inner.immutable)
            {
                throw "Error: " + "Contact" + "List is immutable";
            }
            if (zpp_inner.reverse_flag)
            {
                do
                {
                    
                    pop();
                    zpp_inner.valmod();
                    if (zpp_inner.zip_length)
                    {
                        zpp_inner.zip_length = false;
                        zpp_inner.user_length = 0;
                        _loc_1 = zpp_inner.inner.next;
                        while (_loc_1 != null)
                        {
                            
                            _loc_2 = _loc_1;
                            if (_loc_2.active)
                            {
                            }
                            if (_loc_2.arbiter.active)
                            {
                                (zpp_inner.user_length + 1);
                            }
                            _loc_1 = _loc_1.next;
                        }
                    }
                }while (zpp_inner.user_length != 0)
            }
            else
            {
                do
                {
                    
                    shift();
                    zpp_inner.valmod();
                    if (zpp_inner.zip_length)
                    {
                        zpp_inner.zip_length = false;
                        zpp_inner.user_length = 0;
                        _loc_1 = zpp_inner.inner.next;
                        while (_loc_1 != null)
                        {
                            
                            _loc_2 = _loc_1;
                            if (_loc_2.active)
                            {
                            }
                            if (_loc_2.arbiter.active)
                            {
                                (zpp_inner.user_length + 1);
                            }
                            _loc_1 = _loc_1.next;
                        }
                    }
                }while (zpp_inner.user_length != 0)
            }
            return;
        }// end function

        public function at(param1:int) : Contact
        {
            var _loc_2:* = null as ZPP_Contact;
            var _loc_3:* = null as ZPP_Contact;
            zpp_inner.valmod();
            if (param1 >= 0)
            {
                zpp_inner.valmod();
                if (zpp_inner.zip_length)
                {
                    zpp_inner.zip_length = false;
                    zpp_inner.user_length = 0;
                    _loc_2 = zpp_inner.inner.next;
                    while (_loc_2 != null)
                    {
                        
                        _loc_3 = _loc_2;
                        if (_loc_3.active)
                        {
                        }
                        if (_loc_3.arbiter.active)
                        {
                            (zpp_inner.user_length + 1);
                        }
                        _loc_2 = _loc_2.next;
                    }
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
                    zpp_inner.user_length = 0;
                    _loc_2 = zpp_inner.inner.next;
                    while (_loc_2 != null)
                    {
                        
                        _loc_3 = _loc_2;
                        if (_loc_3.active)
                        {
                        }
                        if (_loc_3.arbiter.active)
                        {
                            (zpp_inner.user_length + 1);
                        }
                        _loc_2 = _loc_2.next;
                    }
                }
                param1 = (zpp_inner.user_length - 1) - param1;
            }
            if (param1 >= zpp_inner.at_index)
            {
            }
            if (zpp_inner.at_ite == null)
            {
                zpp_inner.at_index = 0;
                zpp_inner.at_ite = zpp_inner.inner.next;
                while (true)
                {
                    
                    _loc_2 = zpp_inner.at_ite;
                    if (_loc_2.active)
                    {
                    }
                    if (_loc_2.arbiter.active)
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
                    
                    _loc_2 = zpp_inner.at_ite;
                    if (_loc_2.active)
                    {
                    }
                    if (_loc_2.arbiter.active)
                    {
                        break;
                    }
                    zpp_inner.at_ite = zpp_inner.at_ite.next;
                }
            }
            return zpp_inner.at_ite.wrapper();
        }// end function

        public function add(param1:Contact) : Boolean
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

        public static function fromArray(param1:Array) : ContactList
        {
            var _loc_4:* = null as Contact;
            if (param1 == null)
            {
                throw "Error: Cannot convert null Array to Nape list";
            }
            var _loc_2:* = new ContactList();
            var _loc_3:* = 0;
            while (_loc_3 < param1.length)
            {
                
                _loc_4 = param1[_loc_3];
                _loc_3++;
                if (!(_loc_4 is Contact))
                {
                    throw "Error: Array contains non " + "Contact" + " types.";
                }
                _loc_2.push(_loc_4);
            }
            return _loc_2;
        }// end function

        public static function fromVector(param1:Vector.<Contact>) : ContactList
        {
            var _loc_4:* = null as Contact;
            if (param1 == null)
            {
                throw "Error: Cannot convert null Vector to Nape list";
            }
            var _loc_2:* = new ContactList();
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
