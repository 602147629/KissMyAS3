package haxegame.game.coin
{
    import com.dango_itimi.as3_and_createjs.*;
    import com.dango_itimi.as3_and_createjs.display.*;
    import com.dango_itimi.as3_and_createjs.utils.*;
    import flash.*;
    import flash.display.*;
    import haxegame.se.*;

    public class Coin extends Object
    {
        public var type:int;
        public var soundPlayed:Boolean;
        public var movieclip:IMovieClipUtil;
        public var layer:IDisplayObjectContainer;
        public var count:int;
        public static var DELETE_COUNT:int;

        public function Coin(param1:IDisplayObjectContainer = undefined, param2:int = 0) : void
        {
            var _loc_3:* = null as MovieClip;
            if (Boot.skip_constructor)
            {
                return;
            }
            layer = param1;
            type = param2;
            switch(param2) branch count is:<200>[609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 613, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 631, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 649] default offset is:<609>;
            ;
            _loc_3 = new SmallView();
            ;
            _loc_3 = new MiddleView();
            ;
            _loc_3 = new BigView();
            movieclip = CommonClassSet.createMovieClipUtil(_loc_3);
            movieclip.mc.stop();
            param1.addChild(movieclip.mc);
            count = 0;
            return;
        }// end function

        public function playSound() : void
        {
            if (soundPlayed)
            {
                return;
            }
            var _loc_1:* = type;
            switch(_loc_1) branch count is:<200>[609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 613, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 624, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 609, 635] default offset is:<609>;
            ;
            SoundMixer.playCoinSmall();
            ;
            SoundMixer.playCoinMiddle();
            ;
            SoundMixer.playCoinBig();
            soundPlayed = true;
            return;
        }// end function

        public function isCountMax() : Boolean
        {
            return count >= 70;
        }// end function

        public function draw(param1:Number, param2:Number) : void
        {
            movieclip.mc.x = Math.floor(param1);
            movieclip.mc.y = Math.floor(param2);
            movieclip.loopFrame();
            (count + 1);
            return;
        }// end function

        public function destroy() : void
        {
            layer.removeChild(movieclip.mc);
            return;
        }// end function

    }
}
