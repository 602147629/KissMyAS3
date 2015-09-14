package skillInitiate
{
    import battle.*;
    import button.*;
    import flash.display.*;
    import message.*;
    import player.*;
    import resource.*;
    import skill.*;
    import tutorial.*;
    import user.*;
    import utility.*;

    public class SISelectSkillPopup extends Object
    {
        private var _rootMc:MovieClip;
        private var _baseMc:MovieClip;
        private var _isoMc:InStayOut;
        private var _closeBtn:ButtonBase;
        private var _pager:PageButton;
        private var _aSkillList:Array;
        private var _aButton:Array;
        private var _selectedSkillId:int;

        public function SISelectSkillPopup(param1:DisplayObjectContainer, param2:int, param3:int = 0)
        {
            this._rootMc = ResourceManager.getInstance().createMovieClip(ResourcePath.FACILITY_PATH + "UI_SkillInitiate.swf", "SkillListPopupMc");
            this._baseMc = this._rootMc.listPopupMc;
            param1.addChild(this._rootMc);
            this._isoMc = new InStayOut(this._baseMc);
            this._selectedSkillId = param3;
            this._aSkillList = this.createSkillData(param2);
            this._closeBtn = ButtonManager.getInstance().addButton(this._baseMc.closeBtnMc, this.cbClose);
            this._closeBtn.enterSeId = ButtonBase.SE_CANCEL_ID;
            TextControl.setIdText(this._baseMc.closeBtnMc.textMc.textDt, MessageId.COMMON_BUTTON_CLOSE);
            this._pager = new PageButton(this._baseMc.listMc.pageBtnSetGuidMc, this.cbPageChange);
            this.createListButton();
            this._pager.setPage(0, Math.ceil(this._aSkillList.length / this._aButton.length));
            this.updateList();
            this.setButtonEnable(false);
            this.openPopup();
            return;
        }// end function

        public function get selectedSkillId() : int
        {
            return this._selectedSkillId;
        }// end function

        public function get bClosed() : Boolean
        {
            return this._isoMc.bClosed;
        }// end function

        public function get bInitiatable() : Boolean
        {
            return this._aSkillList.length > 0;
        }// end function

        public function release() : void
        {
            var _loc_1:* = null;
            if (this._closeBtn)
            {
                ButtonManager.getInstance().removeButton(this._closeBtn);
            }
            if (this._pager)
            {
                this._pager.release();
            }
            for each (_loc_1 in this._aButton)
            {
                
                _loc_1.release();
            }
            this._aButton = null;
            this._aSkillList = null;
            if (this._rootMc.parent)
            {
                this._rootMc.parent.removeChild(this._rootMc);
            }
            return;
        }// end function

        private function createListButton() : void
        {
            var _loc_2:* = null;
            this._aButton = [];
            var _loc_1:* = [{buttonMc:this._baseMc.listMc.listBtn1Mc, selectedMc:this._baseMc.listMc.listBtn1Select}, {buttonMc:this._baseMc.listMc.listBtn2Mc, selectedMc:this._baseMc.listMc.listBtn2Select}, {buttonMc:this._baseMc.listMc.listBtn3Mc, selectedMc:this._baseMc.listMc.listBtn3Select}, {buttonMc:this._baseMc.listMc.listBtn4Mc, selectedMc:this._baseMc.listMc.listBtn4Select}, {buttonMc:this._baseMc.listMc.listBtn5Mc, selectedMc:this._baseMc.listMc.listBtn5Select}, {buttonMc:this._baseMc.listMc.listBtn6Mc, selectedMc:this._baseMc.listMc.listBtn6Select}, {buttonMc:this._baseMc.listMc.listBtn7Mc, selectedMc:this._baseMc.listMc.listBtn7Select}, {buttonMc:this._baseMc.listMc.listBtn8Mc, selectedMc:this._baseMc.listMc.listBtn8Select}, {buttonMc:this._baseMc.listMc.listBtn9Mc, selectedMc:this._baseMc.listMc.listBtn9Select}];
            for each (_loc_2 in _loc_1)
            {
                
                this._aButton.push(new SISelectSkillButton(_loc_2.buttonMc, _loc_2.selectedMc, this.cbSelectSkill));
            }
            return;
        }// end function

        private function createSkillData(param1:int) : Array
        {
            var _loc_7:* = 0;
            var _loc_8:* = null;
            var _loc_9:* = 0;
            var _loc_10:* = null;
            var _loc_2:* = [];
            var _loc_3:* = UserDataManager.getInstance().userData;
            var _loc_4:* = _loc_3.getPlayerPersonal(param1);
            if (_loc_3.getPlayerPersonal(param1) == null)
            {
                return _loc_2;
            }
            var _loc_5:* = PlayerManager.getInstance().getPlayerInformation(_loc_4.playerId);
            var _loc_6:* = SkillManager.getInstance().getLearnableSkill(_loc_5.weaponType);
            for each (_loc_7 in _loc_6)
            {
                
                if (_loc_7 == BattleManager.getDefaultSkillId(_loc_5))
                {
                    continue;
                }
                _loc_8 = SkillInitiateUtility.getTeachablePlayerList(_loc_7);
                _loc_9 = _loc_8.length;
                for each (_loc_10 in _loc_8)
                {
                    
                    if (_loc_10.uniqueId == param1)
                    {
                        _loc_9 = _loc_9 - 1;
                        break;
                    }
                }
                if (_loc_9 > 0)
                {
                    _loc_2.push(new InitiateSkillData(_loc_7, _loc_9, _loc_4.isHaveSkill(_loc_7)));
                }
            }
            return _loc_2;
        }// end function

        private function updateList() : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_1:* = this._aButton.length * this._pager.pageIndex;
            var _loc_2:* = 0;
            while (_loc_2 < this._aButton.length)
            {
                
                _loc_3 = this._aButton[_loc_2];
                if (_loc_1 + _loc_2 < this._aSkillList.length)
                {
                    _loc_4 = this._aSkillList[_loc_1 + _loc_2] as InitiateSkillData;
                    _loc_3.setSkill(_loc_4);
                    _loc_3.setShowSelectedMc(_loc_4.skillId == this._selectedSkillId);
                }
                else
                {
                    _loc_3.setSkill();
                    _loc_3.setShowSelectedMc(false);
                }
                _loc_2++;
            }
            return;
        }// end function

        public function setButtonEnable(param1:Boolean) : void
        {
            var _loc_2:* = null;
            for each (_loc_2 in this._aButton)
            {
                
                _loc_2.setButtonEnable(param1);
            }
            this._closeBtn.setDisable(!param1);
            this._pager.btnEnable(param1);
            return;
        }// end function

        public function openPopup() : void
        {
            if (this._isoMc.bClosed)
            {
                this._isoMc.setIn(this.cbIn);
                this.setButtonEnable(true);
            }
            return;
        }// end function

        public function cbIn() : void
        {
            if (TutorialManager.getInstance().isFacilityTutorial(TutorialManager.FACILITY_TUTORIAL_FLAG_SKILL_INITIATE_2))
            {
                TutorialManager.getInstance().facilityTutorialPopup(TutorialManager.FACILITY_TUTORIAL_FLAG_SKILL_INITIATE_2);
            }
            return;
        }// end function

        public function closePopup() : void
        {
            if (this._isoMc.bOpened)
            {
                this._isoMc.setOut();
                this.setButtonEnable(false);
            }
            return;
        }// end function

        private function cbClose(param1:int) : void
        {
            this.closePopup();
            return;
        }// end function

        private function cbPageChange(param1:int, param2:int) : Boolean
        {
            this.updateList();
            return true;
        }// end function

        private function cbSelectSkill(param1:int) : void
        {
            this._selectedSkillId = param1;
            this.closePopup();
            return;
        }// end function

    }
}
