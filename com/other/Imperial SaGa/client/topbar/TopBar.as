package topbar
{
    import button.*;
    import flash.display.*;
    import flash.net.*;
    import layer.*;
    import message.*;
    import resource.*;
    import tutorial.*;
    import user.*;
    import utility.*;

    public class TopBar extends Object
    {
        private var _mc:MovieClip;
        private var _instayout:InStayOut;
        private var _layer:LayerMainProcess;
        private var _crownCount:NumericNumberMc;
        private var _userData:UserDataPersonal;
        private var _progress:ProgressBar;
        private var _btnCrown:ButtonBase;
        private var _btnHelp:ButtonBase;
        private var _btnConfig:ButtonBase;
        private var _bTopbarDisable:Boolean;
        private var _bCrownDisable:Boolean;
        private var _bHelpDisable:Boolean;
        private var _bConfigDisable:Boolean;
        private var _bCrownWindowOpened:Boolean;
        private var _configWindow:ConfigWindow;
        private var _cbConfigWindowOpen:Function;
        private var _cbConfigWindowClose:Function;
        private var _nowProcessId:int;
        private static const CROWN_COUNT:int = 99;

        public function TopBar(param1:LayerMainProcess)
        {
            this._layer = param1;
            this._mc = ResourceManager.getInstance().createMovieClip(ResourcePath.COMMON_DATA_PATH + "UI_Topbar.swf", "Topbar");
            if (Main.GetApplicationData().checkChargeJumpEnable() == false)
            {
                this._mc.topbarMc.gotoAndStop("mixi");
            }
            else
            {
                this._mc.topbarMc.gotoAndStop("default");
            }
            this._instayout = new InStayOut(this._mc);
            this._layer.getLayer(LayerMainProcess.TOPBAR).addChild(this._mc);
            this._cbConfigWindowOpen = null;
            this._cbConfigWindowClose = null;
            this._nowProcessId = 0;
            this.setTopBar();
            return;
        }// end function

        public function getMc() : MovieClip
        {
            return this._mc;
        }// end function

        public function cbConfigWindow(param1:Function, param2:Function) : void
        {
            this._cbConfigWindowOpen = param1;
            this._cbConfigWindowClose = param2;
            return;
        }// end function

        public function release() : void
        {
            if (this._configWindow)
            {
                this._configWindow.release();
            }
            this._configWindow = null;
            if (this._instayout)
            {
                this._instayout.release();
            }
            this._instayout = null;
            if (this._mc && this._mc.parent)
            {
                this._mc.parent.removeChild(this._mc);
            }
            return;
        }// end function

        public function open() : void
        {
            if (this._instayout.bClosed)
            {
                this._instayout.setIn(this.cbIn);
            }
            return;
        }// end function

        private function cbIn() : void
        {
            this._bHelpDisable = false;
            this.updateDisable_Help();
            return;
        }// end function

        public function close() : void
        {
            if (this._instayout.bOpened)
            {
                this._bHelpDisable = true;
                this.updateDisable_Help();
                this._instayout.setOut();
            }
            return;
        }// end function

        public function get bConfigWindowOpend() : Boolean
        {
            return this._configWindow != null && this._configWindow.bOpend;
        }// end function

        public function update() : void
        {
            this.updateEmperorLv();
            this.updateCrown();
            return;
        }// end function

        public function updateCrownData() : void
        {
            this.updateCrown();
            return;
        }// end function

        public function updateProgress() : void
        {
            this._progress.updateProgress();
            return;
        }// end function

        public function resetProgress() : void
        {
            this._progress.resetProgres();
            return;
        }// end function

        public function updateChapter() : void
        {
            var _loc_1:* = MessageManager.getInstance().getMessage(MessageId.COMMON_CHAPTER);
            _loc_1 = _loc_1.replace("%d", this._userData.chapter);
            TextControl.setText(this._mc.topbarMc.chapterTextMc.textDt, _loc_1);
            TextControl.setIdText(this._mc.topbarMc.nextChapterTextMc.textDt, MessageId.TOPBAR_NEXT_CHAPTER);
            return;
        }// end function

        public function updateEmperorName() : void
        {
            TextControl.setText(this._mc.topbarMc.playerNameMc.textDt, this._userData.name);
            return;
        }// end function

        private function setTopBar() : void
        {
            this._userData = UserDataManager.getInstance().userData;
            var _loc_1:* = UserDataManager.getInstance().userData.getCrownTotal();
            TextControl.setText(this._mc.topbarMc.playerNameMc.textDt, this._userData.name);
            TextControl.setIdText(this._mc.topbarMc.lvTextMc.textDt, MessageId.TOPBAR_LEVEL);
            this.updateEmperorLv();
            TextControl.setIdText(this._mc.topbarMc.moneyTitletMc.textDt, MessageId.TOPBAR_MONEY);
            this._crownCount = new NumericNumberMc(this._mc.topbarMc.moneyNumMc, _loc_1.total, 0, false);
            this._progress = new ProgressBar(this._mc.topbarMc.progressLampMc.progressLampLine);
            var _loc_2:* = new Gauge(this._mc.topbarMc.gaugeMc, 1, 0);
            if (Main.GetApplicationData().checkChargeJumpEnable())
            {
                this._btnCrown = ButtonManager.getInstance().addButton(this._mc.topbarMc.cRBtnMc, this.cbCrownButtonClick);
            }
            else
            {
                this._btnCrown = null;
            }
            this._btnHelp = ButtonManager.getInstance().addButton(this._mc.topbarMc.helpBtnMc, this.cbHelpButtonClick);
            this._btnConfig = ButtonManager.getInstance().addButton(this._mc.topbarMc.configBtnMc, this.cbConfigButtonClick);
            if (this._btnCrown)
            {
                this._btnCrown.setDisable(true);
            }
            this._btnHelp.setDisable(true);
            this._btnConfig.setDisable(true);
            if (this._btnCrown)
            {
                this._btnCrown.enterSeId = ButtonBase.SE_CURSOR_ID;
            }
            this._btnHelp.enterSeId = ButtonBase.SE_CURSOR_ID;
            this._btnConfig.enterSeId = ButtonBase.SE_CURSOR_ID;
            this._bTopbarDisable = true;
            this._bCrownDisable = true;
            this._bHelpDisable = true;
            this._bConfigDisable = true;
            this.updateChapter();
            this.update();
            return;
        }// end function

        public function control(param1:Number) : void
        {
            if (this._crownCount)
            {
                this._crownCount.control(param1);
            }
            if (this._configWindow && this._configWindow.bOpend)
            {
                this._configWindow.control(param1);
            }
            if (!Main.GetProcess().isCrownUpdateing() && this._bCrownWindowOpened)
            {
                this._bCrownWindowOpened = false;
                if (this._cbConfigWindowClose != null)
                {
                    this._cbConfigWindowClose();
                }
            }
            var _loc_2:* = Main.GetProcess().bTopbarDsable;
            if (this._bTopbarDisable != _loc_2)
            {
                this._bTopbarDisable = _loc_2;
                this.updateDisable_Crown();
                this.updateDisable_Help();
                this.updateDisable_Config();
            }
            return;
        }// end function

        public function setButtonUpdate(param1:int) : void
        {
            var _loc_2:* = false;
            if (this._nowProcessId != param1)
            {
                this._nowProcessId = param1;
                switch(param1)
                {
                    case ProcessMain.PROCESS_HOME:
                    case ProcessMain.PROCESS_EMPLOYMENT:
                    case ProcessMain.PROCESS_MAGIC_DEVELOP:
                    case ProcessMain.PROCESS_MAKE_EQUIP:
                    case ProcessMain.PROCESS_MY_PAGE:
                    case ProcessMain.PROCESS_SKILL_INITIATE:
                    case ProcessMain.PROCESS_STORAGE:
                    case ProcessMain.PROCESS_TRADING_POST:
                    case ProcessMain.PROCESS_TRAINING_ROOM:
                    case ProcessMain.PROCESS_COMMAND_POST:
                    case ProcessMain.PROCESS_BARRACKS:
                    case ProcessMain.PROCESS_RETIRE:
                    case ProcessMain.PROCESS_DAILY_MISSION:
                    {
                        this._bCrownDisable = false;
                        this._bConfigDisable = false;
                        break;
                    }
                    default:
                    {
                        this._bCrownDisable = true;
                        this._bConfigDisable = true;
                        _loc_2 = true;
                        break;
                        break;
                    }
                }
            }
            if (TutorialManager.getInstance().isTutorial())
            {
                this._bCrownDisable = true;
                this._bHelpDisable = true;
                this._bConfigDisable = true;
            }
            else
            {
                if (!_loc_2)
                {
                    this._bCrownDisable = false;
                    this._bConfigDisable = false;
                }
                this._bHelpDisable = false;
            }
            this.updateDisable_Crown();
            this.updateDisable_Help();
            this.updateDisable_Config();
            return;
        }// end function

        private function updateEmperorLv() : void
        {
            var _loc_1:* = UserDataManager.getInstance().getEmperorLv();
            TextControl.setText(this._mc.topbarMc.lvNumMc.textDt, _loc_1.toString());
            return;
        }// end function

        private function updateCrown() : void
        {
            var _loc_1:* = UserDataManager.getInstance().userData.getCrownTotal();
            var _loc_2:* = this._crownCount.nowCount - _loc_1.total;
            if (_loc_2 > CROWN_COUNT)
            {
                _loc_2 = _loc_2 / 10;
            }
            else
            {
                _loc_2 = CROWN_COUNT;
            }
            this._crownCount.startCount(_loc_1.total, _loc_2);
            return;
        }// end function

        private function cbCrownButtonClick(param1:int) : void
        {
            if (Main.GetProcess().isCrownUpdateing() || Main.GetProcess().bTopbarDsable)
            {
                return;
            }
            Main.GetProcess().createCrownUpdateWindow();
            this._bCrownWindowOpened = true;
            if (this._cbConfigWindowOpen != null)
            {
                this._cbConfigWindowOpen();
            }
            return;
        }// end function

        private function cbHelpButtonClick(param1:int) : void
        {
            if (Main.GetProcess().bTopbarDsable)
            {
                return;
            }
            var _loc_2:* = new URLRequest(Main.GetApplicationData().getHelpJumpUrl());
            navigateToURL(_loc_2);
            return;
        }// end function

        private function cbConfigButtonClick(param1:int) : void
        {
            var _loc_2:* = Main.GetProcess().bTopbarDsable;
            if (this._configWindow != null || _loc_2)
            {
                return;
            }
            this._configWindow = new ConfigWindow(this._layer, this.cbConfigWindowClose);
            if (this._cbConfigWindowOpen != null)
            {
                this._cbConfigWindowOpen();
            }
            this._configWindow.open();
            return;
        }// end function

        private function cbConfigWindowClose() : void
        {
            if (this._configWindow)
            {
                this._configWindow.release();
            }
            this._configWindow = null;
            if (this._cbConfigWindowClose != null)
            {
                this._cbConfigWindowClose();
            }
            return;
        }// end function

        private function updateDisable_Crown() : void
        {
            var _loc_1:* = false;
            if (this._btnCrown)
            {
                _loc_1 = this._bTopbarDisable || this._bCrownDisable;
                if (this._btnCrown.getDisableFlag() != _loc_1)
                {
                    this._btnCrown.setDisable(_loc_1);
                }
            }
            return;
        }// end function

        private function updateDisable_Help() : void
        {
            var _loc_1:* = this._bTopbarDisable || this._bHelpDisable;
            if (this._btnHelp.getDisableFlag() != _loc_1)
            {
                this._btnHelp.setDisable(_loc_1);
            }
            return;
        }// end function

        private function updateDisable_Config() : void
        {
            var _loc_1:* = this._bTopbarDisable || this._bConfigDisable;
            if (this._btnConfig.getDisableFlag() != _loc_1)
            {
                this._btnConfig.setDisable(_loc_1);
            }
            return;
        }// end function

    }
}
