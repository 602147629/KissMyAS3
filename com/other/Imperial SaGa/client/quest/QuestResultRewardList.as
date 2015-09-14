package quest
{
    import button.*;
    import employment.*;
    import flash.display.*;
    import flash.geom.*;
    import layer.*;
    import player.*;
    import status.*;
    import utility.*;

    public class QuestResultRewardList extends Object
    {
        private const _PAGE_NUM:int = 3;
        private const _WAIT_TIME:Number = 0.5;
        private const _BUTTON_SKIP:int = 1;
        private const _BUTTON_NEXT:int = 2;
        private var _mcResultReward:MovieClip;
        private var _mcResultRewardXX:MovieClip;
        private var _page:PageButton;
        private var _pageAnim:PageAnim;
        private var _pageIndex:int;
        private var _phase:int;
        private var _mainCtrlPhase:int;
        private var _aRemuneration:Array;
        private var _dispIndex:int;
        private var _layer:LayerQuest;
        private var _employAnimation:EmploymentNormalAnimation;
        private var _bEnd:Boolean;
        private var _bCardAnimation:Boolean;
        private var _playIndex:int;
        private var _waitTime:Number;
        private var _aButtonMc:Array;
        private var _aButton:Array;
        private var _mouseOverId:int = -1;
        private var _aRemunerationMc:Array;
        private var _aRewardRecord:Array;
        private var _playRewardRecord:QuestResultRewardRecord;
        private var _aDispRewardRecord:Array;
        private var _simpleStatus:CommonSimpleStatus;
        private static const PHASE_NOTHING:int = 0;
        private static const PHASE_OPEN:int = 1;
        private static const PHASE_MAIN:int = 10;
        private static const PHASE_CARD_ANIM:int = 21;
        private static const PHASE_PAGE_CHANGE:int = 80;
        private static const PHASE_CLOSE:int = 99;
        private static const PHASE_END:int = 999;
        private static const MAIN_PHASE_NOTHING:int = 0;
        private static const MAIN_PHASE_OPEN:int = 1;
        private static const MAIN_PHASE_WAIT:int = 10;
        private static const MAIN_PHASE_CARD:int = 20;
        private static const MAIN_PHASE_CLOSE:int = 21;

        public function QuestResultRewardList(param1:MovieClip, param2:MovieClip, param3:Array, param4:LayerQuest)
        {
            var _loc_5:* = null;
            var _loc_6:* = null;
            this._mcResultReward = param1;
            this._mcResultRewardXX = param2;
            this._aRemuneration = param3;
            this._layer = param4;
            this._pageIndex = 0;
            this._aButton = [];
            CommonSimpleStatus.loadResource();
            this._simpleStatus = new CommonSimpleStatus(this._mcResultReward);
            this._simpleStatus.hide();
            this._pageIndex = 0;
            this._page = new PageButton(this._mcResultRewardXX.pageBtnSetGuidMc, this.cbChangePage, this._pageIndex, Math.ceil(this._aRemuneration.length / this._PAGE_NUM));
            this._page.btnEnable(false);
            this._pageAnim = new PageAnim(this._mcResultRewardXX, this.changePage, this.cbPageAnimEnd);
            this._bEnd = false;
            this.createItemButton();
            this._aRemunerationMc = [this._mcResultRewardXX.rewardSetMc.reward1BtnMc.rewardMc, this._mcResultRewardXX.rewardSetMc.reward3BtnMc.rewardMc, this._mcResultRewardXX.rewardSetMc.reward5BtnMc.rewardMc];
            this._aRewardRecord = [];
            for each (_loc_5 in this._aRemunerationMc)
            {
                
                _loc_6 = new QuestResultRewardRecord(_loc_5);
                this._aRewardRecord.push(_loc_6);
            }
            this.setResultList();
            this._employAnimation = null;
            return;
        }// end function

        public function get bEnd() : Boolean
        {
            return this._bEnd;
        }// end function

        public function get bCardAnimation() : Boolean
        {
            return this._bCardAnimation;
        }// end function

        private function createItemButton() : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            this._aButtonMc = [this._mcResultRewardXX.rewardSetMc.reward1BtnMc, this._mcResultRewardXX.rewardSetMc.reward3BtnMc, this._mcResultRewardXX.rewardSetMc.reward5BtnMc];
            var _loc_1:* = 0;
            while (_loc_1 < this._aButtonMc.length)
            {
                
                _loc_2 = this._aButtonMc[_loc_1];
                _loc_3 = new ButtonBase(_loc_2, null, this.cbOverRewardButton, this.cbOutMenuRewardButton);
                _loc_3.setId(_loc_1);
                _loc_3.enterSeId = Constant.UNDECIDED;
                ButtonManager.getInstance().addButtonBase(_loc_3);
                _loc_3.setDisable(true);
                this._aButton.push(_loc_3);
                _loc_1++;
            }
            return;
        }// end function

        public function release() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            if (this._simpleStatus)
            {
                this._simpleStatus.release();
            }
            this._simpleStatus = null;
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
            for each (_loc_1 in this._aButton)
            {
                
                ButtonManager.getInstance().removeButton(_loc_1);
            }
            this._aButton = [];
            for each (_loc_2 in this._aRewardRecord)
            {
                
                if (_loc_2)
                {
                    _loc_2.release();
                }
            }
            this._aRewardRecord = [];
            this._playRewardRecord = null;
            if (this._employAnimation)
            {
                this._employAnimation.release();
            }
            this._employAnimation = null;
            if (this._mcResultRewardXX)
            {
                if (this._mcResultRewardXX.parent)
                {
                    this._mcResultRewardXX.parent.removeChild(this._mcResultRewardXX);
                }
            }
            this._mcResultRewardXX = null;
            return;
        }// end function

        private function changePage(param1:int) : void
        {
            if (this._pageIndex == param1)
            {
                return;
            }
            this._pageIndex = param1;
            this._dispIndex = this._PAGE_NUM * this._pageIndex;
            this._page.changePage(this._pageIndex);
            this.setResultList();
            return;
        }// end function

        private function cbChangePage(param1:int, param2:int) : Boolean
        {
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
            this.setBtnEnableAll(false);
            return false;
        }// end function

        private function cbPageAnimEnd() : void
        {
            if (this._phase < PHASE_CLOSE)
            {
                this.setPhase(PHASE_MAIN);
            }
            else
            {
                this.resultSkipAll();
            }
            return;
        }// end function

        private function cbOverRewardButton(param1:int) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            if (this._mouseOverId != param1)
            {
                this._mouseOverId = param1;
                _loc_2 = this._aRewardRecord[param1];
                if (_loc_2 && _loc_2.rewardData && _loc_2.rewardData.categoryId != CommonConstant.ITEM_KIND_CROWN)
                {
                    _loc_3 = this._mcResultReward.BalloonAmbitNull;
                    _loc_4 = new Point(_loc_3.x, _loc_3.y);
                    _loc_4 = _loc_3.parent.localToGlobal(_loc_4);
                    _loc_4 = this._mcResultReward.globalToLocal(_loc_4);
                    _loc_3 = this._aButtonMc[param1].rewardMc.BalloonNull;
                    _loc_5 = new Point(_loc_3.x, _loc_3.y);
                    _loc_5 = _loc_3.parent.localToGlobal(_loc_5);
                    if (this._simpleStatus)
                    {
                        this._simpleStatus.setData(_loc_2.rewardData.categoryId, _loc_2.rewardData.itemId);
                        this._simpleStatus.setPosition(_loc_4);
                        this._simpleStatus.setArrowTargetPosition(_loc_5);
                        this._simpleStatus.show();
                    }
                }
            }
            return;
        }// end function

        private function cbOutMenuRewardButton(param1:int) : void
        {
            if (this._mouseOverId == param1)
            {
                this._mouseOverId = -1;
                if (this._simpleStatus.isShow())
                {
                    this._simpleStatus.hide();
                }
            }
            return;
        }// end function

        public function control(param1:Number) : void
        {
            switch(this._phase)
            {
                case PHASE_OPEN:
                {
                    this.controlOpen();
                    break;
                }
                case PHASE_MAIN:
                {
                    this.controlMain(param1);
                    break;
                }
                case PHASE_CARD_ANIM:
                {
                    this.controlCardAnim(param1);
                    break;
                }
                case PHASE_PAGE_CHANGE:
                {
                    this.controlPageChange();
                    break;
                }
                case PHASE_CLOSE:
                {
                    this.controlClose();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function setPhase(param1:int) : void
        {
            if (this._phase != param1)
            {
                this._phase = param1;
                switch(this._phase)
                {
                    case PHASE_OPEN:
                    {
                        this.phaseOpen();
                        break;
                    }
                    case PHASE_MAIN:
                    {
                        this.phaseMain();
                        break;
                    }
                    case PHASE_CARD_ANIM:
                    {
                        this.phaseCardAnim();
                        break;
                    }
                    case PHASE_PAGE_CHANGE:
                    {
                        this.phasePageChange();
                        break;
                    }
                    case PHASE_CLOSE:
                    {
                        this.phaseClose();
                        break;
                    }
                    case PHASE_END:
                    {
                        this.phaseEnd();
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
            this.setPhase(PHASE_MAIN);
            return;
        }// end function

        private function controlOpen() : void
        {
            return;
        }// end function

        private function phaseMain() : void
        {
            this._playIndex = 0;
            this._mainCtrlPhase = MAIN_PHASE_OPEN;
            ButtonManager.getInstance().unseal();
            return;
        }// end function

        private function controlMain(param1:Number) : void
        {
            switch(this._mainCtrlPhase)
            {
                case MAIN_PHASE_OPEN:
                {
                    this._playRewardRecord = this._aDispRewardRecord[this._playIndex];
                    if (this._playRewardRecord == null)
                    {
                        this.setPhase(PHASE_PAGE_CHANGE);
                        break;
                    }
                    this._waitTime = this._WAIT_TIME;
                    this._playRewardRecord.setIn();
                    this._mainCtrlPhase = MAIN_PHASE_WAIT;
                    break;
                }
                case MAIN_PHASE_WAIT:
                {
                    if (this._playRewardRecord.currentLabel == QuestResultRewardRecord.LABEL_STAY)
                    {
                        this._waitTime = this._waitTime - param1;
                        if (this._waitTime <= 0)
                        {
                            if (this._playRewardRecord != null && this._playRewardRecord.playerDisplay != null)
                            {
                                this.phaseCardAnim();
                                this._mainCtrlPhase = MAIN_PHASE_CARD;
                            }
                            else
                            {
                                this._mainCtrlPhase = MAIN_PHASE_CLOSE;
                            }
                        }
                    }
                    break;
                }
                case MAIN_PHASE_CARD:
                {
                    this.controlCardAnim(param1);
                    break;
                }
                case MAIN_PHASE_CLOSE:
                {
                    var _loc_2:* = this;
                    var _loc_3:* = this._playIndex + 1;
                    _loc_2._playIndex = _loc_3;
                    this._mainCtrlPhase = MAIN_PHASE_OPEN;
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function phaseCardAnim() : void
        {
            this._bCardAnimation = true;
            ButtonManager.getInstance().seal(new Array());
            if (this._employAnimation)
            {
                this._employAnimation.release();
            }
            var _loc_1:* = this._playRewardRecord.playerDisplay;
            this._employAnimation = new EmploymentNormalAnimation(this._layer.getLayer(LayerQuest.ANIMATION), this.cbEmployAnimationClose);
            this._employAnimation.playAnimation(_loc_1.info);
            return;
        }// end function

        private function controlCardAnim(param1:Number) : void
        {
            if (this._employAnimation)
            {
                this._employAnimation.control(param1);
            }
            else
            {
                this._mainCtrlPhase = MAIN_PHASE_CLOSE;
            }
            return;
        }// end function

        private function cbEmployAnimationClose() : void
        {
            this._playRewardRecord.setCardNotHidden();
            this._mainCtrlPhase = MAIN_PHASE_CLOSE;
            ButtonManager.getInstance().unseal();
            this._bCardAnimation = false;
            return;
        }// end function

        private function phasePageChange() : void
        {
            var _loc_1:* = 0;
            if (this._pageIndex < (this._page.pageMax - 1))
            {
                _loc_1 = this._pageIndex + 1;
                this.cbChangePage(_loc_1, PageButton.PAGE_BUTTON_ID_RIGHT);
                ButtonManager.getInstance().seal(new Array());
            }
            else
            {
                this.setPhase(PHASE_CLOSE);
            }
            return;
        }// end function

        private function controlPageChange() : void
        {
            return;
        }// end function

        private function phaseClose() : void
        {
            return;
        }// end function

        private function controlClose() : void
        {
            this.setPhase(PHASE_END);
            return;
        }// end function

        private function phaseEnd() : void
        {
            this._bEnd = true;
            return;
        }// end function

        private function setResultList() : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_1:* = 0;
            this._aDispRewardRecord = [];
            var _loc_2:* = this._dispIndex;
            while (_loc_2 < this._dispIndex + this._PAGE_NUM)
            {
                
                _loc_3 = this._aRewardRecord[_loc_1];
                _loc_4 = this._aRemuneration[_loc_2];
                if (_loc_4 != null)
                {
                    _loc_3.setReward(_loc_4);
                    _loc_3.setVisible(true);
                    this._aDispRewardRecord.push(_loc_3);
                }
                else
                {
                    _loc_3.clear();
                    _loc_3.setVisible(false);
                }
                _loc_1++;
                _loc_2++;
            }
            return;
        }// end function

        public function resultSkip() : void
        {
            var _loc_4:* = null;
            if (this._mainCtrlPhase == MAIN_PHASE_CARD || this._mainCtrlPhase == MAIN_PHASE_CLOSE)
            {
                return;
            }
            this._pageAnim.setStay();
            var _loc_1:* = this.getWarriorRemunerationDataIdx(this._dispIndex + this._playIndex);
            if (_loc_1 == -1)
            {
                this.resultSkipAll();
                return;
            }
            var _loc_2:* = Math.floor(_loc_1 / this._PAGE_NUM);
            this._playIndex = _loc_1 - _loc_2 * this._PAGE_NUM;
            this.changePage(_loc_2);
            var _loc_3:* = 0;
            while (_loc_3 <= this._playIndex)
            {
                
                _loc_4 = this._aDispRewardRecord[_loc_3];
                if (_loc_4 != null)
                {
                    _loc_4.setStay();
                }
                _loc_3++;
            }
            this._playRewardRecord = this._aDispRewardRecord[this._playIndex];
            this.phaseCardAnim();
            this._mainCtrlPhase = MAIN_PHASE_CARD;
            return;
        }// end function

        public function resultSkipAll() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = 0;
            var _loc_3:* = null;
            var _loc_4:* = null;
            this._phase = PHASE_CLOSE;
            for each (_loc_1 in this._aDispRewardRecord)
            {
                
                if (_loc_1 != null)
                {
                    _loc_1.setCardNotHidden();
                    _loc_1.setStay();
                }
            }
            _loc_2 = 0;
            while (_loc_2 < this._aButton.length)
            {
                
                _loc_3 = this._aButton[_loc_2];
                if (_loc_2 < this._aRewardRecord.length)
                {
                    _loc_4 = this._aRewardRecord[_loc_2];
                    if (_loc_4 != null && _loc_4.rewardData != null)
                    {
                        if (!CommonSimpleStatus.isCategoryId(_loc_4.rewardData.categoryId))
                        {
                            _loc_3.setDisable(true);
                        }
                        else
                        {
                            _loc_3.setDisable(false);
                        }
                    }
                    else
                    {
                        _loc_3.setDisable(true);
                    }
                }
                else
                {
                    _loc_3.setDisable(true);
                }
                _loc_2++;
            }
            this._page.btnEnable(true);
            return;
        }// end function

        public function setBtnEnableAll(param1:Boolean) : void
        {
            var _loc_2:* = null;
            for each (_loc_2 in this._aButton)
            {
                
                if (_loc_2 != null)
                {
                    _loc_2.setDisable(!param1);
                }
            }
            this._page.btnEnable(param1);
            return;
        }// end function

        public function setIn() : void
        {
            this.setPhase(PHASE_OPEN);
            return;
        }// end function

        private function getWarriorRemunerationDataIdx(param1:int) : int
        {
            var _loc_2:* = null;
            var _loc_3:* = param1;
            while (_loc_3 < this._aRemuneration.length)
            {
                
                _loc_2 = this._aRemuneration[_loc_3];
                if (_loc_2 && _loc_2.categoryId == CommonConstant.ITEM_KIND_WARRIOR)
                {
                    return _loc_3;
                }
                _loc_3++;
            }
            return -1;
        }// end function

    }
}
