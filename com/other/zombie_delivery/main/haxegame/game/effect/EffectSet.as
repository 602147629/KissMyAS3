package haxegame.game.effect
{
    import com.dango_itimi.as3_and_createjs.display.*;

    public class EffectSet extends Object
    {

        public function EffectSet() : void
        {
            return;
        }// end function

        public static function create(param1:Array, param2:IDisplayObjectContainer, param3:Array, param4:EffectType) : void
        {
            var _loc_6:* = null;
            var _loc_5:* = 0;
            while (_loc_5 < param3.length)
            {
                
                _loc_6 = param3[_loc_5];
                _loc_5++;
                param1.push(new Effect(param2, param4, _loc_6.x, _loc_6.y));
            }
            return;
        }// end function

        public static function run(param1:Array) : void
        {
            var _loc_3:* = null as Effect;
            var _loc_2:* = 0;
            while (_loc_2 < param1.length)
            {
                
                _loc_3 = param1[_loc_2];
                _loc_3.run();
                if (_loc_3.movieclip.isLastFrame())
                {
                    _loc_3.destroy();
                    param1.splice(_loc_2, 1);
                    _loc_2--;
                }
                _loc_2++;
            }
            return;
        }// end function

        public static function destroy(param1:Array) : void
        {
            var _loc_3:* = null as Effect;
            var _loc_2:* = 0;
            while (_loc_2 < param1.length)
            {
                
                _loc_3 = param1[_loc_2];
                _loc_2++;
                _loc_3.destroy();
            }
            return;
        }// end function

    }
}
