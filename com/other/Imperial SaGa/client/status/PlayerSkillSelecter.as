package status
{
    import button.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import input.*;
    import item.*;
    import message.*;
    import player.*;
    import resource.*;
    import utility.*;

    public class PlayerSkillSelecter extends Object
    {
        private var _mc:MovieClip;
        private var _listMc:MovieClip;
        private var _iso:InStayOut;
        private var _closeBtn:ButtonBase;
        private var _aChangeButton:Array;
        private var _aScrollButton:Array;
        private var _aEquippedMc:Array;
        private var _cbCloseFunc:Function;
        private var _target:int;
        private var _aEquipmentBox:Array;
        private var _skillSimpleStatus:SkillSimpleStatus;
        private var _equipSimpleStatus:EquipSimpleStatus;
        private var _index:int;
        private var _page:PageButton;
        private var _pageAnim:PageAnim;
        private var _pageIndex:int;
        private var _aItem:Array;
        private var _aEquippedItemId:Array;
        private var _personalPtr:PlayerPersonal;
        public static const EQUIPMENT_TARGET_SKILL:int = 0;
        public static const EQUIPMENT_TARGET_ITEM:int = 1;
        private static const _LIST_ITEM_NUM:int = 10;

        public function PlayerSkillSelecter(param1:DisplayObjectContainer, param2:PlayerPersonal, param3:Function = null)
        {
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = null;
            this._mc = ResourceManager.getInstance().createMovieClip(ResourcePath.COMMON_DATA_PATH + "UI_Status.swf", "skillSettingWindowMc");
            param1.addChild(this._mc);
            this._listMc = this._mc.skillSettingMc.skillListMc;
            this._personalPtr = param2;
            this._cbCloseFunc = param3;
            this._closeBtn = ButtonManager.getInstance().addButton(this._mc.skillSettingMc.returnBtnMc, this.cbCloseBtn);
            this._closeBtn.enterSeId = ButtonBase.SE_CANCEL_ID;
            TextControl.setIdText(this._closeBtn.getMoveClip().textMc.textDt, MessageId.COMMON_BUTTON_CLOSE);
            this._aChangeButton = [];
            var _loc_4:* = [this._listMc.skillListGuideMc.setSkill1BtnMc, this._listMc.skillListGuideMc.setSkill2BtnMc, this._listMc.skillListGuideMc.setSkill3BtnMc, this._listMc.skillListGuideMc.setSkill4BtnMc, this._listMc.skillListGuideMc.setSkill5BtnMc, this._listMc.skillListGuideMc.setSkill6BtnMc, this._listMc.skillListGuideMc.setSkill7BtnMc, this._listMc.skillListGuideMc.setSkill8BtnMc, this._listMc.skillListGuideMc.setSkill9BtnMc, this._listMc.skillListGuideMc.setSkill10BtnMc];
            var _loc_5:* = 0;
            for each (_loc_6 in _loc_4)
            {
                
                _loc_9 = ButtonManager.getInstance().addButton(_loc_6, this.cbChangeBtn, _loc_5++);
                _loc_9.enterSeId = ButtonBase.SE_DECIDE_ID;
                TextControl.setIdText(_loc_9.getMoveClip().textMc.textDt, MessageId.PLAYER_DETAIL_BUTTON_EQUIPMENT_EQUIP);
                this._aChangeButton.push(_loc_9);
            }
            this._page = new PageButton(this._mc.skillSettingMc.pageBtnSetGuidMc, this.cbChangePage);
            this._pageAnim = new PageAnim(this._listMc, this.changePage, this.cbPageAnimEnd);
            this._aEquipmentBox = [];
            _loc_7 = [this._listMc.skillListGuideMc.skill1Mc, this._listMc.skillListGuideMc.skill2Mc, this._listMc.skillListGuideMc.skill3Mc, this._listMc.skillListGuideMc.skill4Mc, this._listMc.skillListGuideMc.skill5Mc, this._listMc.skillListGuideMc.skill6Mc, this._listMc.skillListGuideMc.skill7Mc, this._listMc.skillListGuideMc.skill8Mc, this._listMc.skillListGuideMc.skill9Mc, this._listMc.skillListGuideMc.skill10Mc];
            for each (_loc_8 in _loc_7)
            {
                
                TextControl.setIdText(_loc_8.textMc.textDt, MessageId.PLAYER_DETAIL_BUTTON_EQUIPMENT_EQUIP);
                _loc_10 = new EquipmentTextBox(_loc_8);
                this._aEquipmentBox.push(new EquipmentTextBox(_loc_8));
            }
            this._aEquippedMc = [this._listMc.skillListGuideMc.SetSkillMark1Mc, this._listMc.skillListGuideMc.SetSkillMark2Mc, this._listMc.skillListGuideMc.SetSkillMark3Mc, this._listMc.skillListGuideMc.SetSkillMark4Mc, this._listMc.skillListGuideMc.SetSkillMark5Mc, this._listMc.skillListGuideMc.SetSkillMark6Mc, this._listMc.skillListGuideMc.SetSkillMark7Mc, this._listMc.skillListGuideMc.SetSkillMark8Mc, this._listMc.skillListGuideMc.SetSkillMark9Mc, this._listMc.skillListGuideMc.SetSkillMark10Mc];
            this._iso = new InStayOut(this._mc);
            this._mc.visible = false;
            TextControl.setText(this._mc.skillSettingMc.setHeaderTextMc.textDt, "");
            this._skillSimpleStatus = new SkillSimpleStatus(this._mc);
            this._equipSimpleStatus = new EquipSimpleStatus(this._mc);
            this._pageIndex = Constant.UNDECIDED;
            this._aItem = [];
            this._aEquippedItemId = [];
            this.setDisableFlag(true);
            return;
        }// end function

        private function get itemLength() : int
        {
            return this._aItem.length;
        }// end function

        private function getItemId(param1:int) : int
        {
            switch(this._target)
            {
                case EQUIPMENT_TARGET_SKILL:
                {
                    return (this._aItem[param1] as OwnSkillData).skillId;
                }
                case EQUIPMENT_TARGET_ITEM:
                {
                    return (this._aItem[param1] as OwnItemData).itemId;
                }
                default:
                {
                    break;
                }
            }
            return 0;
        }// end function

        public function release() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            InputManager.getInstance().delMouseCallback(this._mc);
            if (this._closeBtn)
            {
                ButtonManager.getInstance().removeButton(this._closeBtn);
            }
            this._closeBtn = null;
            for each (_loc_1 in this._aChangeButton)
            {
                
                ButtonManager.getInstance().removeButton(_loc_1);
            }
            this._aChangeButton = null;
            if (this._pageAnim)
            {
                this._pageAnim.release();
            }
            this._pageAnim = null;
            if (this._page)
            {
                this._page.release();
            }
            this._page = null;
            for each (_loc_2 in this._aEquipmentBox)
            {
                
                _loc_2.release();
            }
            this._aEquipmentBox = null;
            if (this._skillSimpleStatus)
            {
                this._skillSimpleStatus.release();
            }
            this._skillSimpleStatus = null;
            if (this._equipSimpleStatus)
            {
                this._equipSimpleStatus.release();
            }
            this._equipSimpleStatus = null;
            if (this._mc && this._mc.parent)
            {
                this._mc.parent.removeChild(this._mc);
            }
            this._mc = null;
            return;
        }// end function

        public function control(param1:Number) : void
        {
            return;
        }// end function

        public function open(param1:int) : void
        {
            var index:* = param1;
            this._index = index;
            this._mc.visible = true;
            this._iso.setIn(function () : void
            {
                setDisableFlag(false);
                InputManager.getInstance().addMouseCallback(_mc, cbMouseMove);
                return;
            }// end function
            );
            return;
        }// end function

        public function isOpen() : Boolean
        {
            return this._mc.visible;
        }// end function

        public function setItem(param1:int, param2:Array, param3:Array, param4:int = 0) : void
        {
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = null;
            this._target = param1;
            this._aItem = param2.concat();
            this._aEquippedItemId = param3;
            if (this._target == EQUIPMENT_TARGET_ITEM)
            {
                for each (_loc_5 in this._aEquippedItemId)
                {
                    
                    if (_loc_5 != Constant.EMPTY_ID)
                    {
                        _loc_6 = 0;
                        while (_loc_6 < this._aItem.length)
                        {
                            
                            _loc_7 = this._aItem[_loc_6];
                            if (_loc_5 == _loc_7.itemId)
                            {
                                this._aItem.splice(_loc_6, 1);
                                break;
                            }
                            _loc_6++;
                        }
                    }
                }
                this._aEquippedItemId = [];
            }
            this._pageIndex = Constant.UNDECIDED;
            this._pageAnim.stop();
            this._page.setPage(0, Math.ceil(this.itemLength / _LIST_ITEM_NUM));
            this.changePage(this.getPageIndexAtId(param4));
            switch(this._target)
            {
                case EQUIPMENT_TARGET_SKILL:
                {
                    TextControl.setIdText(this._mc.skillSettingMc.setHeaderTextMc.textDt, MessageId.PLAYER_DETAIL_EQUIPMENT_SKILL);
                    break;
                }
                case EQUIPMENT_TARGET_ITEM:
                {
                    TextControl.setIdText(this._mc.skillSettingMc.setHeaderTextMc.textDt, MessageId.PLAYER_DETAIL_EQUIPMENT_ACCESSORIES);
                    break;
                }
                default:
                {
                    TextControl.setText(this._mc.skillSettingMc.setHeaderTextMc.textDt, "");
                    break;
                    break;
                }
            }
            return;
        }// end function

        public function setDisableFlag(param1:Boolean) : void
        {
            var _loc_2:* = null;
            if (param1)
            {
                this._closeBtn.setDisable(false);
            }
            this._closeBtn.setDisableFlag(param1);
            for each (_loc_2 in this._aChangeButton)
            {
                
                if (param1)
                {
                    _loc_2.setDisable(false);
                }
                _loc_2.setDisableFlag(param1 || !_loc_2.getMoveClip().visible);
            }
            this._page.btnDisable(param1);
            return;
        }// end function

        private function changePage(param1:int) : void
        {
            if (this._pageIndex == param1)
            {
                return;
            }
            this._pageIndex = param1;
            this._page.changePage(this._pageIndex);
            this.updateList();
            return;
        }// end function

        private function updateList() : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = false;
            var _loc_7:* = 0;
            var _loc_8:* = null;
            var _loc_1:* = 0;
            for each (_loc_2 in this._aEquipmentBox)
            {
                
                _loc_3 = this._aChangeButton[_loc_1] as ButtonBase;
                _loc_4 = this._pageIndex * _LIST_ITEM_NUM + _loc_1;
                if (_loc_4 < this.itemLength)
                {
                    switch(this._target)
                    {
                        case EQUIPMENT_TARGET_SKILL:
                        {
                            _loc_2.setEquipmentData(EquipmentTextBox.EQUIPMENT_TARGET_SKILL, this._aItem[_loc_4]);
                            break;
                        }
                        case EQUIPMENT_TARGET_ITEM:
                        {
                            _loc_2.setEquipmentData(EquipmentTextBox.EQUIPMENT_TARGET_ITEM, this._aItem[_loc_4]);
                            break;
                        }
                        default:
                        {
                            break;
                            break;
                        }
                    }
                    _loc_5 = this.getItemId(_loc_4);
                    if (_loc_5 != Constant.EMPTY_ID)
                    {
                        _loc_6 = false;
                        for each (_loc_7 in this._aEquippedItemId)
                        {
                            
                            if (_loc_5 == _loc_7)
                            {
                                _loc_6 = true;
                                break;
                            }
                        }
                        this._aEquippedMc[_loc_1].visible = _loc_6;
                        _loc_3.setDisableFlag(_loc_6);
                        _loc_3.getMoveClip().visible = !_loc_6;
                    }
                    else
                    {
                        this._aEquippedMc[_loc_1].visible = false;
                        _loc_3.setDisableFlag(true);
                        _loc_3.getMoveClip().visible = false;
                    }
                    if (this._target == EQUIPMENT_TARGET_ITEM)
                    {
                        _loc_8 = ItemManager.getInstance().getItemInformation(_loc_5);
                        _loc_2.setCanEquipped(this._personalPtr.canEquippedAccessories(_loc_8));
                        _loc_2.setSpecial(_loc_8 && _loc_8.bSpecialItem);
                        if (_loc_2.bDisable)
                        {
                            _loc_3.setDisableFlag(true);
                            _loc_3.getMoveClip().visible = false;
                        }
                    }
                    else
                    {
                        _loc_2.setCanEquipped(true);
                        _loc_2.setSpecial(false);
                    }
                }
                else
                {
                    _loc_2.setEmpty();
                    this._aEquippedMc[_loc_1].visible = false;
                    (this._aChangeButton[_loc_1] as ButtonBase).setDisableFlag(true);
                    (this._aChangeButton[_loc_1] as ButtonBase).getMoveClip().visible = false;
                }
                _loc_2.setSelect(false);
                _loc_1++;
            }
            return;
        }// end function

        private function getPageIndexAtId(param1:int) : int
        {
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_2:* = this.itemLength / _LIST_ITEM_NUM;
            if (this.itemLength % _LIST_ITEM_NUM > 0)
            {
                _loc_2++;
            }
            var _loc_3:* = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = 0;
                while (_loc_4 < _LIST_ITEM_NUM)
                {
                    
                    _loc_5 = _loc_3 * _LIST_ITEM_NUM + _loc_4;
                    if (_loc_5 >= 0 && _loc_5 < this.itemLength)
                    {
                        if (this.getItemId(_loc_5) == param1)
                        {
                            return _loc_3;
                        }
                    }
                    _loc_4++;
                }
                _loc_3++;
            }
            return 0;
        }// end function

        private function cbMouseMove(event:MouseEvent) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            if (this._aEquipmentBox == null || this._aEquipmentBox.length == 0)
            {
                return;
            }
            var _loc_2:* = false;
            var _loc_3:* = null;
            for each (_loc_4 in this._aEquipmentBox)
            {
                
                if (!_loc_4.isEmpty() && _loc_4.isHitTest())
                {
                    _loc_3 = _loc_4;
                    for each (_loc_5 in this._aEquipmentBox)
                    {
                        
                        if (_loc_4 != _loc_5)
                        {
                            _loc_5.setSelect(false);
                        }
                    }
                    break;
                    continue;
                }
                _loc_4.setSelect(false);
            }
            if (_loc_3 != null)
            {
                _loc_3.setSelect(true);
                _loc_6 = (this._aEquipmentBox.indexOf(_loc_3) & 1) == 1 ? (this._listMc.skillListGuideMc.BalloonAmbitLeftNull) : (this._listMc.skillListGuideMc.BalloonAmbitRightNull);
                _loc_7 = new Point();
                _loc_8 = new Point();
                if (_loc_3.target == EquipmentTextBox.EQUIPMENT_TARGET_SKILL)
                {
                    this._equipSimpleStatus.hide();
                    _loc_7.x = _loc_6.x;
                    _loc_7.y = _loc_6.y + (_loc_3.mcBase.y - this._listMc.skillListGuideMc.skill1Mc.y);
                    _loc_7 = _loc_6.parent.localToGlobal(_loc_7);
                    _loc_6 = _loc_3.getBalloonNull();
                    if (_loc_6)
                    {
                        _loc_8.x = _loc_6.x;
                        _loc_8.y = _loc_6.y;
                        _loc_8 = _loc_6.parent.localToGlobal(_loc_8);
                    }
                    else
                    {
                        _loc_8.x = _loc_7.x;
                        _loc_8.y = _loc_7.y;
                    }
                    this._skillSimpleStatus.show();
                    this._skillSimpleStatus.setOwnSkillData(_loc_3.getOwnSkillData());
                    this._skillSimpleStatus.setPosition(_loc_7);
                    this._skillSimpleStatus.setArrowTargetPosition(_loc_8);
                }
                else
                {
                    this._skillSimpleStatus.hide();
                    _loc_7.x = _loc_6.x;
                    _loc_7.y = _loc_6.y + (_loc_3.mcBase.y - this._listMc.skillListGuideMc.skill1Mc.y);
                    _loc_7 = _loc_6.parent.localToGlobal(_loc_7);
                    _loc_6 = _loc_3.getBalloonNull();
                    if (_loc_6)
                    {
                        _loc_8.x = _loc_6.x;
                        _loc_8.y = _loc_6.y;
                        _loc_8 = _loc_6.parent.localToGlobal(_loc_8);
                    }
                    else
                    {
                        _loc_8.x = _loc_7.x;
                        _loc_8.y = _loc_7.y;
                    }
                    this._equipSimpleStatus.show();
                    this._equipSimpleStatus.setItemData(_loc_3.id);
                    this._equipSimpleStatus.setPosition(_loc_7);
                    this._equipSimpleStatus.setArrowTargetPosition(_loc_8);
                }
            }
            else
            {
                this._skillSimpleStatus.hide();
                this._equipSimpleStatus.hide();
            }
            return;
        }// end function

        private function cbChangeBtn(param1:int) : void
        {
            var selectEquipmentId:int;
            var id:* = param1;
            this.setDisableFlag(true);
            selectEquipmentId = (this._aEquipmentBox[id] as EquipmentTextBox).id;
            this._iso.setOut(function () : void
            {
                if (_cbCloseFunc != null)
                {
                    _cbCloseFunc(_index, _target, selectEquipmentId);
                }
                return;
            }// end function
            );
            return;
        }// end function

        private function cbChangePage(param1:int, param2:int) : Boolean
        {
            this.setDisableFlag(true);
            switch(param2)
            {
                case PageButton.PAGE_BUTTON_ID_LEFT:
                case PageButton.PAGE_BUTTON_ID_LEFT_LEFT:
                case PageButton.PAGE_BUTTON_ID_LEFT_END:
                {
                    this._pageAnim.setRight(param1);
                    break;
                }
                case PageButton.PAGE_BUTTON_ID_RIGHT:
                case PageButton.PAGE_BUTTON_ID_RIGHT_RIGHT:
                case PageButton.PAGE_BUTTON_ID_RIGHT_END:
                {
                    this._pageAnim.setLeft(param1);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return false;
        }// end function

        private function cbPageAnimEnd() : void
        {
            this.setDisableFlag(false);
            return;
        }// end function

        private function cbCloseBtn(param1:int) : void
        {
            var id:* = param1;
            this.setDisableFlag(true);
            InputManager.getInstance().delMouseCallback(this._mc);
            this._iso.setOut(function () : void
            {
                if (_cbCloseFunc != null)
                {
                    _cbCloseFunc(Constant.UNDECIDED, _target, Constant.EMPTY_ID);
                }
                return;
            }// end function
            );
            return;
        }// end function

    }
}
