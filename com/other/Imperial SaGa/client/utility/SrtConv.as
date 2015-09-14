package utility
{

    public class SrtConv extends Object
    {
        private static const HALF_TO_FULL_MAP:Object = {537:12290, 537:12300, 537:12301, 538:12289, 538:12539, 538:12530, 538:12449, 538:12451, 538:12453, 538:12455, 538:12457, 538:12515, 538:12517, 539:12519, 539:12483, 539:12540, 539:12450, 539:12452, 539:12454, 539:12456, 539:12458, 539:12459, 539:12461, 540:12463, 540:12465, 540:12467, 540:12469, 540:12471, 540:12473, 540:12475, 540:12477, 540:12479, 540:12481, 541:12484, 541:12486, 541:12488, 541:12490, 541:12491, 541:12492, 541:12493, 541:12494, 541:12495, 541:12498, 542:12501, 542:12504, 542:12507, 542:12510, 542:12511, 542:12512, 542:12513, 542:12514, 542:12516, 542:12518, 543:12520, 543:12521, 543:12522, 543:12523, 543:12524, 543:12525, 543:12527, 543:12531, 543:12443, 543:12444};

        public function SrtConv()
        {
            return;
        }// end function

        public static function toZenkaku(param1:String) : String
        {
            var _loc_5:* = NaN;
            var _loc_2:* = "";
            var _loc_3:* = param1.length;
            var _loc_4:* = 0;
            while (_loc_4 < _loc_3)
            {
                
                _loc_5 = param1.charCodeAt(_loc_4);
                if (_loc_5 == 32)
                {
                    _loc_2 = _loc_2 + String.fromCharCode(12288);
                }
                else if (_loc_5 == 92)
                {
                    _loc_2 = _loc_2 + String.fromCharCode(65509);
                }
                else if (_loc_5 >= 33 && _loc_5 <= 126)
                {
                    _loc_2 = _loc_2 + String.fromCharCode(_loc_5 + 65248);
                }
                else
                {
                    _loc_2 = _loc_2 + param1.charAt(_loc_4);
                }
                _loc_4++;
            }
            _loc_2 = toZenKana(_loc_2);
            return _loc_2;
        }// end function

        private static function toPadding(param1:String) : String
        {
            var _loc_2:* = NaN;
            var _loc_3:* = [];
            var _loc_4:* = 0;
            var _loc_5:* = param1.length;
            while (_loc_4 < _loc_5)
            {
                
                _loc_2 = param1.charCodeAt(_loc_4);
                switch(true)
                {
                    case _loc_2 >= 12363 && _loc_2 <= 12386 && _loc_2 % 2 == 1:
                    case _loc_2 >= 12459 && _loc_2 <= 12482 && _loc_2 % 2 == 1:
                    case _loc_2 >= 12388 && _loc_2 <= 12393 && _loc_2 % 2 == 0:
                    case _loc_2 >= 12484 && _loc_2 <= 12489 && _loc_2 % 2 == 0:
                    {
                        _loc_3.push(_loc_2 + ({244:1}[param1.charCodeAt((_loc_4 + 1))] || 0));
                        if (_loc_3[(_loc_3.length - 1)] != _loc_2)
                        {
                            _loc_4 = _loc_4 + 1;
                        }
                        break;
                    }
                    case _loc_2 >= 12399 && _loc_2 <= 12413 && _loc_2 % 3 == 0:
                    case _loc_2 >= 12495 && _loc_2 <= 12509 && _loc_2 % 3 == 0:
                    {
                        _loc_3.push(_loc_2 + ({244:1, 244:2}[param1.charCodeAt((_loc_4 + 1))] || 0));
                        if (_loc_3[(_loc_3.length - 1)] != _loc_2)
                        {
                            _loc_4 = _loc_4 + 1;
                        }
                        break;
                    }
                    default:
                    {
                        _loc_3.push(_loc_2);
                        break;
                        break;
                    }
                }
                _loc_4 = _loc_4 + 1;
            }
            return String.fromCharCode.apply(null, _loc_3);
        }// end function

        private static function toZenKana(param1:String) : String
        {
            var _loc_2:* = 0;
            var _loc_3:* = [];
            var _loc_4:* = HALF_TO_FULL_MAP;
            var _loc_5:* = 0;
            var _loc_6:* = param1.length;
            while (_loc_5 < _loc_6)
            {
                
                _loc_2 = param1.charCodeAt(_loc_5);
                _loc_3[_loc_5] = _loc_4[_loc_2] || _loc_2;
                _loc_5 = _loc_5 + 1;
            }
            return String.fromCharCode.apply(null, _loc_3);
        }// end function

    }
}
