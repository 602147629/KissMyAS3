package nape.dynamics
{
    import flash.*;
    import zpp_nape.dynamics.*;
    import zpp_nape.util.*;

    final public class ContactIterator extends Object
    {
        public var zpp_next:ContactIterator;
        public var zpp_inner:ContactList;
        public var zpp_i:int;
        public var zpp_critical:Boolean;
        public static var zpp_pool:ContactIterator;

        public function ContactIterator() : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            zpp_next = null;
            zpp_critical = false;
            zpp_i = 0;
            zpp_inner = null;
            if (!ZPP_ContactList.internal)
            {
                throw "Error: Cannot instantiate " + "Contact" + "Iterator derp!";
            }
            return;
        }// end function

        public function next() : Contact
        {
            zpp_critical = false;
            var _loc_1:* = zpp_i;
            (zpp_i + 1);
            return zpp_inner.at(_loc_1);
        }// end function

        public function hasNext() : Boolean
        {
            var _loc_3:* = null as ZPP_Contact;
            var _loc_4:* = null as ZPP_Contact;
            zpp_inner.zpp_inner.valmod();
            var _loc_2:* = zpp_inner;
            _loc_2.zpp_inner.valmod();
            if (_loc_2.zpp_inner.zip_length)
            {
                _loc_2.zpp_inner.zip_length = false;
                _loc_2.zpp_inner.user_length = 0;
                _loc_3 = _loc_2.zpp_inner.inner.next;
                while (_loc_3 != null)
                {
                    
                    _loc_4 = _loc_3;
                    if (_loc_4.active)
                    {
                    }
                    if (_loc_4.arbiter.active)
                    {
                        (_loc_2.zpp_inner.user_length + 1);
                    }
                    _loc_3 = _loc_3.next;
                }
            }
            var _loc_1:* = _loc_2.zpp_inner.user_length;
            zpp_critical = true;
            if (zpp_i < _loc_1)
            {
                return true;
            }
            else
            {
                zpp_next = ContactIterator.zpp_pool;
                ContactIterator.zpp_pool = this;
                zpp_inner = null;
                return false;
            }
        }// end function

        public static function get(param1:ContactList) : ContactIterator
        {
            var _loc_2:* = null as ContactIterator;
            var _loc_3:* = null as ContactIterator;
            if (ContactIterator.zpp_pool == null)
            {
                ZPP_ContactList.internal = true;
                _loc_3 = new ContactIterator();
                ZPP_ContactList.internal = false;
                _loc_2 = _loc_3;
            }
            else
            {
                _loc_3 = ContactIterator.zpp_pool;
                ContactIterator.zpp_pool = _loc_3.zpp_next;
                _loc_2 = _loc_3;
            }
            _loc_2.zpp_i = 0;
            _loc_2.zpp_inner = param1;
            _loc_2.zpp_critical = false;
            return _loc_2;
        }// end function

    }
}
