package asset
{
    import flash.display.*;
    import resource.*;

    public class AssetIcon extends Object
    {
        private var _itemIcon:Bitmap;

        public function AssetIcon(param1:MovieClip, param2:int)
        {
            if (param1)
            {
                this._itemIcon = ResourceManager.getInstance().createBitmap(AssetListManager.getInstance().getAssetPng(param2));
                this._itemIcon.smoothing = true;
                param1.addChild(this._itemIcon);
            }
            return;
        }// end function

        public function release() : void
        {
            if (this._itemIcon)
            {
                if (this._itemIcon.parent)
                {
                    this._itemIcon.parent.removeChild(this._itemIcon);
                }
                this._itemIcon = null;
            }
            return;
        }// end function

    }
}
