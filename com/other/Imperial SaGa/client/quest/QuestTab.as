package quest
{
    import button.*;
    import flash.display.*;
    import message.*;
    import player.*;
    import resource.*;
    import utility.*;

    public class QuestTab extends Object
    {
        private var _aButtonMessage:Array;
        private var _mc:MovieClip;
        private var _mcIconMove:MovieClip;
        private var _mcIconBattle:MovieClip;
        private var _mcTitle:MovieClip;
        private var _mcWindow:MovieClip;
        private var _isoTab:InStayOut;
        private var _aMcCharaPoint:Array;
        private var _aButton:Array;
        private var _buttonCount:int;
        private var _bIconMoveing:Boolean;
        private var _bIconBattle:Boolean;
        private var _selectButtonType:int;
        private var _phase:int;
        private var _bmpWindowImage:Bitmap;
        public static const WINDOW_IMAGE_TURNING_POINT:int = 1;
        public static const WINDOW_IMAGE_CITY:int = 2;
        private static var _WINDOW_IMAGE_TURNING_POINT_FILE:String = "DivideIcon_TurningPoint.png";
        private static var _WINDOW_IMAGE_CITY_FILE:String = "DivideIcon_City.png";
        private static const _LABEL_IN2:String = "in2";
        private static const _LABEL_STAY2:String = "stay2";
        private static const _LABEL_OUT2:String = "out2";
        private static const _PHASE_TAB_ACTION:int = 0;
        private static const _PHASE_TAB_IN:int = 1;
        private static const _PHASE_TAB_FULL:int = 2;
        private static const _PHASE_TAB_OUT:int = 3;
        public static const BUTTON_ID1:int = 0;
        public static const BUTTON_ID2:int = 1;
        public static const BUTTON_ID3:int = 2;
        public static const BUTTON_ID4:int = 3;
        public static const BUTTON_TYPE_MOVE_LEFT:int = 0;
        public static const BUTTON_TYPE_MOVE_CENTER:int = 1;
        public static const BUTTON_TYPE_MOVE_RIGHT:int = 2;
        public static const BUTTON_TYPE_DIVIDE:int = 3;
        public static const BUTTON_COUNT1:int = 1;
        public static const BUTTON_COUNT2:int = 2;
        public static const BUTTON_COUNT3:int = 3;
        public static const BUTTON_COUNT4:int = 4;
        private static const _BUTTON_LABEL_PATTERN1:String = "btnPtn1";
        private static const _BUTTON_LABEL_PATTERN2:String = "btnPtn2";
        private static const _BUTTON_LABEL_PATTERN3:String = "btnPtn3";
        private static const _BUTTON_LABEL_PATTERN4:String = "btnPtn4";

        public function QuestTab(param1:MovieClip, param2:int)
        {
            this._aButtonMessage = [MessageId.QUEST_TAB_BUTTON_LEFT, MessageId.QUEST_TAB_BUTTON_CENTER, MessageId.QUEST_TAB_BUTTON_RIGHT, MessageId.QUEST_TAB_BUTTON_DIVIDE];
            this._bmpWindowImage = null;
            this._mc = param1;
            this._mcIconMove = this._mc.teamTabContentsMc.tabMoveIconMc;
            this._mcIconBattle = this._mc.teamTabContentsMc.tabBattleIconMc;
            this._mcTitle = this._mc.teamTabContentsMc.pointTitleMc;
            this._mcWindow = this._mc.teamTabContentsMc.spotNull;
            switch(param2)
            {
                case QuestConstant.TEAM_NO1:
                {
                    this._mc.teamTabContentsMc.teamBaseMc.gotoAndStop("team1");
                    TextControl.setIdText(this._mc.teamTabContentsMc.teamBaseMc.textMc.textDT, MessageId.QUEST_TAB_TEAM1);
                    break;
                }
                case QuestConstant.TEAM_NO2:
                {
                    this._mc.teamTabContentsMc.teamBaseMc.gotoAndStop("team2");
                    TextControl.setIdText(this._mc.teamTabContentsMc.teamBaseMc.textMc.textDT, MessageId.QUEST_TAB_TEAM2);
                    break;
                }
                case QuestConstant.TEAM_NO3:
                {
                    this._mc.teamTabContentsMc.teamBaseMc.gotoAndStop("team3");
                    TextControl.setIdText(this._mc.teamTabContentsMc.teamBaseMc.textMc.textDT, MessageId.QUEST_TAB_TEAM3);
                    break;
                }
                default:
                {
                    break;
                }
            }
            this._aMcCharaPoint = [this._mc.teamTabContentsMc.teamBaseMc.charaNull1, this._mc.teamTabContentsMc.teamBaseMc.charaNull2, this._mc.teamTabContentsMc.teamBaseMc.charaNull3, this._mc.teamTabContentsMc.teamBaseMc.charaNull4, this._mc.teamTabContentsMc.teamBaseMc.charaNull5];
            this._aButton = [new ButtonBase(this._mc.teamTabContentsMc.tabBtnPtn.tabBtn1, this.cbButtonClick), new ButtonBase(this._mc.teamTabContentsMc.tabBtnPtn.tabBtn2, this.cbButtonClick), new ButtonBase(this._mc.teamTabContentsMc.tabBtnPtn.tabBtn3, this.cbButtonClick), new ButtonBase(this._mc.teamTabContentsMc.tabBtnPtn.tabBtn4, this.cbButtonClick)];
            this._isoTab = new InStayOut(this._mc);
            this._selectButtonType = Constant.UNDECIDED;
            this._phase = _PHASE_TAB_OUT;
            this.dispIconMove(true);
            this.dispIconBattle(false);
            this.dispTitle(false);
            return;
        }// end function

        public function get selectButtonType() : int
        {
            return this._selectButtonType;
        }// end function

        public function clearSelectButton() : void
        {
            this._selectButtonType = Constant.UNDECIDED;
            return;
        }// end function

        public function get bTabIn() : Boolean
        {
            return this._phase == _PHASE_TAB_IN;
        }// end function

        public function get bTabFull() : Boolean
        {
            return this._phase == _PHASE_TAB_FULL;
        }// end function

        public function get bTabOut() : Boolean
        {
            return this._phase == _PHASE_TAB_OUT;
        }// end function

        public function release() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            for each (_loc_1 in this._aButton)
            {
                
                ButtonManager.getInstance().removeButton(_loc_1);
            }
            this._aButton = null;
            this._isoTab.release();
            this._isoTab = null;
            if (this._mc.parent)
            {
                this._mc.parent.removeChild(this._mc);
            }
            this._mc = null;
            this.windowImageRelease();
            for each (_loc_2 in this._aMcCharaPoint)
            {
                
                if (_loc_2.parent)
                {
                    _loc_2.parent.removeChild(_loc_2);
                }
            }
            this._aMcCharaPoint = null;
            this._mcTitle = null;
            this._mcIconMove = null;
            this._mcIconBattle = null;
            this._mcWindow = null;
            return;
        }// end function

        public function setIn() : void
        {
            this._selectButtonType = Constant.UNDECIDED;
            this._phase = _PHASE_TAB_ACTION;
            this._isoTab.setIn(this.cbIn);
            return;
        }// end function

        private function cbIn() : void
        {
            this._phase = _PHASE_TAB_IN;
            return;
        }// end function

        public function setInToFull() : void
        {
            this._selectButtonType = Constant.UNDECIDED;
            this._phase = _PHASE_TAB_ACTION;
            this._isoTab.setInLabel(_LABEL_IN2, this.cbFull);
            return;
        }// end function

        private function cbFull() : void
        {
            var _loc_2:* = null;
            var _loc_1:* = 0;
            while (_loc_1 < this._aButton.length)
            {
                
                _loc_2 = this._aButton[_loc_1];
                if (_loc_1 < this._buttonCount)
                {
                    _loc_2.setDisable(false);
                    ButtonManager.getInstance().addButtonBase(_loc_2);
                }
                else
                {
                    _loc_2.setDisable(true);
                }
                _loc_1++;
            }
            this._phase = _PHASE_TAB_FULL;
            return;
        }// end function

        public function setOut() : void
        {
            this._phase = _PHASE_TAB_ACTION;
            this._isoTab.setOut(this.cbOut);
            return;
        }// end function

        private function cbOut() : void
        {
            this._phase = _PHASE_TAB_OUT;
            return;
        }// end function

        public function setFullToIn() : void
        {
            var _loc_1:* = null;
            for each (_loc_1 in this._aButton)
            {
                
                ButtonManager.getInstance().removeArray(_loc_1);
            }
            this._phase = _PHASE_TAB_ACTION;
            this._isoTab.setOutToStayLabel(_LABEL_OUT2, this.cbFullToIn);
            return;
        }// end function

        private function cbFullToIn() : void
        {
            this._phase = _PHASE_TAB_IN;
            this.dispTitle(false);
            this.windowImageRelease();
            return;
        }// end function

        private function windowImageRelease() : void
        {
            if (this._bmpWindowImage != null)
            {
                if (this._bmpWindowImage.parent)
                {
                    this._bmpWindowImage.parent.removeChild(this._bmpWindowImage);
                }
            }
            this._bmpWindowImage = null;
            return;
        }// end function

        public function dispIconMove(param1:Boolean) : void
        {
            this._bIconMoveing = param1;
            this._mcIconMove.visible = param1;
            return;
        }// end function

        public function dispIconBattle(param1:Boolean) : void
        {
            this._bIconBattle = param1;
            this._mcIconBattle.visible = param1;
            return;
        }// end function

        public function dispTitle(param1:Boolean) : void
        {
            this._mcTitle.visible = param1;
            return;
        }// end function

        public function setTitle(param1:String) : void
        {
            this.dispTitle(true);
            TextControl.setText(this._mcTitle.textMc.textDt, param1);
            return;
        }// end function

        public function setWindowImage(param1:int) : void
        {
            switch(param1)
            {
                case WINDOW_IMAGE_TURNING_POINT:
                {
                    break;
                }
                case WINDOW_IMAGE_CITY:
                {
                    break;
                }
                default:
                {
                    break;
                }
            }
            if (this._bmpWindowImage != null)
            {
                this._mc.teamTabContentsMc.spotNull.addChild(this._bmpWindowImage);
            }
            return;
        }// end function

        private function cbButtonClick(param1:int) : void
        {
            this._selectButtonType = param1;
            return;
        }// end function

        public function setButton(param1:int, param2:int) : void
        {
            if (param1 >= this._aButton.length)
            {
                throw new Error("ボタンの限界数以上に設定しようとしている");
            }
            var _loc_3:* = this._aButton[param1];
            _loc_3.setId(param2);
            var _loc_4:* = _loc_3.getMoveClip();
            TextControl.setIdText(_loc_4.textMC.textDt, this._aButtonMessage[param2]);
            return;
        }// end function

        public function setButtonCount(param1:int) : void
        {
            if (param1 > this._aButton.length)
            {
                throw new Error("ボタンの限界数以上に設定しようとしている");
            }
            var _loc_2:* = this._mc.teamTabContentsMc.tabBtnPtn;
            switch(param1)
            {
                case BUTTON_COUNT1:
                {
                    _loc_2.gotoAndStop(_BUTTON_LABEL_PATTERN1);
                    break;
                }
                case BUTTON_COUNT2:
                {
                    _loc_2.gotoAndStop(_BUTTON_LABEL_PATTERN2);
                    break;
                }
                case BUTTON_COUNT3:
                {
                    _loc_2.gotoAndStop(_BUTTON_LABEL_PATTERN3);
                    break;
                }
                case BUTTON_COUNT4:
                {
                    _loc_2.gotoAndStop(_BUTTON_LABEL_PATTERN4);
                    break;
                }
                default:
                {
                    break;
                }
            }
            this._buttonCount = param1;
            return;
        }// end function

        public function setPlayer(param1:PlayerDisplay, param2:int) : void
        {
            param1.setParent(this._aMcCharaPoint[param2]);
            return;
        }// end function

        public static function getResourcePathArray() : Array
        {
            return [ResourcePath.QUEST_MAP_PARTS_PATH + _WINDOW_IMAGE_TURNING_POINT_FILE, ResourcePath.QUEST_MAP_PARTS_PATH + _WINDOW_IMAGE_CITY_FILE];
        }// end function

    }
}
