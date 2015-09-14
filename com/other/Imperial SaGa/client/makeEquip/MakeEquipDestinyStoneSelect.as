package makeEquip
{
    import button.*;
    import destinystone.*;
    import flash.display.*;
    import home.*;
    import item.*;
    import message.*;
    import popup.*;
    import resource.*;
    import tutorial.*;
    import user.*;
    import utility.*;

    public class MakeEquipDestinyStoneSelect extends MakeEquipBase
    {
        private var _parent:DisplayObjectContainer;
        private var _popupParent:DisplayObjectContainer;
        private var _aStoneImage:Array;
        private var _btnStart:ButtonBase;
        private var _btnCancel:ButtonBase;
        private var aStone:Array;
        private var _syntheticType:int;
        private var _aStoneNum:Object;
        private var _aMcWindow:Array;
        private var _bEndTime:Boolean = false;
        private var _bEndTimeOld:Boolean = false;
        private var _bEntry:Boolean;
        private var _aUseStone:Array;
        private var _recipesLevel:int;
        private var FacilityRank:InstitutionInfo;
        private var MaterialMaxLimitSyokyu:int;
        private var MaterialMaxLimitChukyu:int;
        private var MaterialMaxLimitJyoKyu:int;
        private var synteticTypeSyokyu:int;
        private var synteticTypeChukyu:int;
        private var synteticTypeJyokyu:int;
        private var _isoNaviBalloon:InStayOut;
        private var maxNum:int;
        public var _PrevRealArray:Array;
        private var _startBtn:ButtonBase;

        public function MakeEquipDestinyStoneSelect(param1:DisplayObjectContainer, param2:DisplayObjectContainer, param3:int, param4:int, param5:Array)
        {
            var _loc_8:* = 0;
            var _loc_9:* = 0;
            var _loc_10:* = null;
            this._aUseStone = [];
            this._recipesLevel = param4;
            this._parent = param1;
            this._popupParent = param2;
            this._aStoneImage = [];
            _aButton = [];
            this._PrevRealArray = param5;
            this._aStoneNum = new Object();
            this._bEntry = false;
            this.FacilityRank = UserDataManager.getInstance().userData.getInstitutionInfo(CommonConstant.FACILITY_ID_MAKE_EQUIP);
            switch(this.FacilityRank.grade)
            {
                case 1:
                {
                    this.MaterialMaxLimitSyokyu = 25;
                    this.synteticTypeSyokyu = 101;
                    break;
                }
                case 2:
                {
                    this.MaterialMaxLimitSyokyu = 50;
                    this.synteticTypeSyokyu = 102;
                    break;
                }
                case 3:
                {
                    this.MaterialMaxLimitSyokyu = 75;
                    this.synteticTypeSyokyu = 103;
                    break;
                }
                case 4:
                {
                    this.MaterialMaxLimitSyokyu = 99;
                    this.synteticTypeSyokyu = 104;
                    break;
                }
                case 5:
                {
                    this.MaterialMaxLimitSyokyu = 99;
                    this.synteticTypeSyokyu = 104;
                    break;
                }
                case 6:
                {
                    this.MaterialMaxLimitSyokyu = 99;
                    this.synteticTypeSyokyu = 104;
                    break;
                }
                case 7:
                {
                    this.MaterialMaxLimitSyokyu = 99;
                    this.synteticTypeSyokyu = 104;
                    break;
                }
                case 8:
                {
                    this.MaterialMaxLimitSyokyu = 99;
                    this.synteticTypeSyokyu = 104;
                    break;
                }
                case 8:
                {
                    this.MaterialMaxLimitSyokyu = 99;
                    this.synteticTypeSyokyu = 104;
                    break;
                }
                case 9:
                {
                    this.MaterialMaxLimitSyokyu = 99;
                    this.synteticTypeSyokyu = 104;
                    break;
                }
                case 10:
                {
                    this.MaterialMaxLimitSyokyu = 99;
                    this.synteticTypeSyokyu = 104;
                    break;
                }
                default:
                {
                    break;
                }
            }
            switch(this.FacilityRank.grade)
            {
                case 1:
                {
                    this.MaterialMaxLimitChukyu = 33;
                    this.synteticTypeChukyu = 105;
                    break;
                }
                case 2:
                {
                    this.MaterialMaxLimitChukyu = 33;
                    this.synteticTypeChukyu = 105;
                    break;
                }
                case 3:
                {
                    this.MaterialMaxLimitChukyu = 33;
                    this.synteticTypeChukyu = 105;
                    break;
                }
                case 4:
                {
                    this.MaterialMaxLimitChukyu = 33;
                    this.synteticTypeChukyu = 105;
                    break;
                }
                case 5:
                {
                    this.MaterialMaxLimitChukyu = 33;
                    this.synteticTypeChukyu = 105;
                    break;
                }
                case 6:
                {
                    this.MaterialMaxLimitChukyu = 66;
                    this.synteticTypeChukyu = 106;
                    break;
                }
                case 7:
                {
                    this.MaterialMaxLimitChukyu = 99;
                    this.synteticTypeChukyu = 107;
                    break;
                }
                case 8:
                {
                    this.MaterialMaxLimitChukyu = 99;
                    this.synteticTypeChukyu = 107;
                    break;
                }
                case 8:
                {
                    this.MaterialMaxLimitChukyu = 99;
                    this.synteticTypeChukyu = 107;
                    break;
                }
                case 9:
                {
                    this.MaterialMaxLimitChukyu = 99;
                    this.synteticTypeChukyu = 107;
                    break;
                }
                case 10:
                {
                    this.MaterialMaxLimitChukyu = 99;
                    this.synteticTypeChukyu = 107;
                    break;
                }
                default:
                {
                    break;
                }
            }
            switch(this.FacilityRank.grade)
            {
                case 1:
                {
                    this.MaterialMaxLimitJyoKyu = 33;
                    this.synteticTypeJyokyu = 108;
                    break;
                }
                case 2:
                {
                    this.MaterialMaxLimitJyoKyu = 33;
                    this.synteticTypeJyokyu = 108;
                    break;
                }
                case 3:
                {
                    this.MaterialMaxLimitJyoKyu = 33;
                    this.synteticTypeJyokyu = 108;
                    break;
                }
                case 4:
                {
                    this.MaterialMaxLimitJyoKyu = 33;
                    this.synteticTypeJyokyu = 108;
                    break;
                }
                case 5:
                {
                    this.MaterialMaxLimitJyoKyu = 33;
                    this.synteticTypeJyokyu = 108;
                    break;
                }
                case 6:
                {
                    this.MaterialMaxLimitJyoKyu = 33;
                    this.synteticTypeJyokyu = 108;
                    break;
                }
                case 7:
                {
                    this.MaterialMaxLimitJyoKyu = 33;
                    this.synteticTypeJyokyu = 108;
                    break;
                }
                case 8:
                {
                    this.MaterialMaxLimitJyoKyu = 33;
                    this.synteticTypeJyokyu = 108;
                    break;
                }
                case 8:
                {
                    this.MaterialMaxLimitJyoKyu = 33;
                    this.synteticTypeJyokyu = 108;
                    break;
                }
                case 9:
                {
                    this.MaterialMaxLimitJyoKyu = 66;
                    this.synteticTypeJyokyu = 109;
                    break;
                }
                case 10:
                {
                    this.MaterialMaxLimitJyoKyu = 99;
                    this.synteticTypeJyokyu = 110;
                    break;
                }
                default:
                {
                    break;
                }
            }
            switch(this._recipesLevel)
            {
                case 1:
                {
                    this.maxNum = this.MaterialMaxLimitSyokyu;
                    this._syntheticType = this.synteticTypeSyokyu;
                    break;
                }
                case 2:
                {
                    this.maxNum = this.MaterialMaxLimitChukyu;
                    this._syntheticType = this.synteticTypeChukyu;
                    break;
                }
                case 3:
                {
                    this.maxNum = this.MaterialMaxLimitJyoKyu;
                    this._syntheticType = this.synteticTypeJyokyu;
                    break;
                }
                default:
                {
                    break;
                }
            }
            super(param1, "dsSelectMc", true);
            this._isoNaviBalloon = new InStayOut(_mc.chrInfoBalloonTopMc);
            this._isoNaviBalloon.setIn();
            TextControl.setIdText(_mc.chrInfoBalloonTopMc.chrInfoBalloonMc.textMc.textDt, MessageId.CRAFT_ROOM_CREATE_NAVI_GUIDE_NUM);
            switch(this._recipesLevel)
            {
                case 1:
                {
                    _mc.textRecipesMc.gotoAndStop("Rank01");
                    break;
                }
                case 2:
                {
                    _mc.textRecipesMc.gotoAndStop("Rank02");
                    break;
                }
                case 3:
                {
                    _mc.textRecipesMc.gotoAndStop("Rank03");
                    break;
                }
                default:
                {
                    break;
                }
            }
            TextControl.setText(_mc.chooseWindMc.InfoTextMc.textDt, TextControl.formatIdText(MessageId.CRAFT_ROOM_SET_MATERIALS_LIMIT, this.maxNum.toString()));
            this._aMcWindow = [_mc.chooseWindMc.dsWind1Mc, _mc.chooseWindMc.dsWind2Mc, _mc.chooseWindMc.dsWind3Mc];
            this.aStone = MakeEquipConstant.aUseStone[this._recipesLevel];
            var _loc_6:* = 0;
            while (_loc_6 < 3)
            {
                
                _loc_8 = this.aStone[_loc_6];
                _loc_9 = UserDataManager.getInstance().userData.getOwnDestinyStoneNum(_loc_8);
                this.setWindow(_loc_6, _loc_8, this._aMcWindow[_loc_6], this.maxNum, MakeEquipConstant.aMinUseStoneNum[_loc_6], this._PrevRealArray[_loc_6]);
                _loc_6++;
            }
            this._startBtn = ButtonManager.getInstance().addButton(_mc.startBtnMc, this.cbStart);
            this._startBtn.enterSeId = ButtonBase.SE_DECIDE_ID;
            _aButton.push(this._startBtn);
            TextControl.setIdText(_mc.startBtnMc.textMc.textDt, MessageId.MAKE_EQUIP_CREATE_START);
            this._btnCancel = ButtonManager.getInstance().addButton(_mc.returnBtnMc, this.cbReturn);
            this._btnCancel.enterSeId = ButtonBase.SE_CANCEL_ID;
            _aButton.push(this._btnCancel);
            TextControl.setIdText(_mc.returnBtnMc.textMc.textDt, MessageId.COMMON_BUTTON_RETURN);
            var _loc_7:* = 0;
            while (_loc_7 < this._aMcWindow.length)
            {
                
                _loc_10 = ButtonManager.getInstance().addButton(this._aMcWindow[_loc_7].stoneMaxBtnMc, this.cbNumMaxButton, _loc_7);
                _loc_10.enterSeId = ButtonBase.SE_CURSOR_ID;
                _aButton.push(_loc_10);
                TextControl.setIdText(this._aMcWindow[_loc_7].stoneMaxBtnMc.textMc.textDt, MessageId.MAKE_EQUIP_CREATE_DSMAX);
                _loc_10 = ButtonManager.getInstance().addButton(this._aMcWindow[_loc_7].stoneResetBtnMc, this.cbNumMinButton, _loc_7);
                _loc_10.enterSeId = ButtonBase.SE_CURSOR_ID;
                _aButton.push(_loc_10);
                TextControl.setIdText(this._aMcWindow[_loc_7].stoneResetBtnMc.textMc.textDt, MessageId.MAKE_EQUIP_CREATE_DSMIN);
                _loc_7++;
            }
            return;
        }// end function

        public function get syntheticType() : int
        {
            return this._syntheticType;
        }// end function

        public function get aUseStoneNum() : Object
        {
            return this._aStoneNum;
        }// end function

        public function getWindowMovieClip() : MovieClip
        {
            return _mc;
        }// end function

        public function get bClosed() : Boolean
        {
            return _isoMain.bClosed;
        }// end function

        public function get bEntry() : Boolean
        {
            return this._bEntry;
        }// end function

        public function get startBtn() : ButtonBase
        {
            return this._startBtn;
        }// end function

        override public function release() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = null;
            for each (_loc_1 in this._aUseStone)
            {
                
                _loc_1.release();
            }
            this._aUseStone = [];
            super.release();
            for each (_loc_2 in this._aStoneImage)
            {
                
                _loc_3 = _loc_2.bitmapData;
                _loc_3.dispose();
                _loc_2.bitmapData = null;
                if (_loc_2.parent)
                {
                    _loc_2.parent.removeChild(_loc_2);
                }
            }
            this._aStoneImage = [];
            this._aMcWindow = [];
            this._parent = null;
            _mc = null;
            return;
        }// end function

        private function initResource() : void
        {
            _isoMain.setIn();
            this._isoNaviBalloon.setIn();
            return;
        }// end function

        private function setWindow(param1:int, param2:int, param3:MovieClip, param4:int, param5:int, param6:int) : void
        {
            var _loc_10:* = 0;
            var _loc_7:* = ItemManager.getInstance().getDestinyStoneInformation(param2);
            TextControl.setText(param3.textMc.textDt, _loc_7.name);
            var _loc_8:* = UserDataManager.getInstance().userData.getOwnDestinyStoneNum(param2);
            TextControl.setText(param3.NumTextMc.textDt, _loc_8.toString());
            var _loc_9:* = ResourceManager.getInstance().createBitmap(ResourcePath.DESTINY_STONE_PATH + _loc_7.fileName);
            ResourceManager.getInstance().createBitmap(ResourcePath.DESTINY_STONE_PATH + _loc_7.fileName).smoothing = true;
            param3.dsNull.addChild(_loc_9);
            this._aStoneImage.push(_loc_9);
            if (param6 == 0)
            {
                _loc_10 = param5;
            }
            if (param6 != 0)
            {
                _loc_10 = param6;
            }
            var _loc_11:* = new ReelCounter(param3.ItemNumSelectMc, _loc_10, param4, param5);
            this._aUseStone[param1] = _loc_11;
            return;
        }// end function

        private function cbNumMaxButton(param1:int) : void
        {
            this._aUseStone[param1].numMax();
            return;
        }// end function

        private function cbNumMinButton(param1:int) : void
        {
            this._aUseStone[param1].numMin();
            return;
        }// end function

        private function updateStoneNumber(param1:int, param2:int) : void
        {
            this._aStoneNum[param1] = param2;
            return;
        }// end function

        private function cbReturn(param1:int) : void
        {
            this._isoNaviBalloon.setOut();
            close();
            return;
        }// end function

        private function cbReset(param1:int) : void
        {
            return;
        }// end function

        private function cbStart(param1:int) : void
        {
            var nowNum:int;
            var needmaterialNum:int;
            var info:DestinyStoneInformation;
            var needmaterialName:String;
            var reel:ReelCounter;
            var id:* = param1;
            this.setButtonDisable(true);
            var NeededMaterialsName:Array;
            var NeededMaterialsNum:Array;
            var aStone:* = MakeEquipConstant.aUseStone[this._recipesLevel];
            var connectToServer:Boolean;
            var i:int;
            while (i < aStone.length)
            {
                
                nowNum = UserDataManager.getInstance().userData.getOwnDestinyStoneNum(aStone[i]);
                if (nowNum < this._aUseStone[i].num)
                {
                    connectToServer;
                }
                needmaterialNum = this._aUseStone[i].num - nowNum;
                if (needmaterialNum > 0)
                {
                    NeededMaterialsNum.push(needmaterialNum);
                }
                info = ItemManager.getInstance().getDestinyStoneInformation(aStone[i]);
                needmaterialName = info.name;
                if (needmaterialNum > 0)
                {
                    NeededMaterialsName.push(needmaterialName);
                }
                i = (i + 1);
            }
            var PopUpText:* = MessageManager.getInstance().getMessage(MessageId.CRAFT_ROOM_NOT_ENOUGH_TO_MATERIALS_01);
            var d:int;
            while (d < NeededMaterialsNum.length)
            {
                
                PopUpText = PopUpText + ("\n" + TextControl.formatIdText(MessageId.CRAFT_ROOM_NOT_ENOUGH_TO_MATERIALS_02, NeededMaterialsName[d], NeededMaterialsNum[d]));
                d = (d + 1);
            }
            if (connectToServer == false)
            {
                CommonPopup.getInstance().openAlertPopup(CommonPopup.POPUP_TYPE_NORMAL, PopUpText, function () : void
            {
                var _loc_1:* = null;
                setButtonDisable(false);
                for each (_loc_1 in _aUseStone)
                {
                    
                    _loc_1.setDisable(false);
                }
                return;
            }// end function
            );
                return;
            }
            var c:int;
            while (c < aStone.length)
            {
                
                reel = this._aUseStone[c];
                this.updateStoneNumber(aStone[c], reel.num);
                this._PrevRealArray[c] = reel.num;
                c = (c + 1);
            }
            _isoMain.setOut();
            this._isoNaviBalloon.setOut();
            this._bEntry = true;
            this.setButtonDisable(true);
            return;
        }// end function

        public function control(param1:Number) : void
        {
            var _loc_2:* = UserDataManager.getInstance().userData.getInstitutionInfo(CommonConstant.FACILITY_ID_MAKE_EQUIP);
            var _loc_3:* = TimeClock.getNowTime();
            if (_loc_2.upgradeEnd > _loc_3 && _loc_2.upgradeEnd != 0)
            {
                this._bEndTime = true;
            }
            if (this._bEndTime != this._bEndTimeOld)
            {
                this._bEndTimeOld = this._bEndTime;
                if (this._bEndTime)
                {
                    this.setButtonDisable(true);
                    this._btnCancel.setDisable(false);
                }
                else
                {
                    this.setButtonDisable(false);
                }
            }
            return;
        }// end function

        override protected function cbMainIn() : void
        {
            super.cbMainIn();
            if (TutorialManager.getInstance().isFacilityTutorial(TutorialManager.FACILITY_TUTORIAL_FLAG_MAKE_EQUIP_SYNTHETIC_2))
            {
                TutorialManager.getInstance().stepChange(2);
            }
            return;
        }// end function

        override public function setButtonDisable(param1:Boolean) : void
        {
            var _loc_3:* = null;
            super.setButtonDisable(param1);
            var _loc_2:* = 0;
            while (_loc_2 < this._aUseStone.length)
            {
                
                _loc_3 = this._aUseStone[_loc_2];
                _loc_3.setDisable(true);
                _loc_2++;
            }
            return;
        }// end function

    }
}
