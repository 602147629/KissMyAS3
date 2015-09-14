package quest
{
    import flash.display.*;
    import flash.geom.*;
    import resource.*;

    public class QuestMapRoute extends Object
    {
        private var _baseMc:MovieClip;

        public function QuestMapRoute(param1:DisplayObjectContainer, param2:Point, param3:Point)
        {
            this._baseMc = ResourceManager.getInstance().createMovieClip(ResourcePath.QUEST_PATH + QuestMap.getResourceName(), "QuestMapRoute");
            var _loc_4:* = new Point(param3.x - param2.x, param3.y - param2.y);
            var _loc_5:* = new Point(param3.x - param2.x, param3.y - param2.y).length;
            var _loc_6:* = new Matrix();
            this._baseMc.width = _loc_5;
            this._baseMc.height = 10;
            _loc_4 = _loc_6.transformPoint(_loc_4);
            var _loc_7:* = Math.atan2(_loc_4.y, _loc_4.x);
            this._baseMc.rotation = _loc_7 * 180 / Math.PI;
            this._baseMc.x = param2.x + _loc_4.x / 2;
            this._baseMc.y = param2.y + _loc_4.y / 2;
            this.setNoCheck();
            param1.addChild(this._baseMc);
            return;
        }// end function

        public function setNoCheck() : void
        {
            if (this._baseMc)
            {
                this._baseMc.gotoAndStop("normal");
            }
            return;
        }// end function

        public function setCheck() : void
        {
            if (this._baseMc)
            {
                this._baseMc.gotoAndStop("check");
            }
            return;
        }// end function

    }
}
