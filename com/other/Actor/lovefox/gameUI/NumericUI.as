package lovefox.gameUI
{
    import com.bit101.components.*;
    import flash.events.*;
    import flash.geom.*;
    import lovefox.unit.*;

    public class NumericUI extends Window
    {
        private var _ns:NumericStepper;
        private var _okPB:PushButton;
        private var _cancelPB:PushButton;
        private var _func:Function;
        private var _slot:CloneSlot;

        public function NumericUI(param1)
        {
            super(param1);
            this.resize(300, 220);
            this.initDraw();
            return;
        }// end function

        private function initDraw()
        {
            this._ns = new NumericStepper(this, 130, 85);
            this._okPB = new PushButton(this, 70, 160, Config.language("NumericUI", 1), this.handleOK);
            this._okPB.width = 60;
            this._cancelPB = new PushButton(this, 170, 160, Config.language("NumericUI", 2), this.handleCancel);
            this._cancelPB.width = 60;
            this._slot = new CloneSlot(0, 32);
            this._slot.x = 75;
            this._slot.y = 80;
            this.addChild(this._slot);
            this._slot.addEventListener(MouseEvent.ROLL_OVER, this.handleSlotOver);
            this._slot.addEventListener(MouseEvent.ROLL_OUT, this.handleSlotOut);
            return;
        }// end function

        override public function close()
        {
            if (this._slot.item != null)
            {
                this._slot.item.destroy();
            }
            super.close();
            return;
        }// end function

        public function openUI(param1:String = "", param2:Number = 0, param3:Number = 0, param4:Function = null, param5:Object = null, param6 = null, param7 = null, param8 = 0, param9 = null) : void
        {
            var _loc_10:* = null;
            title = param1;
            this._ns.minimum = param2;
            this._ns.maximum = param3;
            this._ns.value = param2;
            this._func = param4;
            data = param5;
            if (param6 != null)
            {
                x = param6;
            }
            if (param7 != null)
            {
                y = param7;
            }
            open();
            if (param9 != null)
            {
                this._ns.value = param9;
            }
            if (param8 != 0)
            {
                if (this._slot.item != null)
                {
                    this._slot.item.destroy();
                }
                _loc_10 = Item.newItem(Config._itemMap[param8], 0, 0, UNIT_TYPE_ENUM.TYPEID_ITEMCLONE, 0);
                _loc_10.display();
                this._slot.item = _loc_10;
                this._slot.item.numstr = param3 + 1;
            }
            return;
        }// end function

        private function handleOK(param1)
        {
            this._func(this._ns.value, _data);
            this.close();
            return;
        }// end function

        private function handleCancel(param1)
        {
            this.close();
            return;
        }// end function

        private function handleSlotOver(event:Event) : void
        {
            var _loc_3:* = null;
            var _loc_2:* = event.currentTarget;
            if (_loc_2.item != null)
            {
                _loc_3 = _loc_2.parent.localToGlobal(new Point(_loc_2.x, _loc_2.y));
                Holder.showInfo(_loc_2.item.outputInfo(), new Rectangle(_loc_3.x, _loc_3.y, _loc_2._size, _loc_2._size), false, 0, 200);
            }
            return;
        }// end function

        private function handleSlotOut(event:MouseEvent) : void
        {
            Holder.closeInfo();
            return;
        }// end function

    }
}
