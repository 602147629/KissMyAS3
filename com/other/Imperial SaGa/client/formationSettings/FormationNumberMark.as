package formationSettings
{
    import flash.display.*;
    import resource.*;

    public class FormationNumberMark extends Object
    {
        private var _mcBase:MovieClip;
        private var _index:int;

        public function FormationNumberMark(param1:DisplayObjectContainer, param2:int)
        {
            this._mcBase = ResourceManager.getInstance().createMovieClip(ResourcePath.BATTLE_PATH + "BattleFormation.swf", "CharaSetPositionMc");
            param1.addChild(this._mcBase);
            (this._mcBase.setPositionNumMc as MovieClip).gotoAndStop("setPosition" + (param2 + 1));
            (this._mcBase.setPositionFalemMc as MovieClip).gotoAndStop("setPosition" + (param2 + 1));
            this._index = param2;
            return;
        }// end function

        public function get index() : int
        {
            return this._index;
        }// end function

        public function release() : void
        {
            if (this._mcBase && this._mcBase.parent)
            {
                this._mcBase.parent.removeChild(this._mcBase);
            }
            this._mcBase = null;
            return;
        }// end function

        public function setPosition(param1:int, param2:int) : void
        {
            this._mcBase.x = param1;
            this._mcBase.y = param2;
            return;
        }// end function

        public function mouseOn() : void
        {
            this._mcBase.gotoAndStop("onMouse");
            return;
        }// end function

        public function mouseOff() : void
        {
            this._mcBase.gotoAndStop("offMouse");
            return;
        }// end function

        public function select() : void
        {
            this._mcBase.gotoAndStop("click");
            return;
        }// end function

        public function show() : void
        {
            this._mcBase.visible = true;
            return;
        }// end function

        public function hide() : void
        {
            this._mcBase.visible = false;
            return;
        }// end function

    }
}
