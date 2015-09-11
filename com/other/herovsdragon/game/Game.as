package herovsdragon.game
{
    import Box2D.Common.Math.*;
    import Box2D.Dynamics.*;
    import com.dango_itimi.box2d.*;
    import com.dango_itimi.box2d.material.*;
    import com.dango_itimi.events.core.*;
    import com.dango_itimi.events.mouse.*;
    import flash.display.*;
    import flash.geom.*;
    import herovsdragon.game.background.*;
    import herovsdragon.game.box2d.view.*;
    import herovsdragon.game.char.*;
    import herovsdragon.game.collision.*;
    import herovsdragon.game.dragon.*;
    import herovsdragon.game.dragon.damage.*;
    import herovsdragon.game.dragon.fire.*;
    import herovsdragon.game.dragon.stomp.*;
    import herovsdragon.game.hero.*;
    import herovsdragon.game.hero.hiteffect.*;
    import herovsdragon.game.loader.*;
    import herovsdragon.game.scene.*;
    import herovsdragon.game.se.*;
    import herovsdragon.game.ui.font_effect.*;
    import herovsdragon.game.ui.life.*;
    import herovsdragon.game.ui.time.*;

    public class Game extends Object
    {
        private var mainFunction:Function;
        private var container:Sprite;
        private var keyChecker:KeyChecker;
        private var clickChecker:ClickChecker;
        private var dragChecker:DragChecker;
        private var dragCheckerForRight:DragChecker;
        private var viewLoader:ViewLoader;
        private var bgmLoader:BgmLoader;
        private var gameLayer:Sprite;
        private var debugLayer:Sprite;
        private var viewLayer:Sprite;
        private var fontEffectLayer:Sprite;
        private var uiLayer:Sprite;
        private var backgroundLayer:Sprite;
        private var playerLayer:Sprite;
        private var enemyLayer:Sprite;
        private var bgm:BGM;
        private var world:b2World;
        private var gameView:GameView;
        private var box2dView:Box2DView;
        private var box2dViewParser:ViewParser;
        private var soundEffectMap:SoundEffectMap;
        private var background:Background;
        private var lifeForPlayer:Life;
        private var hero:Hero;
        private var dragon:Dragon;
        private var dragonColorChanger:CharacterColorChanger;
        private var hitted:Boolean;
        private var fireBreath:FireBreath;
        private var fireLayer:Sprite;
        private var contactParser:ContactParser;
        private var heroColorChanger:CharacterColorChanger;
        private var stompEffect:StompEffect;
        private var fireExplosion:FireExplosion;
        private var effectLayer:Sprite;
        private var bladeDamageEffect:BladeDamageEffect;
        private var gameOverScene:GameOverScene;
        private var gameClearScene:GameClearScene;
        private var gameTime:GameTime;
        private var bestTimeStorage:BestTimeStorage;
        private var lifeForEnemy:LifeForEnemy;
        private var lifeGage:LifeGage;
        private var heroHitEffectMap:HitEffectMap;
        private var fontEffectBehindLayer:Sprite;
        private var fontEffectViewer:FontEffectViewer;
        private static var FRAME_RATE:uint;
        private static const GRAVITY_Y:Number = 10;
        private static const BOX2D_SCALE:uint = 10;

        public function Game(param1:Sprite, param2:KeyChecker, param3:ClickChecker, param4:DragChecker, param5:DragChecker)
        {
            this.dragCheckerForRight = param5;
            this.dragChecker = param4;
            this.clickChecker = param3;
            this.keyChecker = param2;
            this.container = param1;
            this.viewLoader = new ViewLoader();
            this.bgmLoader = new BgmLoader();
            this.initializeLayer();
            this.mainFunction = this.waitForViewLoaded;
            return;
        }// end function

        private function initializeLayer() : void
        {
            this.gameLayer = new Sprite();
            this.gameLayer.focusRect = false;
            this.container.addChild(this.gameLayer);
            this.gameLayer.mask = new Mask();
            this.debugLayer = new Sprite();
            this.viewLayer = new Sprite();
            this.fontEffectBehindLayer = new Sprite();
            this.fontEffectLayer = new Sprite();
            this.uiLayer = new Sprite();
            this.gameLayer.addChild(this.viewLayer);
            this.gameLayer.addChild(this.fontEffectBehindLayer);
            this.gameLayer.addChild(this.fontEffectLayer);
            this.gameLayer.addChild(this.uiLayer);
            this.backgroundLayer = new Sprite();
            this.playerLayer = new Sprite();
            this.enemyLayer = new Sprite();
            this.fireLayer = new Sprite();
            this.effectLayer = new Sprite();
            this.viewLayer.addChild(this.backgroundLayer);
            this.viewLayer.addChild(this.fireLayer);
            this.viewLayer.addChild(this.enemyLayer);
            this.viewLayer.addChild(this.playerLayer);
            this.viewLayer.addChild(this.effectLayer);
            return;
        }// end function

        public function run() : void
        {
            this.mainFunction();
            return;
        }// end function

        private function waitForViewLoaded() : void
        {
            if (this.viewLoader.run())
            {
                this.mainFunction = this.initializeForSoundLoaded;
            }
            return;
        }// end function

        private function initializeForSoundLoaded() : void
        {
            this.bgmLoader.initialize();
            this.mainFunction = this.waitForSoundLoaded;
            return;
        }// end function

        private function waitForSoundLoaded() : void
        {
            this.bgmLoader.run();
            if (this.bgmLoader.checkFinished())
            {
                this.finishForSoundLoaded();
            }
            return;
        }// end function

        private function finishForSoundLoaded() : void
        {
            this.bgm = new BGM(this.bgmLoader);
            this.bgm.play();
            this.mainFunction = this.finishForLoaded;
            return;
        }// end function

        private function finishForLoaded() : void
        {
            try
            {
                this.container.parent.parent["nowLoading"].visible = false;
            }
            catch (e:Error)
            {
            }
            this.initializeBox2D();
            return;
        }// end function

        private function initializeBox2D() : void
        {
            FRAME_RATE = this.container.stage.frameRate;
            this.world = new b2World(new b2Vec2(0, GRAVITY_Y), true);
            this.initializeView();
            this.initializeGame();
            this.initializeEvent();
            this.initializeBallAfterEventCreated();
            this.initializeUI();
            this.initializeOnViewLayer();
            this.initializeScene();
            this.initializeDebug();
            this.initializeForReadyScene();
            return;
        }// end function

        private function initializeView() : void
        {
            this.gameView = new GameView();
            this.box2dView = new Box2DView();
            this.box2dViewParser = new ViewParser(new ChunkSetParameter(), this.box2dView);
            this.box2dViewParser.changeToMaterial(this.world, BOX2D_SCALE);
            return;
        }// end function

        private function initializeGame() : void
        {
            this.soundEffectMap = new SoundEffectMap();
            this.fontEffectViewer = new FontEffectViewer(this.fontEffectBehindLayer, this.fontEffectLayer);
            Hero.initializeStatic(this.world, BOX2D_SCALE, FRAME_RATE, GRAVITY_Y, this.container, this.keyChecker, this.dragChecker, this.dragCheckerForRight, this.soundEffectMap, this.fontEffectViewer);
            Dragon.initializeStatic(this.world, BOX2D_SCALE, FRAME_RATE, GRAVITY_Y, this.container, this.soundEffectMap);
            FireBreath.initializeStatic(this.world, BOX2D_SCALE, FRAME_RATE, GRAVITY_Y);
            HitEffect.initializeStatic(BOX2D_SCALE);
            this.background = new Background();
            var _loc_1:* = this.box2dViewParser.getChunkInBox(ChunkSetParameter.ID_HERO, 0);
            this.hero = new Hero(_loc_1);
            this.dragon = new Dragon();
            this.dragon.initialize(this.box2dViewParser.getChunkInBox(ChunkSetParameter.ID_DRAGON, 0));
            this.fireBreath = new FireBreath(this.box2dViewParser.getChunkInBox(ChunkSetParameter.ID_FIRE, 0));
            this.stompEffect = new StompEffect();
            this.fireExplosion = new FireExplosion();
            this.bladeDamageEffect = new BladeDamageEffect();
            this.heroColorChanger = new CharacterColorChanger(this.hero._viewLayer);
            this.dragonColorChanger = new CharacterColorChanger(this.dragon._viewLayer);
            this.heroHitEffectMap = new HitEffectMap(this.effectLayer);
            this.contactParser = new ContactParser(this.world, _loc_1._key, this.box2dViewParser);
            return;
        }// end function

        private function initializeEvent() : void
        {
            return;
        }// end function

        private function initializeBallAfterEventCreated() : void
        {
            return;
        }// end function

        private function initializeUI() : void
        {
            this.lifeGage = new LifeGage(this.gameView.lifePt.x, this.gameView.lifePt.y);
            this.lifeForPlayer = new LifeForPlayer();
            this.lifeForPlayer.initialize(this.lifeGage._body.redGagePt);
            this.lifeForEnemy = new LifeForEnemy();
            this.lifeForEnemy.initialize(this.lifeGage._body.orangeGagePt);
            this.gameTime = new GameTime();
            this.bestTimeStorage = new BestTimeStorage();
            return;
        }// end function

        private function initializeOnViewLayer() : void
        {
            this.background.addChild(this.backgroundLayer);
            this.dragon.addChild(this.enemyLayer);
            this.hero.addChild(this.playerLayer);
            this.fireBreath.addChild(this.fireLayer);
            this.stompEffect.addChild(this.fireLayer);
            this.fireExplosion.addChild(this.effectLayer);
            this.bladeDamageEffect.addChild(this.effectLayer);
            this.lifeGage.addChild(this.uiLayer);
            return;
        }// end function

        private function initializeScene() : void
        {
            GameScene.initializeOnce(this.clickChecker, this.uiLayer);
            this.gameOverScene = new GameOverScene();
            this.gameClearScene = new GameClearScene();
            return;
        }// end function

        private function initializeDebug() : void
        {
            var _loc_1:* = new b2DebugDraw();
            _loc_1.SetSprite(this.debugLayer);
            _loc_1.SetDrawScale(BOX2D_SCALE);
            _loc_1.SetLineThickness(1);
            _loc_1.SetAlpha(0.5);
            _loc_1.SetFillAlpha(0);
            _loc_1.SetFlags(b2DebugDraw.e_shapeBit);
            this.world.SetDebugDraw(_loc_1);
            return;
        }// end function

        private function initializeForReadyScene() : void
        {
            this.mainFunction = this.viewReadyScene;
            return;
        }// end function

        private function viewReadyScene() : void
        {
            this.initializeForGameScene();
            return;
        }// end function

        private function initializeForGameScene() : void
        {
            this.gameTime.setStartTime();
            this.mainFunction = this.viewGameScene;
            return;
        }// end function

        private function viewGameScene() : void
        {
            this.play();
            return;
        }// end function

        private function initializeForGameOverScene() : void
        {
            this.hero.changeActorToDown();
            this.gameOverScene.initializePlay();
            this.mainFunction = this.viewGameOverScene;
            return;
        }// end function

        private function viewGameOverScene() : void
        {
            this.hero.run();
            this.gameOverScene.run();
            if (this.gameOverScene._selectedRetry)
            {
                this.initializeAfterGameOver();
                this.mainFunction = this.waitForFinishedGameOverScene;
            }
            return;
        }// end function

        private function waitForFinishedGameOverScene() : void
        {
            this.gameOverScene.run();
            if (this.gameOverScene.checkFinished())
            {
                this.initializeForReadyScene();
            }
            return;
        }// end function

        private function initializeForGameClearScene() : void
        {
            this.dragon.changeActorToDown();
            var _loc_1:* = this.gameTime.getPlayTime();
            var _loc_2:* = GameTime.changeMilliSecondsToStr(_loc_1);
            var _loc_3:* = this.bestTimeStorage.getBestPlayTime();
            var _loc_4:* = GameTime.changeMilliSecondsToStr(_loc_3);
            if (_loc_3 != 0)
            {
            }
            if (_loc_1 < _loc_3)
            {
                this.bestTimeStorage.recordPlayTime(_loc_1);
                _loc_4 = _loc_2;
            }
            this.gameClearScene.setPlayTimeStr(_loc_2, _loc_4);
            this.gameClearScene.initializePlay();
            this.mainFunction = this.viewGameClearScene;
            return;
        }// end function

        private function viewGameClearScene() : void
        {
            this.dragon.run();
            this.gameClearScene.run();
            if (this.gameClearScene._selectedRetry)
            {
                this.initializeAfterGameOver();
                this.mainFunction = this.waitForFinishedGameClearScene;
            }
            return;
        }// end function

        private function waitForFinishedGameClearScene() : void
        {
            this.gameClearScene.run();
            if (this.gameClearScene.checkFinished())
            {
                this.initializeForReadyScene();
            }
            return;
        }// end function

        private function initializeAfterGameOver() : void
        {
            this.hero.initialiseAfterGameOver();
            this.dragon.initialiseAfterGameOver();
            this.heroColorChanger.initializeAfterGameOver();
            this.dragonColorChanger.initializeAfterGameOver();
            this.stompEffect.initialiseAfterGameOver();
            this.fireBreath.initialiseAfterGameOver();
            this.fireExplosion.initialiseAfterGameOver();
            this.bladeDamageEffect.initialiseAfterGameOver();
            this.heroHitEffectMap.initializeAfterGameOver();
            this.fontEffectViewer.initializeAfterGameOver();
            this.lifeForPlayer.initializeAfterGameOver();
            this.lifeForEnemy.initializeAfterGameOver();
            this.resetHitted();
            this.gameLayer.stage.focus = this.gameLayer;
            return;
        }// end function

        private function play() : void
        {
            this.playForControler();
            this.playForBox2d();
            this.playForUI();
            this.draw();
            this.contactParser.run();
            this.decideNextActOfHero();
            this.decideNextActOfDragon();
            this.decideNextActOfFire();
            this.decideNextActOfStomp();
            if (this.lifeForPlayer.isZero())
            {
                this.initializeForGameOverScene();
            }
            else if (this.lifeForEnemy.isZero())
            {
                this.initializeForGameClearScene();
            }
            return;
        }// end function

        private function playForControler() : void
        {
            this.hero.run();
            this.dragon.run();
            this.heroColorChanger.run();
            this.dragonColorChanger.run();
            this.fireBreath.run();
            this.stompEffect.run();
            this.fireExplosion.run();
            this.bladeDamageEffect.run();
            this.heroHitEffectMap.run();
            return;
        }// end function

        private function playForBox2d() : void
        {
            this.world.Step(1 / FRAME_RATE, 10, 2);
            this.world.ClearForces();
            this.world.DrawDebugData();
            return;
        }// end function

        private function playForUI() : void
        {
            this.soundEffectMap.run();
            this.lifeForPlayer.run();
            this.lifeForEnemy.run();
            this.fontEffectViewer.run();
            return;
        }// end function

        private function draw() : void
        {
            this.hero.draw();
            this.dragon.draw();
            this.fireBreath.draw();
            return;
        }// end function

        private function decideNextActOfHero() : void
        {
            if (this.decideNextActOfHeroForHittedFire())
            {
                return;
            }
            if (this.decideNextActOfHeroForHittedStomp())
            {
                return;
            }
            if (this.decideNextActOfHeroForHittedClaw())
            {
                return;
            }
            this.hero.decideNextAct();
            return;
        }// end function

        private function decideNextActOfHeroForHittedFire() : Boolean
        {
            if (!this.contactParser.isHittedFire())
            {
                return false;
            }
            var _loc_1:* = this.fireBreath.getChunkPosition();
            this.fireExplosion.view(_loc_1.x * BOX2D_SCALE, _loc_1.y * BOX2D_SCALE);
            this.fireBreath.erase();
            this.hitted = true;
            if (this.hero.isDefensing())
            {
                this.heroColorChanger.viewDefenseSuccess();
                this.hero.changeActorToDefenseSuccess();
                this.lifeForPlayer.upLifeByDefense();
                this.soundEffectMap.playForDefenseSuccess();
                this.heroHitEffectMap.createHitEffect(this.hero.getChunkPositionX(), this.hero.getChunkPositionY(), true);
            }
            else
            {
                this.heroColorChanger.viewDamage();
                this.hero.changeActorToDamage();
                this.lifeForPlayer.downLifeByFire();
                this.soundEffectMap.playForPlayerDamage();
                this.heroHitEffectMap.createHitEffect(this.hero.getChunkPositionX(), this.hero.getChunkPositionY(), false);
                this.fontEffectViewer.addSentenceForDamagePoint(Life.getFireDamageForFont(), this.hero.getFontPositionX(), this.hero.getFontPositionY());
            }
            return true;
        }// end function

        private function decideNextActOfHeroForHittedStomp() : Boolean
        {
            var _loc_1:* = null;
            if (!this.stompEffect.hitTest(this.hero.getView()))
            {
                return false;
            }
            if (!this.hero.isDefensing())
            {
                this.hero.isDefensing();
            }
            if (this.hero.isDefenseSuccessing())
            {
                if (this.hero.isDefensing())
                {
                    this.lifeForPlayer.upLifeByDefense();
                }
                this.heroColorChanger.viewDefenseSuccess();
                this.hero.changeActorToDefenseSuccess();
                this.soundEffectMap.playForDefenseSuccess();
                this.heroHitEffectMap.createHitEffect(this.hero.getChunkPositionX(), this.hero.getChunkPositionY(), true);
            }
            else
            {
                _loc_1 = this.stompEffect.getAttackHitArea();
                if (!_loc_1)
                {
                    return false;
                }
                if (this.heroColorChanger.isSameAsProcessingHitArea(_loc_1))
                {
                    return false;
                }
                if (!this.hero.isDamaging())
                {
                    this.fontEffectViewer.addSentenceForDamagePoint(Life.getStompDamageForFont(), this.hero.getFontPositionX(), this.hero.getFontPositionY());
                }
                this.heroColorChanger.viewDamage(_loc_1);
                this.hero.changeActorToDamage();
                this.lifeForPlayer.downLifeByStomp();
                this.soundEffectMap.playForPlayerDamage();
                this.heroHitEffectMap.createHitEffect(this.hero.getChunkPositionX(), this.hero.getChunkPositionY(), false);
            }
            return true;
        }// end function

        private function decideNextActOfHeroForHittedClaw() : Boolean
        {
            if (this.hero.isDamaging())
            {
                return false;
            }
            if (!this.dragon.isAttackedClaw())
            {
                return false;
            }
            if (!this.dragon.hitTestForClaw(this.hero.getView()))
            {
                return false;
            }
            this.heroColorChanger.viewDamage();
            this.hero.changeActorToDamage();
            this.lifeForPlayer.downLifeByClaw();
            this.soundEffectMap.playForPlayerDamage();
            this.heroHitEffectMap.createHitEffect(this.hero.getChunkPositionX(), this.hero.getChunkPositionY(), false);
            this.fontEffectViewer.addSentenceForDamagePoint(Life.getFireDamageForFont(), this.hero.getFontPositionX(), this.hero.getFontPositionY());
            return true;
        }// end function

        private function decideNextActOfDragon() : void
        {
            this.decideNextActOfDragonByDamage();
            this.dragon.decideNextAct();
            return;
        }// end function

        private function decideNextActOfDragonByDamage() : void
        {
            var _loc_1:* = this.hero.getBladeHitArea();
            if (!_loc_1)
            {
                return;
            }
            if (this.dragonColorChanger.isSameAsProcessingHitArea(_loc_1))
            {
                return;
            }
            var _loc_2:* = _loc_1.getBounds(this.gameLayer);
            if (!this.dragon.checkHittedAttack(_loc_2))
            {
                return;
            }
            this.dragonColorChanger.viewDamage(_loc_1);
            this.hitted = true;
            this.dragon.damage();
            this.soundEffectMap.playForHittedBlade();
            var _loc_3:* = this.dragon.getChunkPosition();
            this.bladeDamageEffect.view(_loc_3.x * BOX2D_SCALE, _loc_3.y * BOX2D_SCALE);
            if (this.hero.isAttacking())
            {
                this.lifeForEnemy.downLifeByNormalAttack();
                this.fontEffectViewer.addSentenceForDamagePoint(Life.getNormalAttackDamageForFont(), this.dragon.getFontPositionX(), this.dragon.getFontPositionY());
            }
            else if (this.hero.isSecondAttacking())
            {
                this.lifeForEnemy.downLifeBySecondAttack();
                this.fontEffectViewer.addSentenceForDamagePoint(Life.getSecondAttackDamageForFont(), this.dragon.getFontPositionX(), this.dragon.getFontPositionY());
            }
            else if (this.hero.isThirdAttacking())
            {
                this.lifeForEnemy.downLifeByThirdAttack();
                this.fontEffectViewer.addSentenceForDamagePoint(Life.getThirdAttackDamageForFont(), this.dragon.getFontPositionX(), this.dragon.getFontPositionY());
            }
            else
            {
                this.lifeForEnemy.downLifeBySpecialAttack();
                this.fontEffectViewer.addSentenceForDamagePoint(Life.getSpecialAttackDamageForFont(), this.dragon.getFontPositionX(), this.dragon.getFontPositionY());
            }
            if (!this.dragon.isRetreating())
            {
                this.dragon.isRetreating();
            }
            if (this.dragon.isAdvancing())
            {
                this.dragon.changeActorToNeutral();
            }
            if (this.dragon.isNeutral())
            {
                this.dragon.isNeutral();
            }
            if (this.dragon.isShiftedFromDamageToAttack())
            {
                this.dragon.shiftFromDamageToAttack();
            }
            return;
        }// end function

        private function decideNextActOfFire() : void
        {
            if (!this.dragon.isFired())
            {
                return;
            }
            var _loc_1:* = this.dragon.getChunkPosition();
            this.fireBreath.view(_loc_1);
            this.soundEffectMap.playForFire();
            return;
        }// end function

        private function decideNextActOfStomp() : void
        {
            if (!this.dragon.isStomped())
            {
                return;
            }
            var _loc_1:* = this.dragon.getChunkPosition();
            this.stompEffect.view(_loc_1.x * BOX2D_SCALE, _loc_1.y * BOX2D_SCALE);
            this.soundEffectMap.playForStomp();
            return;
        }// end function

        public function resetHitted() : void
        {
            this.hitted = false;
            return;
        }// end function

        public function get _isHitted() : Boolean
        {
            return this.hitted;
        }// end function

    }
}
