package formationSettings
{
    import flash.display.*;
    import message.*;
    import resource.*;

    public class FormationChangeSetIcon extends Object
    {
        private var _mcChangeIcon:MovieClip;
        private var _mcChangeIconNot:MovieClip;
        private var _mcSetIcon:MovieClip;
        private var _mcSetIconNot:MovieClip;
        private var _type:int;
        private var _bMouseOver:Boolean;
        public static const TYPE_CHANGE:int = 0;
        public static const TYPE_SET:int = 1;
        public static const TYPE_CHANGE_NOT:int = 2;
        public static const TYPE_SET_NOT:int = 3;

        public function FormationChangeSetIcon(param1:DisplayObjectContainer, param2:int)
        {
            this._type = param2;
            this._bMouseOver = false;
            this._mcChangeIcon = ResourceManager.getInstance().createMovieClip(ResourcePath.FORMATION_PATH + "UI_Formation.swf", "CharaChangeIconMc");
            this._mcChangeIcon.mouseChildren = false;
            this._mcChangeIcon.mouseEnabled = false;
            TextControl.setIdText(this._mcChangeIcon.textMc.textDt, MessageId.FORMATION_FORMATION_REPLACE);
            this._mcChangeIconNot = ResourceManager.getInstance().createMovieClip(ResourcePath.FORMATION_PATH + "UI_Formation.swf", "CharaChangeIconMcNot");
            this._mcChangeIconNot.mouseChildren = false;
            this._mcChangeIconNot.mouseEnabled = false;
            TextControl.setIdText(this._mcChangeIconNot.textMc.textDt, MessageId.FORMATION_FORMATION_REPLACE);
            this._mcSetIcon = ResourceManager.getInstance().createMovieClip(ResourcePath.FORMATION_PATH + "UI_Formation.swf", "CharaSetIconMc");
            this._mcSetIcon.mouseChildren = false;
            this._mcSetIcon.mouseEnabled = false;
            TextControl.setIdText(this._mcSetIcon.textMc.textDt, MessageId.FORMATION_FORMATION_SET);
            this._mcSetIconNot = ResourceManager.getInstance().createMovieClip(ResourcePath.FORMATION_PATH + "UI_Formation.swf", "CharaSetIconMcNot");
            this._mcSetIconNot.mouseChildren = false;
            this._mcSetIconNot.mouseEnabled = false;
            TextControl.setIdText(this._mcSetIconNot.textMc.textDt, MessageId.FORMATION_FORMATION_SET);
            param1.addChild(this._mcChangeIcon);
            param1.addChild(this._mcChangeIconNot);
            param1.addChild(this._mcSetIcon);
            param1.addChild(this._mcSetIconNot);
            this.show();
            return;
        }// end function

        public function release() : void
        {
            if (this._mcChangeIcon && this._mcChangeIcon.parent)
            {
                this._mcChangeIcon.parent.removeChild(this._mcChangeIcon);
            }
            this._mcChangeIcon = null;
            if (this._mcChangeIconNot && this._mcChangeIconNot.parent)
            {
                this._mcChangeIconNot.parent.removeChild(this._mcChangeIconNot);
            }
            this._mcChangeIconNot = null;
            if (this._mcSetIcon && this._mcSetIcon.parent)
            {
                this._mcSetIcon.parent.removeChild(this._mcSetIcon);
            }
            this._mcSetIcon = null;
            if (this._mcSetIconNot && this._mcSetIconNot.parent)
            {
                this._mcSetIconNot.parent.removeChild(this._mcSetIconNot);
            }
            this._mcSetIconNot = null;
            return;
        }// end function

        public function setPosition(param1:int, param2:int) : void
        {
            this._mcChangeIcon.x = param1;
            this._mcChangeIcon.y = param2;
            this._mcChangeIconNot.x = param1;
            this._mcChangeIconNot.y = param2;
            this._mcSetIcon.x = param1;
            this._mcSetIcon.y = param2;
            this._mcSetIconNot.x = param1;
            this._mcSetIconNot.y = param2;
            return;
        }// end function

        public function setType(param1:int) : void
        {
            this._type = param1;
            this.show();
            return;
        }// end function

        public function mouseOver() : void
        {
            if (this._type != TYPE_CHANGE)
            {
                return;
            }
            if (this._bMouseOver)
            {
                return;
            }
            this._bMouseOver = true;
            return;
        }// end function

        public function mouseOut() : void
        {
            if (this._type != TYPE_CHANGE)
            {
                return;
            }
            if (!this._bMouseOver)
            {
                return;
            }
            this._bMouseOver = false;
            return;
        }// end function

        public function show() : void
        {
            this._mcChangeIcon.visible = this._type == TYPE_CHANGE;
            this._mcChangeIconNot.visible = this._type == TYPE_CHANGE_NOT;
            this._mcSetIcon.visible = this._type == TYPE_SET;
            this._mcSetIconNot.visible = this._type == TYPE_SET_NOT;
            return;
        }// end function

        public function hide() : void
        {
            this._mcChangeIcon.visible = false;
            this._mcChangeIconNot.visible = false;
            this._mcSetIcon.visible = false;
            this._mcSetIconNot.visible = false;
            return;
        }// end function

    }
}
