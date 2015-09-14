package questSelect
{
    import battle.*;
    import button.*;
    import flash.display.*;
    import flash.geom.*;
    import item.*;
    import message.*;
    import popup.*;
    import resource.*;
    import sound.*;
    import status.*;
    import tutorial.*;
    import user.*;

    public class UseItemSelect extends Object
    {
        private var _mc:MovieClip;
        private var _itemSimpleStatus:ItemSimpleStatus;
        private var _statusTarget:int;
        private var _aUseItemBtn:Array;
        private var _bAddButton:Boolean;
        private static const ITEM_BTN_IDX_GROWTH:int = 0;
        private static const ITEM_BTN_IDX_ASSAULT:int = 1;
        private static const ITEM_BTN_IDX_LP:int = 2;
        private static var _aItemSelectState:Array = [false, false, false];

        public function UseItemSelect(param1:MovieClip, param2:Function)
        {
            var _loc_12:* = null;
            this._mc = param1;
            this._itemSimpleStatus = new ItemSimpleStatus(this._mc);
            this._statusTarget = Constant.EMPTY_ID;
            var _loc_3:* = UseItemButton.SELECT_MODE_NORMAL;
            var _loc_4:* = UseItemButton.SELECT_MODE_NORMAL;
            var _loc_5:* = UseItemButton.SELECT_MODE_NORMAL;
            if (TutorialManager.getInstance().isBasicTutorial(CommonConstant.USER_STATE_TUTORIAL_QUEST_SELECT, TutorialManager.BASIC_TUTORIAL_FLAG_QUEST_SELECT_END))
            {
                _loc_3 = UseItemButton.SELECT_MODE_TUTORIAL_OUT;
                _loc_4 = UseItemButton.SELECT_MODE_TUTORIAL_TARGET;
                _loc_5 = UseItemButton.SELECT_MODE_TUTORIAL_OUT;
            }
            this._aUseItemBtn = [];
            var _loc_6:* = UserDataManager.getInstance().isSortiePlayerGrowtEnd();
            var _loc_7:* = UserDataManager.getInstance().isSortiePlayerGrowtEnd() == false ? (null) : (this.cbBlock_Growth);
            this._aUseItemBtn.push(new UseItemButton(this._mc.ItemBtn1Mc, PaymentItemId.ITEM_GROWTH_RATE_UP, false, _loc_3, param2, _loc_7));
            var _loc_8:* = UserDataManager.getInstance().getSortiePlayerNum();
            var _loc_9:* = UserDataManager.getInstance().getSortiePlayerNum() >= BattleConstant.FEVER_PLAYER_COUNT ? (null) : (this.cbBlock_Fever);
            this._aUseItemBtn.push(new UseItemButton(this._mc.ItemBtn2Mc, PaymentItemId.ITEM__WHOLE_ARMY_ASSAULT, UserDataManager.getInstance().userData.hasFreeWholeArmyAssault, _loc_4, param2, _loc_9));
            var _loc_10:* = UserDataManager.getInstance().getSortiePlayerLpTargetNum();
            var _loc_11:* = UserDataManager.getInstance().getSortiePlayerLpTargetNum() > 0 ? (null) : (this.cbBlock_Lp);
            this._aUseItemBtn.push(new UseItemButton(this._mc.ItemBtn3Mc, PaymentItemId.ITEM_DEFENCE_LP_DAMEAGE, false, _loc_5, param2, _loc_11));
            for each (_loc_12 in this._aUseItemBtn)
            {
                
                _loc_12.errorSeId = SoundId.SE_RS3_SYSTEM_ERROR;
            }
            TextControl.setIdText(this._mc.TitleTextMc.textDt, MessageId.QUEST_SELECT_ITEM_TITLE);
            TextControl.setIdText(this._mc.InfoTextMc.textDt, MessageId.QUEST_SELECT_ITEM_EXPLANETION);
            this._bAddButton = false;
            return;
        }// end function

        public function release() : void
        {
            var _loc_1:* = null;
            this.removeButton();
            for each (_loc_1 in this._aUseItemBtn)
            {
                
                _loc_1.release();
            }
            this._aUseItemBtn = null;
            if (this._itemSimpleStatus)
            {
                this._itemSimpleStatus.release();
            }
            this._itemSimpleStatus = null;
            this._mc = null;
            return;
        }// end function

        public function control(param1:Number) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_2:* = null;
            if (this._bAddButton)
            {
                for each (_loc_3 in this._aUseItemBtn)
                {
                    
                    if (_loc_3.bMouseOver)
                    {
                        _loc_2 = _loc_3;
                        break;
                    }
                }
            }
            if (_loc_2)
            {
                if (this._statusTarget != _loc_2.id)
                {
                    this._statusTarget = _loc_2.id;
                    _loc_4 = _loc_2.mcBase.PopNull;
                    _loc_5 = new Point(_loc_4.x, _loc_4.y);
                    _loc_5 = _loc_4.parent.localToGlobal(_loc_5);
                    _loc_5 = this._mc.globalToLocal(_loc_5);
                    _loc_4 = _loc_2.mcBase.SettingPopNull;
                    _loc_6 = new Point(_loc_4.x, _loc_4.y);
                    _loc_6 = _loc_4.parent.localToGlobal(_loc_6);
                    this._itemSimpleStatus.show();
                    this._itemSimpleStatus.setPaymentItemData(this._statusTarget);
                    this._itemSimpleStatus.setPosition(_loc_5);
                    this._itemSimpleStatus.setArrowTargetPosition(_loc_6);
                }
            }
            else
            {
                this._itemSimpleStatus.hide();
                this._statusTarget = Constant.EMPTY_ID;
            }
            return;
        }// end function

        public function addButton() : void
        {
            var _loc_1:* = null;
            if (this._bAddButton == false)
            {
                for each (_loc_1 in this._aUseItemBtn)
                {
                    
                    ButtonManager.getInstance().addButtonBase(_loc_1);
                }
                this._bAddButton = true;
            }
            return;
        }// end function

        public function setDisable(param1:Boolean) : void
        {
            var _loc_2:* = null;
            for each (_loc_2 in this._aUseItemBtn)
            {
                
                _loc_2.setDisable(param1);
            }
            return;
        }// end function

        public function removeButton() : void
        {
            var _loc_1:* = null;
            if (this._bAddButton)
            {
                this.backupSelect();
                for each (_loc_1 in this._aUseItemBtn)
                {
                    
                    ButtonManager.getInstance().removeArray(_loc_1);
                }
                this._bAddButton = false;
            }
            return;
        }// end function

        public function clearSelect() : void
        {
            var _loc_1:* = null;
            for each (_loc_1 in this._aUseItemBtn)
            {
                
                _loc_1.setSelect(false);
            }
            return;
        }// end function

        public function resetSelect() : void
        {
            var _loc_2:* = null;
            var _loc_3:* = false;
            if (TutorialManager.getInstance().isBasicTutorial(CommonConstant.USER_STATE_TUTORIAL_QUEST_SELECT, TutorialManager.BASIC_TUTORIAL_FLAG_QUEST_SELECT_END))
            {
                this.clearSelect();
                return;
            }
            var _loc_1:* = 0;
            while (_loc_1 < this._aUseItemBtn.length)
            {
                
                _loc_2 = this._aUseItemBtn[_loc_1];
                _loc_3 = _aItemSelectState[_loc_1];
                _loc_2.setSelect(_loc_3);
                _loc_1++;
            }
            return;
        }// end function

        private function backupSelect() : void
        {
            var _loc_2:* = null;
            if (TutorialManager.getInstance().isBasicTutorial(CommonConstant.USER_STATE_TUTORIAL_QUEST_SELECT, TutorialManager.BASIC_TUTORIAL_FLAG_QUEST_SELECT_END))
            {
                return;
            }
            var _loc_1:* = 0;
            while (_loc_1 < this._aUseItemBtn.length)
            {
                
                _loc_2 = this._aUseItemBtn[_loc_1];
                _aItemSelectState[_loc_1] = _loc_2.bSelect;
                _loc_1++;
            }
            return;
        }// end function

        public function getSelectItemId(param1:Boolean = false) : Array
        {
            var _loc_3:* = null;
            var _loc_2:* = [];
            for each (_loc_3 in this._aUseItemBtn)
            {
                
                if (_loc_3.bSelect && _loc_3.bFree == param1)
                {
                    _loc_2.push(_loc_3.id);
                }
            }
            return _loc_2;
        }// end function

        public function checkAnySelect() : Boolean
        {
            var _loc_1:* = null;
            for each (_loc_1 in this._aUseItemBtn)
            {
                
                if (_loc_1.bSelect)
                {
                    return true;
                }
            }
            return false;
        }// end function

        public function getUseItemButton(param1:int) : UseItemButton
        {
            var _loc_2:* = null;
            for each (_loc_2 in this._aUseItemBtn)
            {
                
                if (_loc_2.paymentItemId == param1)
                {
                    return _loc_2;
                }
            }
            return null;
        }// end function

        private function cbBlock_Growth(param1:int) : void
        {
            CommonPopup.getInstance().openAlertPopup(CommonPopup.POPUP_TYPE_NORMAL, TextControl.formatIdText(MessageId.QUEST_SELECT_ITEM_GROWTH_LIMIT, ItemManager.getInstance().getItemName(CommonConstant.ITEM_KIND_PAYMENT_ITEM, PaymentItemId.ITEM_GROWTH_RATE_UP)), null, null, true);
            return;
        }// end function

        private function cbBlock_Fever(param1:int) : void
        {
            CommonPopup.getInstance().openAlertPopup(CommonPopup.POPUP_TYPE_NORMAL, MessageManager.getInstance().getMessage(MessageId.QUEST_SELECT_ITEM_NUMBER_SHORTAGE), null, null, true);
            return;
        }// end function

        private function cbBlock_Lp(param1:int) : void
        {
            CommonPopup.getInstance().openAlertPopup(CommonPopup.POPUP_TYPE_NORMAL, TextControl.formatIdText(MessageId.QUEST_SELECT_ITEM_NOT_USE_DEFENCE_LP_DAMEAGE, ItemManager.getInstance().getItemName(CommonConstant.ITEM_KIND_PAYMENT_ITEM, PaymentItemId.ITEM_DEFENCE_LP_DAMEAGE)), null, null, true);
            return;
        }// end function

        public static function loadResource() : void
        {
            var _loc_1:* = null;
            ItemSimpleStatus.loadResource();
            _loc_1 = ItemManager.getInstance().getItemPng(CommonConstant.ITEM_KIND_PAYMENT_ITEM, PaymentItemId.ITEM_GROWTH_RATE_UP);
            if (_loc_1)
            {
                ResourceManager.getInstance().loadResource(_loc_1);
            }
            _loc_1 = ItemManager.getInstance().getItemPng(CommonConstant.ITEM_KIND_PAYMENT_ITEM, PaymentItemId.ITEM__WHOLE_ARMY_ASSAULT);
            if (_loc_1)
            {
                ResourceManager.getInstance().loadResource(_loc_1);
            }
            _loc_1 = ItemManager.getInstance().getItemPng(CommonConstant.ITEM_KIND_PAYMENT_ITEM, PaymentItemId.ITEM_DEFENCE_LP_DAMEAGE);
            if (_loc_1)
            {
                ResourceManager.getInstance().loadResource(_loc_1);
            }
            SoundManager.getInstance().loadSound(SoundId.SE_RS3_SYSTEM_ERROR);
            return;
        }// end function

    }
}
