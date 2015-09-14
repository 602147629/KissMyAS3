package formation
{

    public class OwnFormationData extends Object
    {
        private var _formationId:int;
        private var _bNew:Boolean;

        public function OwnFormationData(param1:Object)
        {
            this._formationId = param1.formationId;
            this._bNew = param1.bNew;
            return;
        }// end function

        public function get formationId() : int
        {
            return this._formationId;
        }// end function

        public function get bNew() : Boolean
        {
            return this._bNew;
        }// end function

        public function checked() : void
        {
            this._bNew = false;
            return;
        }// end function

    }
}
