package dailyMission
{
    import button.*;
    import flash.display.*;
    import layer.*;
    import message.*;
    import network.*;
    import popup.*;
    import resource.*;
    import sound.*;
    import tutorial.*;
    import utility.*;

    public class DailyMissionMain extends Object
    {
        private var _phase:int;
        private var _parent:DisplayObjectContainer;
        private var _layer:LayerDailyMission;
        private var _mcBase:MovieClip;
        private var _isoMain:InStayOut;
        private var _isoTitle:InStayOut;
        private var _isoInfo:InStayOut;
        private var _isoChara:InStayOut;
        private var _missionList:DailyMissionList;
        private var _receivePopup:DailyMissionReceivePopup;
        private var _btnReturn:ButtonBase;
        private var _bBtnEnable:Boolean;
        private var _bConnected:Boolean;
        private static const _PHASE_NONE:int = 0;
        private static const _PHASE_LOADING:int = 1;
        private static const _PHASE_OPEN:int = 2;
        private static const _PHASE_TUTORIAL:int = 3;
        private static const _PHASE_MAIN:int = 4;
        private static const _PHASE_RECEIVE_POPUP:int = 5;
        private static const _PHASE_RELOAD:int = 6;
        private static const _PHASE_CLOSE:int = 7;
        private static const _PHASE_END:int = 8;
        private static const _PHASE_MAINTENANCE:int = 90;

        public function DailyMissionMain(param1:DisplayObjectContainer)
        {
            this._parent = param1;
            this._layer = null;
            Main.GetProcess().topBar.cbConfigWindow(this.cbConfigWindowOpen, this.cbConfigWindowClose);
            ResourceManager.getInstance().loadResource(ResourcePath.HOME_PATH + "UI_DailyMission.swf");
            CommonPopup.getInstance().loadResource();
            this._bConnected = false;
            NetManager.getInstance().request(new NetTaskDailyMissionList(this.cbConnected));
            this.setPhase(_PHASE_LOADING);
            return;
        }// end function

        public function get bClose() : Boolean
        {
            return this._isoMain && this._isoMain.bClosed;
        }// end function

        public function get bStay() : Boolean
        {
            return this._phase == _PHASE_MAIN && (this._isoMain && this._isoMain.bAnimetion == false);
        }// end function

        private function cbConnected(param1:NetResult) : void
        {
            this._bConnected = true;
            return;
        }// end function

        private function resourceLoaded() : void
        {
            if (!this._bConnected || ResourceManager.getInstance().isLoaded() == false || SoundManager.getInstance().isLoaded() == false)
            {
                return;
            }
            this._layer = new LayerDailyMission();
            this._parent.addChild(this._layer);
            this._mcBase = ResourceManager.getInstance().createMovieClip(ResourcePath.HOME_PATH + "UI_DailyMission.swf", "dailyMissionMc");
            DisplayUtils.setMouseEnable(this._mcBase, false);
            this._layer.getLayer(LayerDailyMission.MAIN).addChild(this._mcBase);
            this._isoMain = new InStayOut(this._mcBase);
            this._isoTitle = new InStayOut(this._mcBase.titleMc);
            this._isoInfo = new InStayOut(this._mcBase.infoMc);
            this._isoChara = new InStayOut(this._mcBase.chrInfoBalloonTopMc);
            this._bBtnEnable = false;
            this._missionList = new DailyMissionList(this._mcBase.missionMc, this.cbGetEndBtn);
            this._missionList.setButtonEnable(this._bBtnEnable);
            this._receivePopup = null;
            this._btnReturn = ButtonManager.getInstance().addButton(this._mcBase.returnBtnMc, this.cbReturnBtn);
            this._btnReturn.enterSeId = ButtonBase.SE_CANCEL_ID;
            this._btnReturn.setDisable(!this._bBtnEnable);
            TextControl.setIdText(this._mcBase.returnBtnMc.textMc.textDt, MessageId.COMMON_BUTTON_RETURN);
            TextControl.setIdText(this._mcBase.infoMc.captionMc.textMc.textDt, MessageId.DAILY_MISSION_EXPLANATION);
            TextControl.setIdText(this._mcBase.chrInfoBalloonTopMc.chrInfoBalloonMc.textMc.textDt, MessageId.DAILY_MISSION_NAVI_MESSAGE_DEFAULT);
            this.setPhase(_PHASE_OPEN);
            return;
        }// end function

        public function release() : void
        {
            if (this._btnReturn)
            {
                ButtonManager.getInstance().removeButton(this._btnReturn);
            }
            this._btnReturn = null;
            if (this._receivePopup)
            {
                this._receivePopup.release();
            }
            this._receivePopup = null;
            if (this._missionList)
            {
                this._missionList.release();
            }
            this._missionList = null;
            if (this._isoChara)
            {
                this._isoChara.release();
            }
            this._isoChara = null;
            if (this._isoInfo)
            {
                this._isoInfo.release();
            }
            this._isoInfo = null;
            if (this._isoTitle)
            {
                this._isoTitle.release();
            }
            this._isoTitle = null;
            if (this._isoMain)
            {
                this._isoMain.release();
            }
            this._isoMain = null;
            if (this._mcBase && this._mcBase.parent)
            {
                this._mcBase.parent.removeChild(this._mcBase);
            }
            this._mcBase = null;
            if (this._layer)
            {
                this._layer.release();
            }
            this._layer = null;
            this._parent = null;
            return;
        }// end function

        private function setPhase(param1:int) : void
        {
            this._phase = param1;
            switch(this._phase)
            {
                case _PHASE_OPEN:
                {
                    this.phaseOpen();
                    break;
                }
                case _PHASE_TUTORIAL:
                {
                    this.phaseTutorial();
                    break;
                }
                case _PHASE_MAIN:
                {
                    this.phaseMain();
                    break;
                }
                case _PHASE_RELOAD:
                {
                    this.phaseReload();
                    break;
                }
                case _PHASE_CLOSE:
                {
                    this.phaseClose();
                    break;
                }
                case _PHASE_MAINTENANCE:
                {
                    this.initPhaseMaintenance();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function control(param1:Number) : void
        {
            if (this._missionList)
            {
                this._missionList.control(param1);
            }
            switch(this._phase)
            {
                case _PHASE_LOADING:
                {
                    this.resourceLoaded();
                    break;
                }
                case _PHASE_OPEN:
                {
                    this.controlOpen();
                    break;
                }
                case _PHASE_MAIN:
                {
                    this.controlMain(param1);
                    break;
                }
                case _PHASE_RECEIVE_POPUP:
                {
                    this.controlReceivePopup(param1);
                    break;
                }
                case _PHASE_RELOAD:
                {
                    this.controlReload();
                    break;
                }
                case _PHASE_CLOSE:
                {
                    this.controlClose();
                    break;
                }
                case _PHASE_MAINTENANCE:
                {
                    this.controlPhaseMaintenance();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function phaseOpen() : void
        {
            this.setAllBtnEnable(false);
            this._isoTitle.setIn();
            this._isoInfo.setIn();
            this._isoChara.setIn();
            this._isoMain.setIn(function () : void
            {
                setPhase(_PHASE_MAINTENANCE);
                return;
            }// end function
            );
            return;
        }// end function

        private function controlOpen() : void
        {
            return;
        }// end function

        private function phaseTutorial() : void
        {
            if (TutorialManager.getInstance().isFacilityTutorial(TutorialManager.FACILITY_TUTORIAL_FLAG_DAILY_MISSION))
            {
                with ({})
                {
                    {}.cbClose = function () : void
            {
                setPhase(_PHASE_MAIN);
                return;
            }// end function
            ;
                }
                TutorialManager.getInstance().facilityTutorialPopup(TutorialManager.FACILITY_TUTORIAL_FLAG_DAILY_MISSION, function () : void
            {
                setPhase(_PHASE_MAIN);
                return;
            }// end function
            );
            }
            else
            {
                this.setPhase(_PHASE_MAIN);
            }
            return;
        }// end function

        private function phaseMain() : void
        {
            this.setAllBtnEnable(true);
            return;
        }// end function

        private function controlMain(param1:Number) : void
        {
            return;
        }// end function

        private function controlReceivePopup(param1:Number) : void
        {
            var _loc_2:* = false;
            this._receivePopup.control(param1);
            if (this._receivePopup.bEnd)
            {
                _loc_2 = this._receivePopup.bReloadRequest;
                this._receivePopup.release();
                this._receivePopup = null;
                if (_loc_2)
                {
                    this.setPhase(_PHASE_RELOAD);
                }
                else
                {
                    this._missionList.updateMission();
                    this.setPhase(_PHASE_MAIN);
                }
            }
            return;
        }// end function

        public function phaseReload() : void
        {
            this.setAllBtnEnable(false);
            this._bConnected = false;
            NetManager.getInstance().request(new NetTaskDailyMissionList(this.cbConnected));
            return;
        }// end function

        public function controlReload() : void
        {
            if (this._bConnected == false)
            {
                return;
            }
            this._missionList.updateMission();
            this.setPhase(_PHASE_MAIN);
            return;
        }// end function

        private function phaseClose() : void
        {
            Main.GetProcess().topBar.cbConfigWindow(null, null);
            this.setAllBtnEnable(false);
            this._isoTitle.setOut();
            this._isoInfo.setOut();
            this._isoChara.setOut();
            this._isoMain.setOut(function () : void
            {
                setPhase(_PHASE_END);
                return;
            }// end function
            );
            return;
        }// end function

        private function controlClose() : void
        {
            return;
        }// end function

        private function initPhaseMaintenance() : void
        {
            if (Main.GetApplicationData().maintenanceData.isMaintenanceTime())
            {
                Main.GetProcess().createMaintenanceWindow();
            }
            else
            {
                this.setPhase(_PHASE_TUTORIAL);
            }
            return;
        }// end function

        private function controlPhaseMaintenance() : void
        {
            if (Main.GetProcess().maintenance == null)
            {
                this.setPhase(_PHASE_TUTORIAL);
            }
            return;
        }// end function

        private function setAllBtnEnable(param1:Boolean) : void
        {
            this._bBtnEnable = param1;
            this._missionList.setButtonEnable(param1);
            this._btnReturn.setDisable(!param1);
            return;
        }// end function

        private function cbReturnBtn(param1:int) : void
        {
            this.setPhase(_PHASE_CLOSE);
            return;
        }// end function

        private function cbConfigWindowOpen() : void
        {
            this.setAllBtnEnable(false);
            return;
        }// end function

        private function cbConfigWindowClose() : void
        {
            this.setAllBtnEnable(this._phase == _PHASE_MAIN);
            return;
        }// end function

        private function cbGetEndBtn(param1:DailyMissionData) : void
        {
            this.setAllBtnEnable(false);
            this._receivePopup = new DailyMissionReceivePopup(param1);
            this.setPhase(_PHASE_RECEIVE_POPUP);
            return;
        }// end function

    }
}
