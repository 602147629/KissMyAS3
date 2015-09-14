package skillInitiate
{
    import flash.display.*;
    import item.*;
    import message.*;
    import resource.*;
    import utility.*;

    public class SISelectProbabiliryPopup extends Object
    {
        private var _rootMc:MovieClip;
        private var _baseMc:MovieClip;
        private var _isoMc:InStayOut;
        private var _selectedId:int;
        private var _aButton:Array;
        private var _siManager:SkillInitiateManager;

        public function SISelectProbabiliryPopup(param1:DisplayObjectContainer, param2:int = 0, param3:int = 0, param4:int = 0)
        {
            this._rootMc = ResourceManager.getInstance().createMovieClip(ResourcePath.FACILITY_PATH + "UI_SkillInitiate.swf", "ProbabilityUpListPopupMc");
            param1.addChild(this._rootMc);
            this._baseMc = this._rootMc.listPopupMc;
            this._isoMc = new InStayOut(this._baseMc);
            this._baseMc.closeBtnMc.visible = false;
            this.createListButton(param2, param4);
            TextControl.setIdText(this._baseMc.listMc.titleMc.textDt, MessageId.SKILL_INITIATE__TEMP_MESSAGE_TITLE);
            var _loc_5:* = ItemManager.getInstance().getItemName(CommonConstant.ITEM_KIND_PAYMENT_ITEM, PaymentItemId.ITEM_REVISION_PROBABILITY);
            TextControl.setText(this._baseMc.listMc.titleEndMc.textDt, TextControl.formatIdText(MessageId.SKILL_INITIATE__TEMP_MESSAGE_PAYMENTITEM, _loc_5));
            this._selectedId = param3;
            this.openPopup();
            return;
        }// end function

        public function get bonusId() : int
        {
            return this._selectedId;
        }// end function

        public function get bClosed() : Boolean
        {
            return this._isoMc.bClosed;
        }// end function

        public function release() : void
        {
            var _loc_1:* = null;
            for each (_loc_1 in this._aButton)
            {
                
                _loc_1.release();
            }
            this._aButton = null;
            if (this._rootMc.parent)
            {
                this._rootMc.parent.removeChild(this._rootMc);
            }
            return;
        }// end function

        private function createListButton(param1:int, param2:int) : void
        {
            var _loc_5:* = null;
            var _loc_6:* = 0;
            var _loc_8:* = null;
            var _loc_9:* = 0;
            this._aButton = [];
            var _loc_3:* = [{buttonMc:this._baseMc.listMc.listBtn1Mc, selectedMc:this._baseMc.listMc.listBtn1Select}, {buttonMc:this._baseMc.listMc.listBtn2Mc, selectedMc:this._baseMc.listMc.listBtn2Select}, {buttonMc:this._baseMc.listMc.listBtn3Mc, selectedMc:this._baseMc.listMc.listBtn3Select}, {buttonMc:this._baseMc.listMc.listBtn4Mc, selectedMc:this._baseMc.listMc.listBtn4Select}, {buttonMc:this._baseMc.listMc.listBtn5Mc, selectedMc:this._baseMc.listMc.listBtn5Select}, {buttonMc:this._baseMc.listMc.listBtn6Mc, selectedMc:this._baseMc.listMc.listBtn6Select}, {buttonMc:this._baseMc.listMc.listBtn7Mc, selectedMc:this._baseMc.listMc.listBtn7Select}, {buttonMc:this._baseMc.listMc.listBtn8Mc, selectedMc:this._baseMc.listMc.listBtn8Select}, {buttonMc:this._baseMc.listMc.listBtn9Mc, selectedMc:this._baseMc.listMc.listBtn9Select}, {buttonMc:this._baseMc.listMc.listBtn10Mc, selectedMc:this._baseMc.listMc.listBtn10Select}];
            var _loc_4:* = SkillInitiateUtility.getBonusNum();
            var _loc_7:* = false;
            _loc_6 = 0;
            while (_loc_6 < _loc_3.length)
            {
                
                if (_loc_6 >= _loc_4)
                {
                    break;
                }
                _loc_5 = _loc_3[_loc_6];
                _loc_8 = new SISelectProbabilityButton(_loc_5.buttonMc, _loc_5.selectedMc, param1, _loc_6, this.cbSelectProbability, _loc_7);
                this._aButton.push(_loc_8);
                _loc_9 = SkillInitiateUtility.getBonusProbability(_loc_6) + param2;
                if (_loc_9 >= 100)
                {
                    _loc_7 = true;
                }
                _loc_6++;
            }
            while (_loc_6 < _loc_3.length)
            {
                
                _loc_5 = _loc_3[_loc_6];
                _loc_5.buttonMc.visible = false;
                _loc_5.selectedMc.visible = false;
                _loc_6++;
            }
            return;
        }// end function

        private function updateList() : void
        {
            var _loc_2:* = null;
            var _loc_1:* = 0;
            while (_loc_1 < this._aButton.length)
            {
                
                _loc_2 = this._aButton[_loc_1];
                _loc_2.setShowSelectedMc(_loc_1 == this._selectedId);
                _loc_1++;
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
            return;
        }// end function

        public function openPopup() : void
        {
            if (this._isoMc.bClosed)
            {
                this._isoMc.setIn();
                this.updateList();
                this.setButtonEnable(true);
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

        private function cbSelectProbability(param1:int) : void
        {
            this._selectedId = param1;
            this.updateList();
            this.closePopup();
            return;
        }// end function

    }
}
