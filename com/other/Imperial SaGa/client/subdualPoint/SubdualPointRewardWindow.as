package subdualPoint
{
    import button.*;
    import flash.display.*;
    import message.*;
    import resource.*;
    import utility.*;

    public class SubdualPointRewardWindow extends Object
    {
        private var _phase:int;
        private var _mc:MovieClip;
        private var _isoMain:InStayOut;
        private var _btnClose:ButtonBase;
        private var _data:SubdualPointData;
        private var _rewardList:SubdualPointRewardList;
        private static const _PHASE_OPEN_WAIT:int = 0;
        private static const _PHASE_LOAD_RESOURCE:int = 1;
        private static const _PHASE_OPEN:int = 2;
        private static const _PHASE_MAIN:int = 3;
        private static const _PHASE_CLOSE:int = 4;
        private static const _PHASE_END:int = 5;

        public function SubdualPointRewardWindow(param1:DisplayObjectContainer, param2:SubdualPointData)
        {
            this._mc = ResourceManager.getInstance().createMovieClip(ResourcePath.QUEST_PATH + "UI_QuestSelect.swf", "QuestSubjugationRewardMc");
            param1.addChild(this._mc);
            this._isoMain = new InStayOut(this._mc);
            this._btnClose = ButtonManager.getInstance().addButton(this._mc.closeBtnMc, this.cbCloseBtn);
            this._btnClose.enterSeId = ButtonBase.SE_CANCEL_ID;
            this._btnClose.setDisable(true);
            TextControl.setIdText(this._mc.closeBtnMc.textMc.textDt, MessageId.COMMON_BUTTON_CLOSE);
            this._data = param2;
            this._rewardList = null;
            this.setPhase(_PHASE_LOAD_RESOURCE);
            return;
        }// end function

        public function get bEnd() : Boolean
        {
            return this._phase == _PHASE_END;
        }// end function

        public function release() : void
        {
            if (this._rewardList)
            {
                this._rewardList.release();
            }
            this._rewardList = null;
            this._data = null;
            if (this._btnClose)
            {
                ButtonManager.getInstance().removeButton(this._btnClose);
            }
            this._btnClose = null;
            if (this._isoMain)
            {
                this._isoMain.release();
            }
            this._isoMain = null;
            if (this._mc && this._mc.parent)
            {
                this._mc.parent.removeChild(this._mc);
            }
            this._mc = null;
            return;
        }// end function

        public function control(param1:Number) : void
        {
            switch(this._phase)
            {
                case _PHASE_LOAD_RESOURCE:
                {
                    this.controlLoadResource();
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
                    case _PHASE_LOAD_RESOURCE:
                    {
                        this.phaseLoadResource();
                        break;
                    }
                    case _PHASE_OPEN:
                    {
                        this.phaseOpen();
                        break;
                    }
                    case _PHASE_MAIN:
                    {
                        this.phaseMain();
                        break;
                    }
                    case _PHASE_CLOSE:
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

        private function phaseLoadResource() : void
        {
            this._data.loadResource();
            return;
        }// end function

        private function controlLoadResource() : void
        {
            if (ResourceManager.getInstance().isLoaded() == false)
            {
                return;
            }
            this._rewardList = new SubdualPointRewardList(this._mc.rewardBox, this._data);
            this.setPhase(_PHASE_OPEN);
            return;
        }// end function

        private function phaseOpen() : void
        {
            this.setIn();
            return;
        }// end function

        private function phaseMain() : void
        {
            this.setButtonEnable(true);
            return;
        }// end function

        private function phaseClose() : void
        {
            this.setButtonEnable(false);
            this.setOut();
            return;
        }// end function

        private function setIn() : void
        {
            if (this._isoMain.bOpened == false && this._isoMain.bAnimetionOpen == false)
            {
                this._isoMain.setIn(function () : void
            {
                setPhase(_PHASE_MAIN);
                return;
            }// end function
            );
            }
            else
            {
                this.setPhase(_PHASE_MAIN);
            }
            return;
        }// end function

        private function setOut() : void
        {
            if (this._isoMain.bClosed == false && this._isoMain.bAnimetionClose == false)
            {
                this._isoMain.setOut(function () : void
            {
                setPhase(_PHASE_END);
                return;
            }// end function
            );
            }
            else
            {
                this.setPhase(_PHASE_END);
            }
            return;
        }// end function

        private function setButtonEnable(param1:Boolean) : void
        {
            this._btnClose.setDisable(!param1);
            this._rewardList.setButtonEnable(param1);
            return;
        }// end function

        private function cbCloseBtn(param1:int) : void
        {
            this.setPhase(_PHASE_CLOSE);
            return;
        }// end function

    }
}
