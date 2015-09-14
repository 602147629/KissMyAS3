package home
{
    import barracks.*;
    import flash.display.*;
    import utility.*;

    public class HomeHealingBox extends Object
    {
        private var _isoHealingBox:InStayOut;
        private var _healingBox:BarracksHealingBox;
        private var _mouseEnable:Boolean;

        public function HomeHealingBox(param1:MovieClip, param2:DisplayObjectContainer)
        {
            this._isoHealingBox = new InStayOut(param1);
            this._healingBox = new BarracksHealingBox(param1.ItemIconBox, param2);
            this._mouseEnable = false;
            return;
        }// end function

        public function release() : void
        {
            if (this._healingBox)
            {
                this._healingBox.release();
            }
            this._healingBox = null;
            if (this._isoHealingBox)
            {
                this._isoHealingBox.release();
            }
            this._isoHealingBox = null;
            return;
        }// end function

        public function setMouseEnable(param1:Boolean) : void
        {
            this._mouseEnable = param1;
            if (this._isoHealingBox.bOpened)
            {
                this.cbIn();
            }
            return;
        }// end function

        public function updateNum() : void
        {
            this._healingBox.updateNum();
            return;
        }// end function

        public function open() : void
        {
            this.updateNum();
            if (this._isoHealingBox.bClosed)
            {
                this._isoHealingBox.setIn(this.cbIn);
            }
            else
            {
                this.cbIn();
            }
            return;
        }// end function

        private function cbIn() : void
        {
            this._healingBox.setMouseOverEnable(this._mouseEnable);
            return;
        }// end function

        public function close() : void
        {
            this._healingBox.setMouseOverEnable(false);
            this._isoHealingBox.setOut();
            return;
        }// end function

    }
}
