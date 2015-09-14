package makeEquip
{
    import button.*;
    import destinystone.*;
    import flash.display.*;
    import item.*;
    import message.*;
    import popup.*;
    import resource.*;
    import tutorial.*;
    import user.*;
    import utility.*;

    public class MakeEquipSyntheticTypeSelect extends MakeEquipBase
    {
        private var _aDummyBtn:Array;
        private var _select:int;
        private var _aStoneImage:Array;

        public function MakeEquipSyntheticTypeSelect(param1:DisplayObjectContainer)
        {
            var _loc_3:* = null;
            super(param1, "dsSelectMc", true);
            this._aDummyBtn = [];
            this._aStoneImage = [];
            var _loc_2:* = _mc.creatWindMc;
            _loc_3 = ButtonManager.getInstance().addButton(_loc_2.itemSBtn1Mc, this.cbSelectButton, CommonConstant.MAKE_EQUIP_TYPE_WEAPON_SWORD);
            _loc_3.enterSeId = ButtonBase.SE_DECIDE_ID;
            this._aDummyBtn.push(_loc_3);
            _loc_2.itemSBtn1Mc.itemIconMc.gotoAndStop(MakeEquipConstant.aTypeLabel[CommonConstant.MAKE_EQUIP_TYPE_WEAPON_SWORD]);
            TextControl.setIdText(_loc_2.text1Mc.textDt, MessageId.MAKE_EQUIP_CREATE_CATEGORY_WEAPON_SWORD);
            this.setUseStoneImage(MakeEquipConstant.aUseStone[CommonConstant.MAKE_EQUIP_TYPE_WEAPON_SWORD], _loc_2.dsSetNull1);
            _loc_3 = ButtonManager.getInstance().addButton(_loc_2.itemSBtn2Mc, this.cbSelectButton, CommonConstant.MAKE_EQUIP_TYPE_WEAPON_STAFF);
            _loc_3.enterSeId = ButtonBase.SE_DECIDE_ID;
            this._aDummyBtn.push(_loc_3);
            _loc_2.itemSBtn2Mc.itemIconMc.gotoAndStop(MakeEquipConstant.aTypeLabel[CommonConstant.MAKE_EQUIP_TYPE_WEAPON_STAFF]);
            TextControl.setIdText(_loc_2.text2Mc.textDt, MessageId.MAKE_EQUIP_CREATE_CATEGORY_WEAPON_STAFF);
            this.setUseStoneImage(MakeEquipConstant.aUseStone[CommonConstant.MAKE_EQUIP_TYPE_WEAPON_STAFF], _loc_2.dsSetNull2);
            _loc_3 = ButtonManager.getInstance().addButton(_loc_2.itemSBtn3Mc, this.cbSelectButton, CommonConstant.MAKE_EQUIP_TYPE_WEAPON_OTHER);
            _loc_3.enterSeId = ButtonBase.SE_DECIDE_ID;
            this._aDummyBtn.push(_loc_3);
            _loc_2.itemSBtn3Mc.itemIconMc.gotoAndStop(MakeEquipConstant.aTypeLabel[CommonConstant.MAKE_EQUIP_TYPE_WEAPON_OTHER]);
            TextControl.setIdText(_loc_2.text3Mc.textDt, MessageId.MAKE_EQUIP_CREATE_CATEGORY_WEAPON_OTHER);
            this.setUseStoneImage(MakeEquipConstant.aUseStone[CommonConstant.MAKE_EQUIP_TYPE_WEAPON_OTHER], _loc_2.dsSetNull3);
            _loc_3 = ButtonManager.getInstance().addButton(_loc_2.itemSBtn4Mc, this.cbSelectButton, CommonConstant.MAKE_EQUIP_TYPE_PROTECTOR_ARMOR);
            _loc_3.enterSeId = ButtonBase.SE_DECIDE_ID;
            this._aDummyBtn.push(_loc_3);
            _loc_2.itemSBtn4Mc.itemIconMc.gotoAndStop(MakeEquipConstant.aTypeLabel[CommonConstant.MAKE_EQUIP_TYPE_PROTECTOR_ARMOR]);
            TextControl.setIdText(_loc_2.text4Mc.textDt, MessageId.MAKE_EQUIP_CREATE_CATEGORY_PROTECTOR_ARMOR);
            this.setUseStoneImage(MakeEquipConstant.aUseStone[CommonConstant.MAKE_EQUIP_TYPE_PROTECTOR_ARMOR], _loc_2.dsSetNull4);
            _loc_3 = ButtonManager.getInstance().addButton(_loc_2.itemSBtn5Mc, this.cbSelectButton, CommonConstant.MAKE_EQUIP_TYPE_PROTECTOR_CLOTHES);
            _loc_3.enterSeId = ButtonBase.SE_DECIDE_ID;
            this._aDummyBtn.push(_loc_3);
            _loc_2.itemSBtn5Mc.itemIconMc.gotoAndStop(MakeEquipConstant.aTypeLabel[CommonConstant.MAKE_EQUIP_TYPE_PROTECTOR_CLOTHES]);
            TextControl.setIdText(_loc_2.text5Mc.textDt, MessageId.MAKE_EQUIP_CREATE_CATEGORY_PROTECTOR_CLOTHES);
            this.setUseStoneImage(MakeEquipConstant.aUseStone[CommonConstant.MAKE_EQUIP_TYPE_PROTECTOR_CLOTHES], _loc_2.dsSetNull5);
            _loc_3 = ButtonManager.getInstance().addButton(_loc_2.itemSBtn6Mc, this.cbSelectButton, CommonConstant.MAKE_EQUIP_TYPE_ACCESSORY);
            _loc_3.enterSeId = ButtonBase.SE_DECIDE_ID;
            _aButton.push(_loc_3);
            _loc_2.itemSBtn6Mc.itemIconMc.gotoAndStop(MakeEquipConstant.aTypeLabel[CommonConstant.MAKE_EQUIP_TYPE_ACCESSORY]);
            TextControl.setIdText(_loc_2.text6Mc.textDt, MessageId.MAKE_EQUIP_CREATE_CATEGORY_ACCESSORY);
            this.setUseStoneImage(MakeEquipConstant.aUseStone[CommonConstant.MAKE_EQUIP_TYPE_ACCESSORY], _loc_2.dsSetNull6);
            _loc_3 = ButtonManager.getInstance().addButton(_mc.returnBtnMc, this.cbSelectButton, Constant.UNDECIDED);
            _loc_3.enterSeId = ButtonBase.SE_CANCEL_ID;
            _aButton.push(_loc_3);
            TextControl.setIdText(_mc.returnBtnMc.textMc.textDt, MessageId.COMMON_BUTTON_RETURN);
            for each (_loc_3 in this._aDummyBtn)
            {
                
                _loc_3.setDisable(true);
                ButtonManager.getInstance().removeArray(_loc_3);
            }
            this._select = Constant.UNDECIDED;
            return;
        }// end function

        public function get select() : int
        {
            return this._select;
        }// end function

        override public function release() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            super.release();
            for each (_loc_1 in this._aDummyBtn)
            {
                
                _loc_1.release();
            }
            this._aDummyBtn = [];
            for each (_loc_2 in this._aStoneImage)
            {
                
                if (_loc_2.bitmapData != null)
                {
                    _loc_2.bitmapData.dispose();
                }
                if (_loc_2.parent)
                {
                    _loc_2.parent.removeChild(_loc_2);
                }
            }
            this._aStoneImage = [];
            return;
        }// end function

        private function setUseStoneImage(param1:Array, param2:MovieClip) : void
        {
            var _loc_5:* = 0;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_3:* = [param2.dsNull1, param2.dsNull2, param2.dsNull3];
            var _loc_4:* = 0;
            while (_loc_4 < 3)
            {
                
                _loc_5 = param1[_loc_4];
                _loc_6 = _loc_3[_loc_4];
                _loc_7 = ItemManager.getInstance().getDestinyStoneInformation(_loc_5);
                _loc_8 = ResourceManager.getInstance().createBitmap(ResourcePath.DESTINY_STONE_PATH + _loc_7.fileName);
                _loc_8.smoothing = true;
                _loc_8.x = _loc_8.x - _loc_8.width / 2;
                _loc_8.y = _loc_8.y - _loc_8.height / 2;
                _loc_6.addChild(_loc_8);
                this._aStoneImage.push(_loc_8);
                _loc_4++;
            }
            return;
        }// end function

        private function cbSelectButton(param1:int) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            if (param1 != Constant.UNDECIDED)
            {
                if (UserDataManager.getInstance().userData.getEquipItemTotalNum() >= CommonConstant.OWN_ITEM_MAX_ACCESSORIES)
                {
                    ButtonManager.getInstance().push();
                    CommonPopup.getInstance().openAlertPopup(CommonPopup.POPUP_TYPE_NORMAL, MessageManager.getInstance().getMessage(MessageId.MAKE_EQUIP_NUM_MAX), this.cbClosePopup);
                    return;
                }
                _loc_2 = [];
                _loc_3 = MakeEquipConstant.aUseStone[param1];
                _loc_4 = 0;
                while (_loc_4 < _loc_3.length)
                {
                    
                    _loc_5 = _loc_3[_loc_4];
                    if (UserDataManager.getInstance().userData.getOwnDestinyStoneNum(_loc_5) < MakeEquipConstant.aMinUseStoneNum[_loc_4])
                    {
                        _loc_2.push(_loc_5);
                    }
                    _loc_4++;
                }
                if (_loc_2.length > 0)
                {
                    ButtonManager.getInstance().push();
                    _loc_6 = [];
                    _loc_4 = 0;
                    while (_loc_4 < _loc_3.length)
                    {
                        
                        _loc_8 = new Object();
                        _loc_9 = ItemManager.getInstance().getDestinyStoneInformation(_loc_3[_loc_4]);
                        _loc_8.name = _loc_9.name;
                        _loc_8.count = MakeEquipConstant.aMinUseStoneNum[_loc_4];
                        _loc_6.push(_loc_8);
                        _loc_4++;
                    }
                    _loc_7 = StringTools.format(MessageManager.getInstance().getMessage(MessageId.MAKE_EQUIP_POPUP_NOT_ENOUGH_STONE), _loc_6[0].name, _loc_6[0].count, _loc_6[1].name, _loc_6[1].count, _loc_6[2].name, _loc_6[2].count);
                    CommonPopup.getInstance().openAlertPopup(CommonPopup.POPUP_TYPE_NORMAL, _loc_7, this.cbClosePopup);
                    return;
                }
            }
            this._select = param1;
            close();
            return;
        }// end function

        private function cbClosePopup() : void
        {
            ButtonManager.getInstance().pop();
            return;
        }// end function

        override protected function cbMainIn() : void
        {
            super.cbMainIn();
            if (TutorialManager.getInstance().isFacilityTutorial(TutorialManager.FACILITY_TUTORIAL_FLAG_MAKE_EQUIP_SYNTHETIC_1))
            {
                TutorialManager.getInstance().stepChange(1);
            }
            return;
        }// end function

    }
}
