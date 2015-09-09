package lovefox.gameUI
{
    import com.bit101.components.*;
    import lovefox.unit.*;
    import lovefox.util.*;

    public class ClipSlot extends MouseSprite
    {
        private var _selected:Boolean = false;
        private var _rect:Table;
        private var _selectedRect:Table;
        private var _clip:UnitClip;
        private var _width:Object;
        private var _height:Object;
        private var _container:Object;
        private var _data:Object;
        private var _enabled:Object;

        public function ClipSlot(param1, param2, param3, param4 = null)
        {
            this._container = param1;
            this._container.addChild(this);
            x = param2;
            y = param3;
            this._rect = new Table("table16");
            addChild(this._rect);
            this._selectedRect = new Table("table19");
            this._selectedRect.mouseChildren = false;
            this._selectedRect.mouseEnabled = false;
            if (param4 != null)
            {
                this.clip = param4;
            }
            this.resize(82, 82);
            this.enabled = true;
            return;
        }// end function

        public function set enabled(param1)
        {
            this._enabled = param1;
            if (this._enabled)
            {
                this.buttonMode = true;
                this.mouseEnabled = true;
                this.mouseChildren = true;
            }
            else
            {
                this.buttonMode = false;
                this.mouseEnabled = false;
                this.mouseChildren = false;
            }
            return;
        }// end function

        public function get enabled()
        {
            return this._enabled;
        }// end function

        public function set data(param1:Object) : void
        {
            this._data = param1;
            return;
        }// end function

        public function get data() : Object
        {
            return this._data;
        }// end function

        public function set selected(param1)
        {
            this._selected = param1;
            if (this._selected)
            {
                if (this._selectedRect.parent == null)
                {
                    addChild(this._selectedRect);
                }
                if (this._clip != null)
                {
                    addChild(this._clip);
                    this._clip.changeStateTo("walk");
                }
            }
            else
            {
                if (this._selectedRect.parent != null)
                {
                    this._selectedRect.parent.removeChild(this._selectedRect);
                }
                if (this._clip != null)
                {
                    this._clip.changeStateTo("idle");
                }
            }
            return;
        }// end function

        public function set clip(param1)
        {
            if (this._clip != null)
            {
                this._clip.destroy();
                if (this._clip.parent != null)
                {
                    this._clip.parent.removeChild(this._clip);
                }
                this._clip = null;
            }
            if (param1 != null)
            {
                this._clip = UnitClip.newUnitClip(param1);
                this._clip.changeStateTo("idle");
                addChild(this._clip);
                this._clip.x = this._width / 2;
                this._clip.y = this._height / 4 * 3;
            }
            return;
        }// end function

        public function get clip()
        {
            return this._clip;
        }// end function

        public function destroy()
        {
            this.clip = null;
            return;
        }// end function

        public function resize(param1, param2)
        {
            this._width = param1;
            this._height = param2;
            this._rect.resize(param1, param2);
            this._selectedRect.resize(param1, param2);
            if (this._clip != null)
            {
                this._clip.x = param1 / 2;
                this._clip.y = param2 / 4 * 3;
            }
            return;
        }// end function

    }
}
