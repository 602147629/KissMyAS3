package skillInitiate
{
    import button.*;
    import flash.display.*;
    import icon.*;
    import item.*;
    import message.*;
    import player.*;
    import popup.*;
    import resource.*;
    import skill.*;
    import user.*;
    import utility.*;

    public class SIConfirmPopup extends Object
    {
        private const _PHASE_OPEN:int = 1;
        private const _PHASE_UPDATE:int = 10;
        private const _PHASE_CONFIRM:int = 20;
        private const _PHASE_CLOSE:int = 99;
        private var _parent:DisplayObjectContainer;
        private var _siManager:SkillInitiateManager;
        private var _phase:int;
        private var _bEnd:Boolean;
        private var _bConfirm:Boolean;
        private var _baseMc:MovieClip;
        private var _isoBase:InStayOut;
        private var _yesButton:ButtonBase;
        private var _noButton:ButtonBase;

        public function SIConfirmPopup(param1:DisplayObjectContainer, param2:SkillInitiateManager)
        {
            this._parent = param1;
            this._siManager = param2;
            this._bEnd = false;
            this._bConfirm = false;
            this.setPhase(this._PHASE_OPEN);
            return;
        }// end function

        public function get bEnd() : Boolean
        {
            return this._bEnd && (this._isoBase == null || this._isoBase.bEnd);
        }// end function

        public function get bConfirm() : Boolean
        {
            return this._bConfirm;
        }// end function

        public function release() : void
        {
            if (this._yesButton)
            {
                ButtonManager.getInstance().removeButton(this._yesButton);
            }
            if (this._noButton)
            {
                ButtonManager.getInstance().removeButton(this._noButton);
            }
            if (this._isoBase)
            {
                this._isoBase.release();
            }
            this._isoBase = null;
            if (this._baseMc && this._baseMc.parent)
            {
                this._baseMc.parent.removeChild(this._baseMc);
            }
            this._baseMc = null;
            this._siManager = null;
            this._parent = null;
            return;
        }// end function

        public function control(param1:Number) : void
        {
            return;
        }// end function

        private function setPhase(param1:int) : void
        {
            if (param1 != this._phase)
            {
                this._phase = param1;
                switch(param1)
                {
                    case this._PHASE_OPEN:
                    {
                        this.phaseOpen();
                        break;
                    }
                    case this._PHASE_UPDATE:
                    {
                        this.phaseUpdate();
                        break;
                    }
                    case this._PHASE_CONFIRM:
                    {
                        this.phaseConfirm();
                        break;
                    }
                    case this._PHASE_CLOSE:
                    {
                        this.phaseClose();
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
            }
            return;
        }// end function

        private function phaseOpen() : void
        {
            if (this._siManager.isHaveSkill)
            {
                this.setPhase(this._PHASE_UPDATE);
            }
            else
            {
                this.setPhase(this._PHASE_CONFIRM);
            }
            return;
        }// end function

        private function phaseUpdate() : void
        {
            CommonPopup.getInstance().openYesNoPopup(CommonPopup.POPUP_TYPE_NORMAL, MessageManager.getInstance().getMessage(MessageId.SKILL_INITIATE_CONFIRM_UPDATE), function (param1:Boolean) : void
            {
                if (param1)
                {
                    setPhase(_PHASE_CONFIRM);
                }
                else
                {
                    setPhase(_PHASE_CLOSE);
                }
                return;
            }// end function
            );
            return;
        }// end function

        private function phaseConfirm() : void
        {
            this._baseMc = ResourceManager.getInstance().createMovieClip(ResourcePath.FACILITY_PATH + "UI_SkillInitiate.swf", "InfoPopup");
            this._isoBase = new InStayOut(this._baseMc);
            var userData:* = UserDataManager.getInstance().userData;
            var skillInfo:* = SkillManager.getInstance().getSkillInformation(this._siManager.skillId);
            var sPP:* = userData.getPlayerPersonal(this._siManager.studentId);
            var sPI:* = PlayerManager.getInstance().getPlayerInformation(sPP.playerId);
            var tPP:* = userData.getPlayerPersonal(this._siManager.teacherId);
            var tPI:* = PlayerManager.getInstance().getPlayerInformation(tPP.playerId);
            var paymentItemInfo:* = ItemManager.getInstance().getPaymentItemInformation(PaymentItemId.ITEM_REVISION_PROBABILITY);
            var tRank:* = new PlayerRarityIcon(this._baseMc.charaNameSet1Mc.setCharaRankMc, tPI.rarity);
            var sRank:* = new PlayerRarityIcon(this._baseMc.charaNameSet2Mc.setCharaRankMc, sPI.rarity);
            TextControl.setText(this._baseMc.charaNameSet1Mc.textMc.textDt, this._siManager.teacherName + " から");
            TextControl.setText(this._baseMc.charaNameSet2Mc.textMc.textDt, this._siManager.studentName + " に");
            TextControl.setText(this._baseMc.infoDisplayMc.textDt, TextControl.formatIdText(MessageId.SKILL_INITIATE_CONFIRM_NEW, skillInfo.name, Math.min(SkillInitiateUtility.getBaseProbability(this._siManager.teacherId, this._siManager.aSupportId) + SkillInitiateUtility.getBonusProbability(this._siManager.bonusId), 100), paymentItemInfo.name, SkillInitiateUtility.getItemCost(this._siManager.studentId, this._siManager.bonusId)));
            TextControl.setIdText(this._baseMc.yesBtnMc.textMc.textDt, MessageId.COMMON_BUTTON_YES);
            TextControl.setIdText(this._baseMc.noBtnMc.textMc.textDt, MessageId.COMMON_BUTTON_NO);
            this._yesButton = ButtonManager.getInstance().addButton(this._baseMc.yesBtnMc, this.cbButton, 1);
            this._yesButton.enterSeId = ButtonBase.SE_DECIDE_ID;
            this._noButton = ButtonManager.getInstance().addButton(this._baseMc.noBtnMc, this.cbButton);
            this._noButton.enterSeId = ButtonBase.SE_CANCEL_ID;
            this.setButtonEnable(false);
            this._parent.addChild(this._baseMc);
            this._isoBase.setIn(function () : void
            {
                setButtonEnable(true);
                return;
            }// end function
            );
            return;
        }// end function

        private function phaseClose() : void
        {
            this._bEnd = true;
            return;
        }// end function

        private function setButtonEnable(param1:Boolean) : void
        {
            if (this._yesButton)
            {
                this._yesButton.setDisable(!param1);
            }
            if (this._noButton)
            {
                this._noButton.setDisable(!param1);
            }
            return;
        }// end function

        private function cbButton(param1:int) : void
        {
            this.setButtonEnable(false);
            this._bConfirm = param1 == 1;
            this._isoBase.setOut();
            this.setPhase(this._PHASE_CLOSE);
            return;
        }// end function

    }
}
