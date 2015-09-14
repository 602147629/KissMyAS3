package retire
{
    import asset.*;
    import button.*;
    import flash.display.*;
    import item.*;
    import layer.*;
    import message.*;
    import network.*;
    import player.*;
    import playerList.*;
    import popup.*;
    import resource.*;
    import sound.*;
    import user.*;
    import utility.*;

    public class RetireMain extends Object
    {
        private var _phase:int;
        private var _parent:DisplayObjectContainer;
        private var _layer:LayerRetire;
        private var _mcBase:MovieClip;
        private var _isoMain:InStayOut;
        private var _isoPlayerList:InStayOut;
        private var _aPlayerPersonal:Array;
        private var _aPlayerRetireId:Array;
        private var _playerList:RetirePlayerList;
        private var _retireBox:RetireBox;
        private var _btnReturn:ButtonBase;
        private var _btnRetire:ButtonBase;
        private var _bBtnEnable:Boolean;
        private var _bJumpTradingPost:Boolean;
        private static const _PHASE_NONE:int = 0;
        private static const _PHASE_LOADING:int = 1;
        private static const _PHASE_OPEN:int = 2;
        private static const _PHASE_MAIN:int = 3;
        private static const _PHASE_BUSY:int = 4;
        private static const _PHASE_RETIRE_FLASH:int = 5;
        private static const _PHASE_CLOSE:int = 6;
        private static const _PHASE_END:int = 7;
        private static const _PHASE_MAINTENANCE:int = 90;

        public function RetireMain(param1:DisplayObjectContainer)
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            this._parent = param1;
            this._layer = null;
            Main.GetProcess().topBar.cbConfigWindow(this.cbConfigWindowOpen, this.cbConfigWindowClose);
            ResourceManager.getInstance().loadResource(ResourcePath.PLAYER_ANIM_PATH + "CharaAnim.swf");
            ResourceManager.getInstance().loadResource(ResourcePath.COMMON_DATA_PATH + "UI_Status.swf");
            ResourceManager.getInstance().loadResource(ResourcePath.RETIRE_PATH + "UI_Retreat.swf");
            RetirePlayerList.loadResource();
            CommonPopup.getInstance().loadResource();
            ResourceManager.getInstance().loadResource(ItemManager.getInstance().getItemPng(CommonConstant.ITEM_KIND_ASSET, AssetId.ASSET_GOLD_INSIGNIA));
            ResourceManager.getInstance().loadResource(ItemManager.getInstance().getItemPng(CommonConstant.ITEM_KIND_ASSET, AssetId.ASSET_SILVER_INSIGNIA));
            SoundManager.getInstance().loadSound(SoundId.BGM_BGM_MYP_ADEL_1);
            SoundManager.getInstance().loadSoundArray([SoundId.SE_GACHA_DISABLE, SoundId.SE_CHARA_SELECT, SoundId.SE_EFFECT, SoundId.SE_GAGE, SoundId.SE_BRANCH, SoundId.SE_JUMP2]);
            this._aPlayerPersonal = [];
            for each (_loc_2 in UserDataManager.getInstance().userData.aPlayerPersonal)
            {
                
                this._aPlayerPersonal.push(_loc_2.clone());
                _loc_3 = PlayerManager.getInstance().getPlayerInformation(_loc_2.playerId);
                ResourceManager.getInstance().loadResource(ResourcePath.PLAYER_PATH + _loc_3.swf);
            }
            this._bJumpTradingPost = false;
            this.setPhase(_PHASE_LOADING);
            return;
        }// end function

        public function isBusy() : Boolean
        {
            return this._phase != _PHASE_MAIN;
        }// end function

        public function get bClose() : Boolean
        {
            return this._isoMain && this._isoMain.bClosed && (this._isoPlayerList && this._isoPlayerList.bClosed);
        }// end function

        public function get bStay() : Boolean
        {
            return this._phase == _PHASE_MAIN && (this._isoMain && this._isoMain.bAnimetion == false);
        }// end function

        public function get bJumpTradingPost() : Boolean
        {
            return this._bJumpTradingPost;
        }// end function

        private function resourceLoaded() : void
        {
            this._layer = new LayerRetire();
            this._parent.addChild(this._layer);
            this._mcBase = ResourceManager.getInstance().createMovieClip(ResourcePath.RETIRE_PATH + "UI_Retreat.swf", "RetreatMc");
            this._layer.getLayer(LayerRetire.MAIN).addChild(this._mcBase);
            this._isoMain = new InStayOut(this._mcBase.RetreatMainMc);
            this._isoMain.setEnd();
            this._isoPlayerList = new InStayOut(this._mcBase.charaListMc);
            this._isoPlayerList.setEnd();
            this._playerList = null;
            this.resetPlayerList();
            this._retireBox = new RetireBox(this._mcBase.RetreatMainMc.RetreatBoxMc);
            var _loc_1:* = MessageManager.getInstance().getMessage(MessageId.RETIREMENT_ENTRY_TITLE);
            var _loc_2:* = _loc_1.split("\n");
            this._mcBase.RetreatMainMc.captionMc.gotoAndStop("linage" + (_loc_2.length > 1 ? ("2") : ("1")));
            TextControl.setText(this._mcBase.RetreatMainMc.captionMc.textMc.textDt, _loc_1);
            this._btnReturn = ButtonManager.getInstance().addButton(this._mcBase.charaListMc.returnBtnMc, this.cbReturnBtn);
            this._btnReturn.enterSeId = ButtonBase.SE_CANCEL_ID;
            TextControl.setIdText(this._mcBase.charaListMc.returnBtnMc.textMc.textDt, MessageId.COMMON_BUTTON_RETURN);
            this._btnRetire = ButtonManager.getInstance().addButton(this._mcBase.RetreatMainMc.RetreatBtnMc, this.cbRetireBtn);
            this._btnRetire.enterSeId = ButtonBase.SE_DECIDE_ID;
            TextControl.setIdText(this._mcBase.RetreatMainMc.RetreatBtnMc.textMc.textDt, MessageId.RETIREMENT_BUTTON_DECIDE);
            this._bBtnEnable = false;
            if (SoundManager.getInstance().bgmId != SoundId.BGM_BGM_MYP_ADEL_1)
            {
                SoundManager.getInstance().playBgm(SoundId.BGM_BGM_MYP_ADEL_1);
            }
            this.setPhase(_PHASE_OPEN);
            return;
        }// end function

        public function release() : void
        {
            ButtonManager.getInstance().removeButton(this._btnRetire);
            this._btnRetire = null;
            ButtonManager.getInstance().removeButton(this._btnReturn);
            this._btnReturn = null;
            if (this._retireBox)
            {
                this._retireBox.release();
            }
            this._retireBox = null;
            if (this._playerList)
            {
                this._playerList.release();
            }
            this._playerList = null;
            if (this._isoPlayerList)
            {
                this._isoPlayerList.release();
            }
            this._isoPlayerList = null;
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
                case _PHASE_MAIN:
                {
                    this.phaseMain();
                    break;
                }
                case _PHASE_BUSY:
                {
                    this.phaseBusy();
                    break;
                }
                case _PHASE_RETIRE_FLASH:
                {
                    this.phaseRetireFlash();
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
                case _PHASE_RETIRE_FLASH:
                {
                    this.controlRetireFlash();
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
                    break;
                }
            }
            return;
        }// end function

        private function phaseOpen() : void
        {
            this.setAllBtnEnable(false);
            this._isoPlayerList.setIn(function () : void
            {
                _isoMain.setIn(function () : void
                {
                    setPhase(_PHASE_MAINTENANCE);
                    return;
                }// end function
                );
                return;
            }// end function
            );
            return;
        }// end function

        private function controlOpen() : void
        {
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

        public function phaseBusy() : void
        {
            this.setAllBtnEnable(false);
            return;
        }// end function

        public function phaseRetireFlash() : void
        {
            this.setAllBtnEnable(false);
            this._playerList.resetSelect();
            this.resetPlayerList();
            this._retireBox.effectStart();
            return;
        }// end function

        private function controlRetireFlash() : void
        {
            var msg:String;
            if (this._retireBox.bStay)
            {
                msg = TextControl.formatIdText(MessageId.RETIREMENT_GET_INSIGNIA_POPUP_MESSAGE, this._retireBox.goldInsignia, this._retireBox.silverInsignia);
                this._retireBox.reset();
                CommonPopup.getInstance().openYesNoPopup(CommonPopup.POPUP_TYPE_NORMAL, msg, function (param1:Boolean) : void
            {
                if (param1)
                {
                    _bJumpTradingPost = true;
                    setPhase(_PHASE_CLOSE);
                }
                else
                {
                    setPhase(_PHASE_MAIN);
                }
                return;
            }// end function
            , MessageManager.getInstance().getMessage(MessageId.RETIREMENT_GET_INSIGNIA_POPUP_BUTTON), MessageManager.getInstance().getMessage(MessageId.COMMON_BUTTON_CLOSE));
                this.setPhase(_PHASE_BUSY);
            }
            return;
        }// end function

        private function phaseClose() : void
        {
            Main.GetProcess().topBar.cbConfigWindow(null, null);
            this._playerList.resetSelect();
            this.setAllBtnEnable(false);
            this._isoMain.setOut(function () : void
            {
                _isoPlayerList.setOut(function () : void
                {
                    setPhase(_PHASE_END);
                    return;
                }// end function
                );
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
                this.setPhase(_PHASE_MAIN);
            }
            return;
        }// end function

        private function controlPhaseMaintenance() : void
        {
            if (Main.GetProcess().maintenance == null)
            {
                this.setPhase(_PHASE_MAIN);
            }
            return;
        }// end function

        private function setAllBtnEnable(param1:Boolean) : void
        {
            this._bBtnEnable = param1;
            this._btnReturn.setDisable(!param1);
            this.updateRetireButtonEnable();
            this._playerList.setSelectEnable(param1);
            return;
        }// end function

        private function updateRetireButtonEnable() : void
        {
            var _loc_1:* = this._playerList.getMultiSelectPlayerUniqueIdArray();
            this._btnRetire.setDisable(!this._bBtnEnable || _loc_1.length <= 0);
            return;
        }// end function

        public function resetPlayerList() : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_1:* = [];
            for each (_loc_2 in this._aPlayerPersonal)
            {
                
                if (_loc_2.isUseFacility() || UserDataManager.getInstance().userData.aFormationPlayerUniqueId.indexOf(_loc_2.uniqueId) != -1 || _loc_2.isEmperor())
                {
                    _loc_1.push(_loc_2.uniqueId);
                }
            }
            if (this._playerList == null)
            {
                _loc_3 = [];
                for each (_loc_4 in this._aPlayerPersonal)
                {
                    
                    _loc_3.push(new ListPlayerData(_loc_4));
                }
                this._playerList = new RetirePlayerList(this._mcBase.charaListMc.reserveListMc, _loc_3, RetireBox.RETIRE_SELECT_PLAYER_MAX);
                this._playerList.setNotDisplayPlayer(_loc_1);
                this._playerList.setPlayerSelectCallback(this.cbPlayerSelectFunc);
                this._playerList.setPlayerUnselectCallback(this.cbPlayerUnselectFunc);
                this._playerList.setSelectCountOverCallback(this.cbSelectCountOverFunc);
                this._playerList.setRemainPlayerNumCallback(this.cbRemainPlayerNumFunc);
                this._playerList.setOverInsigniaNumCallback(this.cbOverInsigniaNumFunc);
                this._playerList.setCaptionText(MessageManager.getInstance().getMessage(MessageId.BARRACKS_SOLDIER_LIST_CAPTION));
                this._playerList.setSelectEnable(false);
                this._playerList.updateList();
            }
            else
            {
                this._playerList.setNotDisplayPlayer(_loc_1);
                this._playerList.updateList();
            }
            return;
        }// end function

        private function updateRetirePlayer() : void
        {
            var id:int;
            var pp:PlayerPersonal;
            var ppInfo:PlayerInformation;
            var userData:* = UserDataManager.getInstance().userData;
            var aId:* = this._playerList.getMultiSelectPlayerUniqueIdArray();
            var aInfo:Array;
            var _loc_2:* = 0;
            var _loc_3:* = aId;
            while (_loc_3 in _loc_2)
            {
                
                id = _loc_3[_loc_2];
                pp = userData.getPlayerPersonal(id);
                ppInfo = PlayerManager.getInstance().getPlayerInformation(pp.playerId);
                aInfo.push({info:ppInfo, uniqueId:id});
            }
            aInfo.sort(function (param1:Object, param2:Object) : int
            {
                return PlayerManager.getInstance().cmpRarityValue(param2.info.rarity, param1.info.rarity);
            }// end function
            );
            this._retireBox.setSelectedPlayer(aInfo);
            this.updateRetireButtonEnable();
            return;
        }// end function

        private function cbReturnBtn(param1:int) : void
        {
            this.setPhase(_PHASE_CLOSE);
            return;
        }// end function

        private function cbRetireBtn(param1:int) : void
        {
            var msg:String;
            var personal:PlayerPersonal;
            var pInfo:PlayerInformation;
            var id:* = param1;
            var aId:* = this._playerList.getMultiSelectPlayerUniqueIdArray();
            if (aId.length <= 0)
            {
                return;
            }
            this.setPhase(_PHASE_BUSY);
            var bContainRare:Boolean;
            var _loc_3:* = 0;
            var _loc_4:* = aId;
            while (_loc_4 in _loc_3)
            {
                
                id = _loc_4[_loc_3];
                var _loc_5:* = 0;
                var _loc_6:* = this._aPlayerPersonal;
                while (_loc_6 in _loc_5)
                {
                    
                    personal = _loc_6[_loc_5];
                    if (personal.uniqueId == id)
                    {
                        pInfo = PlayerManager.getInstance().getPlayerInformation(personal.playerId);
                        if (pInfo && PlayerManager.getInstance().needDeleteCheckRarity(pInfo.rarity))
                        {
                            bContainRare;
                            break;
                        }
                    }
                }
                if (bContainRare)
                {
                    break;
                }
            }
            if (bContainRare)
            {
                msg = MessageManager.getInstance().getMessage(MessageId.RETIREMENT_PLAYER__CHECK_RARE);
            }
            else
            {
                msg = MessageManager.getInstance().getMessage(MessageId.RETIREMENT_PLAYER__CHECK_NORMAL);
            }
            CommonPopup.getInstance().openYesNoPopup(CommonPopup.POPUP_TYPE_NORMAL, msg, function (param1:Boolean) : void
            {
                if (param1)
                {
                    _aPlayerRetireId = _playerList.getMultiSelectPlayerUniqueIdArray();
                    NetManager.getInstance().request(new NetTaskRetire(_aPlayerRetireId, cbConnectIntesification));
                }
                else
                {
                    setPhase(_PHASE_MAIN);
                }
                return;
            }// end function
            );
            return;
        }// end function

        private function cbConnectIntesification(param1:NetResult) : void
        {
            var _loc_4:* = 0;
            var _loc_2:* = UserDataManager.getInstance().userData;
            var _loc_3:* = _loc_2.aPlayerPersonal;
            _loc_4 = 0;
            while (_loc_4 < _loc_3.length)
            {
                
                if (this._aPlayerRetireId.indexOf(_loc_3[_loc_4].uniqueId) != -1)
                {
                    _loc_3.splice(_loc_4, 1);
                    _loc_4 = _loc_4 - 1;
                    ;
                }
                _loc_4++;
            }
            _loc_2.setOwnPlayer(_loc_3);
            _loc_4 = 0;
            while (_loc_4 < this._aPlayerPersonal.length)
            {
                
                if (this._aPlayerRetireId.indexOf(this._aPlayerPersonal[_loc_4].uniqueId) != -1)
                {
                    this._aPlayerPersonal.splice(_loc_4, 1);
                    _loc_4 = _loc_4 - 1;
                    ;
                }
                _loc_4++;
            }
            _loc_4 = 0;
            while (_loc_4 < this._aPlayerRetireId.length)
            {
                
                this._playerList.removePlayer(this._aPlayerRetireId[_loc_4]);
                _loc_4++;
            }
            this._aPlayerRetireId = [];
            this.setPhase(_PHASE_RETIRE_FLASH);
            return;
        }// end function

        private function cbPlayerSelectFunc(param1:int, param2:ListPlayerData) : void
        {
            this.updateRetirePlayer();
            return;
        }// end function

        private function cbPlayerUnselectFunc(param1:int, param2:ListPlayerData) : void
        {
            this.updateRetirePlayer();
            return;
        }// end function

        private function cbSelectCountOverFunc(param1:int, param2:ListPlayerData) : void
        {
            SoundManager.getInstance().playSe(SoundId.SE_GACHA_DISABLE);
            return;
        }// end function

        private function cbRemainPlayerNumFunc(param1:int, param2:ListPlayerData) : void
        {
            var listIndex:* = param1;
            var listPLayerData:* = param2;
            SoundManager.getInstance().playSe(SoundId.SE_GACHA_DISABLE);
            this.cbConfigWindowOpen();
            CommonPopup.getInstance().openAlertPopup(CommonPopup.POPUP_TYPE_NORMAL, MessageManager.getInstance().getMessage(MessageId.MINIMUM_NUMBER_CHECK_MESSAGE), function () : void
            {
                cbConfigWindowClose();
                return;
            }// end function
            );
            return;
        }// end function

        private function cbOverInsigniaNumFunc(param1:int, param2:ListPlayerData) : void
        {
            var listIndex:* = param1;
            var listPLayerData:* = param2;
            SoundManager.getInstance().playSe(SoundId.SE_GACHA_DISABLE);
            this.cbConfigWindowOpen();
            CommonPopup.getInstance().openAlertPopup(CommonPopup.POPUP_TYPE_NORMAL, MessageManager.getInstance().getMessage(MessageId.RETIREMENT_INSIGNIA_OVER_POPUP_MESSAGE), function () : void
            {
                cbConfigWindowClose();
                return;
            }// end function
            );
            return;
        }// end function

        public function cbConfigWindowOpen() : void
        {
            this.setAllBtnEnable(false);
            return;
        }// end function

        public function cbConfigWindowClose() : void
        {
            this.setAllBtnEnable(this._phase == _PHASE_MAIN);
            return;
        }// end function

    }
}
