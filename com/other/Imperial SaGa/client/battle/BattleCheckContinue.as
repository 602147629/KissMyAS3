package battle
{
    import button.*;
    import flash.display.*;
    import message.*;
    import popup.*;
    import resource.*;
    import tutorial.*;
    import utility.*;

    public class BattleCheckContinue extends Object
    {
        private var _mc:MovieClip;
        private var _isoMain:InStayOut;
        private var _btnYes:ButtonBase;
        private var _btnNo:ButtonBase;
        private var _select:int;
        private var _bClose:Boolean;
        public static const SELECT_YES:int = 1;
        public static const SELECT_NO:int = 2;

        public function BattleCheckContinue(param1:DisplayObjectContainer, param2:Boolean = false)
        {
            this._select = Constant.UNDECIDED;
            this._bClose = false;
            if (param2 == false)
            {
                this._mc = ResourceManager.getInstance().createMovieClip(ResourcePath.BATTLE_PATH + "UI_BattleMain.swf", "RetreatPopup");
                param1.addChild(this._mc);
                this._isoMain = new InStayOut(this._mc);
                this._btnYes = ButtonManager.getInstance().addButton(this._mc.YesBtnMc, this.cbYes);
                this._btnYes.enterSeId = ButtonBase.SE_DECIDE_ID;
                this._btnNo = ButtonManager.getInstance().addButton(this._mc.NoBtnMc, this.cbNo);
                this._btnNo.enterSeId = ButtonBase.SE_CANCEL_ID;
                TextControl.setIdText(this._mc.sortieSoldierNumWindowMc.retreatText1Mc.textDt, MessageId.BATTLE_RETREAT_CONTINUE1);
                TextControl.setIdText(this._mc.YesBtnMc.textMc.textDt, MessageId.BATTLE_RETREAT_YES);
                TextControl.setIdText(this._mc.NoBtnMc.textMc.textDt, MessageId.BATTLE_RETREAT_NO);
                this.setButtonDisable();
                this._isoMain.setIn(this.cbOpen);
            }
            else
            {
                CommonPopup.getInstance().openRetreatPopup(CommonPopup.POPUP_TYPE_NAVI, MessageManager.getInstance().getMessage(MessageId.BATTLE_RETREAT_CHECK), MessageManager.getInstance().getMessage(MessageId.BATTLE_RETREAT_CHECK2), MessageManager.getInstance().getMessage(MessageId.BATTLE_RETREAT_CHECK_YES), MessageManager.getInstance().getMessage(MessageId.BATTLE_RETREAT_CHECK_NO), this.cbEscapeEntryClose);
            }
            return;
        }// end function

        public function get select() : int
        {
            return this._select;
        }// end function

        public function get bClose() : Boolean
        {
            return this._bClose;
        }// end function

        public function release() : void
        {
            if (this._btnYes)
            {
                ButtonManager.getInstance().removeButton(this._btnYes);
            }
            this._btnYes = null;
            if (this._btnNo)
            {
                ButtonManager.getInstance().removeButton(this._btnNo);
            }
            this._btnNo = null;
            if (this._isoMain)
            {
                this._isoMain.release();
            }
            this._isoMain = null;
            if (this._mc)
            {
                if (this._mc.parent)
                {
                    this._mc.parent.removeChild(this._mc);
                }
            }
            this._mc = null;
            return;
        }// end function

        private function setButtonDisable() : void
        {
            this._btnYes.setDisable(true);
            this._btnNo.setDisable(true);
            return;
        }// end function

        private function setButtonEnable() : void
        {
            this._btnYes.setDisable(false);
            this._btnNo.setDisable(false);
            return;
        }// end function

        private function cbYes(param1:int) : void
        {
            this._select = SELECT_YES;
            this.setButtonDisable();
            this._isoMain.setOut(this.cbClose);
            TutorialManager.getInstance().hideTutorial();
            return;
        }// end function

        private function cbNo(param1:int) : void
        {
            this._select = SELECT_NO;
            this.setButtonDisable();
            this._isoMain.setOut(this.cbClose);
            return;
        }// end function

        private function cbOpen() : void
        {
            this.setButtonEnable();
            if (TutorialManager.getInstance().isTutorial())
            {
                this._btnNo.setDisable(true);
                TutorialManager.getInstance().setTutorialArrow(this._btnYes.getMoveClip(), TutorialManager.TUTORIAL_ARROW_DIRECTION_UP);
                TutorialManager.getInstance().setTutorialBalloon(MessageManager.getInstance().getMessage(MessageId.TUTORIAL_BALLOON_FIRST_BATTLE_002), TutorialManager.TUTORIAL_BALLOON_POS_BOTTOM);
            }
            return;
        }// end function

        private function cbClose() : void
        {
            this._bClose = true;
            return;
        }// end function

        private function cbEscapeEntryClose(param1:Boolean) : void
        {
            if (param1)
            {
                this._select = SELECT_YES;
            }
            else
            {
                this._select = SELECT_NO;
            }
            this._bClose = true;
            return;
        }// end function

    }
}
