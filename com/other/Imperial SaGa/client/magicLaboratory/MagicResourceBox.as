package magicLaboratory
{
    import asset.*;
    import flash.display.*;
    import message.*;
    import status.*;
    import user.*;

    public class MagicResourceBox extends UserResourceBox
    {

        public function MagicResourceBox(param1:MovieClip)
        {
            super(param1, AssetId.ASSET_MAGIC_DEVELOP);
            return;
        }// end function

        override public function updateNum() : void
        {
            var _loc_1:* = UserDataManager.getInstance().userData.magicResource;
            TextControl.setText(_mcBase.NumTextMc.textDt, _loc_1.toString());
            return;
        }// end function

    }
}
