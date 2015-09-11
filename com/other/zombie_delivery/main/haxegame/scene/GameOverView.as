package haxegame.scene
{
    import flash.*;
    import flash.display.*;

    dynamic public class GameOverView extends MovieClip
    {
        public var zombieScorePosition:MovieClip;
        public var twitterButton:MovieClip;
        public var titleButton:MovieClip;
        public var retryButton:MovieClip;
        public var resultScorePosition:MovieClip;
        public var humanScorePosition:MovieClip;
        public var highScore:MovieClip;
        public var facebookButton:MovieClip;

        public function GameOverView() : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            return;
        }// end function

    }
}
