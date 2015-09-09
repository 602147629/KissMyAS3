package lovefox.util
{

    public class XML2Object extends Object
    {
        private static var _noNumber:Boolean = false;

        public function XML2Object()
        {
            return;
        }// end function

        public static function toObj(param1, param2:Boolean = false)
        {
            _noNumber = param2;
            return parseNode(param1);
        }// end function

        private static function parseNode(param1:XML)
        {
            var _loc_3:* = undefined;
            var _loc_4:* = undefined;
            var _loc_7:* = undefined;
            var _loc_8:* = null;
            var _loc_2:* = {};
            var _loc_5:* = [];
            var _loc_6:* = {};
            _loc_3 = 0;
            while (_loc_3 < param1.children().length())
            {
                
                if (param1.children()[_loc_3].nodeKind() == "element" && String(param1.children()[_loc_3]) != "")
                {
                    if (_loc_6[param1.children()[_loc_3].name()] != true)
                    {
                        _loc_6[param1.children()[_loc_3].name()] = true;
                        _loc_5.push(param1.children()[_loc_3].name());
                    }
                }
                else if (param1.children()[_loc_3].nodeKind() == "text")
                {
                    if (_noNumber)
                    {
                        _loc_7 = String(param1.children()[_loc_3]);
                    }
                    else
                    {
                        _loc_7 = Number(param1.children()[_loc_3]);
                        if (isNaN(_loc_7))
                        {
                            _loc_7 = String(param1.children()[_loc_3]);
                        }
                    }
                    return _loc_7;
                }
                _loc_3 = _loc_3 + 1;
            }
            _loc_3 = 0;
            while (_loc_3 < _loc_5.length)
            {
                
                _loc_8 = param1[_loc_5[_loc_3]];
                if (_loc_8.length() == 1)
                {
                    _loc_2[_loc_5[_loc_3]] = parseNode(_loc_8[0]);
                }
                else if (_loc_8.length() > 1)
                {
                    _loc_2[_loc_5[_loc_3]] = [];
                    _loc_4 = 0;
                    while (_loc_4 < _loc_8.length())
                    {
                        
                        _loc_2[_loc_5[_loc_3]][_loc_4] = parseNode(_loc_8[_loc_4]);
                        _loc_4 = _loc_4 + 1;
                    }
                }
                _loc_3 = _loc_3 + 1;
            }
            return _loc_2;
        }// end function

    }
}
