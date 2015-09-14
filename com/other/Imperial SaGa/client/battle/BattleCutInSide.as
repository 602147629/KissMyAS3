package battle
{
    import character.*;
    import enemy.*;
    import flash.display.*;
    import flash.geom.*;
    import player.*;
    import resource.*;
    import utility.*;

    public class BattleCutInSide extends Object
    {
        private var _mcCutIn:MovieClip;
        private var _bmBustUp:Bitmap;
        private var _pos:Point;
        private var _parent:DisplayObjectContainer;
        private var _characterDisplayBase:CharacterDisplayBase;
        private var _bReverse:Boolean;

        public function BattleCutInSide(param1:DisplayObjectContainer, param2:CharacterDisplayBase, param3:Point, param4:Boolean = false)
        {
            this._parent = param1;
            this._pos = param3.clone();
            this._bReverse = param4;
            this._characterDisplayBase = param2;
            return;
        }// end function

        public function get isEnd() : Boolean
        {
            return this._mcCutIn != null && this._mcCutIn.currentLabel == "end";
        }// end function

        public function release() : void
        {
            if (this._bmBustUp)
            {
                if (this._bmBustUp.parent)
                {
                    this._bmBustUp.parent.removeChild(this._bmBustUp);
                }
            }
            this._bmBustUp = null;
            if (this._mcCutIn)
            {
                if (this._mcCutIn.parent)
                {
                    this._mcCutIn.parent.removeChild(this._mcCutIn);
                }
            }
            this._mcCutIn = null;
            this._parent = null;
            this._pos = null;
            this._characterDisplayBase = null;
            return;
        }// end function

        public function play() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = null;
            if (this._mcCutIn == null)
            {
                _loc_1 = "";
                if (this._characterDisplayBase.type == CharacterDisplayBase.TYPE_PLAYER)
                {
                    _loc_2 = this._characterDisplayBase as PlayerDisplay;
                    _loc_1 = ResourcePath.PLAYER_BUSTUP_PATH + _loc_2.info.bustUpFileName;
                }
                if (this._characterDisplayBase.type == CharacterDisplayBase.TYPE_ENEMY)
                {
                    _loc_3 = this._characterDisplayBase as EnemyDisplay;
                    _loc_1 = ResourcePath.ENEMY_BUSTUP_PATH + _loc_3.info.bustUpFileName;
                }
                this._bmBustUp = ResourceManager.getInstance().createBitmap(_loc_1);
                this._bmBustUp.smoothing = true;
                this._bmBustUp.x = this._bmBustUp.x - this._bmBustUp.width / 2;
                this._bmBustUp.y = this._bmBustUp.y - this._bmBustUp.height;
                this._mcCutIn = ResourceManager.getInstance().createMovieClip(ResourcePath.BATTLE_PATH + "UI_BattleMain.swf", "BattleChrCutInMc");
                if (this._bReverse)
                {
                    this._mcCutIn.battleCutInMc.scaleX = -1;
                }
                if (this._bmBustUp != null)
                {
                    this._mcCutIn.battleCutInMc.cutInMoveMc.cutInCharaNull.addChild(this._bmBustUp);
                }
                this._parent.addChild(this._mcCutIn);
                this._mcCutIn.x = 0;
                this._mcCutIn.y = this._pos.y;
                DisplayUtils.setTopPriority(this._characterDisplayBase.layer.parent, this._characterDisplayBase.layer);
            }
            return;
        }// end function

    }
}
