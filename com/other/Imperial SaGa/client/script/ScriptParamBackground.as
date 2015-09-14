package script
{
    import flash.display.*;
    import resource.*;

    public class ScriptParamBackground extends ScriptParamBase
    {
        private var _name:String;
        private var _fileName:String;
        private var _bmp:Bitmap;
        private var _alpha:Number;

        public function ScriptParamBackground()
        {
            this._alpha = 1;
            return;
        }// end function

        public function get name() : String
        {
            return this._name;
        }// end function

        public function get bmp() : Bitmap
        {
            return this._bmp;
        }// end function

        public function set alpha(param1:Number) : void
        {
            this._alpha = param1;
            return;
        }// end function

        override public function release() : void
        {
            ResourceManager.getInstance().removeResource(ResourcePath.EVENT_PATH + "Bg/" + this._fileName);
            if (this._bmp)
            {
                if (this._bmp.parent)
                {
                    this._bmp.parent.removeChild(this._bmp);
                }
            }
            this._bmp = null;
            return;
        }// end function

        public function setParam(param1:String, param2:String) : void
        {
            this._name = param1;
            this._fileName = param2;
            ResourceManager.getInstance().loadResource(ResourcePath.EVENT_PATH + "Bg/" + this._fileName, this.cbLoadComplete);
            return;
        }// end function

        private function cbLoadComplete() : void
        {
            this._bmp = ResourceManager.getInstance().createBitmap(ResourcePath.EVENT_PATH + "Bg/" + this._fileName);
            return;
        }// end function

        public function control(param1:Number) : void
        {
            if (this._bmp == null)
            {
                return;
            }
            this._bmp.alpha = this._alpha;
            return;
        }// end function

        public function setVisible(param1:Boolean) : void
        {
            this._bmp.visible = param1;
            return;
        }// end function

    }
}
