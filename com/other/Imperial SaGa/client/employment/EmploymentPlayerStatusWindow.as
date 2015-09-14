package employment
{
    import flash.display.*;
    import player.*;
    import status.*;

    public class EmploymentPlayerStatusWindow extends Object
    {
        private var _mcBase:MovieClip;
        private var _simpleStatus:PlayerSimpleStatus;

        public function EmploymentPlayerStatusWindow(param1:MovieClip)
        {
            this._mcBase = param1;
            this._simpleStatus = new PlayerSimpleStatus(this._mcBase, PlayerSimpleStatus.LABEL_MAIN);
            this._simpleStatus.setMouseEventEnable(false);
            this._simpleStatus.hide();
            return;
        }// end function

        public function get bOpened() : Boolean
        {
            return this._simpleStatus && this._simpleStatus.isShow() == true;
        }// end function

        public function get bClose() : Boolean
        {
            return this._simpleStatus && this._simpleStatus.isShow() == false;
        }// end function

        public function release() : void
        {
            if (this._simpleStatus)
            {
                this._simpleStatus.release();
            }
            this._simpleStatus = null;
            this._mcBase = null;
            return;
        }// end function

        public function control(param1:Number) : void
        {
            return;
        }// end function

        public function setPlayerInformation(param1:PlayerInformation) : void
        {
            if (param1)
            {
                if (this._simpleStatus)
                {
                    this._simpleStatus.setStatusByPlayerId(param1.id);
                }
            }
            return;
        }// end function

        public function open() : void
        {
            if (this._simpleStatus)
            {
                this._simpleStatus.show();
            }
            return;
        }// end function

        public function close() : void
        {
            if (this._simpleStatus)
            {
                this._simpleStatus.hide();
            }
            return;
        }// end function

    }
}
