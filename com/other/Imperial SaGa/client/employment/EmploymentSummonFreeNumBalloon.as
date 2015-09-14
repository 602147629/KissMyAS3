package employment
{
    import flash.display.*;
    import message.*;
    import user.*;

    public class EmploymentSummonFreeNumBalloon extends Object
    {
        private var _mcBase:MovieClip;

        public function EmploymentSummonFreeNumBalloon(param1:MovieClip)
        {
            this._mcBase = param1;
            this.update();
            return;
        }// end function

        public function release() : void
        {
            this._mcBase = null;
            return;
        }// end function

        public function update() : void
        {
            var _loc_2:* = false;
            var _loc_1:* = UserDataManager.getInstance().userData.gachaResource / CommonConstant.EMPLOYMENT_ITEM_BASE;
            if (_loc_1 > 0)
            {
                _loc_2 = false;
                if (_loc_1 > 99)
                {
                    _loc_1 = 99;
                    _loc_2 = true;
                }
                TextControl.setText(this._mcBase.textMc.textDt, _loc_1.toString());
                this._mcBase.overIcon.visible = _loc_2;
                this._mcBase.visible = true;
            }
            else
            {
                this._mcBase.visible = false;
            }
            return;
        }// end function

        public function setVisible(param1:Boolean) : void
        {
            if (this._mcBase)
            {
                this._mcBase.visible = param1;
            }
            return;
        }// end function

    }
}
