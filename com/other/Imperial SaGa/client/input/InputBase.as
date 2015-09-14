package input
{

    public class InputBase extends Object
    {
        protected var _object:Object;
        protected var _priority:int;
        protected var _bEnable:Boolean;
        protected var _inputGroup:uint;

        public function InputBase(param1:Object, param2:int)
        {
            this._object = param1;
            this._priority = param2;
            this._bEnable = true;
            this._inputGroup = 1;
            return;
        }// end function

        public function setPriority(param1:int) : void
        {
            this._priority = param1;
            return;
        }// end function

        public function enable(param1:Boolean) : void
        {
            this._bEnable = param1;
            return;
        }// end function

        public function setInputGroup(param1:uint) : void
        {
            this._inputGroup = param1;
            return;
        }// end function

        public function get object() : Object
        {
            return this._object;
        }// end function

        public function get priority() : int
        {
            return this._priority;
        }// end function

        public function bEnable() : Boolean
        {
            return this._bEnable;
        }// end function

        public function get inputGroup() : uint
        {
            return this._inputGroup;
        }// end function

    }
}
