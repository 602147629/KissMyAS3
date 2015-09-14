package battle
{
    import flash.display.*;
    import flash.geom.*;
    import message.*;
    import resource.*;

    public class BattleCharacterName extends Object
    {
        private var _mc:MovieClip;

        public function BattleCharacterName(param1:DisplayObjectContainer, param2:String, param3:Point)
        {
            this._mc = ResourceManager.getInstance().createMovieClip(ResourcePath.BATTLE_PATH + "UI_BattleMain.swf", "MonsterNameMc");
            this._mc.x = param3.x;
            this._mc.y = param3.y;
            TextControl.setText(this._mc.textMc.textDt, param2);
            param1.addChild(this._mc);
            return;
        }// end function

        public function release() : void
        {
            if (this._mc)
            {
                if (this._mc.parent)
                {
                    this._mc.parent.removeChild(this._mc);
                }
            }
            this._mc = null;
            return;
        }// end function

    }
}
