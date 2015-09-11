package haxegame.game.score
{
    import com.dango_itimi.as3_and_createjs.display.*;
    import com.dango_itimi.as3_and_createjs.layout.*;
    import com.dango_itimi.utils.*;
    import flash.*;
    import flash.display.*;
    import haxegame.game.*;
    import haxegame.game.combo.*;
    import haxegame.text.*;

    public class Score extends Object
    {
        public var zombieCount:int;
        public var scoreLine:ScoreLine;
        public var humanCount:int;
        public var comboSet:ComboSet;

        public function Score(param1:IDisplayObjectContainer = undefined, param2:GameGuideView = undefined, param3:ComboSet = undefined) : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            comboSet = param3;
            scoreLine = new ScoreLine(param1, param2.scorePosition.x, param2.scorePosition.y, 7);
            initialize();
            return;
        }// end function

        public function initialize() : void
        {
            scoreLine.initialize();
            scoreLine.show();
            zombieCount = 0;
            humanCount = 0;
            return;
        }// end function

        public function getBonus() : int
        {
            if (comboSet.count < 10)
            {
                return 0;
            }
            else if (comboSet.count < 30)
            {
                return 10;
            }
            else if (comboSet.count < 50)
            {
                return 30;
            }
            else if (comboSet.count < 100)
            {
                return 50;
            }
            else
            {
                return 100;
            }
        }// end function

        public function addZombieCount() : void
        {
            (zombieCount + 1);
            return;
        }// end function

        public function addHumanCount() : void
        {
            (humanCount + 1);
            return;
        }// end function

        public function add(param1:Array) : void
        {
            var _loc_4:* = 0;
            var _loc_9:* = null as MovieClip;
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            while (_loc_3 < param1.length)
            {
                
                _loc_4 = param1[_loc_3];
                _loc_3++;
                if (!(_loc_4 is Number))
                {
                    throw "Class cast error";
                }
                _loc_2 = _loc_2 + (_loc_4 + getBonus());
            }
            var _loc_5:* = scoreLine;
            _loc_5.number = _loc_5.number + _loc_2;
            var _loc_6:* = StringUtil.addZeroToHeadOfNumber(_loc_5.number, _loc_5.place);
            var _loc_7:* = _loc_5.numericLine;
            _loc_3 = 0;
            var _loc_8:* = _loc_7.graphicsSet;
            while (_loc_3 < _loc_8.length)
            {
                
                _loc_9 = _loc_8[_loc_3];
                _loc_3++;
                _loc_7.layer.removeChild(_loc_9);
            }
            _loc_5.numericLine.createFromString(_loc_6);
            _loc_7 = _loc_5.numericLine;
            _loc_3 = 0;
            _loc_8 = _loc_7.graphicsSet;
            while (_loc_3 < _loc_8.length)
            {
                
                _loc_9 = _loc_8[_loc_3];
                _loc_3++;
                _loc_7.layer.addChild(_loc_9);
            }
            return;
        }// end function

    }
}
