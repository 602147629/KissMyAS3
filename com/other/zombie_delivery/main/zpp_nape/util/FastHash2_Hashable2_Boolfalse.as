package zpp_nape.util
{
    import __AS3__.vec.*;
    import flash.*;

    public class FastHash2_Hashable2_Boolfalse extends Object
    {
        public var table:Vector.<Hashable2_Boolfalse>;
        public var cnt:int;

        public function FastHash2_Hashable2_Boolfalse() : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            cnt = 0;
            table = null;
            cnt = 0;
            table = new Vector.<Hashable2_Boolfalse>(1048576, true);
            return;
        }// end function

        public function remove(param1:Hashable2_Boolfalse) : void
        {
            var _loc_4:* = null as Hashable2_Boolfalse;
            var _loc_2:* = param1.id * 106039 + param1.di & 1048575;
            var _loc_3:* = table[_loc_2];
            if (_loc_3 == param1)
            {
                table[_loc_2] = _loc_3.hnext;
            }
            else if (_loc_3 != null)
            {
                do
                {
                    
                    _loc_4 = _loc_3;
                    _loc_3 = _loc_3.hnext;
                    if (_loc_3 != null)
                    {
                    }
                }while (_loc_3 != param1)
                _loc_4.hnext = _loc_3.hnext;
            }
            param1.hnext = null;
            (cnt - 1);
            return;
        }// end function

        public function ordered_get(param1:int, param2:int) : Hashable2_Boolfalse
        {
            var _loc_3:* = 0;
            if (param1 > param2)
            {
                _loc_3 = param1;
                param1 = param2;
                param2 = _loc_3;
            }
            var _loc_4:* = table[param1 * 106039 + param2 & 1048575];
            if (_loc_4 == null)
            {
                return null;
            }
            else
            {
                if (_loc_4.id == param1)
                {
                }
                if (_loc_4.di == param2)
                {
                    return _loc_4;
                }
                else
                {
                    do
                    {
                        
                        _loc_4 = _loc_4.hnext;
                        if (_loc_4 != null)
                        {
                            if (_loc_4.id == param1)
                            {
                            }
                        }
                    }while (_loc_4.di != param2)
                    return _loc_4;
                }
            }
        }// end function

        public function maybeAdd(param1:Hashable2_Boolfalse) : void
        {
            var _loc_2:* = param1.id * 106039 + param1.di & 1048575;
            var _loc_3:* = table[_loc_2];
            var _loc_4:* = true;
            if (_loc_3 == null)
            {
                table[_loc_2] = param1;
                param1.hnext = null;
            }
            else if (_loc_4)
            {
                param1.hnext = _loc_3.hnext;
                _loc_3.hnext = param1;
            }
            if (_loc_4)
            {
                (cnt + 1);
            }
            return;
        }// end function

        public function hash(param1:int, param2:int) : int
        {
            return param1 * 106039 + param2 & 1048575;
        }// end function

        public function has(param1:int, param2:int) : Boolean
        {
            var _loc_3:* = table[param1 * 106039 + param2 & 1048575];
            if (_loc_3 == null)
            {
                return false;
            }
            else
            {
                if (_loc_3.id == param1)
                {
                }
                if (_loc_3.di == param2)
                {
                    return true;
                }
                else
                {
                    do
                    {
                        
                        _loc_3 = _loc_3.hnext;
                        if (_loc_3 != null)
                        {
                            if (_loc_3.id == param1)
                            {
                            }
                        }
                    }while (_loc_3.di != param2)
                    return _loc_3 != null;
                }
            }
        }// end function

        public function get(param1:int, param2:int) : Hashable2_Boolfalse
        {
            var _loc_3:* = table[param1 * 106039 + param2 & 1048575];
            if (_loc_3 == null)
            {
                return null;
            }
            else
            {
                if (_loc_3.id == param1)
                {
                }
                if (_loc_3.di == param2)
                {
                    return _loc_3;
                }
                else
                {
                    do
                    {
                        
                        _loc_3 = _loc_3.hnext;
                        if (_loc_3 != null)
                        {
                            if (_loc_3.id == param1)
                            {
                            }
                        }
                    }while (_loc_3.di != param2)
                    return _loc_3;
                }
            }
        }// end function

        public function empty() : Boolean
        {
            return cnt == 0;
        }// end function

        public function clear() : void
        {
            var _loc_3:* = 0;
            var _loc_4:* = null as Hashable2_Boolfalse;
            var _loc_5:* = null as Hashable2_Boolfalse;
            var _loc_1:* = 0;
            var _loc_2:* = table.length;
            while (_loc_1 < _loc_2)
            {
                
                _loc_1++;
                _loc_3 = _loc_1;
                _loc_4 = table[_loc_3];
                if (_loc_4 == null)
                {
                    continue;
                }
                while (_loc_4 != null)
                {
                    
                    _loc_5 = _loc_4.hnext;
                    _loc_4.hnext = null;
                    _loc_4 = _loc_5;
                }
                table[_loc_3] = null;
            }
            return;
        }// end function

        public function add(param1:Hashable2_Boolfalse) : void
        {
            var _loc_2:* = param1.id * 106039 + param1.di & 1048575;
            var _loc_3:* = table[_loc_2];
            if (_loc_3 == null)
            {
                table[_loc_2] = param1;
                param1.hnext = null;
            }
            else
            {
                param1.hnext = _loc_3.hnext;
                _loc_3.hnext = param1;
            }
            (cnt + 1);
            return;
        }// end function

    }
}
