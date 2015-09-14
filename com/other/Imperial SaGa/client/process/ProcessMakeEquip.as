package process
{
    import button.*;
    import destinystone.*;
    import facility.*;
    import flash.display.*;
    import home.*;
    import item.*;
    import layer.*;
    import makeEquip.*;
    import message.*;
    import network.*;
    import player.*;
    import popup.*;
    import resource.*;
    import sound.*;
    import tutorial.*;
    import user.*;
    import utility.*;

    public class ProcessMakeEquip extends ProcessBase
    {
        private const _PHASE_MAIN_OPEN:int = 1;
        private const _PHASE_MAIN_SELECT:int = 2;
        private const _PHASE_SYNTHETIC:int = 10;
        private const _PHASE_DESTINY_STONE_SELECT:int = 11;
        private const _PHASE_SYNTHETIC_CONNECTION:int = 12;
        private const _PHASE_SYNTHETIC_PRODUCTION:int = 13;
        private const _PHASE_DECOMPOSITION:int = 20;
        private const _PHASE_DECOMPOSITION_CONNECTION:int = 21;
        private const _PHASE_DECOMPOSITION_PRODUCTION:int = 22;
        private const _PHASE_UPGRADE_ALL_CLOSE:int = 30;
        private const _PHASE_UPGRADE:int = 40;
        private const _PHASE_UPGRADE_RESOURCE:int = 41;
        private const _PHASE_RETURN:int = 100;
        private var _recipesLevel:int = 0;
        private var _phase:int;
        private var _syntheticType:int;
        private var _layer:LayerMakeEquip;
        private var _mcBg:MovieClip;
        private var _title:MakeEquipTitle;
        private var _destinyStone:MakeEquipDestinyStone;
        private var _synthesisStoneIdArray:Array;
        private var _messageWindow:MakeEquipMessageWindow;
        private var PreviouslyUsedStonesNums:Array;
        private var _syntheticTypeSelect:MakeEquipSyntheticTypeSelect;
        private var _destinyStoneSelect:MakeEquipDestinyStoneSelect;
        private var _syntheticProduction:MakeEquipSyntheticProduction;
        private var _decompositionSelect:MakeEquipDecompositionSelect;
        private var _decompositionPopup:MakeEquipPopup;
        private var _decompositionProduction:MakeEquipDecompositionProduction;
        private var _resultItemId:uint;
        private var _aResultStone:Array;
        private var _bWarehouse:Boolean;
        private var _facilityUpgrade:FacilityUpgrade;
        private var _upgradeDisabled:FacilityUpgradeDisabled;
        private var _bMoveTradingPost:Boolean;
        private var recepiesUpdatedKyokagoFlag:Boolean = false;
        private var recepiesUpdatedKaisigoFlag:Boolean = false;
        private static const _PHASE_MAINTENANCE:int = 90;

        public function ProcessMakeEquip()
        {
            this._syntheticType = Constant.UNDECIDED;
            this._aResultStone = [];
            this.PreviouslyUsedStonesNums = [0, 0, 0];
            this._bMoveTradingPost = false;
            return;
        }// end function

        override public function release() : void
        {
            super.release();
            if (this._facilityUpgrade)
            {
                this._facilityUpgrade.release();
            }
            this._facilityUpgrade = null;
            if (this._decompositionPopup)
            {
                this._decompositionPopup.release();
            }
            this._decompositionPopup = null;
            if (this._decompositionSelect)
            {
                this._decompositionSelect.release();
            }
            this._decompositionSelect = null;
            if (this._syntheticTypeSelect)
            {
                this._syntheticTypeSelect.release();
            }
            this._syntheticTypeSelect = null;
            if (this._destinyStoneSelect)
            {
                this._destinyStoneSelect.release();
            }
            this._destinyStoneSelect = null;
            if (this._messageWindow)
            {
                this._messageWindow.release();
            }
            this._messageWindow = null;
            if (this._destinyStone)
            {
                this._destinyStone.release();
            }
            this._destinyStone = null;
            if (this._title)
            {
                this._title.release();
            }
            this._title = null;
            if (this._mcBg)
            {
                if (this._mcBg.parent)
                {
                    this._mcBg.parent.removeChild(this._mcBg);
                }
            }
            this._mcBg = null;
            if (this._layer)
            {
                this._layer.release();
            }
            this._layer = null;
            this._upgradeDisabled.release();
            ButtonManager.getInstance().updateHit();
            TutorialManager.getInstance().release();
            return;
        }// end function

        override public function init() : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = null;
            super.init();
            ResourceManager.getInstance().loadResource(MakeEquipConstant.RESOURCE_PATH);
            ResourceManager.getInstance().loadResource(MakeEquipConstant.RESOURCE_ANIMATION_PATH);
            var _loc_1:* = [DestinyStoneId.MT_A_ORE_010, DestinyStoneId.MT_A_ORE_020, DestinyStoneId.MT_A_ORE_030, DestinyStoneId.MT_B_WOOD_010, DestinyStoneId.MT_B_WOOD_020, DestinyStoneId.MT_B_WOOD_030, DestinyStoneId.MT_C_FUR_010, DestinyStoneId.MT_C_FUR_020, DestinyStoneId.MT_C_FUR_030];
            for each (_loc_2 in _loc_1)
            {
                
                _loc_3 = ItemManager.getInstance().getDestinyStoneInformation(_loc_2);
                ResourceManager.getInstance().loadResource(ResourcePath.DESTINY_STONE_PATH + _loc_3.fileName);
            }
            CommonPopup.getInstance().loadResource([CommonPopup.POPUP_TYPE_NAVI, CommonPopup.POPUP_TYPE_NAVI_NORA]);
            if (TutorialManager.getInstance().isFacilityTutorial(TutorialManager.FACILITY_TUTORIAL_FLAG_MAKE_EQUIP) || TutorialManager.getInstance().isFacilityTutorial(TutorialManager.FACILITY_TUTORIAL_FLAG_MAKE_EQUIP_SYNTHETIC_3) || TutorialManager.getInstance().isFacilityTutorial(TutorialManager.FACILITY_TUTORIAL_FLAG_MAKE_EQUIP_DECOMPOSITION_1) || TutorialManager.getInstance().isFacilityUpgradeGuide())
            {
                TutorialManager.getInstance().loadResource();
            }
            SoundManager.getInstance().loadSound(SoundId.BGM_INS_STUDIO);
            SoundManager.getInstance().loadSoundArray([SoundId.SE_COMPOSE_START1016, SoundId.SE_COMPOSE_SUCSESS, SoundId.SE_COMPOSE_FALE, SoundId.SE_COMPOSING, SoundId.SE_LANDING1016B, SoundId.SE_RS3_OTHER_FLASH, SoundId.SE_REV_COMPOSE_WIND, SoundId.SE_REV_COMPOSE_STEAM, SoundId.SE_REV_COMPOSE_ANVIL]);
            TutorialManager.getInstance().stepReset();
            FacilityUpgrade.loadResource();
            _bResourceLoadWait = true;
            return;
        }// end function

        override public function controlResourceWait() : void
        {
            super.controlResourceWait();
            if (ResourceManager.getInstance().isLoaded() == false || SoundManager.getInstance().isLoaded() == false)
            {
                return;
            }
            SoundManager.getInstance().playBgm(SoundId.BGM_INS_STUDIO);
            this._layer = new LayerMakeEquip();
            addChild(this._layer);
            this._mcBg = ResourceManager.getInstance().createMovieClip(MakeEquipConstant.RESOURCE_PATH, "bgMc");
            this._layer.getLayer(LayerMakeEquip.BACKGROUND).addChild(this._mcBg);
            this._title = new MakeEquipTitle(this._layer.getLayer(LayerMakeEquip.TITLE));
            this._messageWindow = new MakeEquipMessageWindow(this._layer.getLayer(LayerMakeEquip.MESSAGE_WINDOW));
            _bResourceLoadWait = false;
            this._upgradeDisabled = new FacilityUpgradeDisabled(this._layer.getLayer(LayerMakeEquip.POPUP));
            this.setPhase(_PHASE_MAINTENANCE);
            return;
        }// end function

        override public function control(param1:Number) : void
        {
            super.control(param1);
            if (this._title)
            {
                if (this._phase == this._PHASE_MAIN_SELECT || this._phase == this._PHASE_SYNTHETIC || this._phase == this._PHASE_DESTINY_STONE_SELECT || this._phase == this._PHASE_DECOMPOSITION)
                {
                    if (this._title.bUpgrade)
                    {
                        this.setPhase(this._PHASE_UPGRADE_ALL_CLOSE);
                    }
                }
            }
            if (this._decompositionSelect != null)
            {
                this._decompositionSelect.control(param1);
            }
            switch(this._phase)
            {
                case this._PHASE_MAIN_OPEN:
                {
                    this.controlMainOpen(param1);
                    break;
                }
                case this._PHASE_MAIN_SELECT:
                {
                    this.controlMainSelect(param1);
                    break;
                }
                case this._PHASE_DESTINY_STONE_SELECT:
                {
                    this.controlDestinyStoneSelect(param1);
                    break;
                }
                case this._PHASE_SYNTHETIC_CONNECTION:
                {
                    this.controlSyntheticConnection(param1);
                    break;
                }
                case this._PHASE_SYNTHETIC_PRODUCTION:
                {
                    this.controlSyntheticProduction(param1);
                    break;
                }
                case this._PHASE_DECOMPOSITION:
                {
                    this.controlDecomposition(param1);
                    break;
                }
                case this._PHASE_DECOMPOSITION_CONNECTION:
                {
                    this.controlDecompositionConnection(param1);
                    break;
                }
                case this._PHASE_DECOMPOSITION_PRODUCTION:
                {
                    this.controlDecompositionProduction(param1);
                    break;
                }
                case this._PHASE_UPGRADE_ALL_CLOSE:
                {
                    this.controlUpgradeAllClose(param1);
                    break;
                }
                case this._PHASE_UPGRADE:
                {
                    this.controlUpgrade(param1);
                    break;
                }
                case this._PHASE_UPGRADE_RESOURCE:
                {
                    this.controlUpgradeResource(param1);
                    break;
                }
                case _PHASE_MAINTENANCE:
                {
                    this.controlPhaseMaintenance();
                    break;
                }
                case this._PHASE_RETURN:
                {
                    this.controlReturn(param1);
                    break;
                }
                default:
                {
                    break;
                }
            }
            if (this._phase == this._PHASE_RETURN || this._phase == this._PHASE_SYNTHETIC_CONNECTION || this._phase == this._PHASE_DECOMPOSITION_CONNECTION || this._destinyStoneSelect && this._destinyStoneSelect.bEntry || this._decompositionSelect && this._decompositionSelect.bEnd || this._syntheticProduction != null || this._decompositionProduction != null)
            {
                _bTopbarButtonDisable = true;
            }
            else
            {
                _bTopbarButtonDisable = false;
            }
            return;
        }// end function

        public function setPhase(param1:int) : void
        {
            this._phase = param1;
            switch(this._phase)
            {
                case this._PHASE_MAIN_OPEN:
                {
                    this.phaseMainOpen();
                    break;
                }
                case this._PHASE_MAIN_SELECT:
                {
                    this.phaseMainSelect();
                    break;
                }
                case this._PHASE_DESTINY_STONE_SELECT:
                {
                    this.phaseDestinyStoneSelect();
                    break;
                }
                case this._PHASE_SYNTHETIC_CONNECTION:
                {
                    this.phaseSyntheticConnection();
                    break;
                }
                case this._PHASE_SYNTHETIC_PRODUCTION:
                {
                    this.phaseSyntheticProduction();
                    break;
                }
                case this._PHASE_DECOMPOSITION:
                {
                    this.phaseDecomposition();
                    break;
                }
                case this._PHASE_DECOMPOSITION_CONNECTION:
                {
                    this.phaseDecompositionConnection();
                    break;
                }
                case this._PHASE_DECOMPOSITION_PRODUCTION:
                {
                    this.phaseDecompositionProduction();
                    break;
                }
                case this._PHASE_UPGRADE_ALL_CLOSE:
                {
                    this.phaseUpgradeAllClose();
                    break;
                }
                case this._PHASE_UPGRADE:
                {
                    this.phaseUpgrade();
                    break;
                }
                case this._PHASE_UPGRADE_RESOURCE:
                {
                    this.phaseUpgradeResource();
                    break;
                }
                case _PHASE_MAINTENANCE:
                {
                    this.initPhaseMaintenance();
                    break;
                }
                case this._PHASE_RETURN:
                {
                    this.phaseReturn();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function phaseMainOpen() : void
        {
            var _loc_1:* = null;
            _bTopbarButtonDisable = false;
            this.recepiesUpdatedKyokagoFlag = false;
            this.recepiesUpdatedKaisigoFlag = false;
            this.setWindowOpen(true);
            if (this._destinyStone)
            {
                this._destinyStone.release();
            }
            this._destinyStone = new MakeEquipDestinyStone(this._layer.getLayer(LayerMakeEquip.STONE));
            this._destinyStone.setButtonDisable(true);
            for each (_loc_1 in this._destinyStone.aRecipes)
            {
                
                _loc_1.setDisableFlag(true);
            }
            return;
        }// end function

        private function controlMainOpen(param1:Number) : void
        {
            if (this._title.bOpened)
            {
                this.setPhase(this._PHASE_MAIN_SELECT);
            }
            return;
        }// end function

        private function phaseMainSelect() : void
        {
            this._destinyStone.setButtonDisable(false);
            return;
        }// end function

        private function controlMainSelect(param1:Number) : void
        {
            var recipe4Btn:EquipButton;
            var recipeBtn:EquipButton;
            var t:* = param1;
            if (this._destinyStone != null && this._destinyStone.bEnd)
            {
                if (this._destinyStone.bSelectCreate)
                {
                    if (this._recipesLevel != this._destinyStone.resipesLevel)
                    {
                        this.PreviouslyUsedStonesNums = [0, 0, 0];
                    }
                    this._recipesLevel = this._destinyStone.resipesLevel;
                    this.setPhase(this._PHASE_DESTINY_STONE_SELECT);
                }
                if (this._destinyStone.bSelectDecomposition)
                {
                    this.setPhase(this._PHASE_DECOMPOSITION);
                }
                if (this._destinyStone.bSelectReturn)
                {
                    this.setPhase(this._PHASE_RETURN);
                }
                this._destinyStone.close();
                this._destinyStone.release();
                this._destinyStone = null;
            }
            if (TutorialManager.getInstance().isStepChange())
            {
                if (TutorialManager.getInstance().isFacilityTutorial(TutorialManager.FACILITY_TUTORIAL_FLAG_MAKE_EQUIP))
                {
                    TutorialManager.getInstance().facilityTutorialPopup(TutorialManager.FACILITY_TUTORIAL_FLAG_MAKE_EQUIP, function () : void
            {
                _destinyStone.UpdateRecipesSeals();
                return;
            }// end function
            );
                }
                else if (TutorialManager.getInstance().isFacilityUpgradeGuide())
                {
                    TutorialManager.getInstance().facilityTutorialPopup(TutorialManager.FACILITY_TUTORIAL_FLAG_FACILITY_UPGRADE_1, function () : void
            {
                TutorialManager.getInstance().setTutorialArrow(_title.btnUpgrade.getMoveClip(), TutorialManager.TUTORIAL_ARROW_DIRECTION_LEFT);
                return;
            }// end function
            );
                }
            }
            if (this._destinyStone && this._destinyStone.bOpened && this.recepiesUpdatedKaisigoFlag == false && this._upgradeDisabled.popUpEnd() == false)
            {
                this._destinyStone.UpdateRecipesSeals();
                var _loc_3:* = 0;
                var _loc_4:* = this._destinyStone.aRecipes;
                while (_loc_4 in _loc_3)
                {
                    
                    recipe4Btn = _loc_4[_loc_3];
                    recipe4Btn.setDisableFlag(false);
                }
                this.recepiesUpdatedKaisigoFlag = true;
            }
            if (this._upgradeDisabled)
            {
                this._upgradeDisabled.popUpControl(t, CommonConstant.FACILITY_ID_MAKE_EQUIP);
                if (this._upgradeDisabled.popUpEnd())
                {
                    if (this._destinyStone != null && this.recepiesUpdatedKyokagoFlag == false)
                    {
                        this._destinyStone.buttonNotIdPress(2);
                        this._destinyStone.UpdateRecipesSeals();
                        var _loc_3:* = 0;
                        var _loc_4:* = this._destinyStone.aRecipes;
                        while (_loc_4 in _loc_3)
                        {
                            
                            recipeBtn = _loc_4[_loc_3];
                            recipeBtn.setDisableFlag(true);
                        }
                        this.recepiesUpdatedKyokagoFlag = true;
                    }
                }
            }
            return;
        }// end function

        private function phaseDestinyStoneSelect() : void
        {
            var _loc_1:* = UserDataManager.getInstance().userData.getInstitutionInfo(CommonConstant.FACILITY_ID_MAKE_EQUIP);
            var _loc_2:* = TimeClock.getNowTime();
            if (_loc_1.upgradeEnd > _loc_2 && _loc_1.upgradeEnd != 0)
            {
                this._upgradeDisabled = new FacilityUpgradeDisabled(this._layer.getLayer(LayerMakeEquip.POPUP));
            }
            this._synthesisStoneIdArray = [];
            if (this._destinyStoneSelect)
            {
                this._destinyStoneSelect.release();
            }
            this._destinyStoneSelect = new MakeEquipDestinyStoneSelect(this._layer.getLayer(LayerMakeEquip.MAIN), this._layer.getLayer(LayerMakeEquip.POPUP), this._syntheticType, this._recipesLevel, this.PreviouslyUsedStonesNums);
            if (this._upgradeDisabled.facilityUpgrade(CommonConstant.FACILITY_ID_MAKE_EQUIP))
            {
                this._destinyStoneSelect.startBtn.setDisable(true);
                if (this._messageWindow.bClosed)
                {
                    this._messageWindow.open();
                }
                this._messageWindow.setMessageId(MessageId.FACILITY_UPGRADENOW_GUIDE_SYNTHESIS_MESSAGE);
            }
            this._synthesisStoneIdArray = MakeEquipConstant.aUseStone[this._syntheticType];
            return;
        }// end function

        private function controlDestinyStoneSelect(param1:Number) : void
        {
            if (this._upgradeDisabled)
            {
                this._upgradeDisabled.countControl(param1);
            }
            if (this._destinyStoneSelect)
            {
                this._destinyStoneSelect.control(param1);
                if (this._destinyStoneSelect.bEntry)
                {
                    this.PreviouslyUsedStonesNums = this._destinyStoneSelect._PrevRealArray;
                    this.setPhase(this._PHASE_SYNTHETIC_CONNECTION);
                }
                else if (this._destinyStoneSelect.bEnd)
                {
                    this._destinyStoneSelect.close();
                    this.PreviouslyUsedStonesNums = [0, 0, 0];
                    this._destinyStoneSelect.release();
                    this._destinyStoneSelect = null;
                    this._upgradeDisabled.close();
                    if (this._messageWindow.bOpened)
                    {
                        this._messageWindow.close();
                    }
                    this.setPhase(this._PHASE_MAIN_OPEN);
                }
            }
            if (TutorialManager.getInstance().isStepChange())
            {
                if (TutorialManager.getInstance().isFacilityTutorial(TutorialManager.FACILITY_TUTORIAL_FLAG_MAKE_EQUIP_SYNTHETIC_2))
                {
                    TutorialManager.getInstance().facilityTutorialPopup(TutorialManager.FACILITY_TUTORIAL_FLAG_MAKE_EQUIP_SYNTHETIC_2);
                }
            }
            return;
        }// end function

        private function phaseSyntheticConnection() : void
        {
            var _loc_3:* = undefined;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = null;
            var _loc_7:* = null;
            this._resultItemId = Constant.EMPTY_ID;
            var _loc_1:* = [];
            var _loc_2:* = this._destinyStoneSelect.aUseStoneNum;
            for (_loc_3 in _loc_2)
            {
                
                _loc_5 = parseInt(_loc_3.toString());
                _loc_1.push(new OwnMaterialData(_loc_5, _loc_2[_loc_3]));
            }
            _loc_4 = 0;
            while (_loc_4 < _loc_1.length)
            {
                
                if (_loc_1[_loc_4].materialId < _loc_1[0].materialId || _loc_1[_loc_4].materialId < _loc_1[1].materialId)
                {
                    _loc_6 = _loc_1.splice(_loc_4, 1);
                    _loc_1.unshift(_loc_6[0]);
                    _loc_4 = 0;
                }
                if (_loc_1[_loc_4].materialId < _loc_1[0].materialId)
                {
                    _loc_7 = _loc_1.splice(_loc_4, 1);
                    _loc_1.unshift(_loc_7[0]);
                    _loc_4 = 0;
                }
                _loc_4++;
            }
            this._bWarehouse = false;
            NetManager.getInstance().request(new NetTaskMakeEquip(this._destinyStoneSelect.syntheticType, _loc_1, this.cbMakeEquip));
            return;
        }// end function

        private function controlSyntheticConnection(param1:Number) : void
        {
            return;
        }// end function

        private function cbMakeEquip(param1:NetResult) : void
        {
            if (param1.resultCode != NetId.RESULT_OK)
            {
                return;
            }
            this._bWarehouse = GetItemInfo.checkAnyWarehouse(param1.data.getItemInfo);
            this._resultItemId = param1.data.itemId;
            this.setPhase(this._PHASE_SYNTHETIC_PRODUCTION);
            return;
        }// end function

        private function phaseSyntheticProduction() : void
        {
            this.setWindowOpen(false);
            this._syntheticProduction = new MakeEquipSyntheticProduction(this._layer.getLayer(LayerMakeEquip.MAIN), this._syntheticType, this._destinyStoneSelect.getWindowMovieClip(), this._resultItemId, this._bWarehouse);
            if (TutorialManager.getInstance().isFacilityTutorial(TutorialManager.FACILITY_TUTORIAL_FLAG_MAKE_EQUIP_SYNTHETIC_3))
            {
                TutorialManager.getInstance().stepChange(3);
            }
            return;
        }// end function

        private function controlSyntheticProduction(param1:Number) : void
        {
            if (this._syntheticProduction != null)
            {
                this._syntheticProduction.control(param1);
                if (this._syntheticProduction.bEnd)
                {
                    this._syntheticProduction.release();
                    this._syntheticProduction = null;
                    this._destinyStoneSelect.release();
                    this._destinyStoneSelect = null;
                    this.setPhase(this._PHASE_DESTINY_STONE_SELECT);
                    this.setWindowOpen(true);
                }
            }
            return;
        }// end function

        private function phaseDecomposition() : void
        {
            var _loc_1:* = UserDataManager.getInstance().userData.getInstitutionInfo(CommonConstant.FACILITY_ID_MAKE_EQUIP);
            var _loc_2:* = TimeClock.getNowTime();
            if (_loc_1.upgradeEnd > _loc_2 && _loc_1.upgradeEnd != 0)
            {
                this._upgradeDisabled = new FacilityUpgradeDisabled(this._layer.getLayer(LayerMakeEquip.POPUP));
            }
            if (this._messageWindow.bClosed)
            {
                this._messageWindow.open();
            }
            this._aResultStone = [];
            this._decompositionSelect = new MakeEquipDecompositionSelect(this._layer.getLayer(LayerMakeEquip.MAIN), this._layer.getLayer(LayerMakeEquip.POPUP));
            this._messageWindow.setMessageId(MessageId.MAKE_EQUIP_INFO_DECOMPO_SELECT);
            if (this._upgradeDisabled.facilityUpgrade(CommonConstant.FACILITY_ID_MAKE_EQUIP))
            {
                this._decompositionSelect.setButtonDisable(true);
                this._messageWindow.setMessageId(MessageId.FACILITY_UPGRADENOW_GUIDE_DECOMPOSITION_MESSAGE);
            }
            return;
        }// end function

        private function controlDecomposition(param1:Number) : void
        {
            if (this._upgradeDisabled)
            {
                this._upgradeDisabled.countControl(param1);
            }
            if (this._decompositionSelect)
            {
                if (this._decompositionSelect.enterItemId.length != 0)
                {
                    this._decompositionSelect.setButtonDisable(true);
                    this.setPhase(this._PHASE_DECOMPOSITION_CONNECTION);
                }
                else if (this._decompositionSelect.bEnd)
                {
                    this._decompositionSelect.release();
                    this._decompositionSelect = null;
                    this._upgradeDisabled.close();
                    if (this._messageWindow.bOpened)
                    {
                        this._messageWindow.close();
                    }
                    this.setPhase(this._PHASE_MAIN_OPEN);
                }
            }
            if (TutorialManager.getInstance().isFacilityTutorial(TutorialManager.FACILITY_TUTORIAL_FLAG_MAKE_EQUIP_DECOMPOSITION_1))
            {
                TutorialManager.getInstance().facilityTutorialPopup(TutorialManager.FACILITY_TUTORIAL_FLAG_MAKE_EQUIP_DECOMPOSITION_1);
            }
            return;
        }// end function

        private function phaseDecompositionConnection() : void
        {
            this._bWarehouse = false;
            NetManager.getInstance().request(new NetTaskMakeEquipDecomposition(this._decompositionSelect.enterItemId, this.cbDecompositionConnection));
            return;
        }// end function

        private function controlDecompositionConnection(param1:Number) : void
        {
            return;
        }// end function

        private function cbDecompositionConnection(param1:NetResult) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = null;
            this._bWarehouse = GetItemInfo.checkAnyWarehouse(param1.data.getItemInfo);
            for each (_loc_2 in param1.data.aMaterial)
            {
                
                _loc_5 = new OwnMaterialData(_loc_2.materialId, _loc_2.num);
                this._aResultStone.push(_loc_5);
            }
            _loc_3 = UserDataManager.getInstance().userData;
            for each (_loc_4 in this._decompositionSelect.enterItemId)
            {
                
                _loc_3.subOwnEquipItem(_loc_4, 1);
            }
            this.setPhase(this._PHASE_DECOMPOSITION_PRODUCTION);
            return;
        }// end function

        private function phaseDecompositionProduction() : void
        {
            this.setWindowOpen(false);
            if (this._messageWindow.bOpened)
            {
                this._messageWindow.close();
            }
            this._decompositionProduction = new MakeEquipDecompositionProduction(this._layer.getLayer(LayerMakeEquip.MAIN), this._decompositionSelect.getWindowMovieClip(), this._decompositionSelect.enterItemId, this._aResultStone, this._bWarehouse);
            return;
        }// end function

        private function controlDecompositionProduction(param1:Number) : void
        {
            if (this._decompositionProduction != null)
            {
                this._decompositionProduction.control(param1);
                if (this._decompositionProduction.bEnd)
                {
                    this._decompositionProduction.release();
                    this._decompositionProduction = null;
                    this._decompositionSelect.release();
                    this._decompositionSelect = null;
                    this.setPhase(this._PHASE_DECOMPOSITION);
                    this.setWindowOpen(true);
                }
            }
            return;
        }// end function

        private function phaseUpgradeAllClose() : void
        {
            this.setWindowOpen(false);
            if (this._messageWindow.bOpened)
            {
                this._messageWindow.close();
            }
            if (this._destinyStone)
            {
                this._destinyStone.close();
            }
            if (this._destinyStoneSelect)
            {
                this._destinyStoneSelect.close();
            }
            if (this._decompositionSelect)
            {
                this._decompositionSelect.close();
            }
            this._upgradeDisabled.close();
            return;
        }// end function

        private function controlUpgradeAllClose(param1:Number) : void
        {
            if (this._destinyStone)
            {
                if (this._destinyStone.bEnd)
                {
                    this._destinyStone._mc.visible = false;
                }
            }
            if (this._destinyStoneSelect)
            {
                this._destinyStoneSelect.control(param1);
                if (this._destinyStoneSelect.bEnd)
                {
                    this._destinyStoneSelect.release();
                    this._destinyStoneSelect = null;
                }
            }
            if (this._decompositionSelect)
            {
                this._decompositionSelect.control(param1);
                if (this._decompositionSelect.bEnd)
                {
                    this._decompositionSelect.release();
                    this._decompositionSelect = null;
                }
            }
            if (this._destinyStoneSelect == null && this._decompositionSelect == null)
            {
                this.setPhase(this._PHASE_UPGRADE_RESOURCE);
            }
            return;
        }// end function

        private function phaseUpgrade() : void
        {
            this.setWindowOpen(false);
            this._title.buttonSeal(true);
            if (this._synthesisStoneIdArray && this._synthesisStoneIdArray.length != 0)
            {
            }
            this._title.open();
            if (this._messageWindow.bOpened)
            {
                this._messageWindow.close();
            }
            ButtonManager.getInstance().push();
            var _loc_1:* = UserDataManager.getInstance().userData;
            this._facilityUpgrade = new FacilityUpgrade(this._layer.getLayer(LayerMakeEquip.MAIN), CommonConstant.FACILITY_ID_MAKE_EQUIP, _loc_1.aPlayerPersonal, this.cbUpgradeClose);
            this._facilityUpgrade.setGradeUpCallback(this.cbFacilityGradeUp);
            this._facilityUpgrade.open();
            return;
        }// end function

        private function controlUpgrade(param1:Number) : void
        {
            if (this._facilityUpgrade != null)
            {
                this._facilityUpgrade.control(param1);
            }
            return;
        }// end function

        private function cbUpgradeClose() : void
        {
            this._bMoveTradingPost = this._facilityUpgrade.bGoTradingPost;
            this._facilityUpgrade.release();
            this._facilityUpgrade = null;
            ButtonManager.getInstance().pop();
            this._title.buttonSeal(false);
            if (this._bMoveTradingPost)
            {
                this.setPhase(this._PHASE_RETURN);
            }
            else
            {
                this.setPhase(this._PHASE_MAIN_OPEN);
            }
            return;
        }// end function

        private function cbFacilityGradeUp() : void
        {
            this._title.setGrade();
            return;
        }// end function

        private function phaseUpgradeResource() : void
        {
            var _loc_2:* = null;
            var _loc_1:* = UserDataManager.getInstance().userData;
            for each (_loc_2 in _loc_1.aPlayerPersonal)
            {
                
                ResourceManager.getInstance().loadArray(PlayerManager.getInstance().getPlayerResourcePath(_loc_2.playerId));
            }
            return;
        }// end function

        private function controlUpgradeResource(param1:Number) : void
        {
            if (ResourceManager.getInstance().isLoaded() && SoundManager.getInstance().isLoaded())
            {
                this.setPhase(this._PHASE_UPGRADE);
            }
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
                this.setPhase(this._PHASE_MAIN_OPEN);
            }
            return;
        }// end function

        private function controlPhaseMaintenance() : void
        {
            if (Main.GetProcess().maintenance == null)
            {
                this.setPhase(this._PHASE_MAIN_OPEN);
            }
            return;
        }// end function

        private function phaseReturn() : void
        {
            _bTopbarButtonDisable = true;
            this._upgradeDisabled.close();
            this.setWindowOpen(false);
            if (this._messageWindow.bOpened)
            {
                this._messageWindow.close();
            }
            return;
        }// end function

        private function controlReturn(param1:Number) : void
        {
            if (this._title.bEnd)
            {
                if (this._bMoveTradingPost)
                {
                    Main.GetProcess().SetProcessId(ProcessMain.PROCESS_TRADING_POST);
                }
                else
                {
                    Main.GetProcess().SetProcessId(ProcessMain.PROCESS_HOME);
                }
                if (this._destinyStone)
                {
                    this._destinyStone.close();
                }
                if (this._destinyStone)
                {
                    if (this._destinyStone.bClosed)
                    {
                        this._destinyStone.release();
                        this._destinyStone = null;
                    }
                }
            }
            return;
        }// end function

        private function setWindowOpen(param1:Boolean) : void
        {
            if (param1)
            {
                if (this._title.bClosed)
                {
                    this._title.open();
                }
            }
            else if (this._title.bOpened)
            {
                this._title.close();
            }
            return;
        }// end function

    }
}
