package haxegame.scene
{
    import com.dango_itimi.as3_and_createjs.*;
    import com.dango_itimi.as3_and_createjs.display.*;
    import com.dango_itimi.as3_and_createjs.event.*;
    import com.dango_itimi.as3_and_createjs.layout.*;
    import com.dango_itimi.as3_and_createjs.utils.*;
    import com.dango_itimi.utils.*;
    import flash.*;
    import flash.display.*;
    import flash.net.*;
    import haxegame.achievement.*;
    import haxegame.save.*;
    import haxegame.text.*;

    public class GameOver extends Object
    {
        public var zombieScoreLine:ScoreLine;
        public var view:GameOverView;
        public var twitterButton:MouseEventChecker;
        public var titleButton:MouseEventChecker;
        public var retryButton:MouseEventChecker;
        public var resultScoreLine:ResultScoreLine;
        public var resultScore:int;
        public var resucuedZombieCount:int;
        public var resucuedHumanCount:int;
        public var record:Record;
        public var movieclip:IMovieClipUtil;
        public var mainFunction:Function;
        public var layer:IDisplayObjectContainer;
        public var humanScoreLine:ScoreLine;
        public var facebookButton:MouseEventChecker;
        public var achievementPlayer:AchievementPlayer;

        public function GameOver(param1:IDisplayObjectContainer = undefined, param2:AchievementPlayer = undefined) : void
        {
            var _loc_3:* = null as Record;
            if (Boot.skip_constructor)
            {
                return;
            }
            layer = param1;
            achievementPlayer = param2;
            if (Record.instance == null)
            {
                _loc_3 = new Record();
                Record.instance = _loc_3;
                record = _loc_3;
            }
            else
            {
                record = Record.instance;
            }
            view = new GameOverView();
            view.highScore.visible = false;
            movieclip = CommonClassSet.createMovieClipUtil(view);
            movieclip.mc.stop();
            view.resultScorePosition.visible = false;
            resultScoreLine = new ResultScoreLine(param1, view.resultScorePosition.x, view.resultScorePosition.y);
            var _loc_4:* = 6;
            view.zombieScorePosition.visible = false;
            zombieScoreLine = new ScoreLine(param1, view.zombieScorePosition.x, view.zombieScorePosition.y, _loc_4);
            view.humanScorePosition.visible = false;
            humanScoreLine = new ScoreLine(param1, view.humanScorePosition.x, view.humanScorePosition.y, _loc_4);
            retryButton = CommonClassSet.createMouseEventChecker(view.retryButton);
            titleButton = CommonClassSet.createMouseEventChecker(view.titleButton);
            twitterButton = CommonClassSet.createMouseEventChecker(view.twitterButton);
            facebookButton = CommonClassSet.createMouseEventChecker(view.facebookButton);
            return;
        }// end function

        public function waitToClick() : void
        {
            if (retryButton.isDowned())
            {
                mainFunction = finishToRetry;
            }
            else if (titleButton.isDowned())
            {
                mainFunction = finishToTitle;
            }
            else if (twitterButton.isDowned())
            {
                linkTwitter();
            }
            else if (facebookButton.isDowned())
            {
                linkFacebook();
            }
            return;
        }// end function

        public function show(param1:int, param2:int, param3:int) : void
        {
            var _loc_9:* = null as MovieClip;
            resultScore = param1;
            resucuedZombieCount = param2;
            resucuedHumanCount = param3;
            layer.addChild(view);
            movieclip.gotoFirstFrame();
            var _loc_4:* = resultScoreLine;
            var _loc_5:* = StringUtil.addZeroToHeadOfNumber(param1, 7);
            _loc_4.numericLine.createFromString(_loc_5);
            var _loc_6:* = _loc_4.numericLine;
            var _loc_7:* = 0;
            var _loc_8:* = _loc_6.graphicsSet;
            while (_loc_7 < _loc_8.length)
            {
                
                _loc_9 = _loc_8[_loc_7];
                _loc_7++;
                _loc_6.layer.addChild(_loc_9);
            }
            var _loc_10:* = zombieScoreLine;
            _loc_5 = StringUtil.addZeroToHeadOfNumber(param2, _loc_10.place);
            _loc_10.numericLine.createFromString(_loc_5);
            _loc_6 = _loc_10.numericLine;
            _loc_7 = 0;
            _loc_8 = _loc_6.graphicsSet;
            while (_loc_7 < _loc_8.length)
            {
                
                _loc_9 = _loc_8[_loc_7];
                _loc_7++;
                _loc_6.layer.addChild(_loc_9);
            }
            _loc_10 = humanScoreLine;
            _loc_5 = StringUtil.addZeroToHeadOfNumber(param3, _loc_10.place);
            _loc_10.numericLine.createFromString(_loc_5);
            _loc_6 = _loc_10.numericLine;
            _loc_7 = 0;
            _loc_8 = _loc_6.graphicsSet;
            while (_loc_7 < _loc_8.length)
            {
                
                _loc_9 = _loc_8[_loc_7];
                _loc_7++;
                _loc_6.layer.addChild(_loc_9);
            }
            checkAchievement();
            mainFunction = play;
            return;
        }// end function

        public function run() : void
        {
            mainFunction();
            retryButton.reset();
            titleButton.reset();
            twitterButton.reset();
            facebookButton.reset();
            return;
        }// end function

        public function play() : void
        {
            if (!movieclip.isLastFrame())
            {
                movieclip.nextFrame();
            }
            else
            {
                mainFunction = waitToClick;
            }
            return;
        }// end function

        public function linkTwitter() : void
        {
            var _loc_2:* = null as String;
            var _loc_1:* = "" + resultScore + " point get! ";
            if (record.isJapaneseLanguage())
            {
                _loc_2 = "ゾンビ " + resucuedZombieCount + "体、人間 " + resucuedHumanCount + "体をお届けしました。";
            }
            else
            {
                _loc_2 = "" + resucuedZombieCount + " zombies and " + resucuedZombieCount + " humans were delivered.";
            }
            var _loc_3:* = encodeURIComponent(_loc_1 + _loc_2 + "Zombie Delivery" + " " + ("http://www.deeg-entertainment.jp/" + "zombie_delivery/"));
            var _loc_4:* = "http://twitter.com/home?status=" + _loc_3;
            Lib.getURL(new URLRequest(_loc_4), "_blank");
            return;
        }// end function

        public function linkFacebook() : void
        {
            var _loc_1:* = encodeURIComponent("http://www.deeg-entertainment.jp/" + "zombie_delivery/");
            var _loc_2:* = encodeURIComponent("Zombie Delivery");
            var _loc_3:* = "http://www.facebook.com/sharer.php?u=" + _loc_1 + "&amp:t=" + _loc_2;
            Lib.getURL(new URLRequest(_loc_3), "_blank");
            return;
        }// end function

        public function isSelectedTitle() : Boolean
        {
            return Reflect.compareMethods(mainFunction, finishToTitle);
        }// end function

        public function isSelectedRetry() : Boolean
        {
            return Reflect.compareMethods(mainFunction, finishToRetry);
        }// end function

        public function hide() : void
        {
            var _loc_4:* = null as MovieClip;
            resultScoreLine.hide();
            var _loc_1:* = zombieScoreLine.numericLine;
            var _loc_2:* = 0;
            var _loc_3:* = _loc_1.graphicsSet;
            while (_loc_2 < _loc_3.length)
            {
                
                _loc_4 = _loc_3[_loc_2];
                _loc_2++;
                _loc_1.layer.removeChild(_loc_4);
            }
            _loc_1 = humanScoreLine.numericLine;
            _loc_2 = 0;
            _loc_3 = _loc_1.graphicsSet;
            while (_loc_2 < _loc_3.length)
            {
                
                _loc_4 = _loc_3[_loc_2];
                _loc_2++;
                _loc_1.layer.removeChild(_loc_4);
            }
            layer.removeChild(view);
            return;
        }// end function

        public function finishToTitle() : void
        {
            return;
        }// end function

        public function finishToRetry() : void
        {
            return;
        }// end function

        public function checkAchievement() : void
        {
            if (record.getPlayCountAchievement())
            {
                achievementPlayer.setAchievement(AchievementType.PLAY_COUNT);
            }
            else if (record.getPlayCountSecretAchievement())
            {
                achievementPlayer.setAchievement(AchievementType.PLAY_COUNT_SECRET);
            }
            if (record.getZombieAchievement())
            {
                achievementPlayer.setAchievement(AchievementType.ZOMBIE);
            }
            else if (record.getZombieSecretAchievement())
            {
                achievementPlayer.setAchievement(AchievementType.ZOMBIE_SECRET);
            }
            if (record.getHumanAchievement())
            {
                achievementPlayer.setAchievement(AchievementType.HUMAN);
            }
            else if (record.getHumanSecretAchievement())
            {
                achievementPlayer.setAchievement(AchievementType.HUMAN_SECRET);
            }
            return;
        }// end function

    }
}
