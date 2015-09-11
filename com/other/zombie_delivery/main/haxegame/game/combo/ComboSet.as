package haxegame.game.combo
{
    import com.dango_itimi.as3_and_createjs.display.*;
    import flash.*;

    public class ComboSet extends Object
    {
        public var set:Array;
        public var maxCount:int;
        public var layer:IDisplayObjectContainer;
        public var count:int;
        public static var DISPLAY_COMBO_NUM:int;
        public static var SPECIAL_COUNT:int;

        public function ComboSet(param1:IDisplayObjectContainer = undefined) : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            layer = param1;
            set = [];
            initialize();
            return;
        }// end function

        public function run() : void
        {
            var _loc_2:* = null as Combo;
            var _loc_1:* = 0;
            while (_loc_1 < set.length)
            {
                
                _loc_2 = set[_loc_1];
                _loc_2.run();
                if (_loc_2.movieclip.isLastFrame())
                {
                    _loc_2.destroy();
                    set.splice(_loc_1, 1);
                    _loc_1--;
                }
                _loc_1++;
            }
            return;
        }// end function

        public function resetCount() : void
        {
            count = 0;
            return;
        }// end function

        public function isSpecialCount() : Boolean
        {
            if (count != 0)
            {
            }
            return count % 50 == 0;
        }// end function

        public function initialize() : void
        {
            count = 0;
            maxCount = 0;
            return;
        }// end function

        public function destroy() : void
        {
            var _loc_3:* = null as Combo;
            var _loc_1:* = 0;
            var _loc_2:* = set;
            while (_loc_1 < _loc_2.length)
            {
                
                _loc_3 = _loc_2[_loc_1];
                _loc_1++;
                _loc_3.destroy();
            }
            return;
        }// end function

        public function create(param1:Number, param2:Number) : void
        {
            (count + 1);
            if (maxCount < count)
            {
                maxCount = count;
            }
            if (count < 3)
            {
                return;
            }
            set.push(new Combo(layer, param1, param2, count));
            return;
        }// end function

    }
}
