package home
{
    import barracks.*;
    import flash.display.*;
    import item.*;
    import layer.*;
    import message.*;
    import network.*;
    import notice.*;
    import player.*;
    import popup.*;
    import status.*;
    import tradingPost.*;
    import tutorial.*;
    import user.*;
    import utility.*;

    public class HomeCurrentParty extends Object
    {
        private var _layer:LayerHome;
        private var _baseMc:MovieClip;
        private var _cbDirectHealingStart:Function;
        private var _cbDirectHealingEnd:Function;
        private var _isoMain:InStayOut;
        private var _curPartyStatus:CurrentPartyStatus;
        private var _healingBox:HomeHealingBox;
        private var _menu:HomeCurrentPartyMenu;
        private var _directRecoveryUniqueId:int;
        private var _mouseEnable:Boolean;
        private var _internalMouseEnable:Boolean;
        private var _bRestWait:Boolean;
        private var _bJumpTradingPost:Boolean;
        private var _bBusy:Boolean;

        public function HomeCurrentParty(param1:LayerHome, param2:MovieClip, param3:Function, param4:Function)
        {
            this._layer = param1;
            this._baseMc = param2;
            this._cbDirectHealingStart = param3;
            this._cbDirectHealingEnd = param4;
            var _loc_5:* = CommanderSkillUtility.isUnlockCommander();
            if (CommanderSkillUtility.isUnlockCommander())
            {
                this._baseMc.PartyInfoMc.gotoAndStop("commander");
            }
            else
            {
                this._baseMc.PartyInfoMc.gotoAndStop("normal");
            }
            this._isoMain = new InStayOut(this._baseMc);
            this._curPartyStatus = new CurrentPartyStatus(this._baseMc.PartyInfoMc, this._layer.getLayer(LayerHome.STATUS_POP), this.cbClickSelect, _loc_5);
            this._healingBox = new HomeHealingBox(this._baseMc.PartyInfoMc.ItemWindow, this._layer.getLayer(LayerHome.STATUS_POP));
            this._menu = new HomeCurrentPartyMenu(this._layer.getLayer(LayerHome.STATUS_POP), this.cbMenu);
            this._directRecoveryUniqueId = Constant.EMPTY_ID;
            this._mouseEnable = false;
            this._internalMouseEnable = false;
            this._bRestWait = false;
            this._bJumpTradingPost = false;
            this._bBusy = false;
            this._layer.getLayer(LayerHome.PARTY).addChild(this._baseMc);
            return;
        }// end function

        public function get bJumpTradingPost() : Boolean
        {
            return this._bJumpTradingPost;
        }// end function

        public function get bBusy() : Boolean
        {
            return this._bBusy;
        }// end function

        public function release() : void
        {
            if (this._menu)
            {
                this._menu.release();
            }
            this._menu = null;
            if (this._healingBox)
            {
                this._healingBox.release();
            }
            this._healingBox = null;
            if (this._curPartyStatus)
            {
                this._curPartyStatus.release();
            }
            this._curPartyStatus = null;
            if (this._isoMain)
            {
                this._isoMain.release();
            }
            this._isoMain = null;
            this._cbDirectHealingEnd = null;
            this._cbDirectHealingStart = null;
            if (this._baseMc != null && this._baseMc.parent != null)
            {
                this._baseMc.parent.removeChild(this._baseMc);
            }
            this._baseMc = null;
            this._layer = null;
            return;
        }// end function

        public function control(param1:Number) : void
        {
            if (this._isoMain.bOpened)
            {
                this._curPartyStatus.control(param1);
            }
            return;
        }// end function

        public function updatePartyCharacter() : void
        {
            this._curPartyStatus.updatePartyCharacter();
            return;
        }// end function

        public function setMouseEnable(param1:Boolean) : void
        {
            this._mouseEnable = param1;
            if (this._isoMain.bOpened)
            {
                this.updateMouseEnable();
            }
            return;
        }// end function

        public function setRestEndEffectWait(param1:Boolean) : void
        {
            this._bRestWait = param1;
            if (this._isoMain.bOpened)
            {
                this.updateMouseEnable();
            }
            return;
        }// end function

        private function updateMouseEnable() : void
        {
            var _loc_1:* = this._mouseEnable && this._internalMouseEnable && this._bRestWait == false;
            this._curPartyStatus.bSelectable = _loc_1;
            this._healingBox.setMouseEnable(_loc_1);
            this._menu.setMouseEnable(_loc_1);
            return;
        }// end function

        public function open() : void
        {
            if (this._isoMain.bClosed)
            {
                this._isoMain.setIn(this.cbIn);
            }
            else
            {
                this.cbIn();
            }
            return;
        }// end function

        private function cbIn() : void
        {
            this._internalMouseEnable = true;
            this.updateMouseEnable();
            return;
        }// end function

        public function close() : void
        {
            this._isoMain.setOut();
            this._healingBox.close();
            this._menu.close();
            this._internalMouseEnable = false;
            this.updateMouseEnable();
            return;
        }// end function

        public function setRestEndAction(param1:int) : void
        {
            this._curPartyStatus.setRestEndAction(param1);
            return;
        }// end function

        private function cbClickSelect(param1:int) : void
        {
            if (TutorialManager.getInstance().isFacilityTutorial(TutorialManager.FACILITY_TUTORIAL_FLAG_BARRACKS_3))
            {
                this._menu.close();
                this._healingBox.close();
                return;
            }
            var _loc_2:* = UserDataManager.getInstance().userData.getPlayerPersonal(this._curPartyStatus.clickSelectUniqueId);
            if (_loc_2 && _loc_2.getHpAtResting() < _loc_2.hpMax && (_loc_2.lastUseFacilityId != CommonConstant.FACILITY_ID_BARRACKS || this.isInstantEnable(_loc_2.uniqueId)))
            {
                this._menu.setPos(this._curPartyStatus.getBtnNull(param1));
                this._menu.open();
                this._healingBox.open();
            }
            else
            {
                this._menu.close();
                this._healingBox.close();
            }
            return;
        }// end function

        private function cbMenu() : void
        {
            this._bBusy = true;
            this._directRecoveryUniqueId = this._curPartyStatus.clickSelectUniqueId;
            this._menu.close();
            this._internalMouseEnable = false;
            this.updateMouseEnable();
            if (this._cbDirectHealingStart != null)
            {
                this._cbDirectHealingStart(this._directRecoveryUniqueId);
            }
            this.directRecoveryStart(this._directRecoveryUniqueId);
            return;
        }// end function

        private function directRecoveryStart(param1:int) : void
        {
            var useHealingPopup:BarracksUseHealingPopup;
            var barracksData:BarracksData;
            var uniqueId:* = param1;
            var instantRestoreItemNum:* = UserDataManager.getInstance().userData.getOwnPaymentItemNum(PaymentItemId.ITEM_INSTANT_HEALING);
            var freeHealingNum:* = UserDataManager.getInstance().userData.freeHealingNum;
            barracksData = this.getBarracksData(uniqueId);
            if (barracksData != null)
            {
                useHealingPopup = new BarracksUseHealingPopup(instantRestoreItemNum, freeHealingNum, true, function (param1:int) : void
            {
                var popupResult:* = param1;
                switch(popupResult)
                {
                    case BarracksUseHealingPopup.POPUP_RESULT_CLOSE:
                    default:
                    {
                        directRecoveryEnd(Constant.EMPTY_ID);
                        break;
                    }
                    case BarracksUseHealingPopup.POPUP_RESULT_USE_FREE_HEALING:
                    {
                        _bJumpTradingPost = true;
                        TradingPostStartPageRequest.getInstance().setRequestInstantHealing();
                        directRecoveryEnd(Constant.EMPTY_ID);
                        break;
                    }
                    case BarracksUseHealingPopup.POPUP_RESULT_USE_INSTANT_HEALING:
                    {
                        if (isInstantEnable(uniqueId) == false)
                        {
                            CommonPopup.getInstance().openAlertPopup(CommonPopup.POPUP_TYPE_NORMAL, MessageManager.getInstance().getMessage(MessageId.BARRACKS_POPUP_MESSAGE_RECOVER_NOT_NEEDED), function () : void
                {
                    directRecoveryEnd(Constant.EMPTY_ID);
                    return;
                }// end function
                );
                            return;
                        }
                        NetManager.getInstance().request(new NetTaskBarracksRestEnd(true, true, barracksData.index, cbConnectInstantRestore));
                        break;
                    }
                    case :
                    {
                        if (isInstantEnable(uniqueId) == false)
                        {
                            CommonPopup.getInstance().openAlertPopup(CommonPopup.POPUP_TYPE_NORMAL, MessageManager.getInstance().getMessage(MessageId.BARRACKS_POPUP_MESSAGE_RECOVER_NOT_NEEDED), function () : void
                {
                    directRecoveryEnd(Constant.EMPTY_ID);
                    return;
                }// end function
                );
                            return;
                        }
                        NetManager.getInstance().request(new NetTaskBarracksRestEnd(true, false, barracksData.index, cbConnectInstantRestore));
                        break;
                        break;
                    }
                }
                return;
            }// end function
            );
            }
            else
            {
                useHealingPopup = new BarracksUseHealingPopup(instantRestoreItemNum, freeHealingNum, true, function (param1:int) : void
            {
                switch(param1)
                {
                    case BarracksUseHealingPopup.POPUP_RESULT_CLOSE:
                    default:
                    {
                        directRecoveryEnd(Constant.EMPTY_ID);
                        ;
                    }
                    case BarracksUseHealingPopup.POPUP_RESULT_USE_FREE_HEALING:
                    {
                        _bJumpTradingPost = true;
                        TradingPostStartPageRequest.getInstance().setRequestInstantHealing();
                        directRecoveryEnd(Constant.EMPTY_ID);
                        ;
                    }
                    case BarracksUseHealingPopup.POPUP_RESULT_USE_INSTANT_HEALING:
                    {
                        NetManager.getInstance().request(new NetTaskDirectRecovery(uniqueId, true, cbConnectDirectRecovery));
                        ;
                    }
                    case :
                    {
                        NetManager.getInstance().request(new NetTaskDirectRecovery(uniqueId, false, cbConnectDirectRecovery));
                        ;
                        ;
                    }
                }
                return;
            }// end function
            );
            }
            return;
        }// end function

        private function cbConnectDirectRecovery(param1:NetResult) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = UserDataManager.getInstance().userData;
            var _loc_4:* = new PlayerPersonal();
            new PlayerPersonal().setParameter(param1.data.playerPersonal);
            var _loc_5:* = _loc_3.aPlayerPersonal;
            _loc_2 = 0;
            while (_loc_2 < _loc_5.length)
            {
                
                if (_loc_5[_loc_2].uniqueId == _loc_4.uniqueId)
                {
                    (_loc_5[_loc_2] as PlayerPersonal).copyParam(_loc_4);
                    break;
                }
                _loc_2++;
            }
            _loc_3.setOwnPlayer(_loc_5);
            this._curPartyStatus.updatePartyCharacter();
            this.directRecoveryEnd(this._directRecoveryUniqueId);
            return;
        }// end function

        private function cbConnectInstantRestore(param1:NetResult) : void
        {
            var i:int;
            var res:* = param1;
            if (res.data.alreadyRest == 1)
            {
                CommonPopup.getInstance().openAlertPopup(CommonPopup.POPUP_TYPE_NORMAL, MessageManager.getInstance().getMessage(MessageId.BARRACKS_POPUP_MESSAGE_RECOVER_NOT_NEEDED), function () : void
            {
                directRecoveryEnd(Constant.EMPTY_ID);
                return;
            }// end function
            );
                return;
            }
            var userData:* = UserDataManager.getInstance().userData;
            var newPersonal:* = new PlayerPersonal();
            newPersonal.setParameter(res.data.playerPersonal);
            userData.setOwnPaymentItem(res.data.aOwnPaymentItemData);
            this._healingBox.updateNum();
            var aPlayerPersonal:* = userData.aPlayerPersonal;
            i;
            while (i < aPlayerPersonal.length)
            {
                
                if (aPlayerPersonal[i].uniqueId == newPersonal.uniqueId)
                {
                    (aPlayerPersonal[i] as PlayerPersonal).copyParam(newPersonal);
                    break;
                }
                i = (i + 1);
            }
            userData.setOwnPlayer(aPlayerPersonal);
            this._curPartyStatus.updatePartyCharacter();
            var barracksData:* = this.getBarracksData(this._directRecoveryUniqueId);
            if (barracksData)
            {
                barracksData.setData(Constant.EMPTY_ID, 0, Constant.EMPTY_ID);
                userData.resetBarracksData(barracksData.index, barracksData.uniqueId, barracksData.restoreTime, barracksData.noticeId);
            }
            NoticeManager.getInstance().crearSimpleNoticeById(res.data.institutionNoticeId);
            this.directRecoveryEnd(this._directRecoveryUniqueId);
            return;
        }// end function

        private function getBarracksData(param1:int) : BarracksData
        {
            var _loc_3:* = null;
            var _loc_2:* = UserDataManager.getInstance().userData.aBarracksData;
            for each (_loc_3 in _loc_2)
            {
                
                if (_loc_3.uniqueId == param1)
                {
                    return _loc_3;
                }
            }
            return null;
        }// end function

        private function isInstantEnable(param1:int) : Boolean
        {
            var _loc_4:* = 0;
            var _loc_2:* = 0;
            var _loc_3:* = UserDataManager.getInstance().userData.getPlayerPersonal(param1);
            if (_loc_3)
            {
                _loc_4 = TimeClock.getNowTime();
                _loc_2 = _loc_3.restoreEndTime > _loc_4 ? (_loc_3.restoreEndTime - _loc_4) : (0);
            }
            return _loc_2 > Constant.INSTANT_MARGIN_SEC;
        }// end function

        private function directRecoveryEnd(param1:int) : void
        {
            this._curPartyStatus.clearClickSelect();
            this._menu.close();
            this._healingBox.close();
            this._internalMouseEnable = true;
            if (this._cbDirectHealingEnd != null)
            {
                this._cbDirectHealingEnd(param1);
            }
            this.updateMouseEnable();
            this._bBusy = false;
            return;
        }// end function

    }
}
