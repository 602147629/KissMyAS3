package quest
{
    import button.*;
    import flash.display.*;
    import flash.events.*;
    import message.*;
    import player.*;
    import resource.*;
    import user.*;
    import utility.*;

    public class QuestResultYearsNotice extends Object
    {
        private var _mainIsoMc:InStayOut;
        private var _isoMcA:InStayOut;
        private var _isoMcB:InStayOut;
        private var _btnIsoMc:InStayOut;
        private var _baseMc:MovieClip;
        private var _msgMcA:MovieClip;
        private var _msgMcB:MovieClip;
        private var _chara:PlayerDisplay;
        private var _btnClose:ButtonBase;
        private var _bClose:Boolean;
        private const _dev_MSG_A:String = "陛下、作戦完了から1年が経ちました。\nこれで即位から%s年になります。";
        private const _dev_MSG_B:String = "民草のために\n予がやらねばならぬことは\nまだたくさんある。\n急ぎ次の作戦を立てねばならぬな！";

        public function QuestResultYearsNotice(param1:DisplayObjectContainer)
        {
            this._baseMc = ResourceManager.getInstance().createMovieClip(ResourcePath.RESULT_PATH + "UI_Result.swf", "AgingReportEventMc");
            param1.addChild(this._baseMc);
            this._msgMcA = ResourceManager.getInstance().createMovieClip(ResourcePath.RESULT_PATH + "UI_Result.swf", "EventBalloonMc");
            this._msgMcB = ResourceManager.getInstance().createMovieClip(ResourcePath.RESULT_PATH + "UI_Result.swf", "EventBalloonMc");
            this._baseMc.balloonNull1.addChild(this._msgMcA);
            this._baseMc.balloonNull2.addChild(this._msgMcB);
            this._msgMcA.balloonMc.gotoAndStop("balloon4");
            this._msgMcB.balloonMc.gotoAndStop("balloon3");
            this._msgMcB.balloonMc.pageSkipMc.visible = false;
            this._msgMcA.balloonMc.charaNameMc.visible = false;
            this._msgMcB.balloonMc.charaNameMc.visible = false;
            this._mainIsoMc = new InStayOut(this._baseMc);
            this._isoMcA = new InStayOut(this._msgMcA);
            this._isoMcB = new InStayOut(this._msgMcB);
            var _loc_2:* = this._dev_MSG_A.replace("%s", UserDataManager.getInstance().userData.progress.toString());
            TextControl.setText(this._msgMcA.balloonMc.textMc.textDt, _loc_2);
            TextControl.setText(this._msgMcB.balloonMc.textMc.textDt, this._dev_MSG_B);
            var _loc_3:* = QuestManager.getInstance().questData.aPlayer;
            var _loc_4:* = _loc_3[0];
            this._chara = new PlayerDisplay(this._baseMc.charaNull, _loc_4.playerId, _loc_4.uniqueId);
            this._btnIsoMc = new InStayOut(this._baseMc.nextBtnMoveMc);
            this._btnClose = ButtonManager.getInstance().addButton(this._baseMc.nextBtnMoveMc.nextBtnMc, this.cbBtnClick);
            this._btnClose.setDisableFlag(true);
            TextControl.setIdText(this._btnClose.getMoveClip().textMc.textDt, MessageId.COMMON_BUTTON_NEXT);
            this._bClose = false;
            return;
        }// end function

        public function release() : void
        {
            if (this._chara)
            {
                this._chara.release();
            }
            this._chara = null;
            if (this._btnClose)
            {
                ButtonManager.getInstance().removeButton(this._btnClose);
                this._btnClose.release();
            }
            this._btnClose = null;
            if (this._btnIsoMc)
            {
                this._btnIsoMc.release();
            }
            this._btnIsoMc = null;
            if (this._msgMcA != null && this._msgMcA.parent != null)
            {
                this._msgMcA.parent.removeChild(this._msgMcA);
            }
            this._msgMcA = null;
            if (this._isoMcA)
            {
                this._isoMcA.release();
            }
            this._isoMcA = null;
            if (this._msgMcB != null && this._msgMcB.parent != null)
            {
                this._msgMcB.parent.removeChild(this._msgMcB);
            }
            this._msgMcB = null;
            if (this._isoMcB)
            {
                this._isoMcB.release();
            }
            this._isoMcB = null;
            if (this._baseMc != null && this._baseMc.parent != null)
            {
                if (this._baseMc.stage.hasEventListener(MouseEvent.CLICK) == true)
                {
                    this._baseMc.stage.removeEventListener(MouseEvent.CLICK, this.cbMouseClick);
                }
                this._baseMc.parent.removeChild(this._baseMc);
            }
            this._baseMc = null;
            if (this._mainIsoMc)
            {
                this._mainIsoMc.release();
            }
            this._mainIsoMc = null;
            return;
        }// end function

        public function setIn() : void
        {
            this._chara.setAnimation(PlayerDisplay.LABEL_JUMP);
            this._mainIsoMc.setIn(this.cbIn);
            return;
        }// end function

        public function setOut() : void
        {
            this._chara.setAnimation(PlayerDisplay.LABEL_SIDE_DASH);
            this._chara.setReverse(true);
            this._mainIsoMc.setOut();
            return;
        }// end function

        private function cbIn() : void
        {
            this._chara.setAnimation(PlayerDisplay.LABEL_FRONT_STOP);
            this._isoMcA.setIn(this.cbMsgAIn);
            return;
        }// end function

        private function cbMsgAIn() : void
        {
            this._baseMc.stage.addEventListener(MouseEvent.CLICK, this.cbMouseClick);
            return;
        }// end function

        private function cbMsgBIn() : void
        {
            this._btnIsoMc.setIn(this.cbBtnIn);
            return;
        }// end function

        private function cbBtnIn() : void
        {
            this._btnClose.setDisable(false);
            return;
        }// end function

        private function cbBtnClick(param1:int) : void
        {
            this._btnClose.setDisableFlag(true);
            this._bClose = true;
            return;
        }// end function

        private function cbMouseClick(event:MouseEvent) : void
        {
            this._baseMc.stage.removeEventListener(MouseEvent.CLICK, this.cbMouseClick);
            this._msgMcA.balloonMc.pageSkipMc.visible = false;
            this._isoMcB.setIn(this.cbMsgBIn);
            return;
        }// end function

        public function get bClose() : Boolean
        {
            return this._bClose;
        }// end function

    }
}
