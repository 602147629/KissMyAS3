package haxegame.game.character
{
    import com.dango_itimi.as3_and_createjs.*;
    import com.dango_itimi.as3_and_createjs.display.*;
    import com.dango_itimi.as3_and_createjs.utils.*;
    import flash.display.*;

    public class Character extends Object
    {
        public var weight:Number;
        public var type:CharacterType;
        public var movieclip:IMovieClipUtil;
        public var layer:IDisplayObjectContainer;

        public function Character() : void
        {
            return;
        }// end function

        public function initialize(param1:IDisplayObjectContainer, param2:CharacterType, param3:Number, param4:CharacterColorType) : void
        {
            layer = param1;
            type = param2;
            weight = param3;
            var _loc_5:* = createView(param3, param4);
            movieclip = CommonClassSet.createMovieClipUtil(_loc_5);
            movieclip.mc.stop();
            param1.addChild(movieclip.mc);
            return;
        }// end function

        public function draw(param1:Number, param2:Number) : void
        {
            movieclip.mc.x = Math.floor(param1);
            movieclip.mc.y = Math.floor(param2);
            movieclip.loopFrame();
            return;
        }// end function

        public function destroy() : void
        {
            layer.removeChild(movieclip.mc);
            return;
        }// end function

        public function createView(param1:Number, param2:CharacterColorType) : MovieClip
        {
            return null;
        }// end function

    }
}
