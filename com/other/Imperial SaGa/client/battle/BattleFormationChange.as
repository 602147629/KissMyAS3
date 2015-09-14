package battle
{
    import button.*;
    import flash.display.*;
    import formation.*;
    import formationSettings.*;
    import message.*;
    import player.*;
    import resource.*;
    import status.*;
    import user.*;
    import utility.*;

    public class BattleFormationChange extends Object
    {
        private var _phase:int;
        private var _parent:DisplayObjectContainer;
        private var _mcBase:MovieClip;
        private var _isoMain:InStayOut;
        private var _bFormationNotBe:Boolean;
        private var _formationSettings:FormationSettings;
        private var _btnDecision:ButtonBase;
        private var _btnReturn:ButtonBase;
        private var _selectedFormationId:int;
        private var _selectedPlayerUniqueId:int;
        private var _cbCloseStart:Function;
        private var _cbCloseEnd:Function;
        private var _bDecision:Boolean;
        private var _bJumping:Boolean;
        private var _battleManager:BattleManager;
        private static const _PHASE_OPEN:int = 0;
        private static const _PHASE_INPUT_WAIT:int = 1;
        private static const _PHASE_CLOSE:int = 2;

        public function BattleFormationChange(param1:DisplayObjectContainer, param2:BattleManager, param3:Function, param4:Function)
        {
            this._battleManager = param2;
            this._bFormationNotBe = false;
            this._formationSettings = null;
            this._selectedFormationId = Constant.EMPTY_ID;
            this._selectedPlayerUniqueId = Constant.EMPTY_ID;
            this._cbCloseStart = param3;
            this._cbCloseEnd = param4;
            this._mcBase = ResourceManager.getInstance().createMovieClip(ResourcePath.BATTLE_PATH + "UI_BattleMain.swf", "FormationChangeMc");
            param1.addChild(this._mcBase);
            this._isoMain = new InStayOut(this._mcBase);
            this._btnDecision = ButtonManager.getInstance().addButton(this._mcBase.decisionBtnMc, this.cbClickDecisionBtn);
            this._btnDecision.enterSeId = ButtonBase.SE_DECIDE_ID;
            this._btnDecision.setDisableFlag(true);
            this._btnReturn = ButtonManager.getInstance().addButton(this._mcBase.returnBtnMc, this.cbClickReturnBtn);
            this._btnReturn.enterSeId = ButtonBase.SE_CANCEL_ID;
            this._btnReturn.setDisableFlag(true);
            TextControl.setIdText(this._mcBase.returnBtnMc.textMc.textDt, MessageId.COMMON_BUTTON_RETURN);
            this._mcBase.visible = false;
            this._bDecision = false;
            this._bJumping = false;
            return;
        }// end function

        public function get selectedFormationId() : int
        {
            return this._selectedFormationId;
        }// end function

        public function get selectedPlayerId() : int
        {
            return this._selectedPlayerUniqueId;
        }// end function

        public function get aFormationPlayerUniqueId() : Array
        {
            return this._formationSettings.aFormationPlayerUniqueId;
        }// end function

        public function get bOpened() : Boolean
        {
            return this._isoMain && this._isoMain.bOpened;
        }// end function

        public function release() : void
        {
            ButtonManager.getInstance().removeButton(this._btnDecision);
            this._btnDecision = null;
            ButtonManager.getInstance().removeButton(this._btnReturn);
            this._btnReturn = null;
            if (this._isoMain)
            {
                this._isoMain.release();
            }
            this._isoMain = null;
            if (this._formationSettings)
            {
                this._formationSettings.release();
            }
            this._formationSettings = null;
            if (this._mcBase && this._mcBase.parent)
            {
                this._mcBase.parent.removeChild(this._mcBase);
            }
            this._mcBase = null;
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
            switch(this._phase)
            {
                case _PHASE_INPUT_WAIT:
                {
                    this.controlPhaseInputWait(param1);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function initPhaseOpen() : void
        {
            this.btnEnable(false);
            this._formationSettings.setSelectEnable(false);
            this._mcBase.visible = true;
            this._isoMain.setIn(function () : void
            {
                setPhase(_PHASE_INPUT_WAIT);
                return;
            }// end function
            );
            return;
        }// end function

        private function initPhaseInputWait() : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            this.btnEnable(true);
            this._formationSettings.setSelectEnable(true);
            var _loc_1:* = 0;
            while (_loc_1 < 5)
            {
                
                _loc_2 = this._formationSettings.getPersonalAtFormationIndex(_loc_1);
                if (_loc_2)
                {
                    _loc_3 = (this._battleManager.getCharacter(_loc_2.questUniqueId) as BattlePlayer).playerPersonal;
                    this.updateStatus(_loc_3);
                    break;
                }
                _loc_1++;
            }
            return;
        }// end function

        private function controlPhaseInputWait(param1:Number) : void
        {
            if (this._formationSettings)
            {
                this._formationSettings.control(param1);
                if (this._bJumping && !this._formationSettings.isJumping())
                {
                    this._bJumping = false;
                    this.btnEnable(true);
                }
            }
            return;
        }// end function

        private function initPhaseClose() : void
        {
            this.btnEnable(false);
            this._formationSettings.setSelectEnable(false);
            if (this._cbCloseStart != null)
            {
                this._cbCloseStart(this._bDecision);
            }
            this._isoMain.setOut(function () : void
            {
                if (_cbCloseEnd != null)
                {
                    _cbCloseEnd(_bDecision);
                }
                _mcBase.visible = false;
                return;
            }// end function
            );
            return;
        }// end function

        private function btnEnable(param1:Boolean) : void
        {
            this._btnDecision.setDisableFlag(!param1);
            this._btnReturn.setDisableFlag(!param1);
            return;
        }// end function

        public function openFormationChange(param1:FormationSetData, param2:Boolean) : void
        {
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            if (this._isoMain.bOpened)
            {
                return;
            }
            this._bFormationNotBe = param2;
            var _loc_3:* = [];
            var _loc_4:* = [Constant.EMPTY_ID, Constant.EMPTY_ID, Constant.EMPTY_ID, Constant.EMPTY_ID, Constant.EMPTY_ID, Constant.EMPTY_ID];
            for each (_loc_5 in this._battleManager.getEntryPlayer())
            {
                
                _loc_4[_loc_5.formationIndex] = _loc_5.playerPersonal.uniqueId;
                _loc_3.push(_loc_5.playerPersonal);
            }
            if (this._battleManager.commanderPlayer)
            {
                _loc_4[FormationSetData.FORMATION_INDEX_COMMANDER] = this._battleManager.commanderPlayer.playerPersonal.uniqueId;
                _loc_3.push(this._battleManager.commanderPlayer.playerPersonal);
            }
            if (this._formationSettings == null)
            {
                _loc_6 = UserDataManager.getInstance().userData;
                this._formationSettings = new FormationSettings(this._mcBase.formationPageMc, this._mcBase.formationAreaMc, this._mcBase.formationInfoMc, this._mcBase.formationSkillInfoMc, this._mcBase.commanderSkillSet, param1.id, _loc_3, _loc_4, false, null, false, param2);
                this._formationSettings.cbFormationChangedFunc = this.cbFormationUpdated;
                this._formationSettings.cbFormationPositionChangedFunc = this.cbFormationUpdated;
                this._formationSettings.cbFormationPlayerOverFunc = this.cbFormationPlayerOver;
                this._formationSettings.setStatusInvisibleFlag(PlayerMiniStatus.INVISIBLE_FLAG_NAME | PlayerMiniStatus.INVISIBLE_FLAG_RARITY);
            }
            else
            {
                this._formationSettings.bFormationNotBe = param2;
                this._formationSettings.setPlayerList(_loc_3);
                _loc_7 = 0;
                for each (_loc_8 in _loc_4)
                {
                    
                    this._formationSettings.setFormationPlayerUniqueId(_loc_7, _loc_8);
                    _loc_7++;
                }
                this._formationSettings.selectFormation(param1.id);
                this._formationSettings.resetJumpPosition();
            }
            this._mcBase.visible = true;
            this.setPhase(_PHASE_OPEN);
            return;
        }// end function

        private function cbClickDecisionBtn(param1:int) : void
        {
            this._selectedFormationId = this._formationSettings.selectedFormationId;
            this._bDecision = true;
            this.setPhase(_PHASE_CLOSE);
            return;
        }// end function

        private function cbClickReturnBtn(param1:int) : void
        {
            this._bDecision = false;
            this.setPhase(_PHASE_CLOSE);
            return;
        }// end function

        private function cbFormationPlayerOver(param1:int, param2:PlayerPersonal) : void
        {
            var _loc_3:* = null;
            if (param2)
            {
                _loc_3 = (this._battleManager.getCharacter(param2.questUniqueId) as BattlePlayer).playerPersonal;
                this.updateStatus(_loc_3);
            }
            return;
        }// end function

        private function cbFormationUpdated(param1:int = -1) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_2:* = [];
            for each (_loc_3 in this._battleManager.getEntryPlayer())
            {
                
                _loc_2.push(_loc_3.playerPersonal);
            }
            if (this._bFormationNotBe)
            {
                FormationBonusUtility.resetFormationBonus(_loc_2);
            }
            else
            {
                FormationBonusUtility.updateFormationBonus(this._formationSettings.selectedFormationId, this._formationSettings.aFormationPlayerUniqueId, _loc_2);
            }
            for each (_loc_4 in _loc_2)
            {
                
                if (this._selectedPlayerUniqueId == _loc_4.uniqueId)
                {
                    this.updateStatus(_loc_4);
                    break;
                }
            }
            this._bJumping = true;
            this.btnEnable(false);
            return;
        }// end function

        private function updateStatus(param1:PlayerPersonal) : void
        {
            var _loc_2:* = this._mcBase.charaStatusInfoMc;
            if (this._selectedPlayerUniqueId != Constant.EMPTY_ID && this._selectedPlayerUniqueId != param1.uniqueId)
            {
                _loc_2.gotoAndPlay("change");
            }
            this._selectedPlayerUniqueId = param1.uniqueId;
            TextControl.setIdText(_loc_2.charaStatusMc.charaStatus1TextMc.textDt, MessageId.COMMON_STATUS_HP);
            TextControl.setIdText(_loc_2.charaStatusMc.charaStatus2TextMc.textDt, MessageId.COMMON_STATUS_LP);
            TextControl.setIdText(_loc_2.charaStatusMc.charaStatus3TextMc.textDt, MessageId.COMMON_STATUS_SP);
            TextControl.setIdText(_loc_2.charaStatusMc.charaStatus4TextMc.textDt, MessageId.COMMON_STATUS_ATTACK);
            TextControl.setIdText(_loc_2.charaStatusMc.charaStatus5TextMc.textDt, MessageId.COMMON_STATUS_DEFENSE);
            TextControl.setIdText(_loc_2.charaStatusMc.charaStatus6TextMc.textDt, MessageId.COMMON_STATUS_SPEED);
            var _loc_3:* = PlayerManager.getInstance().getPlayerInformation(param1.playerId);
            var _loc_4:* = param1 && param1.isEmperor();
            var _loc_5:* = String(param1.hp + "/" + param1.hpMax);
            var _loc_6:* = _loc_4 ? ("-") : (String(param1.lp + "/" + _loc_3.lp));
            var _loc_7:* = String(param1.sp + "/" + param1.spMax);
            TextControl.setText(_loc_2.charaStatusMc.charaNameMc.textDt, _loc_3.name);
            TextControl.setText(_loc_2.charaStatusMc.charaStatusNum1TextMc.textDt, _loc_5);
            TextControl.setText(_loc_2.charaStatusMc.charaStatusNum2TextMc.textDt, _loc_6);
            TextControl.setText(_loc_2.charaStatusMc.charaStatusNum3TextMc.textDt, _loc_7);
            TextControl.setText(_loc_2.charaStatusMc.charaStatusNum4TextMc.textDt, param1.attackTotal.toString());
            TextControl.setText(_loc_2.charaStatusMc.charaStatusNum5TextMc.textDt, param1.defenseTotal.toString());
            TextControl.setText(_loc_2.charaStatusMc.charaStatusNum6TextMc.textDt, param1.speedTotal.toString());
            TextControl.setBonusText(_loc_2.charaStatusMc.statusNumSub1TextMc, param1.isBonusAttack(), param1.bonusAttackTotal);
            TextControl.setBonusText(_loc_2.charaStatusMc.statusNumSub2TextMc, param1.isBonusDefense(), param1.bonusDefenseTotal);
            TextControl.setBonusText(_loc_2.charaStatusMc.statusNumSub3TextMc, param1.isBonusSpeed(), param1.bonusSpeedTotal);
            return;
        }// end function

    }
}
