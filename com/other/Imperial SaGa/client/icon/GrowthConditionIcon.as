package icon
{
    import flash.display.*;

    public class GrowthConditionIcon extends Object
    {
        private var _mc:MovieClip;

        public function GrowthConditionIcon(param1:MovieClip, param2:String = "5")
        {
            this._mc = param1;
            this.setGrowthLabel(param2);
            return;
        }// end function

        public function setGrowthLabel(param1:String) : void
        {
            this._mc.gotoAndStop(param1);
            return;
        }// end function

    }
}
