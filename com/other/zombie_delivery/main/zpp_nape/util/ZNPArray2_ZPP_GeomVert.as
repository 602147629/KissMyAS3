package zpp_nape.util
{
    import __AS3__.vec.*;
    import flash.*;
    import zpp_nape.geom.*;

    public class ZNPArray2_ZPP_GeomVert extends Object
    {
        public var width:int;
        public var total:int;
        public var list:Vector.<ZPP_GeomVert>;

        public function ZNPArray2_ZPP_GeomVert(param1:int = 0, param2:int = 0) : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            total = 0;
            width = 0;
            list = null;
            width = param1;
            total = param1 * param2;
            list = new Vector.<ZPP_GeomVert>(total, true);
            return;
        }// end function

        public function set(param1:int, param2:int, param3:ZPP_GeomVert) : ZPP_GeomVert
        {
            var _loc_4:* = param3;
            list[param2 * width + param1] = param3;
            return _loc_4;
        }// end function

        public function resize(param1:int, param2:int, param3:ZPP_GeomVert) : void
        {
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_4:* = param1 * param2;
            if (_loc_4 > total)
            {
                _loc_5 = 0;
                _loc_6 = total;
                while (_loc_5 < _loc_6)
                {
                    
                    _loc_5++;
                    _loc_7 = _loc_5;
                    list[_loc_7] = param3;
                }
                _loc_5 = _loc_4;
                total = _loc_5;
                list = new Vector.<ZPP_GeomVert>(_loc_5, true);
            }
            width = param1;
            _loc_5 = 0;
            _loc_6 = param1 * param2;
            while (_loc_5 < _loc_6)
            {
                
                _loc_5++;
                _loc_7 = _loc_5;
                list[_loc_7] = param3;
            }
            return;
        }// end function

        public function get(param1:int, param2:int) : ZPP_GeomVert
        {
            return list[param2 * width + param1];
        }// end function

    }
}
