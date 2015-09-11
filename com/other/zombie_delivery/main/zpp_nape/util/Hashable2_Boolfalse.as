package zpp_nape.util
{
    import flash.*;

    public class Hashable2_Boolfalse extends Object
    {
        public var value:Boolean;
        public var next:Hashable2_Boolfalse;
        public var id:int;
        public var hnext:Hashable2_Boolfalse;
        public var di:int;
        public static var zpp_pool:Hashable2_Boolfalse;

        public function Hashable2_Boolfalse() : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            di = 0;
            id = 0;
            hnext = null;
            next = null;
            value = false;
            return;
        }// end function

        public function free() : void
        {
            return;
        }// end function

        public function alloc() : void
        {
            return;
        }// end function

        public static function get(param1:int, param2:int, param3:Boolean) : Hashable2_Boolfalse
        {
            var _loc_5:* = null as Hashable2_Boolfalse;
            if (Hashable2_Boolfalse.zpp_pool == null)
            {
                _loc_5 = new Hashable2_Boolfalse();
            }
            else
            {
                _loc_5 = Hashable2_Boolfalse.zpp_pool;
                Hashable2_Boolfalse.zpp_pool = _loc_5.next;
                _loc_5.next = null;
            }
            _loc_5.id = param1;
            _loc_5.di = param2;
            var _loc_4:* = _loc_5;
            _loc_4.value = param3;
            return _loc_4;
        }// end function

        public static function getpersist(param1:int, param2:int) : Hashable2_Boolfalse
        {
            var _loc_3:* = null as Hashable2_Boolfalse;
            if (Hashable2_Boolfalse.zpp_pool == null)
            {
                _loc_3 = new Hashable2_Boolfalse();
            }
            else
            {
                _loc_3 = Hashable2_Boolfalse.zpp_pool;
                Hashable2_Boolfalse.zpp_pool = _loc_3.next;
                _loc_3.next = null;
            }
            _loc_3.id = param1;
            _loc_3.di = param2;
            return _loc_3;
        }// end function

        public static function ordered_get(param1:int, param2:int, param3:Boolean) : Hashable2_Boolfalse
        {
            var _loc_4:* = null as Hashable2_Boolfalse;
            var _loc_5:* = null as Hashable2_Boolfalse;
            if (param1 <= param2)
            {
                if (Hashable2_Boolfalse.zpp_pool == null)
                {
                    _loc_5 = new Hashable2_Boolfalse();
                }
                else
                {
                    _loc_5 = Hashable2_Boolfalse.zpp_pool;
                    Hashable2_Boolfalse.zpp_pool = _loc_5.next;
                    _loc_5.next = null;
                }
                _loc_5.id = param1;
                _loc_5.di = param2;
                _loc_4 = _loc_5;
                _loc_4.value = param3;
                return _loc_4;
            }
            else
            {
                if (Hashable2_Boolfalse.zpp_pool == null)
                {
                    _loc_5 = new Hashable2_Boolfalse();
                }
                else
                {
                    _loc_5 = Hashable2_Boolfalse.zpp_pool;
                    Hashable2_Boolfalse.zpp_pool = _loc_5.next;
                    _loc_5.next = null;
                }
                _loc_5.id = param2;
                _loc_5.di = param1;
                _loc_4 = _loc_5;
                _loc_4.value = param3;
                return _loc_4;
            }
        }// end function

        public static function ordered_get_persist(param1:int, param2:int) : Hashable2_Boolfalse
        {
            var _loc_3:* = null as Hashable2_Boolfalse;
            if (param1 <= param2)
            {
                if (Hashable2_Boolfalse.zpp_pool == null)
                {
                    _loc_3 = new Hashable2_Boolfalse();
                }
                else
                {
                    _loc_3 = Hashable2_Boolfalse.zpp_pool;
                    Hashable2_Boolfalse.zpp_pool = _loc_3.next;
                    _loc_3.next = null;
                }
                _loc_3.id = param1;
                _loc_3.di = param2;
                return _loc_3;
            }
            else
            {
                if (Hashable2_Boolfalse.zpp_pool == null)
                {
                    _loc_3 = new Hashable2_Boolfalse();
                }
                else
                {
                    _loc_3 = Hashable2_Boolfalse.zpp_pool;
                    Hashable2_Boolfalse.zpp_pool = _loc_3.next;
                    _loc_3.next = null;
                }
                _loc_3.id = param2;
                _loc_3.di = param1;
                return _loc_3;
            }
        }// end function

    }
}
