package script
{
    import button.*;
    import flash.display.*;

    public class ScriptParamAutoSelect extends ScriptParamSelect
    {
        private var _bOpen:Boolean;

        public function ScriptParamAutoSelect()
        {
            return;
        }// end function

        public function get aButton() : Array
        {
            return _aButton;
        }// end function

        public function get aChoice() : Array
        {
            return _aChoice;
        }// end function

        public function get bOpened() : Boolean
        {
            return _isoMain.bOpened;
        }// end function

        public function get bOpen() : Boolean
        {
            return this._bOpen;
        }// end function

        public function setStay() : void
        {
            if (!this._bOpen)
            {
                if (_isoMain && !_isoMain.bOpened)
                {
                    _isoMain.setStay();
                }
                this.cbIn();
            }
            return;
        }// end function

        public function setEnd(param1:int) : void
        {
            _selectNo = param1;
            if (_isoMain && !_isoMain.bEnd)
            {
                _isoMain.setEnd();
            }
            cbOut();
            return;
        }// end function

        override protected function addButton(param1:ScriptSelectChoice, param2:MovieClip) : ButtonBase
        {
            var _loc_3:* = super.addButton(param1, param2);
            _loc_3.setDisableFlag(true);
            return _loc_3;
        }// end function

        override protected function cbIn() : void
        {
            this._bOpen = true;
            return;
        }// end function

    }
}
