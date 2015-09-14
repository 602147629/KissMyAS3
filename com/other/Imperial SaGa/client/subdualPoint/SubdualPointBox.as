package subdualPoint
{
    import asset.*;
    import flash.display.*;
    import message.*;

    public class SubdualPointBox extends Object
    {
        private var _mcBase:MovieClip;

        public function SubdualPointBox(param1:MovieClip)
        {
            this._mcBase = param1;
            TextControl.setText(this._mcBase.captionTextMc.textDt, TextControl.formatIdText(MessageId.EVENT_QUEST_DESTRUCTION_POINT_NAME, AssetListManager.getInstance().getAssetName(AssetId.ASSET_EVENT_POINT_0001)));
            TextControl.setIdText(this._mcBase.pointIndividual.captionTextMc.textDt, MessageId.EVENT_QUEST_DESTRUCTION_POINT_SINGLE);
            TextControl.setIdText(this._mcBase.pointWhole.captionTextMc.textDt, MessageId.EVENT_QUEST_DESTRUCTION_POINT_ALL);
            return;
        }// end function

        public function release() : void
        {
            this._mcBase = null;
            return;
        }// end function

        public function setPoint(param1:int, param2:int) : void
        {
            TextControl.setText(this._mcBase.pointIndividual.numTextMc.textDt, param1.toString());
            TextControl.setText(this._mcBase.pointWhole.numTextMc.textDt, param2.toString());
            return;
        }// end function

    }
}
