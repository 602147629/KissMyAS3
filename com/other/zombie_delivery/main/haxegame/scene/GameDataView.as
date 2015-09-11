package haxegame.scene
{
    import flash.*;
    import flash.display.*;
    import haxegame.achievement.*;

    public class GameDataView extends Sprite
    {
        public var zombieSecretAchievement:ZombieSecretView;
        public var zombieScorePosition:MovieClip;
        public var zombieAchievement:ZombieView;
        public var scoreSecretAchievement:ScoreSecretView;
        public var scoreAchievement:ScoreView;
        public var playCountSecretAchievement:PlayCountSecretView;
        public var playCountAchievement:PlayCountView;
        public var maxComboScorePosition:MovieClip;
        public var humanSecretAchievement:HumanSecretView;
        public var humanScorePosition:MovieClip;
        public var humanAchievement:HumanView;
        public var highScorePosition:MovieClip;
        public var comboSecretAchievement:ComboSecretView;
        public var comboAchievement:ComboView;
        public var backButton:MovieClip;

        public function GameDataView() : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            return;
        }// end function

    }
}
