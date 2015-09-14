package employment
{
    import button.*;
    import flash.display.*;
    import message.*;

    public class EmploymentBuildingBtn extends ButtonBase
    {
        private var _bAvailable:Boolean;

        public function EmploymentBuildingBtn(param1:MovieClip, param2:Function, param3:Function = null, param4:Function = null)
        {
            super(param1, param2, param3, param4);
            this._bAvailable = true;
            return;
        }// end function

        public function get bAvailable() : Boolean
        {
            return this._bAvailable;
        }// end function

        public function set bAvailable(param1:Boolean) : void
        {
            this._bAvailable = param1;
            return;
        }// end function

        public function setBoardText(param1:String) : void
        {
            TextControl.setText(_mc.textMc.textDt, param1);
            return;
        }// end function

        public function setGuideText(param1:String) : void
        {
            TextControl.setText(_mc.textMc2.textDt, param1);
            return;
        }// end function

    }
}
