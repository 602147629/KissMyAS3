package battle
{
    import flash.display.*;
    import flash.filters.*;
    import layer.*;
    import resource.*;

    public class BattleBadStatusColor extends Object
    {
        private var _mc:MovieClip;
        private var _layer:LayerCharacter;
        private var _bFilterStone:Boolean;
        private var _bDead:Boolean;

        public function BattleBadStatusColor(param1:LayerCharacter)
        {
            this._layer = param1;
            this._mc = ResourceManager.getInstance().createMovieClip(ResourcePath.PLAYER_ANIM_PATH + "CharaAnim.swf", "BadStatusCollor");
            this._bFilterStone = false;
            this._bDead = false;
            return;
        }// end function

        public function release() : void
        {
            if (this._mc != null)
            {
                if (this._mc.parent)
                {
                    this._mc.parent.removeChild(this._mc);
                }
            }
            this._mc = null;
            this._layer = null;
            return;
        }// end function

        public function control(param1:BattleBadStatus, param2:Boolean) : void
        {
            var _loc_5:* = null;
            var _loc_3:* = BattleManager.isBadStatusStone(param1);
            if (this._bFilterStone == _loc_3 && this._bDead == param2)
            {
                return;
            }
            var _loc_4:* = [];
            if (param2 == false)
            {
                if (_loc_3)
                {
                    for each (_loc_5 in this._mc.badStatusNull.filters)
                    {
                        
                        _loc_4.push(_loc_5.clone());
                    }
                }
            }
            this._layer.getLayer(LayerCharacter.CHARACTER).filters = _loc_4;
            this._bFilterStone = _loc_3;
            this._bDead = param2;
            return;
        }// end function

    }
}
