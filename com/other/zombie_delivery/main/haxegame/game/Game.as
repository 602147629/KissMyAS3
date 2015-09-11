package haxegame.game
{
    import com.dango_itimi.as3_and_createjs.*;
    import com.dango_itimi.as3_and_createjs.display.*;
    import com.dango_itimi.as3_and_createjs.event.*;
    import flash.display.*;
    import haxe.ds.*;
    import haxegame.achievement.*;
    import haxegame.game.background.*;
    import haxegame.game.character.*;
    import haxegame.game.coin.*;
    import haxegame.game.collision.*;
    import haxegame.game.combo.*;
    import haxegame.game.effect.*;
    import haxegame.game.goal.*;
    import haxegame.game.human.*;
    import haxegame.game.level.*;
    import haxegame.game.life.*;
    import haxegame.game.pointer.*;
    import haxegame.game.score.*;
    import haxegame.game.turn.*;
    import haxegame.game.ui.*;
    import haxegame.game.wall.*;
    import haxegame.game.zombie.*;
    import haxegame.save.*;
    import haxegame.se.*;
    import nape.geom.*;
    import nape.space.*;

    public class Game extends Object
    {
        public var wallMap:IMap;
        public var uiLayer:IDisplayObjectContainer;
        public var stage:Stage;
        public var space:Space;
        public var score:Score;
        public var sceneLayer:IDisplayObjectContainer;
        public var record:Record;
        public var pointerLayer:IDisplayObjectContainer;
        public var pointer:Pointer;
        public var nextTurn:NextTurn;
        public var napeBackground:NapeBackground;
        public var mouseEventChecker:MouseEventChecker;
        public var menuButton:MenuButton;
        public var mainFunction:Function;
        public var lifeLayer:IDisplayObjectContainer;
        public var life:Life;
        public var level:Level;
        public var goalZombie:GoalZombie;
        public var goalHuman:GoalHuman;
        public var goal:Goal;
        public var gameLayer:IDisplayObjectContainer;
        public var gameGuideView:GameGuideView;
        public var frameRate:Number;
        public var effectSet:Array;
        public var debugLayer:IDisplayObjectContainer;
        public var comboSet:ComboSet;
        public var comboLayer:IDisplayObjectContainer;
        public var collisionListener:CollisionListener;
        public var collision:Collision;
        public var coinRunner:CoinRunner;
        public var characterRunner:CharacterRunner;
        public var characterLayer:IDisplayObjectContainer;
        public var backgroundLayer:IDisplayObjectContainer;
        public var background:Background;
        public var assetsParser:AssetsParser;
        public var achievementPlayer:AchievementPlayer;
        public static var GRAVITY:int;

        public function Game() : void
        {
            return;
        }// end function

        public function setView() : void
        {
            gameGuideView = new GameGuideView();
            menuButton = new MenuButton(mouseEventChecker, uiLayer);
            nextTurn = new NextTurn(sceneLayer);
            pointer = new Pointer(mouseEventChecker, pointerLayer);
            background = new Background(backgroundLayer);
            goal = new Goal(gameGuideView);
            goalZombie = new GoalZombie(backgroundLayer, gameGuideView.zombie);
            goalHuman = new GoalHuman(backgroundLayer, gameGuideView.human);
            assetsParser = new AssetsParser();
            collisionListener = new CollisionListener(space);
            napeBackground = new NapeBackground(assetsParser, space, collisionListener.callBackTypeForBallAndFloor, collisionListener.callBackTypeForCoinAndBackground);
            wallMap = new IntMap();
            effectSet = [];
            level = new Level();
            comboSet = new ComboSet(comboLayer);
            characterRunner = new CharacterRunner(characterLayer, space, assetsParser, level, nextTurn, collisionListener.callBackTypeForCharacterAndWall, collisionListener.callBackTypeForBallAndFloor);
            coinRunner = new CoinRunner(characterLayer, space, assetsParser, collisionListener.callBackTypeForCoinAndBackground, comboSet);
            score = new Score(uiLayer, gameGuideView, comboSet);
            life = new Life(lifeLayer, gameGuideView);
            collision = new Collision(collisionListener, characterRunner, coinRunner, wallMap, pointer, goal, score, life, goalZombie, goalHuman);
            return;
        }// end function

        public function setNapeSpace() : void
        {
            var _loc_1:* = new Vec2(0, 90);
            space = new Space(_loc_1);
            var _loc_2:* = space;
            var _loc_3:* = 0;
            if (_loc_3 != _loc_3)
            {
                throw "Error: Space::worldLinearDrag cannot be NaN";
            }
            _loc_2.zpp_inner.global_lin_drag = _loc_3;
            _loc_2 = space;
            _loc_3 = 0;
            if (_loc_3 != _loc_3)
            {
                throw "Error: Space::worldAngularDrag cannot be NaN";
            }
            _loc_2.zpp_inner.global_ang_drag = _loc_3;
            return;
        }// end function

        public function setNapeDebug() : void
        {
            return;
        }// end function

        public function runPointer() : void
        {
            pointer.mainFunction();
            if (pointer.existsDrawnLine())
            {
                WallMap.add(wallMap, space, pointer.drawnLine.id, pointer.drawnLine.firstPoint, pointer.drawnLine.endPoint, collisionListener.callBackTypeForCharacterAndWall);
                pointer.resetDrawnLine();
            }
            if (pointer.existsRemovedLine())
            {
                WallMap.deleteByLineId(wallMap, pointer.removedLineId);
                pointer.resetRemovedLineId();
            }
            return;
        }// end function

        public function runEffect() : void
        {
            if (collision.successPointSet.length > 0)
            {
                SoundMixer.playPowerUp();
            }
            if (collision.missPointSet.length > 0)
            {
                SoundMixer.playExplosion();
            }
            if (collision.bloodPointSet.length > 0)
            {
                SoundMixer.playOn();
            }
            EffectSet.run(effectSet);
            EffectSet.create(effectSet, characterLayer, collision.successPointSet, EffectType.SUCCESS);
            EffectSet.create(effectSet, characterLayer, collision.missPointSet, EffectType.MISS);
            EffectSet.create(effectSet, characterLayer, collision.bloodPointSet, EffectType.BLOOD);
            return;
        }// end function

        public function runCombo() : void
        {
            var _loc_3:* = null as CharacterType;
            var _loc_4:* = NaN;
            var _loc_5:* = NaN;
            if (collision.missPointSet.length > 0)
            {
                comboSet.resetCount();
            }
            var _loc_1:* = 0;
            var _loc_2:* = collision.successCharacterTypeSet;
            while (_loc_1 < _loc_2.length)
            {
                
                _loc_3 = _loc_2[_loc_1];
                _loc_1++;
                _loc_4 = 0;
                _loc_5 = 0;
                switch(_loc_3.index) branch count is:<1>[49, 15] default offset is:<11>;
                ;
                _loc_4 = gameGuideView.zombieCombo.x;
                _loc_5 = gameGuideView.zombieCombo.y;
                ;
                _loc_4 = gameGuideView.humanCombo.x;
                _loc_5 = gameGuideView.humanCombo.y;
                comboSet.create(_loc_4, _loc_5);
            }
            comboSet.run();
            return;
        }// end function

        public function run() : void
        {
            mainFunction();
            return;
        }// end function

        public function playNextTurnScene() : void
        {
            playCommon();
            nextTurn.run();
            if (life.isZero())
            {
                initializeGameOut();
            }
            else if (nextTurn.isFinished())
            {
                characterRunner.startNextLevel();
                mainFunction = play;
            }
            return;
        }// end function

        public function playNapeDebug() : void
        {
            return;
        }// end function

        public function playGameOut() : void
        {
            EffectSet.run(effectSet);
            goalZombie.run();
            goalHuman.run();
            if (goalZombie.isFinishedToPlayGameOut())
            {
                mainFunction = out;
            }
            return;
        }// end function

        public function playCommon() : void
        {
            space.step(1 / frameRate);
            playNapeDebug();
            collision.execute();
            runPointer();
            characterRunner.run();
            coinRunner.run();
            runEffect();
            runCombo();
            goalZombie.run();
            goalHuman.run();
            menuButton.run();
            checkAchievement();
            mouseEventChecker.reset();
            return;
        }// end function

        public function play() : void
        {
            playCommon();
            if (life.isZero())
            {
                initializeGameOut();
            }
            else if (characterRunner.isFinishedRushCreation())
            {
                initializeNextTurnScene();
            }
            else if (characterRunner.isFinishedLevelCreation())
            {
                level.increment();
                initializeNextTurnScene();
            }
            return;
        }// end function

        public function out() : void
        {
            return;
        }// end function

        public function isGameOver() : Boolean
        {
            return Reflect.compareMethods(mainFunction, out);
        }// end function

        public function initializeToPlay() : void
        {
            mouseEventChecker.reset();
            mainFunction = play;
            return;
        }// end function

        public function initializeNextTurnScene() : void
        {
            life.initialize();
            nextTurn.show(level.num);
            SoundMixer.playNextTurn();
            mainFunction = playNextTurnScene;
            return;
        }// end function

        public function initializeLayer() : void
        {
            backgroundLayer = CommonClassSet.createLayer();
            debugLayer = CommonClassSet.createLayer();
            lifeLayer = CommonClassSet.createLayer();
            sceneLayer = CommonClassSet.createLayer();
            characterLayer = CommonClassSet.createLayer();
            comboLayer = CommonClassSet.createLayer();
            pointerLayer = CommonClassSet.createLayer();
            uiLayer = CommonClassSet.createLayer();
            gameLayer.addChild(backgroundLayer);
            gameLayer.addChild(debugLayer);
            gameLayer.addChild(lifeLayer);
            gameLayer.addChild(sceneLayer);
            gameLayer.addChild(characterLayer);
            gameLayer.addChild(comboLayer);
            gameLayer.addChild(pointerLayer);
            gameLayer.addChild(uiLayer);
            return;
        }// end function

        public function initializeGameOut() : void
        {
            var _loc_1:* = null as BgmPlayer;
            (BgmPlayer.instance == null ? (_loc_1 = new BgmPlayer(), BgmPlayer.instance = _loc_1, _loc_1) : (BgmPlayer.instance)).stop();
            SoundMixer.playGameOut();
            goalZombie.initializeGameOut();
            goalHuman.initializeGameOut();
            record.updateScore(score.scoreLine.number, comboSet.maxCount, score.zombieCount, score.humanCount);
            mainFunction = playGameOut;
            return;
        }// end function

        public function initializeField(param1:IDisplayObjectContainer, param2:Stage, param3:MouseEventChecker, param4:Number, param5:AchievementPlayer) : void
        {
            var _loc_6:* = null as Record;
            achievementPlayer = param5;
            gameLayer = param1;
            frameRate = param4;
            stage = param2;
            mouseEventChecker = param3;
            if (Record.instance == null)
            {
                _loc_6 = new Record();
                Record.instance = _loc_6;
                record = _loc_6;
            }
            else
            {
                record = Record.instance;
            }
            return;
        }// end function

        public function initialize() : void
        {
            initializeLayer();
            setNapeSpace();
            setView();
            setNapeDebug();
            initializeToPlay();
            return;
        }// end function

        public function destroy() : void
        {
            WallMap.destroy(wallMap);
            characterRunner.destroy();
            coinRunner.destroy();
            napeBackground.destroy();
            pointer.destroy();
            collisionListener.destroy();
            EffectSet.destroy(effectSet);
            comboSet.destroy();
            menuButton.hide();
            return;
        }// end function

        public function checkAchievement() : void
        {
            if (record.getComboAchievement(comboSet.count))
            {
                achievementPlayer.setAchievement(AchievementType.COMBO);
            }
            else if (record.getComboSecretAchievement(comboSet.count))
            {
                achievementPlayer.setAchievement(AchievementType.COMBO_SECRET);
            }
            if (record.getScoreAchievement(score.scoreLine.number))
            {
                achievementPlayer.setAchievement(AchievementType.SCORE);
            }
            else if (record.getScoreSecretAchievement(score.scoreLine.number))
            {
                achievementPlayer.setAchievement(AchievementType.SCORE_SECRET);
            }
            return;
        }// end function

    }
}
