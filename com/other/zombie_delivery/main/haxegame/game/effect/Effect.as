package haxegame.game.effect
{
    import com.dango_itimi.as3_and_createjs.*;
    import com.dango_itimi.as3_and_createjs.display.*;
    import com.dango_itimi.as3_and_createjs.utils.*;
    import flash.*;
    import flash.display.*;

    public class Effect extends Object
    {
        public var movieclip:IMovieClipUtil;
        public var layer:IDisplayObjectContainer;

        public function Effect(param1:IDisplayObjectContainer = undefined, param2:EffectType = undefined, param3:Number = 0, param4:Number = 0) : void
        {
            var _loc_5:* = null as MovieClip;
            if (Boot.skip_constructor)
            {
                return;
            }
            layer = param1;
            switch(param2.index) branch count is:<2>[37, 18, 56] default offset is:<14>;
            ;
            _loc_5 = new ExplosionView();
            ;
            _loc_5 = new SuccessView();
            ;
            _loc_5 = new BloodView();
            movieclip = CommonClassSet.createMovieClipUtil(_loc_5);
            movieclip.mc.x = Math.floor(param3);
            movieclip.mc.y = Math.floor(param4);
            movieclip.mc.stop();
            if (Type.enumEq(param2, EffectType.BLOOD))
            {
            }
            if (Math.random() > 0.5)
            {
                movieclip.mc.scaleX = movieclip.mc.scaleX * -1;
            }
            param1.addChild(movieclip.mc);
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
            return;
        }// end function

    }
}
