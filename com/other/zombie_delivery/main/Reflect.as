package 
{

    public class Reflect extends Object
    {

        public function Reflect() : void
        {
            return;
        }// end function

        public static function field(param1, param2:String)
        {
            var _loc_4:* = null;
            return param1[param2];
            ;
            _loc_4 = null;
            return null;
            return;
        }// end function

        public static function fields(param1) : Array
        {
            var _loc_4:* = null as String;
            if (param1 == null)
            {
                return [];
            }
            var _loc_2:* = 0;
            var _loc_3:* = [];
            while (param1 in _loc_2)
            {
                
                _loc_4 = param1[_loc_2];
                if (param1.hasOwnProperty(_loc_4))
                {
                    _loc_3.push(_loc_4);
                }
            }
            return _loc_3;
        }// end function

        public static function isFunction(param1) : Boolean
        {
            return typeof(param1) == "function";
        }// end function

        public static function compareMethods(param1, param2) : Boolean
        {
            return param1 == param2;
        }// end function

        public static function copy(param1:Object) : Object
        {
            var _loc_5:* = null as String;
            var _loc_6:* = null;
            var _loc_2:* = {};
            var _loc_3:* = 0;
            var _loc_4:* = Reflect.fields(param1);
            while (_loc_3 < _loc_4.length)
            {
                
                _loc_5 = _loc_4[_loc_3];
                _loc_3++;
                _loc_6 = Reflect.field(param1, _loc_5);
                _loc_2[_loc_5] = _loc_6;
            }
            return _loc_2;
        }// end function

    }
}
