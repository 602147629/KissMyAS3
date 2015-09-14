package questSelect
{
    import flash.display.*;
    import flash.geom.*;
    import player.*;
    import status.*;
    import user.*;
    import utility.*;

    public class QuestSelectSimpleStatus extends Object
    {
        private var _parent:DisplayObjectContainer;
        private var _simpleStatus:PlayerSimpleStatus;

        public function QuestSelectSimpleStatus(param1:DisplayObjectContainer)
        {
            this._parent = param1;
            this._simpleStatus = new PlayerSimpleStatus(this._parent, PlayerSimpleStatus.LABEL_MAIN);
            this._simpleStatus.setArrowTargetPosition(new Point(this._simpleStatus.baseMc.x, this._simpleStatus.statusMc_pos.y - 30));
            this._simpleStatus.hide();
            return;
        }// end function

        public function release() : void
        {
            if (this._simpleStatus)
            {
                this._simpleStatus.release();
            }
            this._simpleStatus = null;
            this._parent = null;
            return;
        }// end function

        public function updateAlpha(param1:Number) : void
        {
            this._simpleStatus.baseMc.alpha = param1;
            return;
        }// end function

        public function setOpen(param1:PlayerDisplay, param2:DisplayObjectContainer) : void
        {
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_3:* = UserDataManager.getInstance().userData.getPlayerPersonal(param1.uniqueId);
            var _loc_4:* = param1.effectNull.localToGlobal(new Point());
            if (_loc_3 != null)
            {
                DisplayUtils.setTopPriority(this._parent, this._simpleStatus.baseMc);
                _loc_5 = new Point(param2.x, param2.y);
                _loc_5 = param2.parent.localToGlobal(_loc_5);
                _loc_5 = this._parent.globalToLocal(_loc_5);
                _loc_6 = new Point(_loc_5.x, _loc_5.y);
                _loc_7 = param1.effectNull.localToGlobal(new Point());
                this._simpleStatus.setPosition(_loc_6);
                this._simpleStatus.setArrowTargetPosition(_loc_7);
                this._simpleStatus.setStatus(_loc_3);
                this._simpleStatus.show();
            }
            return;
        }// end function

        public function setClose() : void
        {
            if (this._simpleStatus)
            {
                this._simpleStatus.hide();
            }
            return;
        }// end function

    }
}
