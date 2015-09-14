package magicLaboratory
{
    import button.*;
    import flash.display.*;
    import utility.*;

    public class MagicDevelopBase extends Object
    {
        protected var _mc:MovieClip;
        protected var _isoMain:InStayOut;
        protected var _aButton:Array;

        public function MagicDevelopBase(param1:MovieClip, param2:Boolean, param3:Boolean = false)
        {
            this._mc = param1;
            this._aButton = [];
            this._isoMain = new InStayOut(this._mc, param3);
            if (param2)
            {
                this._isoMain.setIn(this.cbMainIn);
            }
            return;
        }// end function

        public function get bEnd() : Boolean
        {
            return this._isoMain.bEnd;
        }// end function

        protected function cbMainIn() : void
        {
            return;
        }// end function

        public function release() : void
        {
            var _loc_1:* = null;
            for each (_loc_1 in this._aButton)
            {
                
                ButtonManager.getInstance().removeButton(_loc_1);
            }
            this._aButton = [];
            if (this._isoMain)
            {
                this._isoMain.release();
            }
            this._isoMain = null;
            if (this._mc != null && this._mc.parent != null)
            {
                this._mc.parent.removeChild(this._mc);
            }
            this._mc = null;
            return;
        }// end function

        public function open() : void
        {
            this._isoMain.setIn(this.cbMainIn);
            return;
        }// end function

        public function setButtonDisable() : void
        {
            var _loc_1:* = null;
            for each (_loc_1 in this._aButton)
            {
                
                _loc_1.setDisable(true);
            }
            return;
        }// end function

        public function close() : void
        {
            this.setButtonDisable();
            this._isoMain.setOut();
            return;
        }// end function

    }
}
