package user
{
    import asset.*;
    import item.*;
    import message.*;
    import network.*;
    import popup.*;
    import resource.*;
    import tutorial.*;

    public class ProvisionChecker extends Object
    {
        private var _userData:UserDataPersonal;
        private var _checkTarget:int;
        private var _aCheckTarget:Array;
        private var _aNoticeType:Array;
        private var _cbEnd:Function;
        public static const CHECK_TARGET_ALL:int = 0;
        public static const CHECK_TARGET_FREE_WHOLE_ARMY_ASSAULT:int = 1;
        public static const CHECK_TARGET_TIME_FREE_HEALING:int = 2;
        public static const CHECK_TARGET_LVUP_FREE_HEALING:int = 3;

        public function ProvisionChecker(param1:int = 0, param2:Array = null)
        {
            var _loc_3:* = null;
            var _loc_6:* = 0;
            this._userData = UserDataManager.getInstance().userData;
            this._checkTarget = param1;
            this._aCheckTarget = [];
            this._aNoticeType = [];
            if (param2 == null)
            {
                _loc_3 = [CHECK_TARGET_TIME_FREE_HEALING, CHECK_TARGET_LVUP_FREE_HEALING, CHECK_TARGET_FREE_WHOLE_ARMY_ASSAULT];
            }
            else
            {
                _loc_3 = param2.concat();
            }
            var _loc_4:* = _loc_3.indexOf(param1);
            if (_loc_3.indexOf(param1) >= 1)
            {
                _loc_3.splice(_loc_4, 1);
                _loc_3.unshift(param1);
            }
            var _loc_5:* = 0;
            while (_loc_5 < _loc_3.length)
            {
                
                _loc_6 = _loc_3[_loc_5];
                switch(_loc_6)
                {
                    case CHECK_TARGET_FREE_WHOLE_ARMY_ASSAULT:
                    {
                        this._aCheckTarget.push(this.createFreeWholeArmyAssault());
                        break;
                    }
                    case CHECK_TARGET_TIME_FREE_HEALING:
                    {
                        this._aCheckTarget.push(this.createTimeFreeHealing());
                        break;
                    }
                    case CHECK_TARGET_LVUP_FREE_HEALING:
                    {
                        this._aCheckTarget.push(this.createLvUpFreeHealing());
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
                _loc_5++;
            }
            return;
        }// end function

        public function release() : void
        {
            var _loc_1:* = null;
            this._aNoticeType = null;
            for each (_loc_1 in this._aCheckTarget)
            {
                
                _loc_1.release();
            }
            this._aCheckTarget = null;
            this._cbEnd = null;
            this._userData = null;
            return;
        }// end function

        public function check() : Boolean
        {
            var _loc_3:* = null;
            var _loc_1:* = TutorialManager.getInstance().isTutorial();
            if (_loc_1 && TutorialManager.getInstance().isBasicTutorial(CommonConstant.USER_STATE_TUTORIAL_3, TutorialManager.BASIC_TUTORIAL_FLAG_HOME_4) && !TutorialManager.getInstance().isBasicTutorial(CommonConstant.USER_STATE_TUTORIAL_3, TutorialManager.BASIC_TUTORIAL_FLAG_WORLD_MAP))
            {
                _loc_1 = false;
            }
            if (_loc_1)
            {
                return false;
            }
            var _loc_2:* = 0;
            while (_loc_2 < this._aCheckTarget.length)
            {
                
                _loc_3 = this._aCheckTarget[_loc_2];
                if (_loc_3.check())
                {
                    return true;
                }
                if (_loc_3.id == this._checkTarget)
                {
                    break;
                }
                _loc_2++;
            }
            return false;
        }// end function

        public function popup(param1:Function = null) : void
        {
            var cbEnd:* = param1;
            var aProvision:* = this.updateProvision();
            if (aProvision.length > 0)
            {
                CommonPopup.getInstance().openProvisionPopup(CommonPopup.POPUP_TYPE_NAVI, MessageManager.getInstance().getMessage(MessageId.SUPPLY_INFORMATION_TITLE), aProvision, function () : void
            {
                if (_aNoticeType.length > 0)
                {
                    _cbEnd = cbEnd;
                    NetManager.getInstance().request(new NetTaskNoticeType(_aNoticeType.shift(), cbNoticeType));
                }
                else if (cbEnd != null)
                {
                    cbEnd();
                }
                return;
            }// end function
            );
            }
            else if (cbEnd != null)
            {
                this.cbEnd();
            }
            return;
        }// end function

        private function cbNoticeType(param1:NetResult) : void
        {
            if (this._aNoticeType && this._aNoticeType.length > 0)
            {
                NetManager.getInstance().request(new NetTaskNoticeType(this._aNoticeType.shift(), this.cbNoticeType));
            }
            else
            {
                if (this._cbEnd != null)
                {
                    this._cbEnd();
                }
                this._cbEnd = null;
            }
            return;
        }// end function

        private function updateProvision() : Array
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_1:* = [];
            this._aNoticeType = [];
            var _loc_2:* = 0;
            while (_loc_2 < this._aCheckTarget.length)
            {
                
                _loc_3 = this._aCheckTarget[_loc_2];
                _loc_4 = _loc_3.update();
                if (_loc_4)
                {
                    _loc_1.push(_loc_4);
                    this._aNoticeType.push(_loc_3.noticeType);
                }
                _loc_2++;
            }
            return _loc_1;
        }// end function

        private function createFreeWholeArmyAssault() : ProvisionCheckTarget
        {
            return new ProvisionCheckTarget(CHECK_TARGET_FREE_WHOLE_ARMY_ASSAULT, this._userData.checkFreeWholeArmyAssault, this.updateFreeWholeArmyAssault, NetTaskNoticeType.TYPE_FREE_ASSAULT);
        }// end function

        private function updateFreeWholeArmyAssault() : ProvisionData
        {
            var _loc_2:* = null;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = null;
            var _loc_1:* = this._userData.updateFreeWholeArmyAssault();
            if (_loc_1)
            {
                _loc_2 = ItemManager.getInstance().getItemName(CommonConstant.ITEM_KIND_PAYMENT_ITEM, PaymentItemId.ITEM__WHOLE_ARMY_ASSAULT);
                _loc_3 = 1;
                _loc_4 = this._userData.getNextFreeWholeArmyAssaultTime();
                _loc_5 = new Date();
                _loc_5.setTime(1000 * _loc_4);
                _loc_4 = _loc_5.getHours();
                return new ProvisionData(CommonConstant.ITEM_KIND_PAYMENT_ITEM, PaymentItemId.ITEM__WHOLE_ARMY_ASSAULT, _loc_1, TextControl.formatIdText(MessageId.SUPPLY_INFORMATION_MESSAGE, _loc_2, _loc_2, _loc_3, _loc_4));
            }
            return null;
        }// end function

        private function createTimeFreeHealing() : ProvisionCheckTarget
        {
            return new ProvisionCheckTarget(CHECK_TARGET_TIME_FREE_HEALING, this._userData.checkTimeFreeHealing, this.updateTimeFreeHealing, NetTaskNoticeType.TYPE_FREE_HEALING);
        }// end function

        private function updateTimeFreeHealing() : ProvisionData
        {
            var _loc_2:* = null;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = null;
            var _loc_1:* = this._userData.updateTimeFreeHealing();
            if (_loc_1)
            {
                _loc_2 = ItemManager.getInstance().getItemName(CommonConstant.ITEM_KIND_ASSET, AssetId.ASSET_FREE_HEALING);
                _loc_3 = CommonConstant.FREE_HEALING_MAX_NUM;
                _loc_4 = this._userData.getNextFreeHealingTime();
                _loc_5 = new Date();
                _loc_5.setTime(1000 * _loc_4);
                _loc_4 = _loc_5.getHours();
                return new ProvisionData(CommonConstant.ITEM_KIND_ASSET, AssetId.ASSET_FREE_HEALING, _loc_1, TextControl.formatIdText(MessageId.SUPPLY_INFORMATION_MESSAGE, _loc_2, _loc_2, _loc_3, _loc_4));
            }
            return null;
        }// end function

        private function createLvUpFreeHealing() : ProvisionCheckTarget
        {
            return new ProvisionCheckTarget(CHECK_TARGET_LVUP_FREE_HEALING, this._userData.checkLvUpFreeHealing, this.updateLvUpFreeHealing, NetTaskNoticeType.TYPE_FREE_HEALING);
        }// end function

        private function updateLvUpFreeHealing() : ProvisionData
        {
            var _loc_2:* = null;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = null;
            var _loc_1:* = this._userData.updateLvUpFreeHealing();
            if (_loc_1)
            {
                _loc_2 = ItemManager.getInstance().getItemName(CommonConstant.ITEM_KIND_ASSET, AssetId.ASSET_FREE_HEALING);
                _loc_3 = CommonConstant.FREE_HEALING_MAX_NUM;
                _loc_4 = this._userData.getNextFreeHealingTime();
                _loc_5 = new Date();
                _loc_5.setTime(1000 * _loc_4);
                _loc_4 = _loc_5.getHours();
                return new ProvisionData(CommonConstant.ITEM_KIND_ASSET, AssetId.ASSET_FREE_HEALING, _loc_1, TextControl.formatIdText(MessageId.NOTICE_LV_UP_SUPPLY, _loc_2, _loc_3));
            }
            return null;
        }// end function

        public static function loadResource() : void
        {
            ResourceManager.getInstance().loadArray([ItemManager.getInstance().getItemPng(CommonConstant.ITEM_KIND_PAYMENT_ITEM, PaymentItemId.ITEM__WHOLE_ARMY_ASSAULT), ItemManager.getInstance().getItemPng(CommonConstant.ITEM_KIND_ASSET, AssetId.ASSET_FREE_HEALING)]);
            return;
        }// end function

    }
}

import asset.*;

import item.*;

import message.*;

import network.*;

import popup.*;

import resource.*;

import tutorial.*;

class ProvisionCheckTarget extends Object
{
    private var _id:int;
    private var _checkFunc:Function;
    private var _updateFunc:Function;
    private var _noticeType:int;

    function ProvisionCheckTarget(param1:int, param2:Function, param3:Function, param4:int)
    {
        this._id = param1;
        this._checkFunc = param2;
        this._updateFunc = param3;
        this._noticeType = param4;
        return;
    }// end function

    public function get id() : int
    {
        return this._id;
    }// end function

    public function get noticeType() : int
    {
        return this._noticeType;
    }// end function

    public function release() : void
    {
        this._updateFunc = null;
        this._checkFunc = null;
        return;
    }// end function

    public function check() : Boolean
    {
        return this._checkFunc();
    }// end function

    public function update() : ProvisionData
    {
        return this._updateFunc();
    }// end function

}

