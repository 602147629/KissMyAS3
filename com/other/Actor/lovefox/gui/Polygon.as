package lovefox.gui
{
    import flash.display.*;

    public class Polygon extends Sprite
    {
        private var _data:Object;
        private var _size:Object;
        private var _initAngle:Object;
        private var _nodeArray:Object;
        private var _shape:Shape;
        private var _shape1:Shape;
        private var _bg:GPanel;

        public function Polygon(param1, param2, param3 = null)
        {
            this._nodeArray = [];
            this._size = param1;
            this._initAngle = param2;
            if (param3 != null)
            {
                this.data = param3;
            }
            this._bg = new GPanel(Config.findUI("login").circle);
            this._bg.x = (-this._bg.width) / 2;
            this._bg.y = (-this._bg.height) / 2;
            addChild(this._bg);
            this._shape = new Shape();
            this._shape1 = new Shape();
            addChild(this._shape1);
            addChild(this._shape);
            this._shape.filters = [new GlowFilter(41727, 1, 2, 2, 1)];
            return;
        }// end function

        public function destroy()
        {
            removeEventListener(Event.ENTER_FRAME, this.handleEnterFrame);
            this._shape.filters = [];
            this._bg.destroy();
            return;
        }// end function

        public function set data(param1)
        {
            this._data = param1;
            this.draw();
            return;
        }// end function

        public function draw()
        {
            var _loc_1:* = undefined;
            var _loc_2:* = Math.PI * 2 / this._data.length;
            _loc_1 = 0;
            while (_loc_1 < this._data.length)
            {
                
                if (this._nodeArray[_loc_1] == null)
                {
                    this._nodeArray[_loc_1] = {};
                }
                if (this._nodeArray[_loc_1].pre == null)
                {
                    this._nodeArray[_loc_1].pre = [0, 0];
                }
                this._nodeArray[_loc_1].aim = [this._data[_loc_1] * Math.cos(this._initAngle + _loc_2 * _loc_1) * this._size, this._data[_loc_1] * Math.sin(this._initAngle + _loc_2 * _loc_1) * this._size];
                _loc_1 = _loc_1 + 1;
            }
            removeEventListener(Event.ENTER_FRAME, this.handleEnterFrame);
            addEventListener(Event.ENTER_FRAME, this.handleEnterFrame);
            return;
        }// end function

        private function handleEnterFrame(param1)
        {
            var _loc_3:* = undefined;
            var _loc_4:* = undefined;
            var _loc_5:* = undefined;
            var _loc_2:* = true;
            this._shape.graphics.clear();
            this._shape.graphics.lineStyle(2, 7855331, 1);
            this._shape.graphics.beginFill(0, 0);
            this._shape1.graphics.clear();
            this._shape1.graphics.lineStyle(0, 0, 0);
            this._shape1.graphics.beginFill(0, 0.5);
            _loc_5 = 0;
            while (_loc_5 < this._nodeArray.length)
            {
                
                _loc_3 = (this._nodeArray[_loc_5].aim[0] - this._nodeArray[_loc_5].pre[0]) / 4;
                _loc_4 = (this._nodeArray[_loc_5].aim[1] - this._nodeArray[_loc_5].pre[1]) / 4;
                if (Math.abs(_loc_3) > 0.1 || Math.abs(_loc_4) > 0.1)
                {
                    _loc_2 = false;
                    this._nodeArray[_loc_5].pre[0] = this._nodeArray[_loc_5].pre[0] + _loc_3;
                    this._nodeArray[_loc_5].pre[1] = this._nodeArray[_loc_5].pre[1] + _loc_4;
                }
                else
                {
                    this._nodeArray[_loc_5].pre[0] = this._nodeArray[_loc_5].aim[0];
                    this._nodeArray[_loc_5].pre[1] = this._nodeArray[_loc_5].aim[1];
                }
                if (_loc_5 == 0)
                {
                    this._shape.graphics.moveTo(this._nodeArray[_loc_5].pre[0], this._nodeArray[_loc_5].pre[1]);
                    this._shape1.graphics.moveTo(this._nodeArray[_loc_5].pre[0], this._nodeArray[_loc_5].pre[1]);
                }
                else
                {
                    this._shape.graphics.lineTo(this._nodeArray[_loc_5].pre[0], this._nodeArray[_loc_5].pre[1]);
                    this._shape1.graphics.lineTo(this._nodeArray[_loc_5].pre[0], this._nodeArray[_loc_5].pre[1]);
                }
                _loc_5 = _loc_5 + 1;
            }
            this._shape.graphics.endFill();
            this._shape1.graphics.endFill();
            if (_loc_2)
            {
                removeEventListener(Event.ENTER_FRAME, this.handleEnterFrame);
            }
            return;
        }// end function

    }
}
