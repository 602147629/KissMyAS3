package haxegame.achievement
{
    import com.dango_itimi.as3_and_createjs.*;
    import com.dango_itimi.as3_and_createjs.display.*;
    import com.dango_itimi.as3_and_createjs.utils.*;
    import flash.*;
    import flash.display.*;
    import haxegame.se.*;

    public class Achievement extends Object
    {
        public var movieclip:IMovieClipUtil;
        public var mainFunction:Function;
        public var layer:IDisplayObjectContainer;
        public var baseView:AchievementView;

        public function Achievement(param1:IDisplayObjectContainer = undefined, param2:AchievementType = undefined) : void
        {
            var _loc_3:* = null as DisplayObject;
            if (Boot.skip_constructor)
            {
                return;
            }
            layer = param1;
            baseView = new AchievementView();
            switch(param2.index) branch count is:<9>[39, 55, 71, 87, 103, 119, 135, 151, 167, 183] default offset is:<35>;
            ;
            _loc_3 = new ComboView();
            ;
            _loc_3 = new ScoreView();
            ;
            _loc_3 = new ZombieView();
            ;
            _loc_3 = new HumanView();
            ;
            _loc_3 = new PlayCountView();
            ;
            _loc_3 = new ComboSecretView();
            ;
            _loc_3 = new ScoreSecretView();
            ;
            _loc_3 = new ZombieSecretView();
            ;
            _loc_3 = new HumanSecretView();
            ;
            _loc_3 = new PlayCountSecretView();
            baseView.position.addChild(_loc_3);
            movieclip = CommonClassSet.createMovieClipUtil(baseView);
            movieclip.mc.stop();
            return;
        }// end function

        public function show() : void
        {
            SoundMixer.playClick();
            SoundMixer.playAchievement();
            layer.addChild(movieclip.mc);
            return;
        }// end function

        public function hide() : void
        {
            layer.removeChild(movieclip.mc);
            return;
        }// end function

    }
}
