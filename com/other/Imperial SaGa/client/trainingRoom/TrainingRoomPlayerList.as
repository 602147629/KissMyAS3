package trainingRoom
{
    import flash.display.*;
    import playerList.*;
    import status.*;

    public class TrainingRoomPlayerList extends PlayerListBase
    {
        private var _overlay:Shape;

        public function TrainingRoomPlayerList(param1:MovieClip, param2:Array)
        {
            super(param1, param2);
            this._overlay = new Shape();
            this._overlay.graphics.beginFill(4473924);
            this._overlay.graphics.drawRect(0, 0, 486, 456);
            this._overlay.graphics.endFill();
            this._overlay.alpha = 0.5;
            _mcBase.addChild(this._overlay);
            this._overlay.visible = false;
            return;
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
