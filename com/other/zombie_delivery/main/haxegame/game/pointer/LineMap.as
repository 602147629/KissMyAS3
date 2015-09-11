package haxegame.game.pointer
{
    import com.dango_itimi.as3_and_createjs.display.*;

    public class LineMap extends Object
    {

        public function LineMap() : void
        {
            return;
        }// end function

        public static function add(param1:IMap, param2:IDisplayObjectContainer, param3:int) : Line
        {
            var _loc_4:* = new Line(param2, param3);
            param1.h[param3] = _loc_4;
            return _loc_4;
        }// end function

        public static function clear(param1:IMap, param2:int) : void
        {
            var _loc_3:* = param1.h[param2];
            _loc_3.graphics.clear();
            param1.remove(param2);
            return;
        }// end function

        public static function removeOldestLine(param1:IMap) : int
        {
            var _loc_4:* = 0;
            var _loc_5:* = null as Line;
            var _loc_2:* = -1;
            var _loc_3:* = param1.keys();
            
            if (_loc_3.hasNext())
            {
                _loc_4 = _loc_3.next();
                _loc_5 = param1.h[_loc_4];
                if (_loc_2 != -1)
                {
                }
                if (_loc_5.id < _loc_2)
                {
                    _loc_2 = _loc_5.id;
                }
                ;
            }
            LineMap.clear(param1, _loc_2);
            return _loc_2;
        }// end function

        public static function destroy(param1:IMap, param2:IDisplayObjectContainer) : void
        {
            var _loc_4:* = 0;
            var _loc_5:* = null as Line;
            var _loc_3:* = param1.keys();
            
            if (_loc_3.hasNext())
            {
                _loc_4 = _loc_3.next();
                _loc_5 = param1.h[_loc_4];
                _loc_5.destroy(param2);
                ;
            }
            return;
        }// end function

    }
}
