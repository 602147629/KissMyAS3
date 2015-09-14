package script
{
    import button.*;
    import flash.display.*;
    import flash.geom.*;
    import message.*;
    import resource.*;
    import utility.*;

    public class ScriptSkipControl extends Object
    {
        private var _cbClick:Function;
        private var _mcSkipFade:MovieClip;
        private var _mcSkipBtnBox:MovieClip;
        private var _isoSkipFade:InStayOut;
        private var _isoSkipBtnBox:InStayOut;
        private var _btnSkip:ButtonBase;
        private var _bSkipBtnEnable:Boolean;
        private var _bSkipEnable_Command:Boolean;
        private var _bSkipEnable_Iso:Boolean;

        public function ScriptSkipControl(param1:MovieClip, param2:DisplayObjectContainer, param3:Function, param4:Boolean = true)
        {
            var _loc_5:* = null;
            param1.visible = false;
            if (param4)
            {
                this._cbClick = param3;
                this._mcSkipFade = ResourceManager.getInstance().createMovieClip(ScriptManager.getResourcePath(), "SkipFadeBox");
                this._mcSkipBtnBox = ResourceManager.getInstance().createMovieClip(ScriptManager.getResourcePath(), "skipBtnBox");
                _loc_5 = new Point(param1.x, param1.y);
                _loc_5 = param1.parent.localToGlobal(_loc_5);
                _loc_5 = param2.globalToLocal(_loc_5);
                this._mcSkipBtnBox.x = _loc_5.x;
                this._mcSkipBtnBox.y = _loc_5.y;
                param2.addChild(this._mcSkipBtnBox);
                param2.addChild(this._mcSkipFade);
                this._isoSkipFade = new InStayOut(this._mcSkipFade);
                this._isoSkipBtnBox = new InStayOut(this._mcSkipBtnBox);
                this._btnSkip = ButtonManager.getInstance().addButton(this._mcSkipBtnBox.skipBtn, this._cbClick);
                this._btnSkip.enterSeId = ButtonBase.SE_DECIDE_ID;
                this._btnSkip.setDisable(true);
                TextControl.setIdText(this._mcSkipBtnBox.skipBtn.textMc.textDt, MessageId.COMMON_BUTTON_SKIP);
            }
            else
            {
                this._cbClick = null;
                this._mcSkipFade = null;
                this._mcSkipBtnBox = null;
                this._isoSkipFade = null;
                this._isoSkipBtnBox = null;
                this._btnSkip = null;
            }
            this._bSkipBtnEnable = false;
            this._bSkipEnable_Command = false;
            this._bSkipEnable_Iso = false;
            return;
        }// end function

        public function get bEndMaskIn() : Boolean
        {
            return this._isoSkipFade && this._isoSkipFade.bOpened;
        }// end function

        public function get bEndMaskOut() : Boolean
        {
            return this._isoSkipFade == null || this._isoSkipFade.bClosed;
        }// end function

        public function release() : void
        {
            if (this._btnSkip)
            {
                ButtonManager.getInstance().removeButton(this._btnSkip);
            }
            this._btnSkip = null;
            if (this._isoSkipBtnBox)
            {
                this._isoSkipBtnBox.release();
            }
            this._isoSkipBtnBox = null;
            if (this._isoSkipFade)
            {
                this._isoSkipFade.release();
            }
            this._isoSkipFade = null;
            if (this._mcSkipBtnBox != null && this._mcSkipBtnBox.parent != null)
            {
                this._mcSkipBtnBox.parent.removeChild(this._mcSkipBtnBox);
            }
            this._mcSkipBtnBox = null;
            if (this._mcSkipFade != null && this._mcSkipFade.parent != null)
            {
                this._mcSkipFade.parent.removeChild(this._mcSkipFade);
            }
            this._mcSkipFade = null;
            this._cbClick = null;
            return;
        }// end function

        public function openSkipUI() : void
        {
            if (this._isoSkipBtnBox)
            {
                this._isoSkipBtnBox.setIn(function () : void
            {
                _bSkipEnable_Iso = true;
                updateSkipBtnEnable();
                return;
            }// end function
            );
            }
            return;
        }// end function

        public function closeSkipUI() : void
        {
            this._bSkipEnable_Iso = false;
            this.updateSkipBtnEnable();
            if (this._isoSkipBtnBox)
            {
                this._isoSkipBtnBox.setOut();
            }
            return;
        }// end function

        public function setCommandSkipEnable(param1:Boolean) : void
        {
            this._bSkipEnable_Command = param1;
            this.updateSkipBtnEnable();
            return;
        }// end function

        private function updateSkipBtnEnable() : void
        {
            var _loc_1:* = this._bSkipEnable_Command && this._bSkipEnable_Iso;
            if (this._bSkipBtnEnable != _loc_1)
            {
                this._bSkipBtnEnable = _loc_1;
                if (this._btnSkip)
                {
                    this._btnSkip.setDisable(!_loc_1);
                }
            }
            return;
        }// end function

        public function skipIn() : void
        {
            if (this._isoSkipFade)
            {
                this._isoSkipFade.setIn();
            }
            return;
        }// end function

        public function skipOut() : void
        {
            if (this._isoSkipFade)
            {
                this._isoSkipFade.setOut();
            }
            return;
        }// end function

    }
}
