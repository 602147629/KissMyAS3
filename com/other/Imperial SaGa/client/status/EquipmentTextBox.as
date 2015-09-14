package status
{
    import flash.display.*;
    import flash.geom.*;
    import input.*;
    import item.*;
    import message.*;
    import player.*;
    import skill.*;

    public class EquipmentTextBox extends Object
    {
        private var _mcBase:MovieClip;
        private var _target:int;
        private var _equipmentData:Object;
        private var _bSelect:Boolean;
        private var _bDisable:Boolean;
        private var _bSpecial:Boolean;
        public static const EQUIPMENT_TARGET_SKILL:int = 0;
        public static const EQUIPMENT_TARGET_ITEM:int = 1;

        public function EquipmentTextBox(param1:MovieClip)
        {
            this._mcBase = param1;
            this._target = EQUIPMENT_TARGET_SKILL;
            this._equipmentData = null;
            this._bSelect = false;
            this._bDisable = false;
            this._bSpecial = false;
            TextControl.setIdText(this._mcBase.textMc.textDt, MessageId.COMMON_EMPTY);
            return;
        }// end function

        public function get mcBase() : MovieClip
        {
            return this._mcBase;
        }// end function

        public function getBalloonNull() : MovieClip
        {
            return this._mcBase.BalloonNull;
        }// end function

        public function get target() : int
        {
            return this._target;
        }// end function

        public function get id() : int
        {
            if (this._equipmentData)
            {
                switch(this._target)
                {
                    case EQUIPMENT_TARGET_SKILL:
                    {
                        return (this._equipmentData as OwnSkillData).skillId;
                    }
                    case EQUIPMENT_TARGET_ITEM:
                    {
                        return (this._equipmentData as OwnItemData).itemId;
                    }
                    default:
                    {
                        break;
                    }
                }
            }
            return Constant.EMPTY_ID;
        }// end function

        public function get bSelect() : Boolean
        {
            return this._bSelect;
        }// end function

        public function get bDisable() : Boolean
        {
            return this._bDisable;
        }// end function

        public function get bSpecial() : Boolean
        {
            return this._bSpecial;
        }// end function

        public function release() : void
        {
            if (this._mcBase && this._mcBase.parent)
            {
                this._mcBase.parent.removeChild(this._mcBase);
            }
            this._mcBase = null;
            return;
        }// end function

        public function isHitTest() : Boolean
        {
            var _loc_1:* = InputManager.getInstance().corsor;
            return this._mcBase.hitTestPoint(_loc_1.x, _loc_1.y);
        }// end function

        public function setEquipmentData(param1:int, param2) : void
        {
            this._target = param1;
            this._equipmentData = null;
            switch(this._target)
            {
                case EQUIPMENT_TARGET_SKILL:
                {
                    this.setSkillData(param2 as OwnSkillData);
                    break;
                }
                case EQUIPMENT_TARGET_ITEM:
                {
                    this.setItemData(param2 as OwnItemData);
                    break;
                }
                default:
                {
                    break;
                }
            }
            this.setSelect(false);
            return;
        }// end function

        private function setSkillData(param1:OwnSkillData) : void
        {
            var _loc_2:* = null;
            this._equipmentData = param1;
            if (param1 && param1.skillId != Constant.EMPTY_ID)
            {
                _loc_2 = SkillManager.getInstance().getSkillInformation(param1.skillId);
                if (_loc_2)
                {
                    this._mcBase.visible = true;
                    TextControl.setText(this._mcBase.textMc.textDt, _loc_2.name);
                }
            }
            else
            {
                this.setEmpty();
            }
            return;
        }// end function

        private function setItemData(param1:OwnItemData) : void
        {
            var _loc_2:* = null;
            this._equipmentData = param1;
            if (this._equipmentData && this._equipmentData.itemId != Constant.EMPTY_ID)
            {
                _loc_2 = ItemManager.getInstance().getItemInformation(this._equipmentData.itemId);
                if (_loc_2)
                {
                    this._mcBase.visible = true;
                    TextControl.setText(this._mcBase.textMc.textDt, _loc_2.name);
                }
            }
            else
            {
                this.setEmpty();
            }
            return;
        }// end function

        public function getOwnSkillData() : OwnSkillData
        {
            return this._equipmentData as OwnSkillData;
        }// end function

        public function getOwnItemData() : OwnItemData
        {
            return this._equipmentData as OwnItemData;
        }// end function

        public function setEmpty() : void
        {
            this._equipmentData = null;
            this._mcBase.visible = false;
            return;
        }// end function

        public function setCanEquipped(param1:Boolean) : void
        {
            this._bDisable = !param1;
            return;
        }// end function

        public function setSpecial(param1:Boolean) : void
        {
            this._bSpecial = param1;
            return;
        }// end function

        public function setSelect(param1:Boolean) : void
        {
            var _loc_2:* = null;
            this._bSelect = param1;
            if (this._bDisable && this._bSpecial)
            {
                _loc_2 = this._bSelect ? ("chargeItemDisableOn") : ("chargeItemDisableOff");
            }
            else if (this._bDisable)
            {
                _loc_2 = this._bSelect ? ("disableOn") : ("disableOff");
            }
            else if (this._bSpecial)
            {
                _loc_2 = this._bSelect ? ("chargeItemOn") : ("chargeItemOff");
            }
            else
            {
                _loc_2 = this._bSelect ? ("on") : ("off");
            }
            this._mcBase.gotoAndStop(_loc_2);
            return;
        }// end function

        public function getEquipmentDescription() : String
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            switch(this._target)
            {
                case EQUIPMENT_TARGET_SKILL:
                {
                    _loc_1 = this._equipmentData as OwnSkillData;
                    if (_loc_1.skillId != Constant.EMPTY_ID)
                    {
                        _loc_3 = SkillManager.getInstance().getSkillInformation(_loc_1.skillId);
                        if (_loc_3)
                        {
                            if (_loc_3.detailDescription != null)
                            {
                                return _loc_3.detailDescription;
                            }
                            return "";
                        }
                    }
                    break;
                }
                case EQUIPMENT_TARGET_ITEM:
                {
                    _loc_2 = this._equipmentData as OwnItemData;
                    if (_loc_2.itemId != Constant.EMPTY_ID)
                    {
                        _loc_4 = ItemManager.getInstance().getItemInformation(_loc_2.itemId);
                        if (_loc_4)
                        {
                            return _loc_4.explanation;
                        }
                    }
                    break;
                }
                default:
                {
                    break;
                }
            }
            return "";
        }// end function

        public function isEmpty() : Boolean
        {
            return this._equipmentData == null;
        }// end function

    }
}
