package 
{
    import background.*;
    import balloon.*;
    import button.*;
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;
    import input.*;
    import layer.*;
    import mainProcess.*;
    import network.*;
    import notice.*;
    import popup.*;
    import process.*;
    import resource.*;
    import script.*;
    import sound.*;
    import status.*;
    import topbar.*;
    import tradingPost.*;
    import user.*;
    import utility.*;
    import window.*;

    public class ProcessMain extends Sprite
    {
        private var _oldTimer:int;
        private var _processId:int = 1;
        private var _oldProcessId:int = -1;
        private var _prevProcessId:int = 1;
        private var _pro:ProcessBase;
        private var _layer:LayerMainProcess;
        private var _screen:DisplayObjectContainer;
        private var _loadingWatcher:LoadingWatcher;
        private var _topBar:TopBar;
        private var _background:BackGround;
        private var _maintenance:MaintenanceNotice;
        private var _fade:Fade;
        private var _crownUpdate:CrownUpdate;
        public static const PROCESS_INIT:int = 1;
        public static const PROCESS_LOGIN:int = 2;
        public static const PROCESS_LOGIN_AFTER:int = 3;
        public static const PROCESS_TITLE:int = 4;
        public static const PROCESS_COMMAND_POST:int = 5;
        public static const PROCESS_HOME:int = 10;
        public static const PROCESS_MY_PAGE:int = 11;
        public static const PROCESS_RETIRE:int = 20;
        public static const PROCESS_DAILY_MISSION:int = 30;
        public static const PROCESS_QUEST_SELECT:int = 100;
        public static const PROCESS_QUEST:int = 110;
        public static const PROCESS_EMPLOYMENT:int = 120;
        public static const PROCESS_BARRACKS:int = 121;
        public static const PROCESS_TRADING_POST:int = 122;
        public static const PROCESS_MAKE_EQUIP:int = 123;
        public static const PROCESS_STORAGE:int = 150;
        public static const PROCESS_EMPEROR_SELECT:int = 160;
        public static const PROCESS_MAGIC_DEVELOP:int = 170;
        public static const PROCESS_TRAINING_ROOM:int = 180;
        public static const PROCESS_SKILL_INITIATE:int = 190;
        public static const PROCESS_ENDING:int = 200;
        public static const PROCESS_OPENING:int = 210;
        public static const PROCESS_SPECIAL_EVENT:int = 300;

        public function ProcessMain()
        {
            this._oldTimer = getTimer();
            return;
        }// end function

        public function SetProcessId(param1:int) : void
        {
            if (this._processId != param1)
            {
                this._prevProcessId = this._processId;
                this._processId = param1;
            }
            return;
        }// end function

        public function get prevProcessId() : int
        {
            return this._prevProcessId;
        }// end function

        public function get bTopbarDsable() : Boolean
        {
            return this._pro.bTopbarButtonDisable;
        }// end function

        public function get loading() : LoadingScreen
        {
            return null;
        }// end function

        public function get topBar() : TopBar
        {
            return this._topBar;
        }// end function

        public function get background() : BackGround
        {
            return this._background;
        }// end function

        public function get maintenance() : MaintenanceNotice
        {
            return this._maintenance;
        }// end function

        public function get fade() : Fade
        {
            return this._fade;
        }// end function

        public function createCrownUpdateWindow() : void
        {
            if (this._crownUpdate == null)
            {
                this._crownUpdate = new CrownUpdate();
            }
            return;
        }// end function

        public function isCrownUpdateing() : Boolean
        {
            if (this._crownUpdate == null)
            {
                return false;
            }
            return true;
        }// end function

        public function init(param1:DisplayObjectContainer) : void
        {
            this._screen = param1;
            this._layer = new LayerMainProcess();
            addChild(this._layer);
            Blowfish.createFixitionKey();
            ResourceManager.getInstance();
            ScriptManager.getInstance().init();
            NetManager.getInstance().init();
            StatusManager.getInstance().init();
            WindowManager.getInstance().init();
            SoundManager.getInstance().init();
            var _loc_2:* = Main.GetApplicationData().userConfigData;
            SoundManager.getInstance().setVolumeBgm(_loc_2.getVolumeBgm());
            SoundManager.getInstance().setVolumeSe(_loc_2.getVolumeSe());
            ButtonManager.getInstance().init(this._screen);
            InputManager.getInstance().initialize(this._screen);
            NoticeManager.getInstance().init();
            BalloonManager.getInstance().init(this._screen);
            this._fade = new Fade(this._layer.getLayer(LayerMainProcess.FADE));
            this._fade.setFadeOut(0);
            return;
        }// end function

        public function startLoadingWatch() : void
        {
            if (this._loadingWatcher == null)
            {
                this._loadingWatcher = new LoadingWatcher(this._layer.getLayer(LayerMainProcess.LOADING));
            }
            return;
        }// end function

        public function stopLoadingWatch() : void
        {
            if (this._loadingWatcher)
            {
                this._loadingWatcher.release();
            }
            this._loadingWatcher = null;
            return;
        }// end function

        public function createLoadingScreen() : void
        {
            if (this._loadingWatcher)
            {
                this._loadingWatcher.showNowLoading();
            }
            return;
        }// end function

        public function isNowLoading() : Boolean
        {
            return this._loadingWatcher && this._loadingWatcher.bNowLoading;
        }// end function

        public function closeLoadingScreen() : void
        {
            if (this._loadingWatcher)
            {
                this._loadingWatcher.hideNowLoading();
            }
            return;
        }// end function

        public function createMaintenanceWindow(param1:Boolean = false) : void
        {
            if (this._maintenance != null)
            {
                this._maintenance.release();
            }
            this._maintenance = null;
            var _loc_2:* = Main.GetApplicationData().maintenanceData.getMaintenanceType(param1);
            this._maintenance = new MaintenanceNotice(this._layer.getLayer(LayerMainProcess.MAIN), _loc_2);
            Main.GetApplicationData().maintenanceData.maintenanceCheckType();
            return;
        }// end function

        public function onEnterFrame(event:Event) : void
        {
            var _loc_2:* = getTimer();
            var _loc_3:* = (_loc_2 - this._oldTimer) / 1000;
            this._oldTimer = _loc_2;
            StatusManager.getInstance().control(_loc_3);
            SoundManager.getInstance().control(_loc_3);
            InputManager.getInstance().control(_loc_3);
            WindowManager.getInstance().control(_loc_3);
            BalloonManager.getInstance().control(_loc_3);
            NetManager.getInstance().control(_loc_3);
            if (CommonPopup.isUse())
            {
                CommonPopup.getInstance().control(_loc_3);
            }
            if (this._crownUpdate != null)
            {
                this._crownUpdate.control(_loc_3);
                if (this._crownUpdate.bUpdateing == false)
                {
                    this._crownUpdate.release();
                    this._crownUpdate = null;
                }
            }
            this.newProcess();
            if (this._pro == null && this._topBar == null)
            {
                return;
            }
            if (this._loadingWatcher)
            {
                this._loadingWatcher.control(_loc_3);
            }
            if (this._pro.bResourceLoadWait)
            {
                this._pro.controlResourceWait();
                return;
            }
            this._fade.control(_loc_3);
            if (this._maintenance)
            {
                if (this._maintenance.bClose)
                {
                    this._maintenance.release();
                    this._maintenance = null;
                }
                else
                {
                    return;
                }
            }
            this._pro.control(_loc_3);
            if (this._topBar)
            {
                this._topBar.control(_loc_3);
            }
            return;
        }// end function

        private function newProcess() : void
        {
            if (this._processId == this._oldProcessId)
            {
                return;
            }
            if (this._topBar)
            {
                this._topBar.setButtonUpdate(this._processId);
            }
            if (this._pro != null)
            {
                this._pro.release();
                this._pro.parent.removeChild(this._pro);
                this._pro = null;
                ResourceManager.getInstance().Optimization();
                SoundManager.getInstance().Optimization();
                ButtonManager.getInstance().clearSeal();
            }
            if (this._processId != PROCESS_TRADING_POST)
            {
                TradingPostStartPageRequest.getInstance().clear();
            }
            switch(this._processId)
            {
                case PROCESS_INIT:
                {
                    this._pro = new ProcessInitialize();
                    break;
                }
                case PROCESS_LOGIN:
                {
                    this._pro = new ProcessLogin(this.cbLoginComplete);
                    break;
                }
                case PROCESS_LOGIN_AFTER:
                {
                    this._pro = new ProcessLoginAfter();
                    break;
                }
                case PROCESS_TITLE:
                {
                    this._pro = new ProcessTitle();
                    break;
                }
                case PROCESS_COMMAND_POST:
                {
                    this._pro = new ProcessCommandPost();
                    break;
                }
                case PROCESS_HOME:
                {
                    this._pro = new ProcessHome();
                    break;
                }
                case PROCESS_RETIRE:
                {
                    this._pro = new ProcessRetire();
                    break;
                }
                case PROCESS_DAILY_MISSION:
                {
                    this._pro = new ProcessDailyMission();
                    break;
                }
                case PROCESS_QUEST_SELECT:
                {
                    this._pro = new ProcessQuestSelect();
                    break;
                }
                case PROCESS_QUEST:
                {
                    this._pro = new ProcessQuest();
                    break;
                }
                case PROCESS_EMPLOYMENT:
                {
                    this._pro = new ProcessEmployment();
                    break;
                }
                case PROCESS_BARRACKS:
                {
                    this._pro = new ProcessBarracks();
                    break;
                }
                case PROCESS_TRADING_POST:
                {
                    this._pro = new ProcessTradingPost();
                    break;
                }
                case PROCESS_STORAGE:
                {
                    this._pro = new ProcessStorage();
                    break;
                }
                case PROCESS_EMPEROR_SELECT:
                {
                    this._pro = new ProcessEmperorSelect();
                    break;
                }
                case PROCESS_MAKE_EQUIP:
                {
                    this._pro = new ProcessMakeEquip();
                    break;
                }
                case PROCESS_MAGIC_DEVELOP:
                {
                    this._pro = new ProcessMagicLaboratory();
                    break;
                }
                case PROCESS_TRAINING_ROOM:
                {
                    this._pro = new ProcessTrainingRoom();
                    break;
                }
                case PROCESS_SKILL_INITIATE:
                {
                    this._pro = new ProcessSkillInitiate();
                    break;
                }
                case PROCESS_ENDING:
                {
                    this._pro = new ProcessEnding();
                    break;
                }
                case PROCESS_OPENING:
                {
                    this._pro = new ProcessOpening();
                    break;
                }
                case PROCESS_SPECIAL_EVENT:
                {
                    this._pro = new ProcessSpecialScript();
                    break;
                }
                default:
                {
                    break;
                }
            }
            this._layer.getLayer(LayerMainProcess.MAIN).addChild(this._pro);
            this._pro.init();
            this._oldProcessId = this._processId;
            return;
        }// end function

        private function cbLoginComplete() : void
        {
            if (this._topBar != null)
            {
                return;
            }
            var _loc_1:* = ResourceManager.getInstance().loadResource(ResourcePath.COMMON_DATA_PATH + "UI_option.swf");
            _loc_1.bRemoveLock = true;
            var _loc_2:* = ResourceManager.getInstance().loadResource(ResourcePath.COMMON_DATA_PATH + "UI_Loading.swf");
            _loc_2.bRemoveLock = true;
            return;
        }// end function

        private function cbResourceLoadComplete() : void
        {
            if (ResourceManager.getInstance().isLoaded() == false)
            {
                return;
            }
            return;
        }// end function

        public function createTopBar() : void
        {
            if (this._topBar != null)
            {
                return;
            }
            this._topBar = new TopBar(this._layer);
            return;
        }// end function

        public function createBackGround() : void
        {
            var _loc_1:* = ResourceManager.getInstance().createMovieClip(ResourcePath.COMMON_DATA_PATH + "UI_BackGround.swf", "BackGround");
            this._background = new BackGround(_loc_1);
            this._layer.getLayer(LayerMainProcess.BACKGROUND).addChild(_loc_1);
            return;
        }// end function

        public function setBackGroundVisible(param1:Boolean) : void
        {
            this._layer.getLayer(LayerMainProcess.BACKGROUND).visible = param1;
            return;
        }// end function

        public function stageActivate(event:Event) : void
        {
            SoundManager.getInstance().setMute(false);
            return;
        }// end function

        public function stageDeactivate(event:Event) : void
        {
            SoundManager.getInstance().setMute(true);
            return;
        }// end function

    }
}
