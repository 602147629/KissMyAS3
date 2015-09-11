package haxegame
{
    import com.dango_itimi.as3_and_createjs.*;
    import com.dango_itimi.as3_and_createjs.display.*;
    import com.dango_itimi.as3_and_createjs.event.*;
    import com.dango_itimi.as3_and_createjs.sound.*;
    import com.dango_itimi.as3_and_createjs.utils.*;
    import flash.display.*;
    import haxegame.achievement.*;
    import haxegame.game.*;
    import haxegame.scene.*;
    import haxegame.se.*;
    import haxegame.tutorial.*;

    public class Main extends Object
    {
        public var tutorial:Tutorial;
        public var title:Title;
        public var stageLayer:IContainerUtil;
        public var stage:Stage;
        public var setting:Setting;
        public var sceneLayer:IDisplayObjectContainer;
        public var rootLayer:IDisplayObjectContainer;
        public var nextFunctionOfMenu:Function;
        public var mouseEventChecker:MouseEventChecker;
        public var menu:Menu;
        public var mainFunction:Function;
        public var loadingView:LoadingView;
        public var gameOver:GameOver;
        public var gameMouseCheckLayer:IDisplayObjectContainer;
        public var gameLayer:IDisplayObjectContainer;
        public var gameData:GameData;
        public var gameClass:Class;
        public var game:Game;
        public var frameRate:Number;
        public var extraHeaderFooterLayer:IDisplayObjectContainer;
        public var bgmPlayer:BgmPlayer;
        public var achievementPlayer:AchievementPlayer;
        public var achievementLayer:IDisplayObjectContainer;

        public function Main() : void
        {
            return;
        }// end function

        public function test() : void
        {
            return;
        }// end function

        public function run(param1) : void
        {
            mainFunction();
            if (SoundMixer.soundEffectMap != null)
            {
                SoundMixer.soundEffectMap.run();
            }
            if (achievementPlayer != null)
            {
                achievementPlayer.run();
            }
            return;
        }// end function

        public function preload() : void
        {
            return;
        }// end function

        public function playTutorial() : void
        {
            tutorial.run();
            if (tutorial.isFinished())
            {
                destroyTutorial();
            }
            return;
        }// end function

        public function playTitleScene() : void
        {
            if (title.gameStartButton.isDowned())
            {
                bgmPlayer.stop();
                destroyTitleScene(initializeGame);
            }
            else if (title.menuButton.isDowned())
            {
                initializeMenu(playTitleScene);
            }
            else if (title.tutorialButton.isDowned())
            {
                initializeTutorial();
            }
            title.run();
            return;
        }// end function

        public function playSetting() : void
        {
            if (setting.backButton.isDowned())
            {
                destroySetting();
            }
            setting.run();
            return;
        }// end function

        public function playMenu() : void
        {
            if (menu.settingButton.isDowned())
            {
                initializeSetting();
            }
            else if (menu.gameDataButton.isDowned())
            {
                initializeGameData();
            }
            else if (menu.closeButton.isDowned())
            {
                destroyMenu();
            }
            menu.run();
            return;
        }// end function

        public function playGameOver() : void
        {
            gameOver.run();
            if (gameOver.isSelectedRetry())
            {
                destroyGameOver(initializeGame);
            }
            else if (gameOver.isSelectedTitle())
            {
                destroyGameOver(initializeTitleScene);
            }
            return;
        }// end function

        public function playGameData() : void
        {
            if (gameData.backButton.isDowned())
            {
                destroyGameData();
            }
            gameData.backButton.reset();
            return;
        }// end function

        public function playGameAndSetMenuButton() : void
        {
            game.menuButton.initialize();
            mainFunction = playGame;
            return;
        }// end function

        public function playGame() : void
        {
            game.run();
            if (game.isGameOver())
            {
                initializeGameOver();
            }
            else if (game.menuButton.isClicked())
            {
                initializeMenu(playGameAndSetMenuButton);
            }
            return;
        }// end function

        public function loadAssets() : void
        {
            return;
        }// end function

        public function initializeTutorial() : void
        {
            SoundMixer.playClick();
            tutorial.initialize();
            mainFunction = playTutorial;
            return;
        }// end function

        public function initializeToLoadAssets() : void
        {
            initializeChildToLoadAssets();
            loadingView = new LoadingView();
            rootLayer.addChild(loadingView);
            loadingView.text.visible = false;
            mainFunction = loadAssets;
            return;
        }// end function

        public function initializeTitleScene() : void
        {
            bgmPlayer.play1();
            title.show();
            mainFunction = playTitleScene;
            return;
        }// end function

        public function initializeSetting() : void
        {
            SoundMixer.playClick();
            setting.show();
            mainFunction = playSetting;
            return;
        }// end function

        public function initializePreload() : void
        {
            initializeChildPreload();
            mainFunction = preload;
            return;
        }// end function

        public function initializeMenu(param1:Function) : void
        {
            SoundMixer.playClick();
            nextFunctionOfMenu = param1;
            menu.show();
            mainFunction = playMenu;
            return;
        }// end function

        public function initializeMain() : void
        {
            initializeInstance();
            initializeTitleScene();
            return;
        }// end function

        public function initializeLayer() : void
        {
            stageLayer = CommonClassSet.createContainerUtil(stage);
            rootLayer = CommonClassSet.createLayer();
            stageLayer.com.dango_itimi.as3_and_createjs.utils:IContainerUtil::addChild(rootLayer);
            gameLayer = CommonClassSet.createLayer();
            gameMouseCheckLayer = CommonClassSet.createLayer();
            sceneLayer = CommonClassSet.createLayer();
            extraHeaderFooterLayer = CommonClassSet.createLayer();
            achievementLayer = CommonClassSet.createLayer();
            rootLayer.addChild(gameLayer);
            rootLayer.addChild(gameMouseCheckLayer);
            rootLayer.addChild(sceneLayer);
            rootLayer.addChild(extraHeaderFooterLayer);
            rootLayer.addChild(achievementLayer);
            return;
        }// end function

        public function initializeInstance() : void
        {
            var _loc_2:* = null as BgmPlayer;
            var _loc_1:* = new GameMouseCheckLayerArea(gameMouseCheckLayer);
            mouseEventChecker = CommonClassSet.createMouseEventChecker(stage);
            achievementPlayer = new AchievementPlayer(achievementLayer);
            new ExtraHeaderFooter(extraHeaderFooterLayer);
            menu = new Menu(sceneLayer);
            setting = new Setting(sceneLayer);
            gameData = new GameData(sceneLayer);
            gameOver = new GameOver(sceneLayer, achievementPlayer);
            title = new Title(sceneLayer);
            tutorial = new Tutorial(sceneLayer);
            game = Type.createEmptyInstance(gameClass);
            game.initializeField(gameLayer, stage, mouseEventChecker, frameRate, achievementPlayer);
            if (BgmPlayer.instance == null)
            {
                _loc_2 = new BgmPlayer();
                BgmPlayer.instance = _loc_2;
                bgmPlayer = _loc_2;
            }
            else
            {
                bgmPlayer = BgmPlayer.instance;
            }
            return;
        }// end function

        public function initializeGameOver() : void
        {
            bgmPlayer.stop();
            gameOver.show(game.score.scoreLine.number, game.score.zombieCount, game.score.humanCount);
            mainFunction = playGameOver;
            return;
        }// end function

        public function initializeGameData() : void
        {
            SoundMixer.playClick();
            gameData.show();
            mainFunction = playGameData;
            return;
        }// end function

        public function initializeGame() : void
        {
            SoundMixer.playClick();
            bgmPlayer.play2();
            game.initialize();
            mainFunction = playGame;
            return;
        }// end function

        public function initializeFree() : void
        {
            return;
        }// end function

        public function initializeChildToLoadAssets() : void
        {
            return;
        }// end function

        public function initializeChildPreload() : void
        {
            return;
        }// end function

        public function initialize(param1:Object) : void
        {
            initializeLayer();
            initializeFree();
            initializePreload();
            return;
        }// end function

        public function destroyTutorial() : void
        {
            title.hide();
            bgmPlayer.stop();
            initializeGame();
            return;
        }// end function

        public function destroyToLoadAssets() : void
        {
            rootLayer.removeChild(loadingView);
            initializeMain();
            return;
        }// end function

        public function destroyTitleScene(param1:Function) : void
        {
            title.hide();
            this.param1();
            return;
        }// end function

        public function destroySetting() : void
        {
            setting.hide();
            mainFunction = playMenu;
            return;
        }// end function

        public function destroyMenu() : void
        {
            menu.hide();
            mainFunction = nextFunctionOfMenu;
            return;
        }// end function

        public function destroyGameOver(param1:Function) : void
        {
            SoundMixer.playClick();
            gameOver.hide();
            game.destroy();
            this.param1();
            return;
        }// end function

        public function destroyGameData() : void
        {
            gameData.hide();
            mainFunction = playMenu;
            return;
        }// end function

    }
}
