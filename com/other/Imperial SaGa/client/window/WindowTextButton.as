package window
{
    import button.*;
    import flash.display.*;
    import flash.text.*;
    import message.*;
    import resource.*;

    public class WindowTextButton extends WindowItemBase
    {
        private var _id:int;
        private var _textButtonMc:MovieClip;
        private var _textButton:ButtonBase;
        private var _cbFunction:Function;
        private var _textControl:TextControl;
        private var _widthScalse:Number;
        public static const BUTTON_TYPE_BLUE:int = 1;
        public static const BUTTON_TYPE_WHITE:int = 2;

        public function WindowTextButton(param1:String, param2:Function, param3:int = -1, param4:Number = 1, param5:int = 2, param6:Boolean = true)
        {
            this._widthScalse = param4;
            this._id = param3;
            this._textButtonMc = ResourceManager.getInstance().createMovieClip(ResourceManager.EMBED_COMMON_WINDOW, "textButton" + param5.toString());
            var _loc_7:* = this._textButtonMc.textMc.textDt;
            var _loc_8:* = this._textButtonMc.textMc.textDt.defaultTextFormat;
            this._textButtonMc.textMc.textDt.defaultTextFormat.size = Math.ceil(int(_loc_8.size) * param4);
            _loc_7.defaultTextFormat = _loc_8;
            this._textControl = new TextControl(_loc_7);
            addChild(this._textButtonMc);
            this._textButton = new ButtonBase(this._textButtonMc, this.cbTextButtonClick);
            this._textButton.enterSeId = ButtonBase.SE_DECIDE_ID;
            this.setText(param1);
            this._textButtonMc.height = _size.y + 1;
            this._textButtonMc.scaleX = this._widthScalse;
            _size.x = this._textControl.getWidth() * this._widthScalse;
            _bSingleHorz = param6;
            this._cbFunction = param2;
            return;
        }// end function

        override public function release() : void
        {
            super.release();
            if (this._textButtonMc && this._textButtonMc.parent)
            {
                this._textButtonMc.parent.removeChild(this._textButtonMc);
            }
            this._textButtonMc = null;
            ButtonManager.getInstance().removeButton(this._textButton);
            return;
        }// end function

        public function get textButton() : ButtonBase
        {
            return this._textButton;
        }// end function

        private function setText(param1:String) : void
        {
            this._textControl.setText(param1);
            var _loc_2:* = this._textButtonMc.textMc.textDt;
            _loc_2.text = "";
            _loc_2.width = 0;
            _size.x = this._textControl.getWidth() * this._widthScalse;
            _size.y = this._textControl.getHeigth();
            return;
        }// end function

        private function cbTextButtonClick(param1:int) : void
        {
            _windowBase.close();
            this._cbFunction(this._id);
            return;
        }// end function

        override public function setWindowBase(param1:WindowBase) : void
        {
            super.setWindowBase(param1);
            ButtonManager.getInstance().addButtonBase(this._textButton);
            return;
        }// end function

    }
}
