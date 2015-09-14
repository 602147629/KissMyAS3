package magicLaboratory
{
    import asset.*;
    import flash.display.*;
    import message.*;
    import utility.*;

    public class MagicLearnPlate extends Object
    {
        private var _baseMc:MovieClip;
        private var _skillNameMc:MovieClip;
        private var _learningTime:NumericNumberMc;
        private var _assetIcon:AssetIcon;

        public function MagicLearnPlate(param1:MovieClip, param2:MovieClip, param3:MovieClip, param4:MovieClip = null)
        {
            this._baseMc = param1;
            this._skillNameMc = param2;
            this._learningTime = new NumericNumberMc(param3.larningTimeMc, 0, 0);
            this._assetIcon = null;
            if (param4)
            {
                this._assetIcon = new AssetIcon(param4, AssetId.ASSET_MAGIC_DEVELOP);
            }
            return;
        }// end function

        public function release() : void
        {
            if (this._assetIcon)
            {
                this._assetIcon.release();
            }
            this._assetIcon = null;
            if (this._learningTime)
            {
                this._learningTime.release();
            }
            this._learningTime = null;
            this._baseMc = null;
            this._skillNameMc = null;
            return;
        }// end function

        public function setEnable(param1:Boolean) : void
        {
            this._baseMc.visible = param1;
            return;
        }// end function

        public function setSkillName(param1:String) : void
        {
            TextControl.setText(this._skillNameMc.textDt, param1);
            return;
        }// end function

        public function setLearningTime(param1:uint) : void
        {
            var _loc_2:* = param1 % 60;
            var _loc_3:* = param1 / 60 % 60;
            var _loc_4:* = param1 / 60 / 60;
            var _loc_5:* = param1 / 60 / 60 * 10000 + _loc_3 * 100 + _loc_2;
            this._learningTime.setNum(_loc_5);
            return;
        }// end function

        public function control(param1:Number) : void
        {
            this._learningTime.control(param1);
            return;
        }// end function

        public function setResourceNum(param1:int) : void
        {
            if (this._baseMc.costTextMc)
            {
                TextControl.setText(this._baseMc.costTextMc.textDt, param1.toString());
            }
            return;
        }// end function

    }
}
