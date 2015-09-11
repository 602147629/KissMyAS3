package haxegame.game.wall
{
    import nape.callbacks.*;
    import nape.space.*;

    public class WallMap extends Object
    {

        public function WallMap() : void
        {
            return;
        }// end function

        public static function add(param1:IMap, param2:Space, param3:int, param4:Object, param5:Object, param6:CbType) : void
        {
            var _loc_7:* = new Wall(param2, param3, param4, param5, param6);
            param1.h[_loc_7.body.zpp_inner_i.id] = _loc_7;
            return;
        }// end function

        public static function delete(param1:IMap, param2:int) : void
        {
            param1.h[param2].destroy();
            param1.remove(param2);
            return;
        }// end function

        public static function deleteByLineId(param1:IMap, param2:int) : void
        {
            var _loc_4:* = 0;
            var _loc_5:* = null as Wall;
            var _loc_3:* = param1.keys();
            
            if (_loc_3.hasNext())
            {
                _loc_4 = _loc_3.next();
                _loc_5 = param1.h[_loc_4];
                if (_loc_5.lineId == param2)
                {
                    WallMap.delete(param1, _loc_5.body.zpp_inner_i.id);
                }
                else
                {
                    ;
                }
            }
            return;
        }// end function

        public static function destroy(param1:IMap) : void
        {
            var _loc_3:* = 0;
            var _loc_4:* = null as Wall;
            var _loc_2:* = param1.keys();
            
            if (_loc_2.hasNext())
            {
                _loc_3 = _loc_2.next();
                _loc_4 = param1.h[_loc_3];
                _loc_4.destroy();
                ;
            }
            param1 = null;
            return;
        }// end function

    }
}
