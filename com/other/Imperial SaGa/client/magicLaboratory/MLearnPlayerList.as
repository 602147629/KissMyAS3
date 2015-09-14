package magicLaboratory
{
    import flash.display.*;
    import message.*;
    import playerList.*;
    import resource.*;
    import status.*;

    public class MLearnPlayerList extends PlayerListBase
    {
        private var _overlay:Shape;

        public function MLearnPlayerList(param1:MovieClip, param2:Array)
        {
            super(param1, param2);
            TextControl.setIdText(param1.listTitleMc.textDt, MessageId.CORRELATION_TITLE);
            TextControl.setIdText(param1.sortBtnMc.textMc.textDt, MessageId.PLAYER_LIST_SORT_BUTTON);
            this._overlay = new Shape();
            this._overlay.graphics.beginFill(4473924);
            this._overlay.graphics.drawRect(0, 0, 486, 456);
            this._overlay.graphics.endFill();
            this._overlay.alpha = 0.5;
            _mcBase.addChild(this._overlay);
            this._overlay.visible = false;
            return;
        }// end function

        override protected function createMiniStatus(param1:MovieClip) : PlayerMiniStatus
        {
            return new PlayerMiniStatus(ResourcePath.COMMON_DATA_PATH + "UI_Status.swf", param1, null, true);
        }// end function

        public function overlayVisible(param1:Boolean) : void
        {
            this._overlay.visible = param1;
            return;
        }// end function

        public static function loadResource() : void
        {
            loadSoundResourceBase();
            PlayerSimpleStatus.loadResource();
            return;
        }// end function

    }
}
