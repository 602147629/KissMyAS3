package zpp_nape.dynamics
{
    import flash.*;
    import nape.dynamics.*;
    import nape.geom.*;
    import zpp_nape.geom.*;
    import zpp_nape.util.*;

    public class ZPP_Contact extends Object
    {
        public var wrap_position:Vec2;
        public var stamp:int;
        public var py:Number;
        public var px:Number;
        public var pushmod:Boolean;
        public var posOnly:Boolean;
        public var outer:Contact;
        public var next:ZPP_Contact;
        public var modified:Boolean;
        public var length:int;
        public var inner:ZPP_IContact;
        public var hash:int;
        public var fresh:Boolean;
        public var elasticity:Number;
        public var dist:Number;
        public var arbiter:ZPP_Arbiter;
        public var active:Boolean;
        public var _inuse:Boolean;
        public static var internal:Boolean;
        public static var zpp_pool:ZPP_Contact;

        public function ZPP_Contact() : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            length = 0;
            pushmod = false;
            modified = false;
            _inuse = false;
            next = null;
            elasticity = 0;
            dist = 0;
            fresh = false;
            hash = 0;
            stamp = 0;
            posOnly = false;
            active = false;
            inner = null;
            arbiter = null;
            wrap_position = null;
            py = 0;
            px = 0;
            outer = null;
            inner = new ZPP_IContact();
            return;
        }// end function

        public function wrapper() : Contact
        {
            if (outer == null)
            {
                ZPP_Contact.internal = true;
                outer = new Contact();
                ZPP_Contact.internal = false;
                outer.zpp_inner = this;
            }
            return outer;
        }// end function

        public function try_remove(param1:ZPP_Contact) : Boolean
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

        public function splice(param1:ZPP_Contact, param2:int) : ZPP_Contact
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

        public function setbegin(param1:ZPP_Contact) : void
        {
            next = param1;
            modified = true;
            pushmod = true;
            return;
        }// end function

        public function reverse() : void
        {
            var _loc_3:* = null as ZPP_Contact;
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

        public function remove(param1:ZPP_Contact) : void
        {
            var _loc_5:* = null as ZPP_Contact;
            var _loc_6:* = null as ZPP_Contact;
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

        public function position_validate() : void
        {
            if (inactiveme())
            {
                throw "Error: Contact not currently in use";
            }
            wrap_position.zpp_inner.x = px;
            wrap_position.zpp_inner.y = py;
            return;
        }// end function

        public function pop_unsafe() : ZPP_Contact
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

        public function iterator_at(param1:int) : ZPP_Contact
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

        public function insert(param1:ZPP_Contact, param2:ZPP_Contact) : ZPP_Contact
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

        public function inlined_try_remove(param1:ZPP_Contact) : Boolean
        {
            var _loc_5:* = null as ZPP_Contact;
            var _loc_6:* = null as ZPP_Contact;
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

        public function inlined_remove(param1:ZPP_Contact) : void
        {
            var _loc_5:* = null as ZPP_Contact;
            var _loc_6:* = null as ZPP_Contact;
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

        public function inlined_pop_unsafe() : ZPP_Contact
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

        public function inlined_insert(param1:ZPP_Contact, param2:ZPP_Contact) : ZPP_Contact
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

        public function inlined_has(param1:ZPP_Contact) : Boolean
        {
            var _loc_4:* = null as ZPP_Contact;
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

        public function inlined_erase(param1:ZPP_Contact) : ZPP_Contact
        {
            var _loc_2:* = null as ZPP_Contact;
            var _loc_3:* = null as ZPP_Contact;
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

        public function inlined_add(param1:ZPP_Contact) : ZPP_Contact
        {
            param1._inuse = true;
            var _loc_2:* = param1;
            _loc_2.next = next;
            next = _loc_2;
            modified = true;
            (length + 1);
            return param1;
        }// end function

        public function inactiveme() : Boolean
        {
            if (active)
            {
            }
            if (arbiter != null)
            {
            }
            return !arbiter.active;
        }// end function

        public function has(param1:ZPP_Contact) : Boolean
        {
            var _loc_4:* = null as ZPP_Contact;
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

        public function getposition() : void
        {
            var _loc_5:* = null as Vec2;
            var _loc_6:* = false;
            var _loc_7:* = null as ZPP_Vec2;
            var _loc_1:* = this;
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_4:* = false;
            if (_loc_2 == _loc_2)
            {
            }
            if (_loc_3 != _loc_3)
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
                _loc_7.y = _loc_3;
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
                if (_loc_3 != _loc_3)
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
                if (_loc_5.zpp_inner.y != _loc_3)
                {
                    _loc_5.zpp_inner.x = _loc_2;
                    _loc_5.zpp_inner.y = _loc_3;
                    _loc_7 = _loc_5.zpp_inner;
                    if (_loc_7._invalidate != null)
                    {
                        _loc_7._invalidate(_loc_7);
                    }
                }
            }
            _loc_5.zpp_inner.weak = _loc_4;
            wrap_position = _loc_5;
            wrap_position.zpp_inner._inuse = true;
            wrap_position.zpp_inner._immutable = true;
            wrap_position.zpp_inner._validate = position_validate;
            return;
        }// end function

        public function front() : ZPP_Contact
        {
            return next;
        }// end function

        public function free() : void
        {
            arbiter = null;
            return;
        }// end function

        public function erase(param1:ZPP_Contact) : ZPP_Contact
        {
            var _loc_2:* = null as ZPP_Contact;
            var _loc_3:* = null as ZPP_Contact;
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

        public function elem() : ZPP_Contact
        {
            return this;
        }// end function

        public function clear() : void
        {
            return;
        }// end function

        public function begin() : ZPP_Contact
        {
            return next;
        }// end function

        public function back() : ZPP_Contact
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

        public function at(param1:int) : ZPP_Contact
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
            return;
        }// end function

        public function addAll(param1:ZPP_Contact) : void
        {
            var _loc_3:* = null as ZPP_Contact;
            var _loc_2:* = param1.next;
            while (_loc_2 != null)
            {
                
                _loc_3 = _loc_2;
                add(_loc_3);
                _loc_2 = _loc_2.next;
            }
            return;
        }// end function

        public function add(param1:ZPP_Contact) : ZPP_Contact
        {
            param1._inuse = true;
            var _loc_2:* = param1;
            _loc_2.next = next;
            next = _loc_2;
            modified = true;
            (length + 1);
            return param1;
        }// end function

    }
}
