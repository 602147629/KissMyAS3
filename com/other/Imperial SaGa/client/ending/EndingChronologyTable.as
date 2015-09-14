package ending
{
    import button.*;
    import flash.display.*;
    import message.*;
    import utility.*;

    public class EndingChronologyTable extends Object
    {
        private const _PHASE_OPEN:int = 1;
        private const _PHASE_SCROLL:int = 10;
        private const _PHASE_WAIT:int = 20;
        private const _PHASE_CLOSE:int = 99;
        private const _SCROLL_SPEED:int = 5;
        private var _baseMc:MovieClip;
        private var _isoBase:InStayOut;
        private var _nextBtn:ButtonBase;
        private var _chronologyMc:EndingChronologyDetailList;
        private var _phase:int;
        private var _bSkip:Boolean;

        public function EndingChronologyTable(param1:MovieClip, param2:Array)
        {
            this._baseMc = param1;
            this._isoBase = new InStayOut(param1);
            this._nextBtn = ButtonManager.getInstance().addButton(this._baseMc.nextBtnMc, this.cbClose);
            this._nextBtn.enterSeId = ButtonBase.SE_DECIDE_ID;
            this._nextBtn.setDisable(true);
            TextControl.setIdText(this._baseMc.nextBtnMc.textMc.textDt, MessageId.COMMON_BUTTON_SKIP);
            this._chronologyMc = new EndingChronologyDetailList(this._baseMc.chronologicalSetMc, this._baseMc.ScrollBerSet, this._baseMc.chronologicalSetMc.chronologySwindNull1.y, param2);
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
            if (this._nextBtn)
            {
                ButtonManager.getInstance().removeButton(this._nextBtn);
            }
            if (this._chronologyMc)
            {
                this._chronologyMc.release();
            }
            return;
        }// end function

        public function openTable() : void
        {
            if (this._isoBase.bClosed)
            {
                this.setPhase(this._PHASE_OPEN);
            }
            return;
        }// end function

        public function closeTable() : void
        {
            if (this._isoBase.bOpened)
            {
                this.setPhase(this._PHASE_CLOSE);
            }
            return;
        }// end function

        public function getCurrentChapter() : int
        {
            switch(this._phase)
            {
                case this._PHASE_SCROLL:
                {
                    return this._chronologyMc.getPositionChapter();
                }
                case this._PHASE_WAIT:
                {
                    return this._chronologyMc.getPointedChapter();
                }
                default:
                {
                    return Constant.UNDECIDED;
                    break;
                }
            }
        }// end function

        public function control(param1:Number) : void
        {
            this._chronologyMc.control(param1);
            switch(this._phase)
            {
                case this._PHASE_OPEN:
                {
                    this.controlOpen();
                    break;
                }
                case this._PHASE_SCROLL:
                {
                    this.controlScroll();
                    break;
                }
                case this._PHASE_WAIT:
                {
                    this.controlWait();
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
                    case this._PHASE_SCROLL:
                    {
                        this.phaseScroll();
                        break;
                    }
                    case this._PHASE_WAIT:
                    {
                        this.phaseWait();
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
            this._bSkip = false;
            this._isoBase.setIn();
            this._chronologyMc.setScrollBarVisible(false);
            this._nextBtn.setDisable(false);
            this._chronologyMc.setPos(this._baseMc.chronologicalSetMc.chronologySwindNull5.y);
            this._chronologyMc.setScrollable(false);
            return;
        }// end function

        private function controlOpen() : void
        {
            if (this._isoBase.bAnimetionOpen)
            {
                this.setPhase(this._PHASE_SCROLL);
            }
            return;
        }// end function

        private function phaseScroll() : void
        {
            this._chronologyMc.setScrollable(true);
            this._chronologyMc.setSpeed(this._SCROLL_SPEED);
            return;
        }// end function

        private function controlScroll() : void
        {
            if (!this._chronologyMc.bMoving)
            {
                this.setPhase(this._PHASE_WAIT);
            }
            return;
        }// end function

        private function phaseWait() : void
        {
            this._bSkip = true;
            this._chronologyMc.setScrollBarVisible(true);
            this._nextBtn.setDisable(false);
            this._chronologyMc.setSpeed(this._SCROLL_SPEED * 3);
            TextControl.setIdText(this._baseMc.nextBtnMc.textMc.textDt, MessageId.COMMON_BUTTON_NEXT);
            return;
        }// end function

        private function controlWait() : void
        {
            return;
        }// end function

        private function phaseClose() : void
        {
            this._isoBase.setOut();
            return;
        }// end function

        private function controlClose() : void
        {
            return;
        }// end function

        private function cbClose(param1:int) : void
        {
            if (this._bSkip == false)
            {
                this._chronologyMc.setPos(this._chronologyMc.getLastPos());
                this._nextBtn.setDisable(true);
            }
            else
            {
                this.setPhase(this._PHASE_CLOSE);
            }
            return;
        }// end function

    }
}
