package lovefox.gameUI
{
    import com.bit101.components.*;
    import flash.display.*;
    import flash.filters.*;

    public class TaskUpdateTip extends Sprite
    {
        private var updatearr:Array;
        private var ishsowing:Boolean = false;
        private var textsp:Label;

        public function TaskUpdateTip()
        {
            this.updatearr = new Array();
            this.textsp = new Label();
            this.textsp.textColor = 16776960;
            this.textsp.html = true;
            var _loc_1:* = new DropShadowFilter(1, 45, 3342336, 0.3, 1, 1, 10, 1, false, false);
            var _loc_2:* = new Array();
            _loc_2.push(_loc_1);
            this.textsp.filters = _loc_2;
            return;
        }// end function

        public function addToList(param1:int, param2:int, param3:int, param4:int) : void
        {
            var _loc_5:* = new Object();
            new Object().taskid = param1;
            _loc_5.tflag = param2;
            _loc_5.csite = param3;
            _loc_5.num = param4;
            this.updatearr.push(_loc_5);
            this.showlist();
            return;
        }// end function

        private function showlist() : void
        {
            var _loc_1:* = null;
            if (this.ishsowing || this.updatearr.length == 0 || Config.player == null)
            {
                this.updatearr = [];
                return;
            }
            if (this.updatearr[0].tflag == 1)
            {
                _loc_1 = Config._monsterMap[Config._taskMap[this.updatearr[0].taskid]["mon" + this.updatearr[0].csite]].name + "   " + String(this.updatearr[0].num + "/" + Config._taskMap[this.updatearr[0].taskid]["monNum" + this.updatearr[0].csite]);
            }
            else
            {
                _loc_1 = Config._itemMap[Config._taskMap[this.updatearr[0].taskid]["item" + this.updatearr[0].csite]].name + "   " + String(this.updatearr[0].num + "/" + Config._taskMap[this.updatearr[0].taskid]["itemNum" + this.updatearr[0].csite]);
            }
            this.textsp.text = "<FONT SIZE=\'16\'><b>" + _loc_1 + "</b></FONT>";
            Config.player._map._textMap.addChild(this.textsp);
            this.textsp.x = Config.player._mc.x - this.textsp.width / 2;
            this.textsp.y = Config.player._mc.y - Config.player._img._bitmapRectY - 30;
            this.textsp.alpha = 20;
            TweenLite.to(this.textsp, 1, {x:this.textsp.x, y:int(this.textsp.y - 30)}, 0, this.movepause);
            this.ishsowing = true;
            return;
        }// end function

        private function movepause() : void
        {
            TweenLite.to(this.textsp, 1, {x:this.textsp.x, y:int(this.textsp.y - 30)}, 1, this.moveend);
            return;
        }// end function

        private function moveend() : void
        {
            this.ishsowing = false;
            this.textsp.parent.removeChild(this.textsp);
            this.updatearr.splice(0, 1);
            this.showlist();
            return;
        }// end function

    }
}
