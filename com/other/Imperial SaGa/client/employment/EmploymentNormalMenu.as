package employment
{
    import button.*;
    import character.*;
    import develop.*;
    import flash.display.*;
    import item.*;
    import layer.*;
    import message.*;
    import network.*;
    import player.*;
    import resource.*;
    import user.*;
    import utility.*;

    public class EmploymentNormalMenu extends EmploymentMenuBase
    {
        private var _phase:int;
        private var _mcBase:MovieClip;
        private var _isoMain:InStayOut;
        private var _aBtn:Array;
        private var _cbClose:Function;
        private var _layer:LayerEmployment;
        private var _fightMenu:EmploymentFightMenu;
        private var _aEmployPlayerInfo:Array;
        private var _employFightAnimation:EmploymentFightAnimation;
        private var _aCandidatePlayerId:Array;
        private var _employFightAnimation10:EmploymentFightAnimation10;
        private var _aConsumedStoneData:Array;
        private var _summonSpeed:Number;
        private var _bGoTradingPost:Boolean;
        private var _bGoRetire:Boolean;
        private static const _PHASE_OPEN:int = 0;
        private static const _PHASE_INPUT_WAIT:int = 1;
        private static const _PHASE_CONNECTING:int = 2;
        private static const _PHASE_RESOURCE_LOADING:int = 3;
        private static const _PHASE_ANIMATION:int = 4;
        private static const _PHASE_POPUP:int = 5;
        private static const _PHASE_CLOSE:int = 6;
        private static const _BUTTON_RETURN:int = 0;

        public function EmploymentNormalMenu(param1:LayerEmployment, param2:Array, param3:Array, param4:Function)
        {
            var _loc_6:* = null;
            var _loc_7:* = null;
            this._layer = param1;
            this._cbClose = param4;
            this._aEmployPlayerInfo = [];
            this._aConsumedStoneData = null;
            this._summonSpeed = 1;
            this._bGoTradingPost = false;
            this._bGoRetire = false;
            this._mcBase = ResourceManager.getInstance().createMovieClip(ResourcePath.GACHA_PATH + "UI_SummonFree.swf", "summonFreeMenu");
            this._layer.getLayer(LayerEmployment.MAIN).addChild(this._mcBase);
            this._fightMenu = new EmploymentFightMenu(this._mcBase.btnMenuMc, this.cbEmploymentFight, this.cbGotoTradingPost, this.cbGotoRetire);
            this._isoMain = new InStayOut(this._mcBase);
            var _loc_5:* = [{mc:this._mcBase.btnMenuMc.returnBtnMc, cbFunc:this.cbReturnButton, id:_BUTTON_RETURN, soundId:ButtonBase.SE_CANCEL_ID}];
            this._aBtn = [];
            for each (_loc_6 in _loc_5)
            {
                
                _loc_7 = ButtonManager.getInstance().addButton(_loc_6.mc, _loc_6.cbFunc, _loc_6.id);
                _loc_7.enterSeId = _loc_6.soundId;
                this._aBtn.push(_loc_7);
            }
            TextControl.setIdText(this._mcBase.btnMenuMc.returnBtnMc.textMc.textDt, MessageId.COMMON_BUTTON_RETURN);
            this.setPhase(_PHASE_OPEN);
            return;
        }// end function

        public function get bGoTradingPost() : Boolean
        {
            return this._bGoTradingPost;
        }// end function

        public function get bGoRetire() : Boolean
        {
            return this._bGoRetire;
        }// end function

        public function get bStay() : Boolean
        {
            return this._phase == _PHASE_INPUT_WAIT && (this._isoMain && this._isoMain.bAnimetion == false) && (this._fightMenu && this._fightMenu.bStay);
        }// end function

        override public function release() : void
        {
            var _loc_1:* = null;
            for each (_loc_1 in this._aBtn)
            {
                
                ButtonManager.getInstance().removeButton(_loc_1);
            }
            this._aBtn = null;
            if (this._fightMenu)
            {
                this._fightMenu.release();
            }
            this._fightMenu = null;
            if (this._employFightAnimation10)
            {
                this._employFightAnimation10.release();
            }
            this._employFightAnimation10 = null;
            if (this._employFightAnimation)
            {
                this._employFightAnimation.release();
            }
            this._employFightAnimation = null;
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
            this._layer.getLayer(LayerEmployment.ANIMATION_FRONT).removeChildren();
            this._layer = null;
            super.release();
            return;
        }// end function

        private function setPhase(param1:int) : void
        {
            this._phase = param1;
            switch(this._phase)
            {
                case _PHASE_OPEN:
                {
                    this.initPhaseOpen();
                    break;
                }
                case _PHASE_INPUT_WAIT:
                {
                    this.initPhaseInputWait();
                    break;
                }
                case _PHASE_CONNECTING:
                {
                    this.initPhaseConnecting();
                    break;
                }
                case _PHASE_RESOURCE_LOADING:
                {
                    this.initPhaseResourceLoading();
                    break;
                }
                case _PHASE_ANIMATION:
                {
                    this.initPhaseAnimation();
                    break;
                }
                case _PHASE_POPUP:
                {
                    this.initPhasePopup();
                    break;
                }
                case _PHASE_CLOSE:
                {
                    this.initPhaseClose();
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
            param1 = param1 * this._summonSpeed;
            switch(this._phase)
            {
                case _PHASE_INPUT_WAIT:
                {
                    this.controlPhaseInputWait(param1);
                    break;
                }
                case _PHASE_RESOURCE_LOADING:
                {
                    this.controlPhaseResourceLoading();
                    break;
                }
                default:
                {
                    break;
                }
            }
            if (this._employFightAnimation)
            {
                this._employFightAnimation.control(param1);
            }
            if (this._employFightAnimation10)
            {
                this._employFightAnimation10.control(param1);
            }
            return;
        }// end function

        private function initPhaseOpen() : void
        {
            this.resetSummonSpeed();
            this._layer.getLayer(LayerEmployment.ANIMATION_FRONT).visible = false;
            this.btnDisableFlag();
            this._fightMenu.updatePlayerNum();
            var menuOpen:* = function () : void
            {
                _fightMenu.open(function () : void
                {
                    setPhase(_PHASE_INPUT_WAIT);
                    return;
                }// end function
                );
                return;
            }// end function
            ;
            if (!this._isoMain.bOpened)
            {
                this._isoMain.setIn(menuOpen);
            }
            else
            {
                this.menuOpen();
            }
            return;
        }// end function

        private function initPhaseInputWait() : void
        {
            this.btnEnable(true);
            this._fightMenu.setBusy(false);
            return;
        }// end function

        private function controlPhaseInputWait(param1:Number) : void
        {
            if (this._fightMenu)
            {
                this._fightMenu.control(param1);
            }
            return;
        }// end function

        private function initPhaseConnecting() : void
        {
            this.btnEnable(false);
            this._fightMenu.setBusy(true);
            return;
        }// end function

        private function initPhaseResourceLoading() : void
        {
            this.btnEnable(false);
            if (this._fightMenu.bOpened)
            {
                this._fightMenu.close(function () : void
            {
                _fightMenu.allReset();
                return;
            }// end function
            );
            }
            return;
        }// end function

        private function controlPhaseResourceLoading() : void
        {
            if (ResourceManager.getInstance().isLoaded() && this._fightMenu.bEnd)
            {
                this.setPhase(_PHASE_ANIMATION);
            }
            return;
        }// end function

        private function initPhaseAnimation() : void
        {
            this.setSummonSpeed();
            this.btnEnable(false);
            if (this._employFightAnimation)
            {
                this._employFightAnimation.release();
            }
            this._employFightAnimation = null;
            if (this._employFightAnimation10)
            {
                this._employFightAnimation10.release();
            }
            this._employFightAnimation10 = null;
            this._layer.getLayer(LayerEmployment.ANIMATION_FRONT).removeChildren();
            this._layer.getLayer(LayerEmployment.ANIMATION_FRONT).visible = true;
            if (this._aEmployPlayerInfo.length <= 1)
            {
                this._employFightAnimation = new EmploymentFightAnimation(this._layer, this._aCandidatePlayerId, this._aEmployPlayerInfo, this.cbEmployAnimationClose);
                this._employFightAnimation.playAnimation();
            }
            else
            {
                if (this._employFightAnimation10 == null)
                {
                    this._employFightAnimation10 = new EmploymentFightAnimation10(this._layer, this._aCandidatePlayerId, this._aEmployPlayerInfo, this.cbEmployAnimationClose);
                }
                this._employFightAnimation10.playAnimation();
            }
            return;
        }// end function

        private function initPhasePopup() : void
        {
            this.btnEnable(false);
            this._fightMenu.btnEnable(false);
            return;
        }// end function

        private function initPhaseClose() : void
        {
            this.btnEnable(false);
            this._isoMain.setOut(function () : void
            {
                _cbClose();
                return;
            }// end function
            );
            this._fightMenu.close();
            return;
        }// end function

        private function btnEnable(param1:Boolean) : void
        {
            var _loc_2:* = null;
            for each (_loc_2 in this._aBtn)
            {
                
                _loc_2.setDisable(!param1);
            }
            return;
        }// end function

        private function btnDisableFlag() : void
        {
            var _loc_1:* = null;
            for each (_loc_1 in this._aBtn)
            {
                
                _loc_1.setDisable(false);
                _loc_1.setDisableFlag(true);
            }
            return;
        }// end function

        private function cbReturnButton(param1:int) : void
        {
            this.setPhase(_PHASE_CLOSE);
            return;
        }// end function

        private function cbDestinyStoneButton(param1:int) : void
        {
            this.setPhase(_PHASE_OPEN);
            return;
        }// end function

        private function cbEmploymentFight(param1:int) : void
        {
            this._aConsumedStoneData = [];
            var _loc_2:* = CommonConstant.EMPLOYMENT_ITEM_BASE * param1;
            if (param1 > 1)
            {
                NetManager.getInstance().request(new NetTaskEmploymentNormalBox(param1, _loc_2, this.cbConnectEmploymentFight));
            }
            else
            {
                NetManager.getInstance().request(new NetTaskEmploymentNormal(false, this._aConsumedStoneData, _loc_2, this.cbConnectEmploymentFight));
            }
            this.setPhase(_PHASE_CONNECTING);
            return;
        }// end function

        private function cbConnectEmploymentFight(param1:NetResult) : void
        {
            var _loc_2:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            checkConnectCommon(param1, null, this.updateCostDraw);
            if (bReset)
            {
                return;
            }
            var _loc_3:* = aWinnerId.length > 1 ? (ResourcePath.CARD_SMALL_PATH) : (ResourcePath.CARD_BIG_PATH);
            this._aEmployPlayerInfo = [];
            this._aCandidatePlayerId = [];
            for each (_loc_4 in aWinnerId)
            {
                
                _loc_2 = PlayerManager.getInstance().getPlayerInformation(_loc_4);
                ResourceManager.getInstance().loadResource(_loc_3 + CharacterConstant.ID_CARD + _loc_2.cardFileName);
                ResourceManager.getInstance().loadResource(ResourcePath.PLAYER_PATH + _loc_2.swf);
                this._aEmployPlayerInfo.push(_loc_2);
            }
            for each (_loc_5 in aOutId)
            {
                
                _loc_2 = PlayerManager.getInstance().getPlayerInformation(_loc_5);
                ResourceManager.getInstance().loadResource(ResourcePath.PLAYER_PATH + _loc_2.swf);
                this._aCandidatePlayerId.push(_loc_5);
            }
            this.setPhase(_PHASE_RESOURCE_LOADING);
            return;
        }// end function

        private function updateCostDraw() : void
        {
            this._fightMenu.allReset();
            return;
        }// end function

        private function cbEmploymentDestinyStone(param1:Array) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            this._aConsumedStoneData = param1;
            var _loc_2:* = [];
            for each (_loc_3 in this._aConsumedStoneData)
            {
                
                _loc_4 = {materialId:_loc_3.materialId, num:_loc_3.num};
                _loc_2.push(_loc_4);
            }
            NetManager.getInstance().request(new NetTaskEmploymentNormal(false, _loc_2, 0, this.cbConnectEmploymentDestinyStone));
            this.setPhase(_PHASE_CONNECTING);
            return;
        }// end function

        private function cbConnectEmploymentDestinyStone(param1:NetResult) : void
        {
            var _loc_2:* = PlayerManager.getInstance().getPlayerInformation(param1.data.employmentLotteryData.playerId);
            this._aEmployPlayerInfo = [_loc_2];
            ResourceManager.getInstance().loadResource(ResourcePath.PLAYER_PATH + _loc_2.swf);
            ResourceManager.getInstance().loadResource(ResourcePath.CARD_BIG_PATH + CharacterConstant.ID_CARD + _loc_2.cardFileName);
            var _loc_3:* = UserDataManager.getInstance().userData;
            _loc_3.setOwnDestinyStone(param1.data.aOwnMaterial);
            this.setPhase(_PHASE_RESOURCE_LOADING);
            return;
        }// end function

        private function cbGotoTradingPost() : void
        {
            this._bGoTradingPost = true;
            this.setPhase(_PHASE_CLOSE);
            return;
        }// end function

        private function cbGotoRetire() : void
        {
            this._bGoRetire = true;
            this.setPhase(_PHASE_CLOSE);
            return;
        }// end function

        private function cbClosePopup() : void
        {
            this.setPhase(_PHASE_INPUT_WAIT);
            return;
        }// end function

        private function cbEmployAnimationClose() : void
        {
            checkWarehouse(function () : void
            {
                setPhase(_PHASE_OPEN);
                return;
            }// end function
            );
            return;
        }// end function

        private function setSummonSpeed() : void
        {
            var _loc_1:* = Main.GetApplicationData().userConfigData;
            this._summonSpeed = _loc_1.setSummonSpeed();
            DebugLog.print("召喚演出スピード設定:" + this._summonSpeed + "倍");
            return;
        }// end function

        private function resetSummonSpeed() : void
        {
            var _loc_1:* = Main.GetApplicationData().userConfigData;
            _loc_1.resetSummonSpeed();
            this._summonSpeed = 1;
            DebugLog.print("召喚演出スピードをリセット");
            return;
        }// end function

    }
}
