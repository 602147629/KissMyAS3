package employment
{
    import flash.display.*;
    import flash.geom.*;
    import player.*;
    import sound.*;
    import status.*;

    public class EmploymentBoxAnimationBase extends Object
    {
        private var _simpleStatus:PlayerSimpleStatus;
        private var _parent:DisplayObjectContainer;
        private var _mouseOverPInfo:PlayerInformation;
        private var _bMouseEnable:Boolean;

        public function EmploymentBoxAnimationBase(param1:DisplayObjectContainer = null)
        {
            this._parent = param1;
            this.setCardMouseEnable(false);
            this._simpleStatus = new PlayerSimpleStatus(this._parent, PlayerSimpleStatus.LABEL_MAIN);
            this._simpleStatus.setMouseEventEnable(false);
            this._simpleStatus.hide();
            return;
        }// end function

        public function release() : void
        {
            this.setCardMouseEnable(false);
            if (this._simpleStatus)
            {
                this._simpleStatus.release();
            }
            this._simpleStatus = null;
            this._mouseOverPInfo = null;
            this._parent = null;
            return;
        }// end function

        protected function setCardMouseEnable(param1:Boolean) : void
        {
            this._bMouseEnable = param1;
            if (this._bMouseEnable == false)
            {
                if (this._simpleStatus && this._simpleStatus.isShow())
                {
                    this._simpleStatus.hide();
                }
            }
            return;
        }// end function

        protected function cbCardMouseOver(param1:MovieClip, param2:PlayerInformation) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            if (!this._bMouseEnable)
            {
                return;
            }
            if (this._mouseOverPInfo != param2 && param2 != null)
            {
                this._mouseOverPInfo = param2;
                SoundManager.getInstance().playSe(SoundId.SE_BED);
                _loc_3 = param1.BalloonAmbitNull;
                _loc_4 = new Point(_loc_3.x, _loc_3.y);
                _loc_4 = _loc_3.parent.localToGlobal(_loc_4);
                _loc_3 = param1.BalloonNull;
                _loc_5 = new Point(_loc_3.x, _loc_3.y);
                _loc_5 = _loc_3.parent.localToGlobal(_loc_5);
                if (this._simpleStatus)
                {
                    this._simpleStatus.setStatusByPlayerId(param2.id);
                    this._simpleStatus.setPosition(_loc_4);
                    this._simpleStatus.setArrowTargetPosition(_loc_5);
                    this._simpleStatus.show();
                }
            }
            return;
        }// end function

        protected function cbCardMouseOut(param1:MovieClip, param2:PlayerInformation) : void
        {
            if (!this._bMouseEnable)
            {
                return;
            }
            if (this._mouseOverPInfo == param2)
            {
                this._mouseOverPInfo = null;
                if (this._simpleStatus.isShow())
                {
                    this._simpleStatus.hide();
                }
            }
            return;
        }// end function

    }
}
