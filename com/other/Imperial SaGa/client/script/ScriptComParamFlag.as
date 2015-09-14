package script
{

    public class ScriptComParamFlag extends Object
    {
        private var _id:int;

        public function ScriptComParamFlag()
        {
            this._id = Constant.UNDECIDED;
            return;
        }// end function

        public function get id() : int
        {
            return this._id;
        }// end function

        public function setParam(param1:XML) : void
        {
            this._id = parseInt(param1);
            return;
        }// end function

    }
}
