package ending
{
    import button.*;
    import flash.display.*;
    import item.*;
    import message.*;
    import quest.*;
    import resource.*;
    import sound.*;
    import utility.*;

    public class EndingInterCycle extends Object
    {
        private const _PHASE_OPEN:int = 1;
        private const _PHASE_WAIT:int = 10;
        private const _PHASE_FINISH:int = 20;
        private const _PHASE_CLOSE:int = 99;
        private const SCENE_ITEM_SHOW:int = 1;
        private const SCENE_BUTTON_CHANGE:int = 3;
        private var _backMc:Shape;
        private var _baseMc:MovieClip;
        private var _narrationMc:MovieClip;
        private var _itemMc:MovieClip;
        private var _charaMc:MovieClip;
        private var _itemIcon:Bitmap;
        private var _isoBase:InStayOut;
        private var _isoNarration:InStayOut;
        private var _isoItem:InStayOut;
        private var _isoChara:InStayOut;
        private var _nextButton:ButtonBase;
        private var _aCycleMessageId:Array;
        private var _aGetItemData:Array;
        private var _phase:int;
        private var _scene:int;
        private var _waitTimer:Number;
        private const _WAIT_TIME:Number = 2;

        public function EndingInterCycle(param1:DisplayObjectContainer, param2:Array)
        {
            var _loc_3:* = null;
            this._aCycleMessageId = [MessageId.ENDING_MESSAGE_1_005, MessageId.ENDING_MESSAGE_1_006, MessageId.ENDING_MESSAGE_1_007, MessageId.ENDING_MESSAGE_1_008, MessageId.ENDING_MESSAGE_2_002];
            this._backMc = new Shape();
            this._backMc.graphics.beginFill(0);
            this._backMc.graphics.drawRect(0, 0, Constant.SCREEN_WIDTH, Constant.SCREEN_HEIGHT);
            this._backMc.graphics.endFill();
            param1.addChild(this._backMc);
            this._baseMc = ResourceManager.getInstance().createMovieClip(ResourcePath.RESULT_PATH + "UI_CycleChange.swf", "ResultMainMc");
            param1.addChild(this._baseMc);
            this._narrationMc = this._baseMc.cycleEndNarrationMc;
            this._itemMc = this._narrationMc.housyuMc;
            this._charaMc = this._baseMc.nabiCharaInOutMc;
            this._isoBase = new InStayOut(this._baseMc);
            this._isoNarration = new InStayOut(this._narrationMc);
            this._isoItem = new InStayOut(this._itemMc);
            this._isoChara = new InStayOut(this._charaMc);
            this._nextButton = ButtonManager.getInstance().addButton(this._narrationMc.nextBtnMc, this.cbClick);
            this._nextButton.enterSeId = ButtonBase.SE_DECIDE_ID;
            TextControl.setIdText(this._narrationMc.nextBtnMc.textMc.textDt, MessageId.COMMON_BUTTON_NEXT);
            this._nextButton.setDisable(true);
            this._aGetItemData = [];
            TextControl.setText(this._itemMc.itemTextMc.textDt, "");
            TextControl.setText(this._itemMc.itemNumTextMc.textDt, "");
            if (param2)
            {
                _loc_3 = param2[0];
                if (_loc_3)
                {
                    this._itemIcon = ResourceManager.getInstance().createBitmap(ItemManager.getInstance().getItemPng(_loc_3.categoryId, _loc_3.itemId));
                    this._itemIcon.x = -this._itemIcon.width / 2;
                    this._itemIcon.y = -this._itemIcon.height / 2;
                    this._itemMc.itemNull.addChild(this._itemIcon);
                    TextControl.setText(this._itemMc.itemTextMc.textDt, ItemManager.getInstance().getItemName(_loc_3.categoryId, _loc_3.itemId));
                    TextControl.setText(this._itemMc.itemNumTextMc.textDt, MessageManager.getInstance().getMessage(MessageId.ENDING_REWARD_NUM_CROSS) + TextControl.formatIdText(MessageId.ENDING_REWARD_NUM, _loc_3.num));
                    this._aGetItemData.push(ItemManager.getInstance().getItemName(_loc_3.categoryId, _loc_3.itemId));
                }
                ;
            }
            this.setPhase(this._PHASE_OPEN);
            return;
        }// end function

        public function get bEnd() : Boolean
        {
            return this._isoBase.bEnd;
        }// end function

        public function release() : void
        {
            if (this._isoBase)
            {
                this._isoBase.release();
            }
            if (this._isoNarration)
            {
                this._isoNarration.release();
            }
            if (this._isoItem)
            {
                this._isoItem.release();
            }
            if (this._isoChara)
            {
                this._isoChara.release();
            }
            if (this._itemIcon && this._itemIcon.parent)
            {
                this._itemIcon.parent.removeChild(this._itemIcon);
            }
            this._itemIcon = null;
            this._charaMc.removeChildren();
            this._itemMc.removeChildren();
            if (this._nextButton)
            {
                ButtonManager.getInstance().removeButton(this._nextButton);
            }
            if (this._baseMc && this._baseMc.parent)
            {
                this._baseMc.parent.removeChild(this._baseMc);
            }
            if (this._backMc && this._backMc.parent)
            {
                this._backMc.parent.removeChild(this._backMc);
            }
            return;
        }// end function

        public function control(param1:Number) : void
        {
            switch(this._phase)
            {
                case this._PHASE_OPEN:
                {
                    this.controlOpen();
                    break;
                }
                case this._PHASE_WAIT:
                {
                    this.controlWait(param1);
                    break;
                }
                case this._PHASE_FINISH:
                {
                    this.controlFinish(param1);
                    break;
                }
                case this._PHASE_CLOSE:
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
            if (param1 != this._phase)
            {
                this._phase = param1;
                switch(this._phase)
                {
                    case this._PHASE_OPEN:
                    {
                        this.phaseOpen();
                        break;
                    }
                    case this._PHASE_WAIT:
                    {
                        this.phaseWait();
                        break;
                    }
                    case this._PHASE_FINISH:
                    {
                        this.phaseFinish();
                        break;
                    }
                    case this._PHASE_CLOSE:
                    {
                        this.phaseClose();
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
            SoundManager.getInstance().playBgm(SoundId.BGM_QST_MAP_EVECMN);
            this._isoBase.setIn();
            this._isoChara.setIn();
            this._scene = 0;
            TextControl.setIdText(this._narrationMc.narrationBalloonMc.textMc.textDt, this._aCycleMessageId[this._scene]);
            return;
        }// end function

        private function controlOpen() : void
        {
            if (!this._isoBase.bAnimetionOpen)
            {
                this.setPhase(this._PHASE_WAIT);
            }
            return;
        }// end function

        private function phaseWait() : void
        {
            this._scene = 0;
            this._isoNarration.setIn();
            this._nextButton.setDisable(false);
            return;
        }// end function

        private function controlWait(param1:int) : void
        {
            if (this._scene == this.SCENE_ITEM_SHOW && this._isoItem.bClosed)
            {
                this._isoItem.setIn();
                SoundManager.getInstance().playSe(SoundId.SE_REV_RESULT_REWARD);
            }
            if (this._scene != this.SCENE_ITEM_SHOW && this._isoItem.bOpened)
            {
                this._isoItem.setOut();
            }
            if (this._scene < this._aCycleMessageId.length)
            {
                TextControl.setText(this._narrationMc.narrationBalloonMc.textMc.textDt, TextControl.formatIdText(this._aCycleMessageId[this._scene], this._aGetItemData[0]));
                if (this._scene == (this._aCycleMessageId.length - 1))
                {
                    TextControl.setText(this._narrationMc.nextBtnMc.textMc.textDt, "");
                    this._nextButton.setVisible(false);
                    this._nextButton.setDisable(true);
                    this.setPhase(this._PHASE_FINISH);
                }
                else if (this._scene == this.SCENE_BUTTON_CHANGE)
                {
                    TextControl.setIdText(this._narrationMc.nextBtnMc.textMc.textDt, MessageId.ENDING_BUTTON_NEXT);
                }
                else
                {
                    TextControl.setIdText(this._narrationMc.nextBtnMc.textMc.textDt, MessageId.COMMON_BUTTON_NEXT);
                }
            }
            else
            {
                this._isoNarration.setOut();
            }
            return;
        }// end function

        private function phaseFinish() : void
        {
            this._waitTimer = 0;
            return;
        }// end function

        private function controlFinish(param1:Number) : void
        {
            this._waitTimer = this._waitTimer + param1;
            if (this._waitTimer > this._WAIT_TIME && !Main.GetProcess().fade.isFade())
            {
                Main.GetProcess().fade.setFadeOut(3, this.cbFadeOut);
                SoundManager.getInstance().stopBgm();
            }
            return;
        }// end function

        private function phaseClose() : void
        {
            this._isoBase.setOut();
            this._isoChara.setOut();
            return;
        }// end function

        private function controlClose() : void
        {
            return;
        }// end function

        private function cbClick(param1:int) : void
        {
            var _loc_2:* = this;
            var _loc_3:* = this._scene + 1;
            _loc_2._scene = _loc_3;
            return;
        }// end function

        private function cbFadeOut() : void
        {
            this._isoNarration.setOut();
            this.setPhase(this._PHASE_CLOSE);
            return;
        }// end function

    }
}
