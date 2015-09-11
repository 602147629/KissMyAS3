package haxegame.tutorial._Tutorial
{
    import com.dango_itimi.as3_and_createjs.*;
    import com.dango_itimi.as3_and_createjs.display.*;
    import com.dango_itimi.as3_and_createjs.event.*;
    import com.dango_itimi.as3_and_createjs.utils.*;
    import flash.display.*;
    import haxegame.save.*;

    public class Scene extends Object
    {
        public var mouseEventChecker:MouseEventChecker;
        public var mainFunction:Function;
        public var layer:IDisplayObjectContainer;
        public var language:IMovieClipUtil;

        public function Scene() : void
        {
            return;
        }// end function

        public function setLanguage(param1:MovieClip, param2:MovieClip) : void
        {
            var _loc_3:* = null as MovieClip;
            var _loc_5:* = null as Record;
            var _loc_4:* = (Record.instance == null ? (_loc_5 = new Record(), Record.instance = _loc_5, _loc_5) : (Record.instance)).saveData.language;
            var _loc_6:* = _loc_4;
            if (_loc_6 == "ja")
            {
                _loc_3 = param1;
            }
            else if (_loc_6 == "eng")
            {
                _loc_3 = param2;
                ;
            }
            language = CommonClassSet.createMovieClipUtil(_loc_3);
            return;
        }// end function

        public function run() : void
        {
            mainFunction();
            return;
        }// end function

        public function isFinished() : Boolean
        {
            return Reflect.compareMethods(mainFunction, finish);
        }// end function

        public function hideLanguage(param1:MovieClip, param2:MovieClip) : void
        {
            param1.stop();
            param1.visible = false;
            param2.stop();
            param2.visible = false;
            return;
        }// end function

        public function finish() : void
        {
            return;
        }// end function

    }
}
