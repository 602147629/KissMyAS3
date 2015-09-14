package magicLaboratory
{
    import button.*;
    import flash.display.*;
    import message.*;
    import resource.*;
    import skill.*;
    import utility.*;

    public class MagicPlate extends Object
    {
        private var _baseMc:MovieClip;
        private var _balloonAmbitNull:MovieClip;
        private var _ambitOffs:int;
        private var _mcDevMagicPlate:MovieClip;
        private var _mcUndevMagicPlate:MovieClip;
        private var _btnDev:ButtonNotClick;
        private var _btnUndev:ButtonNotClick;
        private var _isoDev:InStayOut;
        private var _isoUndev:InStayOut;
        private var _cbMouseOver:Function;
        private var _cbMouseOut:Function;
        private var _skillId:int;
        private var _bDeveloped:Boolean;

        public function MagicPlate(param1:MovieClip, param2:MovieClip, param3:int, param4:Function, param5:Function)
        {
            this._baseMc = param1;
            this._balloonAmbitNull = param2;
            this._ambitOffs = param3;
            this._cbMouseOver = param4;
            this._cbMouseOut = param5;
            this._mcDevMagicPlate = ResourceManager.getInstance().createMovieClip(ResourcePath.FACILITY_PATH + "UI_MagicLaboratory.swf", "ListItemDevMagicMc");
            this._baseMc.addChild(this._mcDevMagicPlate);
            this._mcUndevMagicPlate = ResourceManager.getInstance().createMovieClip(ResourcePath.FACILITY_PATH + "UI_MagicLaboratory.swf", "ListItemUndevMagicMc");
            this._mcUndevMagicPlate.newIcon.visible = false;
            this._baseMc.addChild(this._mcUndevMagicPlate);
            this._btnDev = new ButtonNotClick(this._mcDevMagicPlate.skillMc, this._cbMouseOver, this._cbMouseOut);
            ButtonManager.getInstance().addButtonBase(this._btnDev);
            this._btnUndev = new ButtonNotClick(this._mcUndevMagicPlate.skillMc, this._cbMouseOver, this._cbMouseOut);
            ButtonManager.getInstance().addButtonBase(this._btnUndev);
            this._isoDev = new InStayOut(this._mcDevMagicPlate);
            this._isoUndev = new InStayOut(this._mcUndevMagicPlate);
            this.setDisable(true);
            return;
        }// end function

        public function get balloonAmbitNull() : MovieClip
        {
            return this._balloonAmbitNull;
        }// end function

        public function get ambitOffs() : int
        {
            return this._ambitOffs;
        }// end function

        public function get balloonNull() : MovieClip
        {
            return this._bDeveloped ? (this._mcDevMagicPlate.skillMc.BalloonNull) : (this._mcUndevMagicPlate.skillMc.BalloonNull);
        }// end function

        public function get skillId() : int
        {
            return this._skillId;
        }// end function

        public function get bOpen() : Boolean
        {
            return this._isoDev.bOpened || this._isoUndev.bOpened;
        }// end function

        public function get bClose() : Boolean
        {
            return this._isoDev.bClosed && this._isoUndev.bClosed;
        }// end function

        public function setSkillId(param1:int, param2:Boolean, param3:Boolean) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            this._skillId = param1;
            this._bDeveloped = param2;
            this._btnDev.setId(this._skillId);
            this._btnUndev.setId(this._skillId);
            if (this._skillId > Constant.EMPTY_ID)
            {
                _loc_4 = SkillManager.getInstance().getSkillInformation(this._skillId);
                _loc_5 = SkillManager.getInstance().getMagicTypeLabel(_loc_4.skillType);
                this._mcDevMagicPlate.skillMc.attributeTypeMc.gotoAndStop(_loc_5);
                this._mcDevMagicPlate.skillMc.skillBgMc.gotoAndStop(_loc_5);
                this._mcUndevMagicPlate.skillMc.attributeTypeMc.gotoAndStop(_loc_5);
                this._mcUndevMagicPlate.skillMc.skillUndevelopedBgMc.gotoAndStop(_loc_5);
                if (param2)
                {
                    TextControl.setText(this._mcDevMagicPlate.skillMc.skillNameMc.textDt, _loc_4.name);
                    this._isoDev.setIn();
                    this.setUndevClose();
                }
                else if (param3)
                {
                    TextControl.setIdText(this._mcUndevMagicPlate.skillMc.skillNameMc.textDt, MessageId.MAGIC_DEVELOP_UNKNOWN_ITEM);
                    this._isoUndev.setIn();
                    this.setDevClose();
                }
                else
                {
                    TextControl.setIdText(this._mcUndevMagicPlate.skillMc.skillNameMc.textDt, MessageId.MAGIC_DEVELOP_UNKNOWN_ITEM);
                    this._isoUndev.setIn();
                    this.setDevClose();
                }
                this._btnDev.setDisableFlag(!param2);
                this._btnUndev.setDisableFlag(param2);
            }
            else
            {
                this.setDisable(true);
                this.setDevClose();
                this.setUndevClose();
            }
            return;
        }// end function

        private function setDevClose() : void
        {
            if (this._isoDev.bClosed == false)
            {
                this._isoDev.setOut();
            }
            return;
        }// end function

        private function setUndevClose() : void
        {
            if (this._isoUndev.bClosed == false)
            {
                this._isoUndev.setOut();
            }
            return;
        }// end function

        public function setDisable(param1:Boolean) : void
        {
            this._btnDev.setDisableFlag(param1);
            this._btnUndev.setDisableFlag(param1);
            return;
        }// end function

        private function cbOver(param1:int) : void
        {
            return;
        }// end function

        private function cbOut(param1:int) : void
        {
            return;
        }// end function

        public function release() : void
        {
            this._cbMouseOver = null;
            if (this._btnDev != null)
            {
                ButtonManager.getInstance().removeButton(this._btnDev);
            }
            this._btnDev = null;
            if (this._btnUndev != null)
            {
                ButtonManager.getInstance().removeButton(this._btnUndev);
            }
            this._btnUndev = null;
            if (this._isoDev)
            {
                this._isoDev.release();
            }
            this._isoDev = null;
            if (this._isoUndev)
            {
                this._isoUndev.release();
            }
            this._isoUndev = null;
            if (this._mcDevMagicPlate != null)
            {
                if (this._mcDevMagicPlate.parent)
                {
                    this._mcDevMagicPlate.parent.removeChild(this._mcDevMagicPlate);
                }
            }
            this._mcDevMagicPlate = null;
            if (this._mcUndevMagicPlate != null)
            {
                if (this._mcUndevMagicPlate.parent)
                {
                    this._mcUndevMagicPlate.parent.removeChild(this._mcUndevMagicPlate);
                }
            }
            this._mcUndevMagicPlate = null;
            this._balloonAmbitNull = null;
            this._baseMc = null;
            return;
        }// end function

    }
}
