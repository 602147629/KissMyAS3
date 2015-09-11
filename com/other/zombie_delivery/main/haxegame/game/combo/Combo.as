package haxegame.game.combo
{
    import com.dango_itimi.as3_and_createjs.*;
    import com.dango_itimi.as3_and_createjs.display.*;
    import com.dango_itimi.as3_and_createjs.layout.*;
    import com.dango_itimi.as3_and_createjs.utils.*;
    import flash.*;
    import flash.display.*;
    import haxegame.text.*;

    public class Combo extends Object
    {
        public var movieclip:IMovieClipUtil;
        public var layer:IDisplayObjectContainer;
        public var comboLine:ComboLine;
        public static var RANDOM_POSITION_RANGE_X:int;
        public static var RANDOM_POSITION_RANGE_Y:int;

        public function Combo(param1:IDisplayObjectContainer = undefined, param2:Number = 0, param3:Number = 0, param4:int = 0) : void
        {
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_11:* = null as MovieClip;
            if (Boot.skip_constructor)
            {
                return;
            }
            layer = param1;
            movieclip = CommonClassSet.createMovieClipUtil(new ComboView());
            if (Math.random() > 0.5)
            {
                _loc_5 = 1;
            }
            else
            {
                _loc_5 = -1;
            }
            if (Math.random() > 0.5)
            {
                _loc_6 = 1;
            }
            else
            {
                _loc_6 = -1;
            }
            movieclip.mc.x = _loc_5 * Math.floor(Math.random() * 20) + param2;
            movieclip.mc.y = _loc_6 * Math.floor(Math.random() * 10) + param3;
            movieclip.mc.stop();
            param1.addChild(movieclip.mc);
            comboLine = new ComboLine(param1, movieclip.mc.x + 25, movieclip.mc.y + 25 - 7);
            var _loc_7:* = comboLine;
            _loc_7.numericLine.create(param4);
            var _loc_8:* = _loc_7.numericLine;
            var _loc_9:* = 0;
            var _loc_10:* = _loc_8.graphicsSet;
            while (_loc_9 < _loc_10.length)
            {
                
                _loc_11 = _loc_10[_loc_9];
                _loc_9++;
                _loc_8.layer.addChild(_loc_11);
            }
            return;
        }// end function

        public function run() : void
        {
            movieclip.nextFrame();
            return;
        }// end function

        public function destroy() : void
        {
            layer.removeChild(movieclip.mc);
            comboLine.hide();
            return;
        }// end function

    }
}
